import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:edplay_ft/features/lesson/domain/entities/lesson.dart';
import 'package:edplay_ft/features/lesson/presentation/bloc/lesson_bloc.dart';

void main() {
  group('LessonBloc', () {
    late LessonBloc bloc;

    setUp(() {
      bloc = LessonBloc();
    });

    tearDown(() {
      bloc.close();
    });

    blocTest<LessonBloc, LessonState>(
      'emite LessonLoading y LessonInProgress al iniciar lección válida',
      build: () => LessonBloc(),
      act: (bloc) => bloc.add(LessonStarted('lesson-001')),
      expect: () => [
        isA<LessonLoading>(),
        isA<LessonInProgress>(),
      ],
    );

    blocTest<LessonBloc, LessonState>(
      'emite LessonLoading y LessonError al iniciar lección inválida',
      build: () => LessonBloc(),
      act: (bloc) => bloc.add(LessonStarted('no-existe')),
      expect: () => [
        isA<LessonLoading>(),
        isA<LessonError>(),
      ],
    );

    blocTest<LessonBloc, LessonState>(
      'ExerciseAnswered correcto emite ExerciseFeedback con wasCorrect=true',
      build: () => LessonBloc(),
      seed: () => LessonInProgress(
        lesson: _mockLesson,
        currentExerciseIndex: 0,
        heartsRemaining: 3,
        answers: const {},
        correctness: const {},
      ),
      act: (bloc) => bloc.add(ExerciseAnswered(
        exerciseId: 'e1',
        answer: 0,
      )),
      expect: () => [
        isA<ExerciseFeedback>()
          ..having((s) => s.wasCorrect, 'wasCorrect', true),
      ],
    );

    blocTest<LessonBloc, LessonState>(
      'ExerciseAnswered incorrecto emite ExerciseFeedback con wasCorrect=false',
      build: () => LessonBloc(),
      seed: () => LessonInProgress(
        lesson: _mockLesson,
        currentExerciseIndex: 0,
        heartsRemaining: 3,
        answers: const {},
        correctness: const {},
      ),
      act: (bloc) => bloc.add(ExerciseAnswered(
        exerciseId: 'e1',
        answer: 2,
      )),
      expect: () => [
        isA<ExerciseFeedback>()
          ..having((s) => s.wasCorrect, 'wasCorrect', false),
      ],
    );

    blocTest<LessonBloc, LessonState>(
      'HeartLost decrementa corazones',
      build: () => LessonBloc(),
      seed: () => LessonInProgress(
        lesson: _mockLesson,
        currentExerciseIndex: 0,
        heartsRemaining: 3,
        answers: const {},
        correctness: const {},
      ),
      act: (bloc) => bloc.add(HeartLost()),
      expect: () => [
        isA<LessonInProgress>()
          ..having((s) => s.heartsRemaining, 'hearts', 2),
      ],
    );

    blocTest<LessonBloc, LessonState>(
      'HeartLost con 1 corazón restante emite LessonFailed',
      build: () => LessonBloc(),
      seed: () => LessonInProgress(
        lesson: _mockLesson,
        currentExerciseIndex: 0,
        heartsRemaining: 1,
        answers: const {},
        correctness: const {},
      ),
      act: (bloc) => bloc.add(HeartLost()),
      expect: () => [
        isA<LessonFailed>(),
      ],
    );

    blocTest<LessonBloc, LessonState>(
      'NextExercise desde ExerciseFeedback avanza al siguiente ejercicio',
      build: () => LessonBloc(),
      seed: () => ExerciseFeedback(
        previousState: LessonInProgress(
          lesson: _mockLesson,
          currentExerciseIndex: 0,
          heartsRemaining: 3,
          answers: const {},
          correctness: const {},
        ),
        wasCorrect: true,
        exerciseId: 'e1',
      ),
      act: (bloc) => bloc.add(NextExercise()),
      expect: () => [
        isA<LessonInProgress>()
          ..having((s) => s.currentExerciseIndex, 'index', 1),
      ],
    );

    blocTest<LessonBloc, LessonState>(
      'LessonSubmitted con score >= 70% emite LessonCompleted',
      build: () => LessonBloc(),
      seed: () => LessonInProgress(
        lesson: _mockLesson,
        currentExerciseIndex: 2,
        heartsRemaining: 3,
        answers: const {},
        correctness: const {
          'e1': true,
          'e2': true,
          'e3': false,
        },
      ),
      act: (bloc) => bloc.add(LessonSubmitted()),
      expect: () => [
        isA<LessonCompleted>()
          ..having((s) => s.result.isCompleted, 'isCompleted', true)
          ..having((s) => s.result.score, 'score', 2 / 3),
      ],
    );

    blocTest<LessonBloc, LessonState>(
      'LessonSubmitted con score < 70% emite LessonCompleted con isCompleted=false',
      build: () => LessonBloc(),
      seed: () => LessonInProgress(
        lesson: _mockLesson,
        currentExerciseIndex: 2,
        heartsRemaining: 3,
        answers: const {},
        correctness: const {
          'e1': true,
          'e2': false,
          'e3': false,
        },
      ),
      act: (bloc) => bloc.add(LessonSubmitted()),
      expect: () => [
        isA<LessonCompleted>()
          ..having((s) => s.result.isCompleted, 'isCompleted', false),
      ],
    );
  });
}

final _mockLesson = Lesson(
  id: 'mock-001',
  unitId: 'unit-001',
  orderNum: 1,
  title: 'Mock Lesson',
  type: LessonType.standard,
  estimatedMinutes: 5,
  xpReward: 30,
  coinReward: 10,
  difficulty: Difficulty.easy,
  exercises: const [
    Exercise(
      id: 'e1',
      orderNum: 1,
      type: ExerciseType.multipleChoice,
      content: {
        'question': '¿Cuánto es 1+1?',
        'options': ['2', '3', '4', '5'],
        'correct_index': 0,
      },
    ),
    Exercise(
      id: 'e2',
      orderNum: 2,
      type: ExerciseType.multipleChoice,
      content: {
        'question': '¿Cuánto es 2+2?',
        'options': ['2', '3', '4', '5'],
        'correct_index': 2,
      },
    ),
    Exercise(
      id: 'e3',
      orderNum: 3,
      type: ExerciseType.multipleChoice,
      content: {
        'question': '¿Cuánto es 3+3?',
        'options': ['5', '6', '7', '8'],
        'correct_index': 1,
      },
    ),
  ],
);
