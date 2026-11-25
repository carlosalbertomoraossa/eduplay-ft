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

/// Fondo **Cuaderno Escolar Mágico**: papel cuadriculado cálido, manchas de
/// acuarela pastel, garabatos matemáticos dibujados a mano, avioncitos de papel,
/// perforaciones de cuaderno y confeti flotante con parallax suave.
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
    for (var i = 0; i < 28; i++) {
      _spores.add(_Spore(
        x: rng.nextDouble() * 1400,
        y: rng.nextDouble() * 800,
        radius: 2.4 + rng.nextDouble() * 3.0,
        speedY: 7 + rng.nextDouble() * 12,
        swayPhase: rng.nextDouble() * math.pi * 2,
        swayAmp: 12 + rng.nextDouble() * 20,
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

    // 1. Papel de cuaderno cálido en degradado suave
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

    // 2. Manchas artísticas de acuarela de fondo (parallax 0.08)
    _drawWatercolorWashes(canvas, view, cam.x * 0.08);

    // 3. Cuadrícula matemática suave + línea de margen roja/coral (parallax 0.16)
    _drawNotebookGrid(canvas, view, cam.x * 0.16);

    // 4. Garabatos matemáticos y siluetas de cuaderno (parallax 0.22)
    _drawNotebookDoodles(canvas, view, cam.x * 0.22);

    // 5. Avioncitos de papel planeando suavemente
    _drawPaperPlanes(canvas, view, cam.x * 0.12 + _time * 24);

    // 6. Ondas suaves de acuarela en la parte inferior (parallax 0.30)
    _drawBottomWatercolorHills(canvas, view, cam.x * 0.30);

    // 7. Confeti y puntitos de acuarela flotando
    _drawWatercolorConfetti(canvas, view, cam.x * 0.20);
  }

  void _drawWatercolorWashes(Canvas canvas, Vector2 view, double offsetX) {
    const spacing = 420.0;
    final start = -(offsetX % spacing) - spacing;

    var idx = 0;
    for (var x = start; x < view.x + spacing; x += spacing) {
      final c1 = Offset(x + 110, view.y * (idx.isEven ? 0.26 : 0.36));
      final c2 = Offset(x + 290, view.y * (idx.isEven ? 0.42 : 0.22));
      const r1 = 135.0;
      const r2 = 115.0;

      canvas.drawCircle(
        c1,
        r1,
        Paint()
          ..shader = RadialGradient(
            colors: [
              theme.farRock.withValues(alpha: 0.46),
              theme.farRock.withValues(alpha: 0.16),
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(center: c1, radius: r1)),
      );

      canvas.drawCircle(
        c2,
        r2,
        Paint()
          ..shader = RadialGradient(
            colors: [
              theme.midRock.withValues(alpha: 0.34),
              theme.accentGlow.withValues(alpha: 0.12),
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(center: c2, radius: r2)),
      );
      idx++;
    }
  }

  void _drawNotebookGrid(Canvas canvas, Vector2 view, double offsetX) {
    const cell = 34.0;
    final gridPaint = Paint()
      ..color = const Color(0xFF94A3B8).withValues(alpha: 0.22)
      ..strokeWidth = 1.0;

    final startX = -(offsetX % cell);
    for (var x = startX; x < view.x; x += cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, view.y), gridPaint);
    }
    for (var y = cell; y < view.y; y += cell) {
      canvas.drawLine(Offset(0, y), Offset(view.x, y), gridPaint);
    }

    // Doble línea rosada clásica de encabezado de cuaderno escolar
    const marginY = 66.0;
    final marginPaint = Paint()
      ..color = const Color(0xFFFB7185).withValues(alpha: 0.32)
      ..strokeWidth = 1.6;
    canvas.drawLine(const Offset(0, marginY), Offset(view.x, marginY), marginPaint);
    canvas.drawLine(
      const Offset(0, marginY + 4),
      Offset(view.x, marginY + 4),
      marginPaint..strokeWidth = 1.0,
    );

    // Perforaciones decorativas tipo cuaderno argollado arriba
    const ringSpacing = 48.0;
    final ringStart = -(offsetX % ringSpacing);
    final holePaint = Paint()..color = const Color(0xFFCBD5E1).withValues(alpha: 0.55);
    final wirePaint = Paint()
      ..color = const Color(0xFF64748B).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    for (var x = ringStart; x < view.x + ringSpacing; x += ringSpacing) {
      canvas.drawCircle(Offset(x, 16), 4.5, holePaint);
      canvas.drawArc(
        Rect.fromCenter(center: Offset(x, 6), width: 10, height: 18),
        0,
        math.pi,
        false,
        wirePaint,
      );
    }
  }

  void _drawNotebookDoodles(Canvas canvas, Vector2 view, double offsetX) {
    const spacing = 340.0;
    final start = -(offsetX % spacing) - spacing;
    final ink = Paint()
      ..color = theme.stoneBody.withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    var idx = 0;
    for (var x = start; x < view.x + spacing; x += spacing) {
      final y1 = view.y * 0.28 + (idx.isEven ? 0 : 28);
      final y2 = view.y * 0.52 + (idx.isEven ? 18 : -16);

      // 1. Escuadra geométrica dibujada a lápiz
      final tri = Path()
        ..moveTo(x + 42, y1 + 36)
        ..lineTo(x + 42, y1)
        ..lineTo(x + 86, y1 + 36)
        ..close();
      canvas.drawPath(tri, ink);

      // 2. Símbolo "+" o "×" alegre dibujado a mano
      final cx = x + 175;
      final cy = y2;
      if (idx.isEven) {
        canvas.drawLine(Offset(cx - 12, cy), Offset(cx + 12, cy), ink);
        canvas.drawLine(Offset(cx, cy - 12), Offset(cx, cy + 12), ink);
      } else {
        canvas.drawLine(Offset(cx - 10, cy - 10), Offset(cx + 10, cy + 10), ink);
        canvas.drawLine(Offset(cx + 10, cy - 10), Offset(cx - 10, cy + 10), ink);
      }

      // 3. Pequeña espiral / estrella dibujada con marcador suave
      final starCenter = Offset(x + 265, y1 + 22);
      canvas.drawCircle(starCenter, 12, ink);
      canvas.drawCircle(starCenter, 4, ink);

      // 4. Nube bocetada a crayón blanco
      final cloudX = x + 115;
      final cloudY = view.y * 0.19;
      final cloudStroke = Paint()
        ..color = theme.stoneTop.withValues(alpha: 0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(cloudX, cloudY), width: 52, height: 22),
        cloudStroke,
      );
      idx++;
    }
  }

  void _drawPaperPlanes(Canvas canvas, Vector2 view, double offsetX) {
    const spacing = 460.0;
    final start = -(offsetX % spacing) - spacing;

    var idx = 0;
    for (var x = start; x < view.x + spacing; x += spacing) {
      final bob = math.sin(_time * 2.0 + idx) * 10;
      final py = view.y * (idx.isEven ? 0.24 : 0.38) + bob;
      final px = x + 120;

      // Estela punteada del avioncito de papel
      final trailPaint = Paint()
        ..color = theme.stoneBody.withValues(alpha: 0.22)
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round;
      for (var d = 1; d <= 5; d++) {
        final tx = px - d * 12.0;
        final ty = py + math.sin(_time * 2.0 + idx - d * 0.35) * 4 + 4;
        canvas.drawCircle(Offset(tx, ty), 1.6, trailPaint);
      }

      // Avioncito de papel doblado
      final wingTop = Path()
        ..moveTo(px + 20, py)
        ..lineTo(px - 10, py - 8)
        ..lineTo(px - 4, py + 2)
        ..close();
      final wingBottom = Path()
        ..moveTo(px + 20, py)
        ..lineTo(px - 4, py + 2)
        ..lineTo(px - 8, py + 10)
        ..close();
      canvas.drawPath(wingTop, Paint()..color = Colors.white.withValues(alpha: 0.92));
      canvas.drawPath(wingBottom, Paint()..color = theme.farRock.withValues(alpha: 0.85));
      canvas.drawPath(
        wingTop,
        Paint()
          ..color = theme.stoneBody.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
      idx++;
    }
  }

  void _drawBottomWatercolorHills(Canvas canvas, Vector2 view, double offsetX) {
    final farPaint = Paint()..color = theme.farRock.withValues(alpha: 0.42);
    final midPaint = Paint()..color = theme.midRock.withValues(alpha: 0.36);
    const spacing = 340.0;
    final start = -(offsetX % spacing) - spacing;

    for (var x = start; x < view.x + spacing; x += spacing) {
      final wave1 = Path()
        ..moveTo(x - 30, view.y)
        ..quadraticBezierTo(x + spacing * 0.45, view.y * 0.72, x + spacing + 30, view.y)
        ..close();
      canvas.drawPath(wave1, farPaint);

      final wave2 = Path()
        ..moveTo(x + 80, view.y)
        ..quadraticBezierTo(x + spacing * 0.80, view.y * 0.78, x + spacing + 140, view.y)
        ..close();
      canvas.drawPath(wave2, midPaint);
    }
  }

  void _drawWatercolorConfetti(Canvas canvas, Vector2 view, double offsetX) {
    const palette = [
      Color(0xFFFB7185),
      Color(0xFF38BDF8),
      Color(0xFFFACC15),
      Color(0xFF34D399),
      Color(0xFFA78BFA),
    ];
    for (var i = 0; i < _spores.length; i++) {
      final s = _spores[i];
      final sx =
          ((s.x - offsetX) % (view.x + 80) + (view.x + 80)) % (view.x + 80) - 40;
      final sy = s.y;
      final sway = math.sin(_time * 1.4 + s.swayPhase) * s.swayAmp;
      final alpha =
          0.30 + 0.35 * (0.5 + 0.5 * math.sin(_time * 2.0 + s.swayPhase));
      final color = palette[i % palette.length];

      canvas.drawCircle(
        Offset(sx + sway, sy),
        s.radius,
        Paint()..color = color.withValues(alpha: alpha),
      );
    }
  }
}
