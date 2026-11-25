// Spec: .sdd/implemented/features/g4-adventure/g4-adventure-plan.md Fase 4 §4.3

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/heart_indicator.dart';
import '../../../../../shared/widgets/lumi_lion_mascot.dart';
import '../../g4_adventure_game.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_state.dart';

/// HUD colorido estilo juguete superpuesto sobre el canvas de Flame.
/// Muestra a Lumi, nivel + mundo, progreso de retos con brújula, estrellitas, vidas y puntaje.
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
                // ── Lumi + Nivel, mundo y brújula de retos arriba-centro ──
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
                          multiplier: multiplier,
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
                                    color: const Color(0xFFFEF9C3)
                                        .withValues(alpha: 0.95),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFF59E0B),
                                      width: 1.6,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.14),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    toast,
                                    style: const TextStyle(
                                      color: Color(0xFF92400E),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.90),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: const Color(0xFFFB7185).withValues(alpha: 0.55),
                              width: 1.6,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: HeartIndicator(currentHearts: lives, maxHearts: 5),
                        ),
                        const SizedBox(height: 5),
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
  final int multiplier;
  final G4AdventureGame? game;

  const _LevelSealBadge({
    required this.level,
    required this.answered,
    required this.multiplier,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFF38BDF8),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0369A1).withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mini-avatar de Lumi reaccionando a la racha y con su outfit equipado
          LumiLionMascot(
            size: 30,
            grade: 4,
            accentColor: const Color(0xFF10B981),
            expressionVariant: multiplier >= 2 ? 1 : 0,
            outfit: game?.outfit,
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF38BDF8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'N$level',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          if (game != null) ...[
            const SizedBox(width: 6),
            ValueListenableBuilder<String>(
              valueListenable: game!.biomeNameNotifier,
              builder: (_, biome, __) => Text(
                biome,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ],
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF08A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF59E0B), width: 1.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('⭐', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 3),
                Text(
                  '$answered/10',
                  style: const TextStyle(
                    color: Color(0xFF92400E),
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    fontFamily: 'Nunito',
                  ),
                ),
                if (game != null)
                  ValueListenableBuilder<int>(
                    valueListenable: game!.targetDirectionNotifier,
                    builder: (_, dir, __) {
                      if (dir == 0) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Icon(
                          dir > 0
                              ? Icons.chevron_right_rounded
                              : Icons.chevron_left_rounded,
                          color: const Color(0xFFD97706),
                          size: 16,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          if (game != null) ...[
            const SizedBox(width: 6),
            ValueListenableBuilder<int>(
              valueListenable: game!.starsCollectedNotifier,
              builder: (_, stars, __) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF22C55E), width: 1.2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('✨', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 2),
                    Text(
                      '$stars',
                      style: const TextStyle(
                        color: Color(0xFF166534),
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (multiplier > 1) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFF97316),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 1.4),
            ),
            child: Text(
              '×$multiplier',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 11,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: EduPlayColors.energyYellow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white, width: 1.6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            '⚡ $score pts',
            style: const TextStyle(
              color: EduPlayColors.textDark,
              fontWeight: FontWeight.w900,
              fontSize: 13,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ],
    );
  }
}
