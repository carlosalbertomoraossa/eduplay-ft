import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:edplay_ft/features/games/g4_adventure/domain/entities/game_question.dart';
import 'package:edplay_ft/features/games/g4_adventure/domain/entities/game_result.dart';
import 'package:edplay_ft/features/lesson/domain/entities/lesson.dart';
import 'package:edplay_ft/features/games/g4_adventure/presentation/bloc/game_bloc.dart';
import 'package:edplay_ft/features/games/g4_adventure/presentation/bloc/game_event.dart';
import 'package:edplay_ft/features/games/g4_adventure/presentation/bloc/game_state.dart';

List<GameQuestion> _mockQuestions(int count) => List.generate(
      count,
      (i) => GameQuestion(
        id: 'q$i',
        question: 'Pregunta $i',
        options: ['A', 'B', 'C'],
        correctIndex: 0,
        xpReward: 10,
        difficulty: Difficulty.easy,
      ),
    );

void main() {
  group('GameBloc', () {
    late GameBloc bloc;

    setUp(() {
      bloc = GameBloc();
    });

    tearDown(() {
      bloc.close();
    });

    blocTest<GameBloc, GameState>(
      'GameStarted emite GameInProgress con level=1, score=0, 3 vidas',
      build: () => GameBloc(),
      act: (bloc) => bloc.add(GameStarted(
        level: 1,
        questions: _mockQuestions(10),
      )),
      expect: () => [
        isA<GameInProgress>()
          ..having((s) => s.currentLevel, 'level', 1)
          ..having((s) => s.score, 'score', 0)
          ..having((s) => s.lives, 'lives', 3)
          ..having((s) => s.correctAnswersCount, 'correct', 0)
          ..having((s) => s.waitingForAnswer, 'waiting', false),
      ],
    );

    blocTest<GameBloc, GameState>(
      'ValueBlockHit activa waitingForAnswer y activeQuestion',
      build: () => GameBloc(),
      seed: () => GameInProgress(
        score: 0,
        lives: 3,
        currentLevel: 1,
        questionsAnswered: 0,
        correctAnswersCount: 0,
        streakCount: 0,
        scoreMultiplier: 1,
        questions: _mockQuestions(10),
      ),
      act: (bloc) => bloc.add(ValueBlockHit()),
      expect: () => [
        isA<GameInProgress>()
          ..having((s) => s.waitingForAnswer, 'waiting', true)
          ..having((s) => s.activeQuestion, 'question', isNotNull),
      ],
    );

    blocTest<GameBloc, GameState>(
      'AnswerBlockHit correcto incrementa score y correctAnswersCount',
      build: () => GameBloc(),
      seed: () => GameInProgress(
        score: 0,
        lives: 3,
        currentLevel: 1,
        questionsAnswered: 0,
        correctAnswersCount: 0,
        streakCount: 0,
        scoreMultiplier: 1,
        questions: _mockQuestions(10),
        activeQuestion: _mockQuestions(1)[0],
        waitingForAnswer: true,
      ),
      act: (bloc) => bloc.add(AnswerBlockHit(0)),
      expect: () => [
        isA<GameInProgress>()
          ..having((s) => s.score, 'score', greaterThan(0))
          ..having((s) => s.correctAnswersCount, 'correct', 1)
          ..having((s) => s.questionsAnswered, 'answered', 1)
          ..having((s) => s.waitingForAnswer, 'waiting', false)
          ..having((s) => s.lastAnswerCorrect, 'lastCorrect', true),
      ],
    );

    blocTest<GameBloc, GameState>(
      'AnswerBlockHit incorrecto decrementa vidas y resetea racha',
      build: () => GameBloc(),
      seed: () => GameInProgress(
        score: 0,
        lives: 3,
        currentLevel: 1,
        questionsAnswered: 0,
        correctAnswersCount: 0,
        streakCount: 0,
        scoreMultiplier: 1,
        questions: _mockQuestions(10),
        activeQuestion: _mockQuestions(1)[0],
        waitingForAnswer: true,
      ),
      act: (bloc) => bloc.add(AnswerBlockHit(1)),
      expect: () => [
        isA<GameInProgress>()
          ..having((s) => s.lives, 'lives', 2)
          ..having((s) => s.streakCount, 'streak', 0)
          ..having((s) => s.scoreMultiplier, 'multiplier', 1)
          ..having((s) => s.lastAnswerCorrect, 'lastCorrect', false),
      ],
    );

    blocTest<GameBloc, GameState>(
      'Racha de 3 correctas activa multiplicador x2',
      build: () => GameBloc(),
      seed: () => GameInProgress(
        score: 100,
        lives: 3,
        currentLevel: 1,
        questionsAnswered: 2,
        correctAnswersCount: 2,
        streakCount: 2,
        scoreMultiplier: 1,
        questions: _mockQuestions(10),
        activeQuestion: _mockQuestions(1)[0],
        waitingForAnswer: true,
      ),
      act: (bloc) => bloc.add(AnswerBlockHit(0)),
      expect: () => [
        isA<GameInProgress>()
          ..having((s) => s.streakCount, 'streak', 3)
          ..having((s) => s.scoreMultiplier, 'multiplier', 2),
      ],
    );

    blocTest<GameBloc, GameState>(
      'Racha de 5 correctas activa multiplicador x3 y vida extra',
      build: () => GameBloc(),
      seed: () => GameInProgress(
        score: 400,
        lives: 3,
        currentLevel: 1,
        questionsAnswered: 4,
        correctAnswersCount: 4,
        streakCount: 4,
        scoreMultiplier: 2,
        questions: _mockQuestions(10),
        activeQuestion: _mockQuestions(1)[0],
        waitingForAnswer: true,
      ),
      act: (bloc) => bloc.add(AnswerBlockHit(0)),
      expect: () => [
        isA<GameInProgress>()
          ..having((s) => s.streakCount, 'streak', 5)
          ..having((s) => s.scoreMultiplier, 'multiplier', 3)
          ..having((s) => s.lives, 'lives', 4),
      ],
    );

    blocTest<GameBloc, GameState>(
      'GameOver cuando las vidas llegan a 0',
      build: () => GameBloc(),
      seed: () => GameInProgress(
        score: 0,
        lives: 1,
        currentLevel: 1,
        questionsAnswered: 0,
        correctAnswersCount: 0,
        streakCount: 0,
        scoreMultiplier: 1,
        questions: _mockQuestions(10),
        activeQuestion: _mockQuestions(1)[0],
        waitingForAnswer: true,
      ),
      act: (bloc) => bloc.add(AnswerBlockHit(1)),
      expect: () => [
        isA<GameOver>(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'LevelComplete cuando se responden 10 preguntas',
      build: () => GameBloc(),
      seed: () => GameInProgress(
        score: 900,
        lives: 3,
        currentLevel: 1,
        questionsAnswered: 9,
        correctAnswersCount: 9,
        streakCount: 9,
        scoreMultiplier: 3,
        questions: _mockQuestions(10),
        activeQuestion: _mockQuestions(1)[0],
        waitingForAnswer: true,
      ),
      act: (bloc) => bloc.add(AnswerBlockHit(0)),
      expect: () => [
        isA<LevelComplete>()
          ..having((s) => s.level, 'level', 1),
      ],
    );

    blocTest<GameBloc, GameState>(
      'NextLevel emite GameInitial para que GamePlayScreen cargue el siguiente nivel',
      build: () => GameBloc(),
      seed: () => LevelComplete(
        level: 1,
        score: 1000,
        partialResult: GameResult(
          finalScore: 1000,
          levelsCompleted: 1,
          questionsCorrect: 10,
          questionsTotal: 10,
          xpEarned: 100,
          coinsEarned: 5,
        ),
      ),
      act: (bloc) => bloc.add(NextLevel()),
      expect: () => [
        isA<GameInitial>(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'NextLevel en último nivel (8) emite GameComplete',
      build: () => GameBloc(),
      seed: () => LevelComplete(
        level: 8,
        score: 2000,
        partialResult: GameResult(
          finalScore: 2000,
          levelsCompleted: 8,
          questionsCorrect: 8,
          questionsTotal: 10,
          xpEarned: 80,
          coinsEarned: 40,
        ),
      ),
      act: (bloc) => bloc.add(NextLevel()),
      expect: () => [
        isA<GameComplete>(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'GameRestarted emite GameInitial',
      build: () => GameBloc(),
      act: (bloc) => bloc.add(GameRestarted(1)),
      expect: () => [
        isA<GameInitial>(),
      ],
    );
  });
}
