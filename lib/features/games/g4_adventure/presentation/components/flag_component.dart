// Spec: specs/games/g4-adventure-plan.md Fase 4

import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Bandera de meta estilo Mario. El poste llega hasta el suelo.
/// Anchor bottomCenter → position.y = groundY → local y=0 es cielo, local y=size.y es suelo.
class FlagComponent extends PositionComponent {
  // Dimensiones del componente (todo en coordenadas locales top→bottom)
  static const double _w = 70.0;
  static const double _h = 155.0;   // altura total: bola + poste + base
  static const double _cx = 30.0;   // centro horizontal del poste
  static const double _ballY = 10.0;
  static const double _ballR = 9.0;
  static const double _poleTop = _ballY + _ballR;     // 19
  static const double _poleBottom = _h - 12.0;        // 143
  static const double _poleW = 6.0;
  static const double _flagTopY = _ballY + 6.0;       // 16
  static const double _flagW = 35.0;
  static const double _flagH = 27.0;

  double _wave = 0;

  FlagComponent({required super.position})
      : super(size: Vector2(_w, _h), anchor: Anchor.bottomCenter);

  @override
  void update(double dt) {
    super.update(dt);
    _wave += dt * 3.5;
  }

  @override
  void render(Canvas canvas) {
    // ── Sombra del poste ────────────────────────────────────────
    canvas.drawRect(
      const Rect.fromLTWH(_cx + 4, _poleTop + 3, _poleW, _poleBottom - _poleTop),
      Paint()..color = const Color(0x33000000),
    );

    // ── Poste (de arriba hacia el suelo) ────────────────────────
    canvas.drawRect(
      const Rect.fromLTWH(_cx - _poleW / 2, _poleTop, _poleW, _poleBottom - _poleTop),
      Paint()..color = const Color(0xFF6D4C41),
    );

    // ── Base del poste (enterrada en el suelo) ───────────────────
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(_cx - 14, _poleBottom, 28, _h - _poleBottom),
        const Radius.circular(5),
      ),
      Paint()..color = const Color(0xFF795548),
    );

    // ── Bola dorada en la punta ──────────────────────────────────
    canvas.drawCircle(
      const Offset(_cx, _ballY),
      _ballR,
      Paint()..color = const Color(0xFFFFD600),
    );
    canvas.drawCircle(
      const Offset(_cx - 2, _ballY - 2),
      3.5,
      Paint()..color = const Color(0xFFFFFF8D),
    );

    // ── Bandera ondeante ────────────────────────────────────────
    final path = Path();
    path.moveTo(_cx, _flagTopY);

    for (var i = 0; i <= 10; i++) {
      final t = i / 10.0;
      final wave = math.sin(_wave + t * math.pi * 1.5) * 4.5 * t;
      path.lineTo(_cx + t * _flagW, _flagTopY + wave);
    }
    path.lineTo(_cx + _flagW, _flagTopY + _flagH / 2);
    for (var i = 10; i >= 0; i--) {
      final t = i / 10.0;
      final wave = math.sin(_wave + t * math.pi * 1.5) * 4.5 * t;
      path.lineTo(_cx + t * _flagW, _flagTopY + _flagH + wave);
    }
    path.close();

    // Relleno rojo (bandera)
    canvas.drawPath(path, Paint()..color = const Color(0xFFE53935));

    // Franja dorada
    canvas.drawRect(
      const Rect.fromLTWH(_cx, _flagTopY + _flagH * 0.33, _flagW * 0.65, 5),
      Paint()..color = const Color(0xFFFDD835),
    );
  }
}
