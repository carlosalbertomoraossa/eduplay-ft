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

    // Halo alegre dorado/mágico
    final glowRadius = status == TotemStatus.purified
        ? 56.0 + math.sin(_time * 3) * 5
        : (status == TotemStatus.sealed ? 42.0 + math.sin(_time * 4) * 5 : 24.0);
    final glowColor = status == TotemStatus.purified
        ? const Color(0xFFFDE047)
        : (status == TotemStatus.sealed ? const Color(0xFF38BDF8) : const Color(0xFFCBD5E1));

    canvas.drawCircle(
      Offset(w / 2, h * 0.34),
      glowRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            glowColor.withValues(alpha: status == TotemStatus.purified ? 0.42 : 0.28),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(
          center: Offset(w / 2, h * 0.34),
          radius: glowRadius,
        )),
    );

    // Palito de madera sosteniendo una Nota Adhesiva (Post-it) de Reto Matemático
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w / 2 - 3.5, h - 20, 7, 20),
        const Radius.circular(3),
      ),
      Paint()..color = const Color(0xFFD97706),
    );
    // Base tipo borrador/soporte
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(8, h - 8, w - 16, 8),
        const Radius.circular(4),
      ),
      Paint()..color = theme.stoneBody,
    );

    // Nota adhesiva (Post-it) colorida con esquinita doblada
    final noteColor = status == TotemStatus.purified
        ? const Color(0xFF86EFAC)
        : (status == TotemStatus.sealed
            ? const Color(0xFFFEF08A)
            : const Color(0xFFE2E8F0));
    final noteBorder = status == TotemStatus.purified
        ? const Color(0xFF16A34A)
        : (status == TotemStatus.sealed
            ? const Color(0xFFF59E0B)
            : const Color(0xFF94A3B8));

    final notePath = Path()
      ..moveTo(5, 16)
      ..lineTo(w - 5, 16)
      ..lineTo(w - 5, h - 22)
      ..lineTo(w - 13, h - 14)
      ..lineTo(5, h - 14)
      ..close();
    canvas.drawPath(notePath, Paint()..color = noteColor);
    canvas.drawPath(
      notePath,
      Paint()
        ..color = noteBorder
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
    // Doblez de la esquinita del post-it
    final fold = Path()
      ..moveTo(w - 13, h - 14)
      ..lineTo(w - 13, h - 22)
      ..lineTo(w - 5, h - 22)
      ..close();
    canvas.drawPath(fold, Paint()..color = noteBorder.withValues(alpha: 0.45));

    // Chincheta roja alegre arriba del post-it
    canvas.drawCircle(Offset(w / 2, 16), 4.2, Paint()..color = const Color(0xFFEF4444));
    canvas.drawCircle(Offset(w / 2 - 1.2, 14.8), 1.4, Paint()..color = Colors.white.withValues(alpha: 0.85));

    // Signo manuscrito "?" o "✓" en tinta azul de esfero
    final symbol = status == TotemStatus.purified
        ? '✓'
        : (status == TotemStatus.sealed ? '?' : '·');
    final symTp = TextPainter(
      text: TextSpan(
        text: symbol,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 19,
          fontWeight: FontWeight.w900,
          color: status == TotemStatus.purified
              ? const Color(0xFF166534)
              : const Color(0xFF1D4ED8),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    symTp.paint(canvas, Offset((w - symTp.width) / 2, 20));

    // Estrellita dorada mágica flotando arriba
    final floatY = math.sin(_time * 3.8 + totemIndex) * 3.5;
    if (status == TotemStatus.purified) {
      _drawStar(
        canvas,
        Offset(w / 2, 5 + floatY),
        11.5,
        const Color(0xFFFDE047),
        const Color(0xFFD97706),
      );
    } else if (status == TotemStatus.sealed) {
      _drawStar(
        canvas,
        Offset(w / 2, 5 + floatY),
        10.0,
        const Color(0xFFFACC15),
        Colors.white,
      );
    }

    // Anillo pulsante + indicador "¡Reto!" cuando Lumi está cerca
    if (status == TotemStatus.sealed && playerNearby) {
      final pulse = 1.0 + 0.12 * math.sin(_time * 7);
      canvas.drawCircle(
        Offset(w / 2, h * 0.45),
        26 * pulse,
        Paint()
          ..color = const Color(0xFFFDE047).withValues(alpha: 0.75)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4,
      );

      final hintTp = TextPainter(
        text: const TextSpan(
          text: '¡Látigo!',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 10.5,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E3A8A),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final pillRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(w / 2, -16 + floatY * 0.4),
          width: hintTp.width + 14,
          height: 18,
        ),
        const Radius.circular(9),
      );
      canvas.drawRRect(pillRect, Paint()..color = const Color(0xFFFEF08A));
      canvas.drawRRect(
        pillRect,
        Paint()
          ..color = const Color(0xFFF59E0B)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
      hintTp.paint(
        canvas,
        Offset((w - hintTp.width) / 2, -16 + floatY * 0.4 - hintTp.height / 2),
      );
    }

    canvas.restore();
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Color fill, Color stroke) {
    final path = Path();
    const points = 5;
    for (var i = 0; i < points * 2; i++) {
      final r = i.isEven ? radius : radius * 0.46;
      final a = -math.pi / 2 + (i * math.pi) / points;
      final pt = center + Offset(math.cos(a) * r, math.sin(a) * r);
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = fill);
    canvas.drawPath(
      path,
      Paint()
        ..color = stroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }
}
