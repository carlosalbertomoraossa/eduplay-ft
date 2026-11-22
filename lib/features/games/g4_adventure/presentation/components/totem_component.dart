import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../data/level_map_data.dart';

enum TotemStatus { sealed, purified, cracked }

/// Altar / Tótem de Luz sellado con runas matemáticas.
/// Golpearlo con la aguja/fósforo (o interactuar cerca) abre una pregunta.
class TotemComponent extends PositionComponent {
  final int totemIndex;
  final BiomeTheme theme;

  TotemStatus status = TotemStatus.sealed;
  bool playerNearby = false;
  double _time = 0;
  double _shakeTimer = 0;

  TotemComponent({
    required this.totemIndex,
    required double x,
    required double baseY,
    required this.theme,
  }) : super(
          position: Vector2(x, baseY),
          size: Vector2(44, 62),
          anchor: Anchor.bottomCenter,
          priority: 5,
        );

  bool get isSealed => status == TotemStatus.sealed;

  Rect get hitRect => Rect.fromLTWH(
        position.x - size.x / 2 - 4,
        position.y - size.y - 4,
        size.x + 8,
        size.y + 8,
      );

  void triggerShake() {
    _shakeTimer = 0.25;
  }

  void resolve({required bool correct}) {
    status = correct ? TotemStatus.purified : TotemStatus.cracked;
    _shakeTimer = 0.2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
    if (_shakeTimer > 0) {
      _shakeTimer = (_shakeTimer - dt).clamp(0.0, 1.0);
    }
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final shakeX = _shakeTimer > 0 ? math.sin(_time * 65) * 3.5 : 0.0;

    canvas.save();
    canvas.translate(shakeX, 0);

    // Halo de luz radial
    final glowRadius = status == TotemStatus.purified
        ? 85.0 + math.sin(_time * 3) * 6
        : (status == TotemStatus.sealed ? 46.0 + math.sin(_time * 4) * 5 : 28.0);
    final glowColor = status == TotemStatus.purified
        ? const Color(0xFFFDE047)
        : (status == TotemStatus.sealed ? theme.accentGlow : const Color(0xFF94A3B8));

    canvas.drawCircle(
      Offset(w / 2, h * 0.36),
      glowRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            glowColor.withValues(alpha: status == TotemStatus.purified ? 0.36 : 0.22),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(
          center: Offset(w / 2, h * 0.36),
          radius: glowRadius,
        )),
    );

    // Pedestal de piedra tallada
    final stonePaint = Paint()..color = const Color(0xFF283044);
    final stoneRim = Paint()
      ..color = Colors.white.withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Base ancha
    final baseRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4, h - 12, w - 8, 12),
      const Radius.circular(4),
    );
    canvas.drawRRect(baseRect, stonePaint);
    canvas.drawRRect(baseRect, stoneRim);

    // Columna obelisco
    final pillar = Path()
      ..moveTo(10, h - 12)
      ..lineTo(14, 16)
      ..lineTo(w / 2, 6)
      ..lineTo(w - 14, 16)
      ..lineTo(w - 10, h - 12)
      ..close();
    canvas.drawPath(pillar, stonePaint);
    canvas.drawPath(pillar, stoneRim);

    // Cristal / llama flotante superior
    final floatY = math.sin(_time * 3.5 + totemIndex) * 3.0;
    if (status == TotemStatus.purified) {
      // Llama dorada encendida (estilo farol de Well Dweller)
      final flame = Path()
        ..moveTo(w / 2, -6 + floatY)
        ..quadraticBezierTo(w / 2 + 10, 6 + floatY, w / 2, 16 + floatY)
        ..quadraticBezierTo(w / 2 - 10, 6 + floatY, w / 2, -6 + floatY)
        ..close();
      canvas.drawPath(flame, Paint()..color = const Color(0xFFF59E0B));
      canvas.drawCircle(
        Offset(w / 2, 8 + floatY),
        4.5,
        Paint()..color = const Color(0xFFFEF9C3),
      );
    } else if (status == TotemStatus.sealed) {
      // Runa de sello flotando
      final diamond = Path()
        ..moveTo(w / 2, -5 + floatY)
        ..lineTo(w / 2 + 8, 5 + floatY)
        ..lineTo(w / 2, 15 + floatY)
        ..lineTo(w / 2 - 8, 5 + floatY)
        ..close();
      canvas.drawPath(diamond, Paint()..color = theme.accentGlow);
      canvas.drawPath(
        diamond,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }

    // Símbolo rúnico grabado en el cuerpo del obelisco
    final runeColor = status == TotemStatus.purified
        ? const Color(0xFFFDE047)
        : (status == TotemStatus.sealed
            ? theme.accentGlow.withValues(alpha: 0.75 + 0.25 * math.sin(_time * 5))
            : const Color(0xFF64748B));
    final runePaint = Paint()
      ..color = runeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    // Runa matemática estilizada
    canvas.drawCircle(Offset(w / 2, h * 0.50), 5.5, runePaint);
    canvas.drawLine(Offset(w / 2, h * 0.62), Offset(w / 2, h * 0.76), runePaint);

    // Anillo pulsante si el viajero está cerca de un tótem sellado
    if (status == TotemStatus.sealed && playerNearby) {
      final pulse = 1.0 + 0.14 * math.sin(_time * 7);
      canvas.drawCircle(
        Offset(w / 2, h * 0.45),
        26 * pulse,
        Paint()
          ..color = const Color(0xFFFDE047).withValues(alpha: 0.55)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }

    canvas.restore();
  }
}
