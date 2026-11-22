// Spec: .sdd/implemented/features/g4-adventure/g4-adventure-plan.md Fase 4 §4.1

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/game_progress_provider.dart';
import '../../../../../core/theme/app_theme.dart';

// Metadatos de cada caverna: bioma subterráneo, tema matemático y dificultad (1-3 estrellas)
const List<_LevelMeta> _levels = [
  _LevelMeta(1, 'El Pozo de Cristal', 'Fracciones Básicas', 1, Color(0xFF0D9488)),
  _LevelMeta(2, 'Cueva de los Hongos', 'Fracciones Equivalentes', 1, Color(0xFF0891B2)),
  _LevelMeta(3, 'Galerías del Eco', 'Multiplicación', 2, Color(0xFF2563EB)),
  _LevelMeta(4, 'Abismo de Ámbar', 'División', 2, Color(0xFFD97706)),
  _LevelMeta(5, 'Ruinas de Amatista', 'Decimales Intro', 2, Color(0xFF7C3AED)),
  _LevelMeta(6, 'Gruta de Luciérnagas', 'Decimales Avanzado', 3, Color(0xFF65A30D)),
  _LevelMeta(7, 'Santuario del Eclipse', 'Repaso Mixto', 3, Color(0xFFE11D48)),
  _LevelMeta(8, 'Trono de la Sombra', '¡Jefe Final!', 3, Color(0xFF9333EA)),
];

class GameLevelSelectScreen extends ConsumerWidget {
  const GameLevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(gameProgressProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
        title: const Text(
          'La Aventura del Cuarto Grado',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: Text(
              'Elige tu nivel · Desbloqueados: ${progress.unlockedLevel}/8',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontFamily: 'Nunito',
                fontSize: 15,
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
                  childAspectRatio: 1.05,
                ),
                itemCount: _levels.length,
                itemBuilder: (context, index) {
                  final meta = _levels[index];
                  return _LevelCard(
                    meta: meta,
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
    );
  }
}

class _LevelCard extends StatelessWidget {
  final _LevelMeta meta;
  final int earnedStars;
  final int bestScore;
  final bool isUnlocked;

  const _LevelCard({
    required this.meta,
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
              meta.color.withValues(alpha: isUnlocked ? 0.90 : 0.45),
              meta.color.withValues(alpha: isUnlocked ? 0.60 : 0.30),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: earnedStars > 0
                ? EduPlayColors.energyYellow
                : Colors.white.withValues(alpha: 0.15),
            width: earnedStars > 0 ? 2 : 1.5,
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
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Número de nivel
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${meta.level}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  if (earnedStars > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '⚡ $bestScore pts',
                        style: const TextStyle(
                          color: EduPlayColors.energyYellow,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    )
                  else if (meta.level == 8)
                    const Text('👑', style: TextStyle(fontSize: 20)),
                ],
              ),
              const Spacer(),
              // Nombre del bioma y tema matemático
              Text(
                meta.biomeName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.5,
                  fontFamily: 'Nunito',
                  height: 1.15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                meta.topic,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.82),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.5,
                  fontFamily: 'Nunito',
                  height: 1.15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              // Estrellas ganadas o dificultad
              Row(
                children: [
                  ...List.generate(3, (i) {
                    return Icon(
                      i < displayStars
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: i < displayStars
                          ? EduPlayColors.energyYellow
                          : Colors.white.withValues(alpha: 0.3),
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
  final String topic;
  final int stars;
  final Color color;

  const _LevelMeta(
    this.level,
    this.biomeName,
    this.topic,
    this.stars,
    this.color,
  );
}
