// Entidades del dominio Lesson
// Spec: /specs/domains/learning/spec.md

import 'package:equatable/equatable.dart';

enum LessonType { intro, standard, boss, review }
enum ExerciseType { multipleChoice, dragDrop, fillBlank, match, sort, draw }
enum Difficulty { easy, medium, hard }

class Lesson extends Equatable {
  final String id;
  final String unitId;
  final int orderNum;
  final String title;
  final LessonType type;
  final int estimatedMinutes;
  final int xpReward;
  final int coinReward;
  final Difficulty difficulty;
  final List<Exercise> exercises;
  final bool isLocked;
  final bool isCompleted;

  const Lesson({
    required this.id,
    required this.unitId,
    required this.orderNum,
    required this.title,
    required this.type,
    required this.estimatedMinutes,
    required this.xpReward,
    required this.coinReward,
    required this.difficulty,
    required this.exercises,
    this.isLocked = false,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [id, orderNum, isLocked, isCompleted];
}

class Exercise extends Equatable {
  final String id;
  final int orderNum;
  final ExerciseType type;
  final Map<String, dynamic> content;
  final String? hint;
  final Map<String, String> mediaUrls;

  const Exercise({
    required this.id,
    required this.orderNum,
    required this.type,
    required this.content,
    this.hint,
    this.mediaUrls = const {},
  });

  @override
  List<Object?> get props => [id, orderNum, type];
}

class LessonResult extends Equatable {
  final String lessonId;
  final double score;        // 0.0–1.0
  final bool isCompleted;    // score >= 0.70
  final int exercisesCorrect;
  final int exercisesTotal;
  final int xpEarned;
  final int coinsEarned;
  final int? newLevel;
  final List<String> achievementsUnlocked;

  const LessonResult({
    required this.lessonId,
    required this.score,
    required this.isCompleted,
    required this.exercisesCorrect,
    required this.exercisesTotal,
    required this.xpEarned,
    required this.coinsEarned,
    this.newLevel,
    this.achievementsUnlocked = const [],
  });

  int get percentScore => (score * 100).round();

  @override
  List<Object?> get props => [lessonId, score, isCompleted];
}
