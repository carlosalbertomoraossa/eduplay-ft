// Indicador de corazones (vidas) en lección
// Spec UX: /specs/product/ux-children.md — "corazón se rompe suavemente"

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';

class HeartIndicator extends StatelessWidget {
  final int currentHearts;
  final int maxHearts;

  const HeartIndicator({
    super.key,
    required this.currentHearts,
    this.maxHearts = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxHearts, (index) {
        final isFilled = index < currentHearts;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Icon(
            isFilled ? Icons.favorite : Icons.favorite_border,
            color: isFilled ? EduPlayColors.softRed : EduPlayColors.textMedium,
            size: 28,
          )
              .animate(key: ValueKey('heart_$index'))
              .scaleXY(
                begin: isFilled ? 1.0 : 1.3,
                end: 1.0,
                duration: 300.ms,
                curve: Curves.elasticOut,
              ),
        );
      }),
    );
  }
}
