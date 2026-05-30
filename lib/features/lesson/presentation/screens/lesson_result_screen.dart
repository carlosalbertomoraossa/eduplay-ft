// Pantalla de resultado de lección
// UX Spec: /specs/product/ux-children.md — post-lesson result screen
// Spec: /specs/domains/learning/spec.md — LessonResult, score >= 0.70 = completed

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/lesson_progress_provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/ep_button.dart';
import '../../data/curriculum_data.dart';
import '../../domain/entities/lesson.dart';

class LessonResultScreen extends ConsumerWidget {
  final LessonResult result;
  const LessonResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passed = result.isCompleted;

    return Scaffold(
      backgroundColor: passed
          ? EduPlayColors.successGreen.withValues(alpha: 0.06)
          : EduPlayColors.softRed.withValues(alpha: 0.06),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            children: [
              // Emoji + título animado
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      passed ? '🏆' : '💪',
                      style: const TextStyle(fontSize: 96),
                    )
                        .animate()
                        .scale(
                          begin: const Offset(0.4, 0.4),
                          duration: 600.ms,
                          curve: Curves.elasticOut,
                        ),

                    const SizedBox(height: 20),

                    Text(
                      passed ? '¡Excelente trabajo!' : '¡Casi lo logras!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: passed
                            ? EduPlayColors.successGreen
                            : EduPlayColors.softRed,
                        fontFamily: 'Nunito',
                      ),
                    )
                        .animate(delay: 200.ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 8),

                    Text(
                      passed
                          ? 'Completaste la lección'
                          : 'Necesitas ${(0.70 * 100).round()}% para aprobar',
                      style: const TextStyle(
                        fontSize: 16,
                        color: EduPlayColors.textMedium,
                        fontFamily: 'Nunito',
                      ),
                    )
                        .animate(delay: 300.ms)
                        .fadeIn(duration: 400.ms),

                    const SizedBox(height: 40),

                    // Tarjeta de estadísticas
                    _StatsCard(result: result)
                        .animate(delay: 400.ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.15, end: 0),

                    // Achievements desbloqueados
                    if (result.achievementsUnlocked.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _AchievementsBanner(
                        achievements: result.achievementsUnlocked,
                      )
                          .animate(delay: 600.ms)
                          .fadeIn(duration: 400.ms),
                    ],

                    // Level up
                    if (result.newLevel != null) ...[
                      const SizedBox(height: 20),
                      _LevelUpBanner(newLevel: result.newLevel!)
                          .animate(delay: 700.ms)
                          .fadeIn(duration: 400.ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1, 1),
                          ),
                    ],
                  ],
                ),
              ),

              // Botones de acción
              Column(
                children: [
                  EpButton(
                    label: passed ? '¡Continuar!' : '¡Intentar de nuevo!',
                    onPressed: () {
                      if (passed) {
                        ref
                            .read(lessonProgressProvider.notifier)
                            .completeLesson(result.lessonId);
                        final unitId =
                            CurriculumData.getLesson(result.lessonId)?.unitId ??
                                'unit-001';
                        context.go('/subjects/$unitId/lessons');
                      } else {
                        context.go('/lessons/${result.lessonId}');
                      }
                    },
                  )
                      .animate(delay: 500.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 12),

                  EpButton(
                    label: 'Ir al inicio',
                    variant: EpButtonVariant.secondary,
                    onPressed: () => context.go('/home'),
                  )
                      .animate(delay: 600.ms)
                      .fadeIn(duration: 400.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final LessonResult result;
  const _StatsCard({required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: EduPlayColors.primaryBlue.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(
            emoji: '✅',
            value: '${result.exercisesCorrect}/${result.exercisesTotal}',
            label: 'Correctas',
          ),
          _Divider(),
          _StatItem(
            emoji: '⭐',
            value: '+${result.xpEarned} XP',
            label: 'Experiencia',
            valueColor: EduPlayColors.energyYellow,
          ),
          _Divider(),
          _StatItem(
            emoji: '🪙',
            value: '+${result.coinsEarned}',
            label: 'Monedas',
            valueColor: const Color(0xFFB45309),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color? valueColor;

  const _StatItem({
    required this.emoji,
    required this.value,
    required this.label,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: valueColor ?? EduPlayColors.textDark,
            fontFamily: 'Nunito',
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: EduPlayColors.textMedium,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: EduPlayColors.backgroundLight,
    );
  }
}

class _AchievementsBanner extends StatelessWidget {
  final List<String> achievements;
  const _AchievementsBanner({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFEF9C3), Color(0xFFFEF3C7)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EduPlayColors.energyYellow, width: 1.5),
      ),
      child: Row(
        children: [
          const Text('🏅', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¡Logro desbloqueado!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB45309),
                    fontFamily: 'Nunito',
                  ),
                ),
                Text(
                  achievements.join(', '),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF92400E),
                    fontFamily: 'Nunito',
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

class _LevelUpBanner extends StatelessWidget {
  final int newLevel;
  const _LevelUpBanner({required this.newLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEDE9FE), Color(0xFFDDD6FE)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: EduPlayColors.adventurePurple,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          const Text('🚀', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¡Subiste de nivel!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: EduPlayColors.adventurePurple,
                    fontFamily: 'Nunito',
                  ),
                ),
                Text(
                  'Ahora eres nivel $newLevel',
                  style: const TextStyle(
                    fontSize: 13,
                    color: EduPlayColors.adventurePurple,
                    fontFamily: 'Nunito',
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
