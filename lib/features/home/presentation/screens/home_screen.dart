// Home del niño — selección de grado
// UX Spec: /specs/product/ux-children.md
// Currículo: /specs/domains/learning/curriculum-men.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/lesson_progress_provider.dart';
import '../../../../../core/providers/selected_grade_provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/xp_bar.dart';

// Mock data — reemplazar con providers reales en bloque 11
class _MockChildData {
  static const name = 'Sofía';
  static const level = 3;
  static const currentXp = 240;
  static const xpToNext = 450;
  static const coins = 85;
  static const stars = 12;
  static const streak = 5;
  static const activityToday = false;
}

class _GradeConfig {
  final int grade;
  final String label;
  final String emoji;
  final String subtitle;
  final Color color;
  final int totalLessons;

  const _GradeConfig({
    required this.grade,
    required this.label,
    required this.emoji,
    required this.subtitle,
    required this.color,
    required this.totalLessons,
  });
}

const _grades = [
  _GradeConfig(
    grade: 1,
    label: 'Primer grado',
    emoji: '🌱',
    subtitle: 'Números, suma y resta hasta 20',
    color: Color(0xFF3B82F6),
    totalLessons: 15,
  ),
  _GradeConfig(
    grade: 2,
    label: 'Segundo grado',
    emoji: '⭐',
    subtitle: 'Números hasta 1.000, tablas ×2 ×3 ×5',
    color: Color(0xFF8B5CF6),
    totalLessons: 15,
  ),
  _GradeConfig(
    grade: 3,
    label: 'Tercer grado',
    emoji: '🚀',
    subtitle: 'Multiplicación, división y fracciones',
    color: Color(0xFF22C55E),
    totalLessons: 15,
  ),
  _GradeConfig(
    grade: 4,
    label: 'Cuarto grado',
    emoji: '🏆',
    subtitle: 'Fracciones, decimales y áreas',
    color: Color(0xFFF59E0B),
    totalLessons: 15,
  ),
  _GradeConfig(
    grade: 5,
    label: 'Quinto grado',
    emoji: '🎓',
    subtitle: 'Porcentajes, proporciones y álgebra',
    color: Color(0xFFEF4444),
    totalLessons: 15,
  ),
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedLessons = ref.watch(lessonProgressProvider);

    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Header(
                onSettingsTap: () => context.push('/settings'),
              ),
            ),

            SliverToBoxAdapter(child: _StreakBanner()),

            // Juegos — visible solo para Grado 4
            const SliverToBoxAdapter(child: _GamesBanner()),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: Text(
                  '¿En qué grado estás?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: EduPlayColors.textDark,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) {
                    final cfg = _grades[i];
                    final completed = cfg.grade == 1 ? completedLessons.length : 0;
                    return _GradeCard(
                      config: cfg,
                      completedLessons: completed,
                      delay: i * 80,
                      onTap: () {
                        ref.read(selectedGradeProvider.notifier).state = cfg.grade;
                        context.push('/subjects/math/units');
                      },
                    );
                  },
                  childCount: _grades.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Header ────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final VoidCallback onSettingsTap;

  const _Header({required this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 12, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: EduPlayColors.backgroundLight,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('👧', style: TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Hola, ${_MockChildData.name}! 👋',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: EduPlayColors.textDark,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      'Nivel 3 · Aventurero del Saber',
                      style: TextStyle(
                        fontSize: 13,
                        color: EduPlayColors.textMedium,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
              ),
              const _StatBadge(
                icon: '⭐',
                value: '${_MockChildData.stars}',
                bgColor: Color(0xFFFEF9C3),
                textColor: Color(0xFFB45309),
              ),
              const SizedBox(width: 6),
              const _StatBadge(
                icon: '💰',
                value: '${_MockChildData.coins}',
                bgColor: Color(0xFFFEF3C7),
                textColor: Color(0xFF92400E),
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings_rounded,
                  color: EduPlayColors.textMedium,
                  size: 22,
                ),
                onPressed: onSettingsTap,
              ),
            ],
          ),
          const SizedBox(height: 14),
          const XpBar(
            currentXp: _MockChildData.currentXp,
            xpToNextLevel: _MockChildData.xpToNext,
            level: _MockChildData.level,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _StatBadge extends StatelessWidget {
  final String icon;
  final String value;
  final Color bgColor;
  final Color textColor;

  const _StatBadge({
    required this.icon,
    required this.value,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: textColor,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Streak Banner ─────────────────────────────────────────────────
class _StreakBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Text('🔥', style: TextStyle(fontSize: 32)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_MockChildData.streak} días seguidos',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  ),
                ),
                Text(
                  _MockChildData.activityToday
                      ? '¡Ya completaste tu lección de hoy!'
                      : '¡Completa una lección para mantener tu racha!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(delay: 150.ms)
        .fadeIn(duration: 350.ms)
        .slideX(begin: -0.08, end: 0);
  }
}

// ─── Grade Card ────────────────────────────────────────────────────
class _GradeCard extends StatelessWidget {
  final _GradeConfig config;
  final int completedLessons;
  final int delay;
  final VoidCallback onTap;

  const _GradeCard({
    required this.config,
    required this.completedLessons,
    required this.delay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = completedLessons / config.totalLessons;
    final hasProgress = completedLessons > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: config.color.withValues(alpha: 0.12),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Barra de color lateral
            Container(
              width: 8,
              height: 88,
              decoration: BoxDecoration(
                color: config.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  bottomLeft: Radius.circular(22),
                ),
              ),
            ),

            // Emoji del grado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(config.emoji, style: const TextStyle(fontSize: 40)),
            ),

            // Texto + progreso
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: config.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${config.grade}°',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: config.color,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          config.label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: EduPlayColors.textDark,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      config.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: EduPlayColors.textMedium,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (hasProgress) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 5,
                          backgroundColor:
                              config.color.withValues(alpha: 0.12),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(config.color),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '$completedLessons/${config.totalLessons} lecciones',
                        style: TextStyle(
                          fontSize: 11,
                          color: config.color,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ] else
                      Text(
                        '${config.totalLessons} lecciones · ¡Empieza aquí!',
                        style: const TextStyle(
                          fontSize: 11,
                          color: EduPlayColors.textMedium,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Arrow
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: config.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: config.color,
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: delay + 200))
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.06, end: 0);
  }
}

// ─── Games Banner — Grado 4 ────────────────────────────────────────
class _GamesBanner extends StatelessWidget {
  const _GamesBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: GestureDetector(
        onTap: () => context.push('/games/g4-adventure'),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7B1FA2), Color(0xFF1565C0)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7B1FA2).withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Text('🎮', style: TextStyle(fontSize: 36)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: EduPlayColors.energyYellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '¡NUEVO! Grado 4°',
                        style: TextStyle(
                          color: Color(0xFF78350F),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'La Aventura del\nCuarto Grado',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Nunito',
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Juega y aprende fracciones, decimales y más',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 11,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white70,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(begin: 0.06, end: 0);
  }
}
