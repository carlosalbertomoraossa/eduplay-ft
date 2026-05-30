// Spec: specs/games/g4-adventure-plan.md Fase 1

import 'package:equatable/equatable.dart';

import '../../domain/entities/game_question.dart';

sealed class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameStarted extends GameEvent {
  final int level;
  final List<GameQuestion> questions;
  GameStarted({required this.level, required this.questions});
  @override
  List<Object?> get props => [level];
}

class ValueBlockHit extends GameEvent {}

class AnswerBlockHit extends GameEvent {
  final int answerIndex;
  AnswerBlockHit(this.answerIndex);
  @override
  List<Object?> get props => [answerIndex];
}

class NextLevel extends GameEvent {}

class GamePaused extends GameEvent {}

class GameResumed extends GameEvent {}

class GameRestarted extends GameEvent {
  final int level;
  GameRestarted(this.level);
  @override
  List<Object?> get props => [level];
}
