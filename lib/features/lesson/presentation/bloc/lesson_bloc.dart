// Lesson Bloc — maneja el flujo de una lección completa
// Spec: /specs/domains/learning/spec.md
// UX Spec: /specs/product/ux-children.md

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/curriculum_data.dart';
import '../../domain/entities/lesson.dart';

// ─── Events ────────────────────────────────────────────────────────
sealed class LessonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LessonStarted extends LessonEvent {
  final String lessonId;
  LessonStarted(this.lessonId);
  @override
  List<Object?> get props => [lessonId];
}

class ExerciseAnswered extends LessonEvent {
  final String exerciseId;
  final dynamic answer;
  ExerciseAnswered({required this.exerciseId, required this.answer});
  @override
  List<Object?> get props => [exerciseId, answer];
}

class HeartLost extends LessonEvent {}

class LessonSubmitted extends LessonEvent {}

class NextExercise extends LessonEvent {}

// ─── States ────────────────────────────────────────────────────────
sealed class LessonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LessonInitial extends LessonState {}
class LessonLoading extends LessonState {}

class LessonInProgress extends LessonState {
  final Lesson lesson;
  final int currentExerciseIndex;
  final int heartsRemaining;
  final Map<String, dynamic> answers;
  final Map<String, bool> correctness;

  LessonInProgress({
    required this.lesson,
    required this.currentExerciseIndex,
    required this.heartsRemaining,
    required this.answers,
    required this.correctness,
  });

  Exercise get currentExercise =>
      lesson.exercises[currentExerciseIndex];

  bool get isLastExercise =>
      currentExerciseIndex == lesson.exercises.length - 1;

  @override
  List<Object?> get props => [
        currentExerciseIndex,
        heartsRemaining,
        answers.length,
      ];
}

class ExerciseFeedback extends LessonState {
  final LessonInProgress previousState;
  final bool wasCorrect;
  final String exerciseId;

  ExerciseFeedback({
    required this.previousState,
    required this.wasCorrect,
    required this.exerciseId,
  });

  @override
  List<Object?> get props => [wasCorrect, exerciseId];
}

class LessonFailed extends LessonState {
  // Spec UX: "¡Necesitas practicar más esto!" (no "Game Over")
  final Lesson lesson;
  LessonFailed(this.lesson);
}

class LessonCompleted extends LessonState {
  final LessonResult result;
  LessonCompleted(this.result);
  @override
  List<Object?> get props => [result];
}

class LessonError extends LessonState {
  final String message;
  LessonError(this.message);
}

// ─── Bloc ──────────────────────────────────────────────────────────
class LessonBloc extends Bloc<LessonEvent, LessonState> {
  static const int maxHearts = 3;

  LessonBloc() : super(LessonInitial()) {
    on<LessonStarted>(_onStarted);
    on<ExerciseAnswered>(_onAnswered);
    on<HeartLost>(_onHeartLost);
    on<NextExercise>(_onNextExercise);
    on<LessonSubmitted>(_onSubmitted);
  }

  Future<void> _onStarted(
    LessonStarted event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoading());
    await Future.delayed(const Duration(milliseconds: 400));
    final lesson = CurriculumData.getLesson(event.lessonId);
    if (lesson == null) {
      emit(LessonError('Lección no encontrada: ${event.lessonId}'));
      return;
    }
    emit(LessonInProgress(
      lesson: lesson,
      currentExerciseIndex: 0,
      heartsRemaining: maxHearts,
      answers: const {},
      correctness: const {},
    ));
  }

  void _onAnswered(
    ExerciseAnswered event,
    Emitter<LessonState> emit,
  ) {
    if (state is! LessonInProgress) return;
    final current = state as LessonInProgress;

    // Verificar respuesta según tipo de ejercicio
    final exercise = current.lesson.exercises
        .firstWhere((e) => e.id == event.exerciseId);
    final wasCorrect = _checkAnswer(exercise, event.answer);

    final newAnswers = Map<String, dynamic>.from(current.answers)
      ..[event.exerciseId] = event.answer;
    final newCorrectness = Map<String, bool>.from(current.correctness)
      ..[event.exerciseId] = wasCorrect;

    emit(ExerciseFeedback(
      previousState: current.copyWith(
        answers: newAnswers,
        correctness: newCorrectness,
      ),
      wasCorrect: wasCorrect,
      exerciseId: event.exerciseId,
    ));
  }

  bool _checkAnswer(Exercise exercise, dynamic answer) {
    final content = exercise.content;
    switch (exercise.type) {
      case ExerciseType.multipleChoice:
        return answer == content['correct_index'];
      case ExerciseType.fillBlank:
        final correct = (content['correct_answer'] as String).trim().toLowerCase();
        final given = (answer as String).trim().toLowerCase();
        return given == correct;
      case ExerciseType.dragDrop:
        // correct_mapping: { item → target }  (ej: {"1": "uno"})
        // answer/_placements: { target → item } (ej: {"uno": "1"})
        final correctMapping = Map<String, String>.from(
          content['correct_mapping'] as Map,
        );
        final userMapping = Map<String, String?>.from(answer as Map);
        if (userMapping.length != correctMapping.length) return false;
        return correctMapping.entries.every(
          (e) => userMapping[e.value] == e.key,
        );
      default:
        return false;
    }
  }

  void _onHeartLost(HeartLost event, Emitter<LessonState> emit) {
    if (state is! LessonInProgress) return;
    final current = state as LessonInProgress;
    final newHearts = current.heartsRemaining - 1;

    if (newHearts <= 0) {
      emit(LessonFailed(current.lesson));
    } else {
      emit(current.copyWith(heartsRemaining: newHearts));
    }
  }

  void _onNextExercise(NextExercise event, Emitter<LessonState> emit) {
    if (state is! ExerciseFeedback) return;
    final feedback = state as ExerciseFeedback;
    final prev = feedback.previousState;
    emit(prev.copyWith(
      currentExerciseIndex: prev.currentExerciseIndex + 1,
    ));
  }

  Future<void> _onSubmitted(
    LessonSubmitted event,
    Emitter<LessonState> emit,
  ) async {
    // Accept either LessonInProgress or ExerciseFeedback as source of truth
    final LessonInProgress progress;
    if (state is LessonInProgress) {
      progress = state as LessonInProgress;
    } else if (state is ExerciseFeedback) {
      progress = (state as ExerciseFeedback).previousState;
    } else {
      return;
    }

    final correctCount =
        progress.correctness.values.where((v) => v).length;
    final total = progress.lesson.exercises.length;
    final score = total == 0 ? 0.0 : correctCount / total;

    emit(LessonCompleted(
      LessonResult(
        lessonId: progress.lesson.id,
        score: score,
        isCompleted: score >= 0.70,
        exercisesCorrect: correctCount,
        exercisesTotal: total,
        xpEarned: score >= 0.70 ? progress.lesson.xpReward : 0,
        coinsEarned: score >= 0.70 ? progress.lesson.coinReward : 0,
      ),
    ));
  }
}

extension on LessonInProgress {
  LessonInProgress copyWith({
    int? currentExerciseIndex,
    int? heartsRemaining,
    Map<String, dynamic>? answers,
    Map<String, bool>? correctness,
  }) =>
      LessonInProgress(
        lesson: lesson,
        currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
        heartsRemaining: heartsRemaining ?? this.heartsRemaining,
        answers: answers ?? this.answers,
        correctness: correctness ?? this.correctness,
      );
}
