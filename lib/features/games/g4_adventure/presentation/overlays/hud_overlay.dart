// Spec: .sdd/implemented/features/g4-adventure/g4-adventure-plan.md Fase 4 §4.3

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/heart_indicator.dart';
import '../../g4_adventure_game.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_state.dart';

/// HUD superpuesto sobre el canvas de Flame.
/// Muestra nivel + bioma, progreso de sellos con brújula, vidas y puntuación.
class HudOverlay extends StatelessWidget {
  final GameBloc gameBloc;
  final G4AdventureGame? game;

  const HudOverlay({
    super.key,
    required this.gameBloc,
    this.game,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: BlocBuilder<GameBloc, GameState>(
        bloc: gameBloc,
        buildWhen: (prev, curr) => curr is GameInProgress,
        builder: (context, state) {
          final inProgress = state is GameInProgress ? state : null;
          final score = inProgress?.score ?? 0;
          final lives = inProgress?.lives ?? 3;
          final level = inProgress?.currentLevel ?? 1;
          final multiplier = inProgress?.scoreMultiplier ?? 1;
          final answered = inProgress?.questionsAnswered ?? 0;

          return SafeArea(
            child: Stack(
              children: [
                // ── Nivel, bioma y brújula de sellos arriba-centro ──
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _LevelSealBadge(
                          level: level,
                          answered: answered,
                          game: game,
                        ),
                        if (game != null)
                          ValueListenableBuilder<String?>(
                            valueListenable: game!.toastMessageNotifier,
                            builder: (_, toast, __) {
                              if (toast == null) return const SizedBox.shrink();
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF090D18)
                                        .withValues(alpha: 0.78),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: const Color(0xFFFDE047)
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                  child: Text(
                                    toast,
                                    style: const TextStyle(
                                      color: Color(0xFFFEF08A),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
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
      ),
    );
  }
}

class _LevelSealBadge extends StatelessWidget {
  final int level;
  final int answered;
  final G4AdventureGame? game;

  const _LevelSealBadge({
    required this.level,
    required this.answered,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1120).withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF5EEAD4).withValues(alpha: 0.45),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'N$level',
            style: const TextStyle(
              color: Color(0xFF5EEAD4),
              fontWeight: FontWeight.w900,
              fontSize: 13,
              fontFamily: 'Nunito',
            ),
          ),
          if (game != null) ...[
            const SizedBox(width: 6),
            ValueListenableBuilder<String>(
              valueListenable: game!.biomeNameNotifier,
              builder: (_, biome, __) => Text(
                biome,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ],
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🕯️', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 3),
                Text(
                  '$answered/10',
                  style: const TextStyle(
                    color: Color(0xFFFDE047),
                    fontWeight: FontWeight.w900,
                    fontSize: 12.5,
                    fontFamily: 'Nunito',
                  ),
                ),
                if (game != null)
                  ValueListenableBuilder<int>(
                    valueListenable: game!.targetDirectionNotifier,
                    builder: (_, dir, __) {
                      if (dir == 0) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Icon(
                          dir > 0
                              ? Icons.chevron_right_rounded
                              : Icons.chevron_left_rounded,
                          color: const Color(0xFFFDE047),
                          size: 16,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
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
            shadows: [Shadow(color: Colors.black87, blurRadius: 4)],
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
