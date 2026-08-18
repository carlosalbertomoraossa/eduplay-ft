// Entidades de gamificación — logros y ranking
// Spec: /specs/domains/gamification/spec.md

import 'package:equatable/equatable.dart';

/// Un logro del catálogo MVP (10 logros — spec sección "Catálogo de logros").
class Achievement extends Equatable {
  final String code;
  final String name;
  final String description;
  final String emoji;
  final bool unlocked;

  const Achievement({
    required this.code,
    required this.name,
    required this.description,
    required this.emoji,
    required this.unlocked,
  });

  @override
  List<Object?> get props => [code, unlocked];
}

/// Una fila del ranking semanal de amigos (solo XP de la semana — spec regla 7).
class LeaderboardEntry extends Equatable {
  final int position;
  final String displayName;
  final String avatarEmoji;
  final int xpThisWeek;
  final bool isCurrentChild;

  const LeaderboardEntry({
    required this.position,
    required this.displayName,
    required this.avatarEmoji,
    required this.xpThisWeek,
    this.isCurrentChild = false,
  });

  @override
  List<Object?> get props => [position, displayName];
}
