// Spec: specs/games/g4-adventure-plan.md Fase 4

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

/// Overlay de nivel completado. Muestra estrellas, score parcial y botón
/// para continuar al siguiente nivel (o salir si era el último).
class LevelCompleteOverlay extends StatelessWidget {
  final GameBloc gameBloc;
  final VoidCallback onExit;

  const LevelCompleteOverlay({
    super.key,
    required this.gameBloc,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      bloc: gameBloc,
      builder: (context, state) {
        final isComplete = state is GameComplete;
        final level =
            state is LevelComplete ? state.level : (state is GameComplete ? 8 : 1);
        final result = state is LevelComplete
            ? state.partialResult
            : (state is GameComplete ? state.result : null);

        return Container(
          color: Colors.black.withValues(alpha: 0.7),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isComplete ? '🏆' : '⭐',
                    style: const TextStyle(fontSize: 52),
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1.0, 1.0),
                        duration: 400.ms,
                        curve: Curves.elasticOut,
                      ),
                  const SizedBox(height: 8),
                  Text(
                    isComplete
                        ? '¡Completaste el juego!'
                        : '¡Nivel $level completado!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ),
                  ),
                  if (result != null) ...[
                    const SizedBox(height: 16),
                    _ResultCard(result: result),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onExit,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            side: const BorderSide(color: Colors.white38),
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
                      if (!isComplete) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => gameBloc.add(NextLevel()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: EduPlayColors.energyYellow,
                              foregroundColor: EduPlayColors.textDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Siguiente',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
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

class _ResultCard extends StatelessWidget {
  final dynamic result;
  const _ResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final accuracy = ((result.accuracy as double) * 100).round();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Stat(icon: '⚡', label: '${result.finalScore}', sublabel: 'pts'),
          _Stat(
            icon: '✅',
            label: '${result.questionsCorrect}/${result.questionsTotal}',
            sublabel: 'correctas',
          ),
          _Stat(icon: '🎯', label: '$accuracy%', sublabel: 'precisión'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String icon;
  final String label;
  final String sublabel;
  const _Stat({
    required this.icon,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            fontFamily: 'Nunito',
          ),
        ),
        Text(
          sublabel,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}
