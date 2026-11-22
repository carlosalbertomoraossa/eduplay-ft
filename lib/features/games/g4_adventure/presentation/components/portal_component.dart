import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../data/level_map_data.dart';

/// Portal Antiguo al final de cada caverna.
/// Se desbloquea cuando los 9 tótems del mapa han sido resueltos;
/// golpearlo o entrar activa el 10° y último reto del nivel.
class PortalComponent extends PositionComponent {
  final BiomeTheme theme;
  int remainingSeals = 9;
  bool activated = false;
  double _time = 0;

  PortalComponent({
    required double x,
    required double baseY,
    required this.theme,
  }) : super(
          position: Vector2(x, baseY),
          size: Vector2(88, 118),
          anchor: Anchor.bottomCenter,
          priority: 4,
        );

  bool get isUnlocked => remainingSeals <= 0;

  Rect get interactRect => Rect.fromLTWH(
        position.x - size.x / 2,
        position.y - size.y,
        size.x,
        size.y,
      );

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final unlocked = isUnlocked;

    // Resplandor ambiental del portal
    final haloRadius = unlocked ? 110.0 + math.sin(_time * 3) * 10 : 52.0;
    final haloColor = unlocked ? const Color(0xFFFDE047) : theme.accentGlow;
    canvas.drawCircle(
      Offset(w / 2, h * 0.52),
      haloRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            haloColor.withValues(alpha: unlocked ? 0.36 : 0.14),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(
          center: Offset(w / 2, h * 0.52),
          radius: haloRadius,
        )),
    );

    // Arco gótico de piedra
    final outerArch = Path()
      ..moveTo(4, h)
      ..lineTo(4, 38)
      ..quadraticBezierTo(w / 2, -10, w - 4, 38)
      ..lineTo(w - 4, h)
      ..close();
    canvas.drawPath(outerArch, Paint()..color = const Color(0xFF1E293B));
    canvas.drawPath(
      outerArch,
      Paint()
        ..color = unlocked ? const Color(0xFFFDE047) : theme.stoneTop
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Interior del portal
    final innerArch = Path()
      ..moveTo(18, h)
      ..lineTo(18, 44)
      ..quadraticBezierTo(w / 2, 10, w - 18, 44)
      ..lineTo(w - 18, h)
      ..close();

    if (unlocked) {
      canvas.drawPath(
        innerArch,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFDE047).withValues(alpha: 0.85),
              theme.accentGlow.withValues(alpha: 0.75),
              const Color(0xFF0F172A),
            ],
          ).createShader(Rect.fromLTWH(18, 12, w - 36, h - 12)),
      );

      // Espiral/anillos de energía
      final ringR = 14 + 5 * math.sin(_time * 4.5);
      canvas.drawCircle(
        Offset(w / 2, h * 0.54),
        ringR,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.75)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
    } else {
      canvas.drawPath(innerArch, Paint()..color = const Color(0xFF0B1120));
      // Candado / cadenas tenues
      final lockPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawLine(Offset(18, h * 0.42), Offset(w - 18, h * 0.65), lockPaint);
      canvas.drawLine(Offset(w - 18, h * 0.42), Offset(18, h * 0.65), lockPaint);
    }

    // Etiqueta flotante sobre el portal
    final labelText = unlocked
        ? '¡PORTAL ABIERTO!'
        : 'Faltan $remainingSeals sellos';
    final tp = TextPainter(
      text: TextSpan(
        text: labelText,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: unlocked ? const Color(0xFFFDE047) : const Color(0xFFCBD5E1),
          shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((w - tp.width) / 2, -20));
  }
}
