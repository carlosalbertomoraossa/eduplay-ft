// Entidades del dashboard parental
// Spec: /specs/domains/parents/spec.md

import 'package:equatable/equatable.dart';

class ChildSummary extends Equatable {
  final String childId;
  final String displayName;
  final int grade;
  final String avatarEmoji;
  final int streakCurrent;
  final int xpThisWeek;
  final int lessonsThisWeek;
  final int minutesThisWeek;
  final DateTime lastActive;
  final double mathProgress; // 0.0–1.0

  const ChildSummary({
    required this.childId,
    required this.displayName,
    required this.grade,
    required this.avatarEmoji,
    required this.streakCurrent,
    required this.xpThisWeek,
    required this.lessonsThisWeek,
    required this.minutesThisWeek,
    required this.lastActive,
    required this.mathProgress,
  });

  @override
  List<Object?> get props => [childId];
}

class UnitProgressSummary extends Equatable {
  final String unitId;
  final String title;
  final int lessonsCompleted;
  final int lessonsTotal;
  final bool isLocked;

  const UnitProgressSummary({
    required this.unitId,
    required this.title,
    required this.lessonsCompleted,
    required this.lessonsTotal,
    required this.isLocked,
  });

  double get percent =>
      lessonsTotal == 0 ? 0 : lessonsCompleted / lessonsTotal;

  bool get isComplete => lessonsCompleted >= lessonsTotal;

  @override
  List<Object?> get props => [unitId];
}

class WeeklyActivity extends Equatable {
  final List<bool> activeDays; // 7 elementos: lun → dom
  final int lessonsCompleted;
  final int minutesStudied;
  final double avgScore;

  const WeeklyActivity({
    required this.activeDays,
    required this.lessonsCompleted,
    required this.minutesStudied,
    required this.avgScore,
  });

  int get activeDaysCount => activeDays.where((d) => d).length;

  @override
  List<Object?> get props => [activeDays, lessonsCompleted];
}
