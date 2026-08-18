import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_state.dart';

class GameCompleteOverlay extends StatelessWidget {
  final GameBloc gameBloc;
  final VoidCallback onExit;

  const GameCompleteOverlay({
    super.key,
    required this.gameBloc,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      bloc: gameBloc,
      builder: (context, state) {
        final result = state is GameComplete ? state.result : null;

        return Container(
          color: Colors.black.withValues(alpha: 0.85),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: EduPlayColors.energyYellow.withValues(alpha: 0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: EduPlayColors.energyYellow.withValues(alpha: 0.25),
                    blurRadius: 32,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🎉', style: TextStyle(fontSize: 56))
                      .animate()
                      .scale(
                        begin: const Offset(0.3, 0.3),
                        end: const Offset(1.0, 1.0),
                        duration: 500.ms,
                        curve: Curves.elasticOut,
                      ),
                  const SizedBox(height: 12),
                  const Text(
                    '¡Completaste la Aventura\ndel Cuarto Grado!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '¡Eres un campeón de las matemáticas!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito',
                      color: EduPlayColors.energyYellow,
                    ),
                  ),
                  if (result != null) ...[
                    const SizedBox(height: 20),
                    _FinalStats(result: result),
                  ],
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onExit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: EduPlayColors.energyYellow,
                        foregroundColor: EduPlayColors.textDark,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        '¡Listo!',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
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

class _FinalStats extends StatelessWidget {
  final dynamic result;
  const _FinalStats({required this.result});

  @override
  Widget build(BuildContext context) {
    final accuracy = ((result.accuracy as double) * 100).round();
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(icon: '⚡', value: '${result.finalScore}', label: 'puntos'),
              _StatItem(
                icon: '✅',
                value: '${result.questionsCorrect}/${result.questionsTotal}',
                label: 'correctas',
              ),
              _StatItem(icon: '🎯', value: '$accuracy%', label: 'precisión'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                icon: '🏆',
                value: '8/8',
                label: 'niveles',
              ),
              _StatItem(icon: '⭐', value: '+${result.xpEarned}', label: 'XP'),
              _StatItem(icon: '🪙', value: '+${result.coinsEarned}', label: 'monedas'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
            fontFamily: 'Nunito',
          ),
        ),
        Text(
          label,
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
