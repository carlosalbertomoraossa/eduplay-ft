// EduPlay Button — componente primario
// Spec UX: /specs/product/ux-children.md — tamaño mínimo tap 48dp

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';

enum EpButtonVariant { primary, secondary, danger }

class EpButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final EpButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  const EpButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = EpButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (variant) {
      EpButtonVariant.primary => EduPlayColors.primaryBlue,
      EpButtonVariant.secondary => EduPlayColors.surfaceWhite,
      EpButtonVariant.danger => EduPlayColors.softRed,
    };

    final foregroundColor = switch (variant) {
      EpButtonVariant.secondary => EduPlayColors.primaryBlue,
      _ => EduPlayColors.surfaceWhite,
    };

    return Semantics(
      button: true,
      enabled: !isLoading && onPressed != null,
      label: label,
      child: SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: variant == EpButtonVariant.secondary
                ? BorderSide(color: EduPlayColors.primaryBlue, width: 2)
                : BorderSide.none,
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: EduPlayColors.surfaceWhite,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 24),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
      ),
    )
        .animate(target: onPressed == null ? 0 : 1)
        .scaleXY(begin: 0.98, end: 1.0, duration: 100.ms),
    );
  }
}
