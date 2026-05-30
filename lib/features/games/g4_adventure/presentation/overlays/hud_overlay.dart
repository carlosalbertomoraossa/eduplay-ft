// Spec: specs/games/g4-adventure-plan.md Fase 4 §4.3

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/heart_indicator.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_state.dart';

/// HUD superpuesto sobre el canvas de Flame.
/// Layout: Nivel centrado arriba · Vidas + score arriba-derecha.
class HudOverlay extends StatelessWidget {
  final GameBloc gameBloc;

  const HudOverlay({super.key, required this.gameBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      bloc: gameBloc,
      buildWhen: (prev, curr) => curr is GameInProgress,
      builder: (context, state) {
        final inProgress = state is GameInProgress ? state : null;
        final score = inProgress?.score ?? 0;
        final lives = inProgress?.lives ?? 3;
        final level = inProgress?.currentLevel ?? 1;
        final multiplier = inProgress?.scoreMultiplier ?? 1;

        return SafeArea(
          child: Stack(
            children: [
              // ── Nivel centrado en la parte superior ──
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _LevelBadge(level: level),
                ),
              ),
              // ── Vidas + puntuación arriba-derecha ──
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      HeartIndicator(currentHearts: lives, maxHearts: 5),
                      const SizedBox(height: 2),
                      _ScoreText(score: score, multiplier: multiplier),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;
  const _LevelBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: EduPlayColors.adventurePurple,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: EduPlayColors.adventurePurple.withValues(alpha: 0.45),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        'Nivel $level',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 14,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }
}

class _ScoreText extends StatelessWidget {
  final int score;
  final int multiplier;
  const _ScoreText({required this.score, required this.multiplier});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$score pts',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 15,
            fontFamily: 'Nunito',
            shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
          ),
        ),
        if (multiplier > 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: EduPlayColors.energyYellow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '×$multiplier',
              style: const TextStyle(
                color: EduPlayColors.textDark,
                fontWeight: FontWeight.w900,
                fontSize: 11,
                fontFamily: 'Nunito',
              ),
            ),
          ),
      ],
    );
  }
}
