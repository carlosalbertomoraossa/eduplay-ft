// Spec: specs/games/g4-adventure-plan.md Fase 4

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

/// Overlay de game over. Muestra score final y opción de reintentar o salir.
class GameOverOverlay extends StatelessWidget {
  final GameBloc gameBloc;
  final VoidCallback onExit;

  const GameOverOverlay({
    super.key,
    required this.gameBloc,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      bloc: gameBloc,
      builder: (context, state) {
        final result = state is GameOver ? state.result : null;
        return Container(
          color: Colors.black.withValues(alpha: 0.75),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: EduPlayColors.surfaceWhite,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('😢', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 8),
                  const Text(
                    '¡Se acabaron las vidas!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nunito',
                      color: EduPlayColors.textDark,
                    ),
                  ),
                  if (result != null) ...[
                    const SizedBox(height: 12),
                    _StatRow(label: 'Puntaje', value: '${result.finalScore}'),
                    _StatRow(
                      label: 'Aciertos',
                      value:
                          '${result.questionsCorrect}/${result.questionsTotal}',
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onExit,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: EduPlayColors.textMedium,
                            side: const BorderSide(
                              color: EduPlayColors.textMedium,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Salir',
                            style: TextStyle(fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final level = result?.levelsCompleted ?? 1;
                            gameBloc.add(GameRestarted(level));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: EduPlayColors.softRed,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Reintentar',
                            style: TextStyle(fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: EduPlayColors.textMedium,
              fontSize: 14,
              fontFamily: 'Nunito',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: EduPlayColors.textDark,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }
}
