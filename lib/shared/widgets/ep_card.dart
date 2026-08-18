// EpCard — tarjeta estilo gamificado
// Spec: /specs/frontend/flutter-arch.md
// UX Spec: /specs/product/ux-children.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';

class EpCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final IconData? icon;
  final Color? accentColor;
  final VoidCallback? onTap;
  final bool isLocked;

  const EpCard({
    super.key,
    required this.child,
    this.title,
    this.icon,
    this.accentColor,
    this.onTap,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? EduPlayColors.primaryBlue;

    return Semantics(
      button: onTap != null,
      enabled: !isLocked,
      child: GestureDetector(
        onTap: isLocked ? null : onTap,
        child: AnimatedContainer(
          duration: 200.ms,
          curve: Curves.easeOut,
          transform: isLocked
              ? (Matrix4.identity()..scale(0.97))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isLocked
                  ? [Colors.grey.shade300, Colors.grey.shade400]
                  : [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLocked
                  ? Colors.grey.shade300
                  : color.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: isLocked ? 0.0 : 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null || icon != null)
                  Row(
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: isLocked ? Colors.grey : color,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isLocked
                                  ? Colors.grey
                                  : EduPlayColors.textDark,
                            ),
                          ),
                        ),
                      if (isLocked)
                        Icon(Icons.lock_outline, color: Colors.grey.shade500, size: 18),
                    ],
                  ),
                if (title != null || icon != null) const SizedBox(height: 12),
                child,
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 100.ms);
  }
}
