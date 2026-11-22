import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../data/level_map_data.dart';

class _Spore {
  double x;
  double y;
  final double radius;
  final double speedY;
  final double swayPhase;
  final double swayAmp;

  _Spore({
    required this.x,
    required this.y,
    required this.radius,
    required this.speedY,
    required this.swayPhase,
    required this.swayAmp,
  });
}

/// Fondo atmosférico subterráneo estilo Hollow Knight / Well Dweller.
/// Se dibuja en coordenadas de pantalla usando la posición de la cámara para
/// lograr capas parallax de pilares, arcos en ruinas, estalactitas y esporas.
class CavernBackgroundComponent extends Component {
  BiomeTheme theme;
  Vector2 Function() getCameraPosition;
  Vector2 Function() getViewportSize;

  double _time = 0;
  final List<_Spore> _spores = [];

  CavernBackgroundComponent({
    required this.theme,
    required this.getCameraPosition,
    required this.getViewportSize,
  }) : super(priority: -100) {
    final rng = math.Random(42);
    for (var i = 0; i < 38; i++) {
      _spores.add(_Spore(
        x: rng.nextDouble() * 1400,
        y: rng.nextDouble() * 800,
        radius: 1.5 + rng.nextDouble() * 2.8,
        speedY: 8 + rng.nextDouble() * 16,
        swayPhase: rng.nextDouble() * math.pi * 2,
        swayAmp: 12 + rng.nextDouble() * 24,
      ));
    }
  }

  void updateTheme(BiomeTheme newTheme) {
    theme = newTheme;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
    final view = getViewportSize();
    final h = view.y > 0 ? view.y : 720.0;
    final w = view.x > 0 ? view.x : 1280.0;
    for (final s in _spores) {
      s.y -= s.speedY * dt;
      if (s.y < -20) {
        s.y = h + 20;
        s.x = (s.x + 173) % (w + 100);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    final view = getViewportSize();
    if (view.x <= 0 || view.y <= 0) return;
    final cam = getCameraPosition();

    // 1. Gradiente profundo de la caverna
    final rect = Rect.fromLTWH(0, 0, view.x, view.y);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [theme.skyTop, theme.skyBottom],
        ).createShader(rect),
    );

    // 2. Resplandor subterráneo lejano (halo ambiental sutil)
    canvas.drawCircle(
      Offset(view.x * 0.5, view.y * 0.32),
      view.x * 0.55,
      Paint()
        ..shader = RadialGradient(
          colors: [
            theme.accentGlow.withValues(alpha: 0.11),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(
          center: Offset(view.x * 0.5, view.y * 0.32),
          radius: view.x * 0.55,
        )),
    );

    // 3. Capa lejana: pilares góticos y arcos en ruinas (parallax 0.16)
    _drawFarRuins(canvas, view, cam.x * 0.16);

    // 4. Capa media: rocas, siluetas de columnas y estalactitas (parallax 0.34)
    _drawMidCavern(canvas, view, cam.x * 0.34);

    // 5. Esporas / luciérnagas flotantes
    _drawSpores(canvas, view, cam.x * 0.25);
  }

  void _drawFarRuins(Canvas canvas, Vector2 view, double offsetX) {
    final paint = Paint()..color = theme.farRock;
    const spacing = 260.0;
    final start = -(offsetX % spacing) - spacing;

    for (var x = start; x < view.x + spacing; x += spacing) {
      // Pilar vertical fino
      canvas.drawRect(
        Rect.fromLTWH(x + 28, 0, 36, view.y),
        paint,
      );
      // Arco puntiagudo gótico entre pilares
      final archPath = Path()
        ..moveTo(x + 64, 0)
        ..lineTo(x + spacing + 28, 0)
        ..lineTo(x + spacing + 28, view.y * 0.28)
        ..quadraticBezierTo(
          x + spacing * 0.5 + 46,
          view.y * 0.06,
          x + 64,
          view.y * 0.28,
        )
        ..close();
      canvas.drawPath(archPath, paint);

      // Ventanal / luz tenue en el pilar
      final glowPaint = Paint()..color = theme.accentGlow.withValues(alpha: 0.08);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + 40, view.y * 0.26, 12, 48),
          const Radius.circular(6),
        ),
        glowPaint,
      );
    }
  }

  void _drawMidCavern(Canvas canvas, Vector2 view, double offsetX) {
    final rockPaint = Paint()..color = theme.midRock;
    const spacing = 220.0;
    final start = -(offsetX % spacing) - spacing;

    for (var x = start; x < view.x + spacing; x += spacing) {
      // Estalactitas superiores
      final stalactite = Path()
        ..moveTo(x + 10, 0)
        ..lineTo(x + 54, 0)
        ..lineTo(x + 34, 72)
        ..close();
      canvas.drawPath(stalactite, rockPaint);

      final stalactite2 = Path()
        ..moveTo(x + 120, 0)
        ..lineTo(x + 185, 0)
        ..lineTo(x + 150, 108)
        ..close();
      canvas.drawPath(stalactite2, rockPaint);

      // Silueta de rocas inferiores
      final ridge = Path()
        ..moveTo(x - 10, view.y)
        ..lineTo(x + 55, view.y * 0.68)
        ..lineTo(x + 135, view.y * 0.77)
        ..lineTo(x + 230, view.y)
        ..close();
      canvas.drawPath(ridge, rockPaint);
    }
  }

  void _drawSpores(Canvas canvas, Vector2 view, double offsetX) {
    for (final s in _spores) {
      final sx = ((s.x - offsetX) % (view.x + 80) + (view.x + 80)) % (view.x + 80) - 40;
      final sy = s.y;
      final sway = math.sin(_time * 1.4 + s.swayPhase) * s.swayAmp;
      final alpha = 0.25 + 0.45 * (0.5 + 0.5 * math.sin(_time * 2.2 + s.swayPhase));

      canvas.drawCircle(
        Offset(sx + sway, sy),
        s.radius * 2.4,
        Paint()..color = theme.sporeColor.withValues(alpha: alpha * 0.25),
      );
      canvas.drawCircle(
        Offset(sx + sway, sy),
        s.radius,
        Paint()..color = theme.sporeColor.withValues(alpha: alpha),
      );
    }
  }
}
