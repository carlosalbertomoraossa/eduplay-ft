// Spec: specs/games/g4-adventure-plan.md Fase 3 §3.1

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GroundPlatform extends PositionComponent with CollisionCallbacks {
  GroundPlatform({required super.position, required super.size});

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }
}

/// Fondo con parallax dibujado en canvas (sin PNGs) y plataforma de suelo.
class BackgroundComponent extends PositionComponent with HasGameReference {
  static const double _groundFraction = 0.80;
  double get groundY => size.y * _groundFraction;

  double _scrollOffset = 0;

  @override
  Future<void> onLoad() async {
    size = game.size;
    add(GroundPlatform(
      position: Vector2(0, groundY),
      size: Vector2(size.x, size.y - groundY),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    _scrollOffset += 100 * dt;
  }

  @override
  void render(Canvas canvas) {
    _drawSky(canvas);
    _drawClouds(canvas);
    _drawFarHills(canvas);
    _drawNearHills(canvas);
    _drawGround(canvas);
    super.render(canvas);
  }

  void _drawSky(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
        ).createShader(rect),
    );
  }

  void _drawClouds(Canvas canvas) {
    final p = Paint()..color = const Color(0xF0FFFFFF);
    const spacing = 380.0;
    final off = _scrollOffset * 0.12;
    final start = -(off % spacing);
    for (var x = start - spacing; x < size.x + spacing; x += spacing) {
      _cloud(canvas, p, x + 70, size.y * 0.12);
      _cloud(canvas, p, x + 240, size.y * 0.08);
    }
  }

  void _cloud(Canvas canvas, Paint p, double cx, double cy) {
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: 100, height: 44), p);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 35, cy + 6), width: 65, height: 32), p);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 40, cy + 6), width: 60, height: 30), p);
  }

  void _drawFarHills(Canvas canvas) {
    final p = Paint()..color = const Color(0xFF43A047);
    const spacing = 260.0;
    final off = _scrollOffset * 0.25;
    final start = -(off % spacing);
    for (var x = start - spacing; x < size.x + spacing; x += spacing) {
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(x + spacing / 2, groundY + 10),
            width: spacing * 1.3,
            height: 200),
        p,
      );
    }
  }

  void _drawNearHills(Canvas canvas) {
    final p = Paint()..color = const Color(0xFF2E7D32);
    const spacing = 190.0;
    final off = _scrollOffset * 0.45;
    final start = -(off % spacing);
    for (var x = start - spacing; x < size.x + spacing; x += spacing) {
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(x + spacing / 2, groundY + 5),
            width: spacing * 1.15,
            height: 140),
        p,
      );
    }
  }

  void _drawGround(Canvas canvas) {
    // Tierra
    canvas.drawRect(
      Rect.fromLTWH(0, groundY, size.x, size.y - groundY),
      Paint()..color = const Color(0xFF6D4C41),
    );
    // Franja de césped
    canvas.drawRect(
      Rect.fromLTWH(0, groundY, size.x, 14),
      Paint()..color = const Color(0xFF4CAF50),
    );
    // Borde oscuro del césped
    canvas.drawRect(
      Rect.fromLTWH(0, groundY + 11, size.x, 3),
      Paint()..color = const Color(0xFF388E3C),
    );
  }
}
