// Home del niño — centro de aventuras Generación Alfa + Calendario MEN Colombia
// UX Spec: ../.sdd/implemented/features/ux-children/technical-specs.md
// Currículo: ../.sdd/implemented/features/domain-learning/curriculum-men.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/child_progress_provider.dart';
import '../../../../../core/providers/colombia_calendar_provider.dart';
import '../../../../../core/providers/daily_quests_provider.dart';
import '../../../../../core/providers/lesson_progress_provider.dart';
import '../../../../../core/providers/lumi_customization_provider.dart';
import '../../../../../core/providers/selected_grade_provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/lumi_lion_mascot.dart';
import '../../../../../shared/widgets/playful_world_background.dart';
import '../../../../../shared/widgets/xp_bar.dart';
import '../../../lesson/data/curriculum_data.dart';

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
    subtitle: '4 períodos · Números hasta 100, figuras y pictogramas',
    color: Color(0xFF3B82F6),
    totalLessons: 40,
  ),
  _GradeConfig(
    grade: 2,
    label: 'Segundo grado',
    emoji: '⭐',
    subtitle: '4 períodos · Números hasta 1.000, tablas, regla y gráficas',
    color: Color(0xFF8B5CF6),
    totalLessons: 35,
  ),
  _GradeConfig(
    grade: 3,
    label: 'Tercer grado',
    emoji: '🚀',
    subtitle: '4 períodos · Multiplicación, división, fracciones y perímetro',
    color: Color(0xFF22C55E),
    totalLessons: 40,
  ),
  _GradeConfig(
    grade: 4,
    label: 'Cuarto grado',
    emoji: '🏆',
    subtitle: '4 períodos · Fracciones, decimales, ángulos, áreas y probabilidad',
    color: Color(0xFFF59E0B),
    totalLessons: 40,
  ),
  _GradeConfig(
    grade: 5,
    label: 'Quinto grado',
    emoji: '🎓',
    subtitle: '4 períodos · Enteros, porcentajes, volumen y álgebra inicial',
    color: Color(0xFFEF4444),
    totalLessons: 40,
  ),
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedLessons = ref.watch(lessonProgressProvider);
    final childProgress = ref.watch(childProgressProvider);
    final calendar = ref.watch(colombiaCalendarProvider);
    final dailyQuests = ref.watch(dailyQuestsProvider);
    final outfit = ref.watch(lumiCustomizationProvider).equipped;
    int activeGrade = 4;
    try {
      activeGrade = ref.watch(selectedGradeProvider);
    } catch (_) {}
    final activePeriod = calendar.activePeriod();

    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      body: PlayfulWorldBackground(
        theme: PlayfulWorldTheme.sunnyMeadow,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _Header(
                  childName: 'Sofía',
                  progress: childProgress,
                  activeGrade: activeGrade,
                  outfit: outfit,
                  onLumiTap: () => context.push('/lumi-wardrobe'),
                  onSettingsTap: () => context.push('/settings'),
                ),
              ),

              // Meta Semanal Saludable + Calendario Escolar Colombia
              SliverToBoxAdapter(
                child: _HealthyHabitBanner(
                  progress: childProgress,
                  calendar: calendar,
                  activePeriod: activePeriod,
                ),
              ),

              // Misiones de Hoy (3–5 min)
              SliverToBoxAdapter(
                child: _DailyQuestsCard(
                  questsState: dailyQuests,
                  onClaim: (quest) {
                    final claimed = ref
                        .read(dailyQuestsProvider.notifier)
                        .claimQuest(quest.id);
                    if (claimed != null) {
                      ref.read(childProgressProvider.notifier).addReward(
                            xp: claimed.xpReward,
                            coins: claimed.coinReward,
                            stars: 1,
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: const Color(0xFF10B981),
                          content: Text(
                            '¡Misión reclamada! +${claimed.coinReward} monedas y +${claimed.xpReward} XP',
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),

              const SliverToBoxAdapter(child: _GamificationLinksRow()),

              // Juego Cuaderno Mágico — ahora multi-grado 1°–5° alineado al período
              SliverToBoxAdapter(
                child: _GamesBanner(
                  grade: activeGrade,
                  activePeriod: activePeriod,
                  outfit: outfit,
                ),
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 22, 24, 12),
                  child: Text(
                    '🌈 ¿En qué grado estás?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
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
                      final completed = completedLessons
                          .intersection(
                              CurriculumData.getLessonIdsForGrade(cfg.grade))
                          .length;
                      return _GradeCard(
                        config: cfg,
                        isSelected: cfg.grade == activeGrade,
                        completedLessons: completed,
                        delay: i * 80,
                        onTap: () {
                          ref
                              .read(selectedGradeProvider.notifier)
                              .setGrade(cfg.grade);
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
      ),
    );
  }
}

// ─── Header ────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final String childName;
  final ChildProgressState progress;
  final int activeGrade;
  final LumiOutfit outfit;
  final VoidCallback onLumiTap;
  final VoidCallback onSettingsTap;

  const _Header({
    required this.childName,
    required this.progress,
    required this.activeGrade,
    required this.outfit,
    required this.onLumiTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 12, 18),
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
              Tooltip(
                message: 'Personalizar a Lumi',
                child: LumiLionMascot(
                  size: 56,
                  grade: activeGrade,
                  expressionVariant: 1,
                  outfit: outfit,
                  interactive: true,
                  onTap: onLumiTap,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Hola, $childName! 👋',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: EduPlayColors.textDark,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      'Nivel ${progress.level} · ${progress.levelTitle}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: EduPlayColors.textMedium,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              _StatBadge(
                icon: '⭐',
                value: '${progress.stars}',
                bgColor: const Color(0xFFFEF9C3),
                textColor: const Color(0xFFB45309),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onLumiTap,
                child: _StatBadge(
                  icon: '🪙',
                  value: '${progress.coins}',
                  bgColor: const Color(0xFFFEF3C7),
                  textColor: const Color(0xFF92400E),
                ),
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
          const SizedBox(height: 12),
          XpBar(
            currentXp: progress.xpIntoCurrentLevel,
            xpToNextLevel: progress.xpToNextLevel,
            level: progress.level,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 380.ms);
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
              fontSize: 13.5,
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

// ─── Hábito Saludable (Meta Semanal + Escudo + Período Colombia) ───
class _HealthyHabitBanner extends StatelessWidget {
  final ChildProgressState progress;
  final ColombiaCalendarState calendar;
  final int activePeriod;

  const _HealthyHabitBanner({
    required this.progress,
    required this.calendar,
    required this.activePeriod,
  });

  static const _dayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    final weekPattern = progress.weekActivityPattern();
    final activeThisWeek = progress.activeDaysInWeek();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF6B35), Color(0xFFF59E0B)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withValues(alpha: 0.28),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 26)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meta semanal: $activeThisWeek/${progress.weeklyGoalDays} días activos',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      '🇨🇴 ${calendar.summaryLabel()}',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.92),
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  '🛡️ ${progress.streakShields}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 12.5,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final done = weekPattern[i];
              return Container(
                width: 34,
                height: 28,
                decoration: BoxDecoration(
                  color: done
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  done ? '✓' : _dayLabels[i],
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: done ? const Color(0xFFEA580C) : Colors.white,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    )
        .animate(delay: 120.ms)
        .fadeIn(duration: 350.ms)
        .slideX(begin: -0.05, end: 0);
  }
}

// ─── Misiones Diarias (3–5 minutos) ────────────────────────────────
class _DailyQuestsCard extends StatelessWidget {
  final DailyQuestsState questsState;
  final void Function(DailyQuest quest) onClaim;

  const _DailyQuestsCard({
    required this.questsState,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF38BDF8).withValues(alpha: 0.35),
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0284C7).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎯', style: TextStyle(fontSize: 19)),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'Misiones de Hoy (3–5 min)',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: EduPlayColors.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${questsState.completedCount}/${questsState.quests.length}',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: Color(0xFF0369A1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...questsState.quests.map((q) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(q.emoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          q.title,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: EduPlayColors.textDark,
                          ),
                        ),
                        Text(
                          q.subtitle,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 11,
                            color: EduPlayColors.textMedium,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: q.ratio,
                            minHeight: 6,
                            backgroundColor: const Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              q.isCompleted
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFF38BDF8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (q.canClaim)
                    GestureDetector(
                      onTap: () => onClaim(q),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '+🪙${q.coinReward}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w900,
                            fontSize: 11.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  else if (q.claimed)
                    const Text(
                      '✅',
                      style: TextStyle(fontSize: 18),
                    )
                  else
                    Text(
                      '${q.progress}/${q.target}',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: EduPlayColors.textMedium,
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate(delay: 150.ms).fadeIn(duration: 350.ms);
  }
}

// ─── Accesos a Armario de Lumi, Logros y Ranking ───────────────────
class _GamificationLinksRow extends StatelessWidget {
  const _GamificationLinksRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: _GamificationLinkCard(
              emoji: '👕',
              label: 'Armario',
              color: const Color(0xFFEC4899),
              onTap: () => context.push('/lumi-wardrobe'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _GamificationLinkCard(
              emoji: '🏆',
              label: 'Logros',
              color: EduPlayColors.adventurePurple,
              onTap: () => context.push('/achievements'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _GamificationLinkCard(
              emoji: '🥇',
              label: 'Ranking',
              color: EduPlayColors.primaryBlue,
              onTap: () => context.push('/leaderboard'),
            ),
          ),
        ],
      ),
    )
        .animate(delay: 180.ms)
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.05, end: 0);
  }
}

class _GamificationLinkCard extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _GamificationLinkCard({
    required this.emoji,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.28), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.10),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Grade Card ────────────────────────────────────────────────────
class _GradeCard extends StatelessWidget {
  final _GradeConfig config;
  final bool isSelected;
  final int completedLessons;
  final int delay;
  final VoidCallback onTap;

  const _GradeCard({
    required this.config,
    required this.isSelected,
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
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: config.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: config.color.withValues(alpha: isSelected ? 0.34 : 0.20),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: config.color.withValues(alpha: isSelected ? 0.90 : 0.55),
              width: isSelected ? 2.8 : 2.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 88,
                decoration: BoxDecoration(
                  color: config.color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(config.emoji, style: const TextStyle(fontSize: 40)),
              ),
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
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: config.color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Activo',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ],
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
      ),
    )
        .animate(delay: Duration(milliseconds: delay + 200))
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.06, end: 0);
  }
}

// ─── Banner Juego Multi-Grado: El Cuaderno Mágico de Lumi ──────────
class _GamesBanner extends StatelessWidget {
  final int grade;
  final int activePeriod;
  final LumiOutfit outfit;

  const _GamesBanner({
    required this.grade,
    required this.activePeriod,
    required this.outfit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GestureDetector(
        onTap: () => context.push('/games/g4-adventure'),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0F766E), Color(0xFF2563EB)],
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2563EB).withValues(alpha: 0.30),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              LumiLionMascot(
                size: 56,
                grade: grade,
                outfit: outfit,
                expressionVariant: 1,
              ),
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
                      child: Text(
                        'JUEGO · Grado $grade° · Período $activePeriod',
                        style: const TextStyle(
                          color: Color(0xFF78350F),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'El Cuaderno Mágico de Lumi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Nunito',
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Salta, recoge estrellas y domina los DBA de tu grado',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
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
