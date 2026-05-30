// Spec: specs/games/g4-adventure-plan.md Fase 1

import 'package:equatable/equatable.dart';

import '../../domain/entities/game_question.dart';
import '../../domain/entities/game_result.dart';

sealed class GameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final int score;
  final int lives;
  final int currentLevel;
  final int questionsAnswered;
  final int streakCount;
  final int scoreMultiplier;
  final List<GameQuestion> questions;
  final GameQuestion? activeQuestion;
  final bool waitingForAnswer;
  final bool? lastAnswerCorrect;

  GameInProgress({
    required this.score,
    required this.lives,
    required this.currentLevel,
    required this.questionsAnswered,
    required this.streakCount,
    required this.scoreMultiplier,
    required this.questions,
    this.activeQuestion,
    this.waitingForAnswer = false,
    this.lastAnswerCorrect,
  });

  int get nextQuestionIndex => questionsAnswered;
  bool get hasMoreQuestions => questionsAnswered < questions.length;

  GameInProgress copyWith({
    int? score,
    int? lives,
    int? currentLevel,
    int? questionsAnswered,
    int? streakCount,
    int? scoreMultiplier,
    List<GameQuestion>? questions,
    GameQuestion? activeQuestion,
    bool clearActiveQuestion = false,
    bool? waitingForAnswer,
    bool? lastAnswerCorrect,
    bool clearLastAnswer = false,
  }) =>
      GameInProgress(
        score: score ?? this.score,
        lives: lives ?? this.lives,
        currentLevel: currentLevel ?? this.currentLevel,
        questionsAnswered: questionsAnswered ?? this.questionsAnswered,
        streakCount: streakCount ?? this.streakCount,
        scoreMultiplier: scoreMultiplier ?? this.scoreMultiplier,
        questions: questions ?? this.questions,
        activeQuestion:
            clearActiveQuestion ? null : activeQuestion ?? this.activeQuestion,
        waitingForAnswer: waitingForAnswer ?? this.waitingForAnswer,
        lastAnswerCorrect:
            clearLastAnswer ? null : lastAnswerCorrect ?? this.lastAnswerCorrect,
      );

  @override
  List<Object?> get props => [
        score, lives, questionsAnswered,
        waitingForAnswer, lastAnswerCorrect, streakCount, scoreMultiplier,
      ];
}

class GameOver extends GameState {
  final GameResult result;
  GameOver(this.result);
  @override
  List<Object?> get props => [result];
}

class LevelComplete extends GameState {
  final int level;
  final int score;
  final GameResult partialResult;
  LevelComplete({
    required this.level,
    required this.score,
    required this.partialResult,
  });
  @override
  List<Object?> get props => [level, score];
}

class GameComplete extends GameState {
  final GameResult result;
  GameComplete(this.result);
  @override
  List<Object?> get props => [result];
}
