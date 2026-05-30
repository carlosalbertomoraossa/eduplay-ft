// XP Bar animada — muestra progreso de nivel
// Spec: /specs/domains/gamification/spec.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';

class XpBar extends StatelessWidget {
  final int currentXp;     // XP en el nivel actual
  final int xpToNextLevel; // XP total necesario para el siguiente nivel
  final int level;
  final bool animate;

  const XpBar({
    super.key,
    required this.currentXp,
    required this.xpToNextLevel,
    required this.level,
    this.animate = true,
  });

  double get _progress =>
      xpToNextLevel == 0 ? 1.0 : (currentXp / xpToNextLevel).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nivel $level',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: EduPlayColors.textDark,
              ),
            ),
            Text(
              '$currentXp / $xpToNextLevel XP',
              style: const TextStyle(
                fontSize: 14,
                color: EduPlayColors.textMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: animate ? 0 : _progress,
            minHeight: 12,
            backgroundColor: EduPlayColors.backgroundLight,
            valueColor: const AlwaysStoppedAnimation<Color>(
              EduPlayColors.energyYellow,
            ),
          ),
        )
            .animate(target: animate ? 1 : 0)
            .custom(
              duration: 800.ms,
              curve: Curves.easeOutCubic,
              builder: (_, value, child) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _progress * value,
                  minHeight: 12,
                  backgroundColor: EduPlayColors.backgroundLight,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    EduPlayColors.energyYellow,
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
