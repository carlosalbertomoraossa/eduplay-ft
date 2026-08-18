// StreakBadge — insignia de racha con animación de fuego
// UX Spec: /specs/product/ux-children.md — "visual llamativo para motivar rachas"

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';

class StreakBadge extends StatelessWidget {
  final int days;
  final bool isCompact;

  const StreakBadge({
    super.key,
    required this.days,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasStreak = days > 0;
    final isHot = days >= 7;

    final gradientColors = isHot
        ? [const Color(0xFFFF5722), const Color(0xFFFF9800)]
        : [EduPlayColors.energyYellow, const Color(0xFFFFB300)];

    return Semantics(
      label: 'Racha de $days ${days == 1 ? "día" : "días"}',
      child: AnimatedContainer(
        duration: 300.ms,
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 10 : 14,
          vertical: isCompact ? 6 : 8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: hasStreak
                ? gradientColors
                : [Colors.grey.shade400, Colors.grey.shade500],
          ),
          borderRadius: BorderRadius.circular(isCompact ? 12 : 16),
          boxShadow: hasStreak
              ? [
                  BoxShadow(
                    color: gradientColors[0].withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isHot ? '🔥' : '⚡',
              style: TextStyle(fontSize: isCompact ? 14 : 17),
            ).animate(key: UniqueKey(), autoPlay: hasStreak)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.1, 1.1),
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                )
                .then(delay: 1200.ms)
                .scale(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.0, 1.0),
                  duration: 1.ms,
                ),
            const SizedBox(width: 4),
            Text(
              '$days',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: isCompact ? 16 : 20,
                fontWeight: FontWeight.w800,
                color: hasStreak ? Colors.white : Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ),
    ).animate(target: hasStreak ? 1 : 0).shimmer(
          duration: 1800.ms,
          color: Colors.white.withValues(alpha: 0.2),
        );
  }
}
