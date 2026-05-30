// Spec: specs/games/g4-adventure-platformer.md §5.2

import 'package:equatable/equatable.dart';

import '../../../../lesson/domain/entities/lesson.dart';

class GameResult extends Equatable {
  final int finalScore;
  final int levelsCompleted;
  final int questionsCorrect;
  final int questionsTotal;
  final int xpEarned;
  final int coinsEarned;
  final bool isHighScore;

  const GameResult({
    required this.finalScore,
    required this.levelsCompleted,
    required this.questionsCorrect,
    required this.questionsTotal,
    required this.xpEarned,
    required this.coinsEarned,
    this.isHighScore = false,
  });

  double get accuracy =>
      questionsTotal > 0 ? questionsCorrect / questionsTotal : 0;

  LessonResult toLessonResult() => LessonResult(
        lessonId: 'game-g4-lvl-$levelsCompleted',
        score: accuracy,
        isCompleted: accuracy >= 0.7,
        exercisesCorrect: questionsCorrect,
        exercisesTotal: questionsTotal,
        xpEarned: xpEarned,
        coinsEarned: coinsEarned,
      );

  @override
  List<Object?> get props => [finalScore, levelsCompleted, questionsCorrect];
}
