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

    // Resplandor alegre del Portal Arcoíris
    final haloRadius = unlocked ? 96.0 + math.sin(_time * 3.2) * 8 : 50.0;
    final haloColor = unlocked ? const Color(0xFFFDE047) : const Color(0xFF38BDF8);
    canvas.drawCircle(
      Offset(w / 2, h * 0.52),
      haloRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            haloColor.withValues(alpha: unlocked ? 0.42 : 0.22),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(
          center: Offset(w / 2, h * 0.52),
          radius: haloRadius,
        )),
    );

    // Arco dorado alegre con borde arcoíris
    final outerArch = Path()
      ..moveTo(4, h)
      ..lineTo(4, 40)
      ..quadraticBezierTo(w / 2, -8, w - 4, 40)
      ..lineTo(w - 4, h)
      ..close();
    canvas.drawPath(outerArch, Paint()..color = const Color(0xFFFDE68A));
    canvas.drawPath(
      outerArch,
      Paint()
        ..color = unlocked ? const Color(0xFFF59E0B) : const Color(0xFF8B5CF6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0,
    );

    // Arcoíris decorativo arriba del marco
    const rainbow = [Color(0xFFFB7185), Color(0xFFFACC15), Color(0xFF4ADE80), Color(0xFF38BDF8)];
    for (var i = 0; i < rainbow.length; i++) {
      canvas.drawArc(
        Rect.fromCenter(center: Offset(w / 2, 42), width: 68 - i * 8, height: 56 - i * 8),
        math.pi,
        math.pi,
        false,
        Paint()
          ..color = rainbow[i].withValues(alpha: unlocked ? 0.9 : 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.2,
      );
    }

    // Interior mágico del portal
    final innerArch = Path()
      ..moveTo(18, h)
      ..lineTo(18, 46)
      ..quadraticBezierTo(w / 2, 12, w - 18, 46)
      ..lineTo(w - 18, h)
      ..close();

    if (unlocked) {
      canvas.drawPath(
        innerArch,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFEF08A),
              Color(0xFF34D399),
              Color(0xFF38BDF8),
            ],
          ).createShader(Rect.fromLTWH(18, 12, w - 36, h - 12)),
      );

      // Anillos mágicos girando
      final ringR = 14 + 5 * math.sin(_time * 4.5);
      canvas.drawCircle(
        Offset(w / 2, h * 0.56),
        ringR,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.85)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0,
      );
      canvas.drawCircle(
        Offset(w / 2, h * 0.56),
        ringR * 0.5,
        Paint()..color = const Color(0xFFFEF9C3).withValues(alpha: 0.75),
      );
    } else {
      canvas.drawPath(
        innerArch,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF818CF8), Color(0xFF4F46E5)],
          ).createShader(Rect.fromLTWH(18, 12, w - 36, h - 12)),
      );

      // Candadito dorado amigable
      final lockCx = w / 2;
      final lockCy = h * 0.62;
      canvas.drawArc(
        Rect.fromCenter(center: Offset(lockCx, lockCy - 8), width: 14, height: 14),
        math.pi,
        math.pi,
        false,
        Paint()
          ..color = const Color(0xFFFDE047)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(lockCx, lockCy), width: 20, height: 15),
          const Radius.circular(4),
        ),
        Paint()..color = const Color(0xFFFACC15),
      );
      canvas.drawCircle(Offset(lockCx, lockCy), 2.4, Paint()..color = const Color(0xFF78350F));
    }

    // Etiqueta legible en cápsula blanca/dorada sobre el portal
    final labelText = unlocked
        ? '¡META ABIERTA!'
        : 'Faltan $remainingSeals retos';
    final tp = TextPainter(
      text: TextSpan(
        text: labelText,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: unlocked ? const Color(0xFF92400E) : const Color(0xFF1E3A8A),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final pillRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w / 2, -16),
        width: tp.width + 16,
        height: 20,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(
      pillRect,
      Paint()..color = unlocked ? const Color(0xFFFEF08A) : Colors.white.withValues(alpha: 0.92),
    );
    canvas.drawRRect(
      pillRect,
      Paint()
        ..color = unlocked ? const Color(0xFFF59E0B) : const Color(0xFF38BDF8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );
    tp.paint(canvas, Offset((w - tp.width) / 2, -16 - tp.height / 2));
  }
}
