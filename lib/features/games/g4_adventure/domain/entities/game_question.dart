// Spec: specs/games/g4-adventure-platformer.md §5.1

import 'package:equatable/equatable.dart';

import '../../../../lesson/domain/entities/lesson.dart';

class GameQuestion extends Equatable {
  final String id;
  final String question;
  final List<String> options; // exactamente 3
  final int correctIndex; // 0, 1 o 2
  final int xpReward;
  final Difficulty difficulty;

  const GameQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.xpReward,
    required this.difficulty,
  });

  bool isCorrectAnswer(int index) => index == correctIndex;

  @override
  List<Object?> get props => [id];
}
