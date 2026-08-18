// Spec: specs/games/g4-adventure-plan.md Fase 1 §1.5

import 'package:bloc/bloc.dart';

import '../../domain/entities/game_result.dart';
import 'game_event.dart';
import 'game_state.dart';

const int _questionsPerLevel = 10;
const int _maxLevel = 8;
const int _initialLives = 3;
const int _maxLives = 5;
const int _baseScore = 100;
const int _streakForDoubleMultiplier = 3;
const int _streakForTripleMultiplier = 5;
const int _xpPerCorrect = 10;
const int _coinsPerLevel = 5;

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GameStarted>(_onStarted);
    on<ValueBlockHit>(_onValueBlockHit);
    on<AnswerBlockHit>(_onAnswerBlockHit);
    on<NextLevel>(_onNextLevel);
    on<GameRestarted>(_onRestarted);
    on<GamePaused>(_onPaused);
    on<GameResumed>(_onResumed);
  }

  void _onStarted(GameStarted event, Emitter<GameState> emit) {
    emit(GameInProgress(
      score: 0,
      lives: _initialLives,
      currentLevel: event.level,
      questionsAnswered: 0,
      correctAnswersCount: 0,
      streakCount: 0,
      scoreMultiplier: 1,
      questions: event.questions,
      waitingForAnswer: false,
    ));
  }

  void _onValueBlockHit(ValueBlockHit event, Emitter<GameState> emit) {
    final current = state;
    if (current is! GameInProgress) return;
    if (current.waitingForAnswer) return;
    if (!current.hasMoreQuestions) return;

    final question = current.questions[current.nextQuestionIndex];
    emit(current.copyWith(
      activeQuestion: question,
      waitingForAnswer: true,
      clearLastAnswer: true,
    ));
  }

  void _onAnswerBlockHit(AnswerBlockHit event, Emitter<GameState> emit) {
    final current = state;
    if (current is! GameInProgress) return;
    if (!current.waitingForAnswer || current.activeQuestion == null) return;

    final isCorrect = current.activeQuestion!.isCorrectAnswer(event.answerIndex);

    if (isCorrect) {
      _handleCorrectAnswer(current, emit);
    } else {
      _handleWrongAnswer(current, emit);
    }
  }

  void _handleCorrectAnswer(GameInProgress current, Emitter<GameState> emit) {
    final newStreak = current.streakCount + 1;
    final newMultiplier = newStreak >= _streakForTripleMultiplier
        ? 3
        : newStreak >= _streakForDoubleMultiplier
            ? 2
            : 1;

    // Vida extra al alcanzar racha de 5
    final bonusLife = newStreak == _streakForTripleMultiplier &&
            current.lives < _maxLives
        ? 1
        : 0;

    final newScore = current.score + _baseScore * newMultiplier;
    final newAnswered = current.questionsAnswered + 1;
    final newCorrect = current.correctAnswersCount + 1;
    final newLives = current.lives + bonusLife;

    final updated = current.copyWith(
      score: newScore,
      lives: newLives,
      questionsAnswered: newAnswered,
      correctAnswersCount: newCorrect,
      streakCount: newStreak,
      scoreMultiplier: newMultiplier,
      waitingForAnswer: false,
      clearActiveQuestion: true,
      lastAnswerCorrect: true,
    );

    if (newAnswered >= _questionsPerLevel) {
      emit(_buildLevelComplete(updated));
    } else {
      emit(updated);
    }
  }

  void _handleWrongAnswer(GameInProgress current, Emitter<GameState> emit) {
    final newLives = current.lives - 1;
    final newAnswered = current.questionsAnswered + 1;

    final updated = current.copyWith(
      lives: newLives,
      questionsAnswered: newAnswered,
      streakCount: 0,
      scoreMultiplier: 1,
      waitingForAnswer: false,
      clearActiveQuestion: true,
      lastAnswerCorrect: false,
    );

    if (newLives <= 0) {
      emit(GameOver(_buildResult(updated)));
    } else if (newAnswered >= _questionsPerLevel) {
      emit(_buildLevelComplete(updated));
    } else {
      emit(updated);
    }
  }

  void _onNextLevel(NextLevel event, Emitter<GameState> emit) {
    final current = state;
    if (current is! LevelComplete) return;

    if (current.level >= _maxLevel) {
      emit(GameComplete(current.partialResult));
    } else {
      // GamePlayScreen se encarga de cargar nuevas preguntas para el nivel siguiente
      emit(GameInitial());
    }
  }

  void _onRestarted(GameRestarted event, Emitter<GameState> emit) {
    emit(GameInitial());
  }

  void _onPaused(GamePaused event, Emitter<GameState> emit) {
    // Mantener el estado actual — la UI muestra un overlay de pausa
  }

  void _onResumed(GameResumed event, Emitter<GameState> emit) {
    // Reanudar desde el mismo estado
  }

  LevelComplete _buildLevelComplete(GameInProgress state) => LevelComplete(
        level: state.currentLevel,
        score: state.score,
        partialResult: _buildResult(state),
      );

  GameResult _buildResult(GameInProgress state) {
    return GameResult(
      finalScore: state.score,
      levelsCompleted: state.currentLevel,
      questionsCorrect: state.correctAnswersCount,
      questionsTotal: state.questionsAnswered,
      xpEarned: state.correctAnswersCount * _xpPerCorrect,
      coinsEarned: state.currentLevel * _coinsPerLevel,
    );
  }
}
