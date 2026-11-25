// Spec: .sdd/implemented/features/g4-adventure/g4-adventure-plan.md Fase 4 §4.1

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/colombia_calendar_provider.dart';
import '../../../../../core/providers/game_progress_provider.dart';
import '../../../../../core/providers/selected_grade_provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../data/game_questions_provider.dart';

// Metadatos visuales de los 8 capítulos del Cuaderno Escolar Mágico (2 por período MEN)
const List<_LevelMeta> _levels = [
  _LevelMeta(1, 'Cuaderno Menta', 1, Color(0xFF0F766E)),
  _LevelMeta(2, 'Acuarela Coral', 1, Color(0xFFE11D48)),
  _LevelMeta(3, 'Página Celeste', 2, Color(0xFF2563EB)),
  _LevelMeta(4, 'Boceto Mandarina', 2, Color(0xFFEA580C)),
  _LevelMeta(5, 'Diario Lavanda', 2, Color(0xFF7C3AED)),
  _LevelMeta(6, 'Atlas Botánico', 3, Color(0xFF15803D)),
  _LevelMeta(7, 'Taller Fucsia', 3, Color(0xFFBE185D)),
  _LevelMeta(8, 'Gran Enciclopedia', 3, Color(0xFF4338CA)),
];

class GameLevelSelectScreen extends ConsumerWidget {
  const GameLevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(gameProgressProvider);
    final calendar = ref.watch(colombiaCalendarProvider);
    final activePeriod = calendar.activePeriod();
    int grade = 4;
    try {
      grade = ref.watch(selectedGradeProvider);
    } catch (_) {}

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFDF7),
        foregroundColor: const Color(0xFF1E293B),
        title: Text(
          'Cuaderno Mágico · Grado $grade°',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFDF7),
              Color(0xFFFEF9C3),
              Color(0xFFE0F2FE),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Selector rápido de Grado (1° a 5°) para cambiar en 1 toque dentro del juego
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var g = 1; g <= 5; g++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: g < 5 ? 6 : 0),
                        child: GestureDetector(
                          onTap: () {
                            try {
                              ref
                                  .read(selectedGradeProvider.notifier)
                                  .setGrade(g);
                            } catch (_) {}
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: g == grade
                                  ? EduPlayColors.primaryBlue
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: g == grade
                                    ? EduPlayColors.primaryBlue
                                    : EduPlayColors.primaryBlue
                                        .withValues(alpha: 0.30),
                                width: g == grade ? 2.0 : 1.3,
                              ),
                              boxShadow: g == grade
                                  ? [
                                      BoxShadow(
                                        color: EduPlayColors.primaryBlue
                                            .withValues(alpha: 0.28),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$g°',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: g == grade
                                    ? Colors.white
                                    : EduPlayColors.textDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.65),
                    width: 1.6,
                  ),
                ),
                child: Text(
                  '📅 ${calendar.summaryLabel()} · Capítulos: ${progress.unlockedLevel}/8',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF92400E),
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: _levels.length,
                  itemBuilder: (context, index) {
                    final meta = _levels[index];
                    final chapterPeriod =
                        GameQuestionsProvider.periodForLevel(meta.level);
                    final topic = GameQuestionsProvider.topicForGradeAndLevel(
                      grade: grade,
                      level: meta.level,
                    );
                    return _LevelCard(
                      meta: meta,
                      topic: topic,
                      period: chapterPeriod,
                      isCurrentPeriod: chapterPeriod == activePeriod,
                      earnedStars: progress.starsFor(meta.level),
                      bestScore: progress.bestScoreFor(meta.level),
                      isUnlocked: progress.isUnlocked(meta.level),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final _LevelMeta meta;
  final String topic;
  final int period;
  final bool isCurrentPeriod;
  final int earnedStars;
  final int bestScore;
  final bool isUnlocked;

  const _LevelCard({
    required this.meta,
    required this.topic,
    required this.period,
    required this.isCurrentPeriod,
    required this.earnedStars,
    required this.bestScore,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    final displayStars = earnedStars > 0 ? earnedStars : meta.stars;

    return GestureDetector(
      onTap: () => context.push('/games/g4-adventure/play/${meta.level}'),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              meta.color.withValues(alpha: isUnlocked ? 0.98 : 0.75),
              meta.color.withValues(alpha: isUnlocked ? 0.80 : 0.58),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isCurrentPeriod
                ? EduPlayColors.energyYellow
                : (earnedStars > 0
                    ? EduPlayColors.energyYellow
                    : Colors.white.withValues(alpha: 0.65)),
            width: isCurrentPeriod ? 2.8 : (earnedStars > 0 ? 2.5 : 1.8),
          ),
          boxShadow: [
            BoxShadow(
              color: meta.color.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Cap. ${meta.level} · P$period',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 11.5,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  if (isCurrentPeriod)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: EduPlayColors.energyYellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '📍 Hoy',
                        style: TextStyle(
                          color: Color(0xFF78350F),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    )
                  else if (earnedStars > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '⚡ $bestScore',
                        style: const TextStyle(
                          color: EduPlayColors.energyYellow,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    )
                  else if (meta.level == 8)
                    const Text('👑', style: TextStyle(fontSize: 18)),
                ],
              ),
              const Spacer(),
              Text(
                meta.biomeName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13.5,
                  fontFamily: 'Nunito',
                  height: 1.15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                topic,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.90),
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5,
                  fontFamily: 'Nunito',
                  height: 1.15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  ...List.generate(3, (i) {
                    return Icon(
                      i < displayStars
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: i < displayStars
                          ? EduPlayColors.energyYellow
                          : Colors.white.withValues(alpha: 0.35),
                      size: 16,
                    );
                  }),
                  if (earnedStars > 0) ...[
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelMeta {
  final int level;
  final String biomeName;
  final int stars;
  final Color color;

  const _LevelMeta(
    this.level,
    this.biomeName,
    this.stars,
    this.color,
  );
}
