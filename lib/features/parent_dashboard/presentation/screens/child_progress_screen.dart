// Progreso detallado del niño — vista para el padre
// Spec: /specs/domains/parents/spec.md + /specs/domains/progress/spec.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../domain/entities/parent_entities.dart';

// Mock — reemplazar con progress-service + gamification-service cuando existan
class _MockChildProgress {
  static const childId = 'child-001';
  static const displayName = 'Sofía';
  static const grade = 2;
  static const avatarEmoji = '👧';
  static const level = 3;
  static const totalXp = 240;
  static const streakCurrent = 5;
  static const coins = 85;

  static const weeklyActivity = WeeklyActivity(
    activeDays: [true, false, true, true, false, false, false], // lun-dom
    lessonsCompleted: 3,
    minutesStudied: 21,
    avgScore: 0.84,
  );

  static const unitProgress = [
    UnitProgressSummary(
      unitId: 'unit-001',
      title: 'Números del 1 al 100',
      lessonsCompleted: 5,
      lessonsTotal: 5,
      isLocked: false,
    ),
    UnitProgressSummary(
      unitId: 'unit-002',
      title: 'Suma hasta 20',
      lessonsCompleted: 0,
      lessonsTotal: 5,
      isLocked: false,
    ),
    UnitProgressSummary(
      unitId: 'unit-003',
      title: 'Resta hasta 20',
      lessonsCompleted: 0,
      lessonsTotal: 5,
      isLocked: true,
    ),
    UnitProgressSummary(
      unitId: 'unit-004',
      title: 'Multiplicación básica',
      lessonsCompleted: 0,
      lessonsTotal: 5,
      isLocked: true,
    ),
  ];
}

class ChildProgressScreen extends StatelessWidget {
  final String childId;
  const ChildProgressScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          _ProfileHeader(
            onBack: () =>
                context.canPop() ? context.pop() : context.go('/parent/dashboard'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _WeeklySection()
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 350.ms),
                const SizedBox(height: 24),
                _UnitsProgressSection()
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 350.ms),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Profile header (SliverAppBar) ────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final VoidCallback onBack;
  const _ProfileHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: EduPlayColors.primaryBlue,
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        onPressed: onBack,
      ),
      title: Text(
        'Progreso de ${_MockChildProgress.displayName}',
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF1CB0F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 56, 24, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.5), width: 2),
                    ),
                    child: const Center(
                      child: Text(_MockChildProgress.avatarEmoji,
                          style: TextStyle(fontSize: 40)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _MockChildProgress.displayName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Text(
                          'Grado ${_MockChildProgress.grade}° · Nivel ${_MockChildProgress.level}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _HeaderBadge(
                                emoji: '🔥',
                                text:
                                    '${_MockChildProgress.streakCurrent} días'),
                            const SizedBox(width: 8),
                            _HeaderBadge(
                                emoji: '⭐',
                                text:
                                    '${_MockChildProgress.totalXp} XP total'),
                            const SizedBox(width: 8),
                            _HeaderBadge(
                                emoji: '💰',
                                text: '${_MockChildProgress.coins} monedas'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderBadge extends StatelessWidget {
  final String emoji;
  final String text;
  const _HeaderBadge({required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$emoji $text',
        style: const TextStyle(
          fontSize: 11,
          color: Colors.white,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ─── Weekly activity section ───────────────────────────────────────
class _WeeklySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const activity = _MockChildProgress.weeklyActivity;
    const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actividad esta semana',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: EduPlayColors.textDark,
            fontFamily: 'Nunito',
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: EduPlayColors.primaryBlue.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              // Days grid
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (i) {
                  final isActive = activity.activeDays[i];
                  return Column(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? EduPlayColors.successGreen
                              : EduPlayColors.backgroundLight,
                          border: isActive
                              ? null
                              : Border.all(
                                  color: const Color(0xFFE2E8F0), width: 1),
                        ),
                        child: Center(
                          child: isActive
                              ? const Icon(Icons.check_rounded,
                                  color: Colors.white, size: 18)
                              : Text(
                                  days[i],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: EduPlayColors.textMedium,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        days[i],
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          color: isActive
                              ? EduPlayColors.successGreen
                              : EduPlayColors.textMedium,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 16),
              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _WeeklyStat(
                    value: '${activity.activeDaysCount}',
                    label: 'días activos',
                    emoji: '📅',
                  ),
                  _WeeklyStat(
                    value: '${activity.lessonsCompleted}',
                    label: 'lecciones',
                    emoji: '📚',
                  ),
                  _WeeklyStat(
                    value: '${activity.minutesStudied} min',
                    label: 'estudiados',
                    emoji: '⏱️',
                  ),
                  _WeeklyStat(
                    value: '${(activity.avgScore * 100).round()}%',
                    label: 'promedio',
                    emoji: '🎯',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeeklyStat extends StatelessWidget {
  final String value;
  final String label;
  final String emoji;
  const _WeeklyStat(
      {required this.value, required this.label, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: EduPlayColors.textDark,
            fontFamily: 'Nunito',
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: EduPlayColors.textMedium,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}

// ─── Units progress section ────────────────────────────────────────
class _UnitsProgressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progreso en Matemáticas',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: EduPlayColors.textDark,
            fontFamily: 'Nunito',
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: EduPlayColors.primaryBlue.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: _MockChildProgress.unitProgress.asMap().entries.map((e) {
              return Column(
                children: [
                  _UnitProgressRow(unit: e.value),
                  if (e.key < _MockChildProgress.unitProgress.length - 1)
                    const Divider(height: 24, color: Color(0xFFF1F5F9)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _UnitProgressRow extends StatelessWidget {
  final UnitProgressSummary unit;
  const _UnitProgressRow({required this.unit});

  @override
  Widget build(BuildContext context) {
    final color = unit.isComplete
        ? EduPlayColors.successGreen
        : unit.isLocked
            ? const Color(0xFFCBD5E1)
            : EduPlayColors.primaryBlue;

    return Opacity(
      opacity: unit.isLocked ? 0.5 : 1.0,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: unit.isLocked
                  ? const Icon(Icons.lock_rounded,
                      size: 16, color: Color(0xFFCBD5E1))
                  : unit.isComplete
                      ? Icon(Icons.check_circle_rounded,
                          size: 20, color: EduPlayColors.successGreen)
                      : const Icon(Icons.play_circle_rounded,
                          size: 20, color: EduPlayColors.primaryBlue),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unit.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito',
                    color: unit.isLocked
                        ? EduPlayColors.textMedium
                        : EduPlayColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                if (!unit.isLocked) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: unit.percent,
                      minHeight: 5,
                      backgroundColor: EduPlayColors.backgroundLight,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
                Text(
                  unit.isLocked
                      ? 'Bloqueada'
                      : '${unit.lessonsCompleted}/${unit.lessonsTotal} lecciones completadas',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Nunito',
                    color: unit.isLocked ? EduPlayColors.textMedium : color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
