// ConfettiOverlay — animación de celebración con partículas
// UX Spec: /specs/product/ux-children.md — "celebración al completar nivel/lección"

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';

class ConfettiOverlay extends StatefulWidget {
  final bool active;
  final Duration duration;
  final VoidCallback? onComplete;

  const ConfettiOverlay({
    super.key,
    this.active = true,
    this.duration = const Duration(milliseconds: 2000),
    this.onComplete,
  });

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  final _confettiColors = [
    EduPlayColors.primaryBlue,
    EduPlayColors.successGreen,
    EduPlayColors.energyYellow,
    EduPlayColors.softRed,
    EduPlayColors.adventurePurple,
    const Color(0xFFF97316),
    const Color(0xFFEC4899),
  ];

  final _random = Random();
  final _particles = <_ConfettiParticle>[];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    if (widget.active) {
      _generateParticles();
      _controller.forward().then((_) => widget.onComplete?.call());
    }

    _controller.addListener(() => setState(() {}));
  }

  void _generateParticles() {
    final screenWidth = MediaQuery.of(context).size.width;
    _particles.clear();
    for (int i = 0; i < 40; i++) {
      _particles.add(_ConfettiParticle(
        color: _confettiColors[_random.nextInt(_confettiColors.length)],
        startX: _random.nextDouble() * screenWidth,
        drift: (_random.nextDouble() - 0.5) * 80,
        size: 8.0 + _random.nextDouble() * 10,
        speed: 1.5 + _random.nextDouble() * 2,
        rotation: _random.nextDouble() * 2 * pi,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return const SizedBox.shrink();

    return IgnorePointer(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _ConfettiPainter(
            particles: _particles,
            progress: _animation.value,
          ),
        ),
      ),
    );
  }
}

class _ConfettiParticle {
  final Color color;
  final double startX;
  final double drift;
  final double size;
  final double speed;
  final double rotation;

  const _ConfettiParticle({
    required this.color,
    required this.startX,
    required this.drift,
    required this.size,
    required this.speed,
    required this.rotation,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()..color = p.color;
      final x = p.startX + sin(p.rotation + progress * 6) * p.drift;
      final y = -40 + progress * size.height * p.speed;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotation + progress * 8);

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(-p.size / 2, -p.size / 4, p.size, p.size / 2),
        const Radius.circular(2),
      );
      canvas.drawRRect(rect, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
