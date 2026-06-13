// Spec: specs/games/g4-adventure-plan.md Fase 3 §3.2

import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'background_component.dart';

enum PlayerState { idle, running, jumping }

/// Jugador dibujado en canvas (personaje colombiano estilo cartoon).
/// Física de salto con gravedad constante; detecta GroundPlatform para aterrizar.
class PlayerComponent extends PositionComponent
    with CollisionCallbacks, HasGameReference {
  static const double _gravity = 900;
  static const double _jumpVelocity = -460;
  static const double walkSpeed = 80.0;

  final double groundY;

  double _vy = 0;
  bool _isOnGround = true;
  bool _moving = true;
  PlayerState _state = PlayerState.running;
  double _animTime = 0;

  PlayerComponent({required this.groundY})
      : super(size: Vector2(48, 64), anchor: Anchor.bottomLeft);

  @override
  Future<void> onLoad() async {
    position = Vector2(80, groundY);
    add(RectangleHitbox());
  }

  bool get isMoving => _moving;
  bool get isOnGround => _isOnGround;
  bool get isRising => !_isOnGround && _vy < 0;

  void stopMoving() => _moving = false;
  void startMoving() => _moving = true;

  void jump() {
    if (!_isOnGround) return;
    _vy = _jumpVelocity;
    _isOnGround = false;
    _state = PlayerState.jumping;
    _playSfx('games/g4/sfx_jump.mp3');
  }

  void celebrate() {
    if (_isOnGround) {
      _vy = _jumpVelocity * 0.5;
      _isOnGround = false;
      _state = PlayerState.jumping;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_moving) {
      _animTime += dt;
      position.x += walkSpeed * dt;
    }
    if (!_isOnGround) {
      _vy += _gravity * dt;
      position.y += _vy * dt;
      if (position.y >= groundY) {
        position.y = groundY;
        _vy = 0;
        _isOnGround = true;
        _state = PlayerState.running;
      }
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is GroundPlatform && _vy > 0) {
      position.y = groundY;
      _vy = 0;
      _isOnGround = true;
      _state = PlayerState.running;
    }
  }

  @override
  void render(Canvas canvas) {
    _draw(canvas);
  }

  void _draw(Canvas canvas) {
    final w = size.x; // 48
    final h = size.y; // 64

    final isJumping = _state == PlayerState.jumping;

    // — Sombra —
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w / 2, h - 2), width: w * 0.7, height: 6),
      Paint()..color = const Color(0x33000000),
    );

    // — Zapatos —
    final shoePaint = Paint()..color = const Color(0xFF212121);
    final legPhase = isJumping ? 0.5 : (math.sin(_animTime * 7) * 0.5 + 0.5);
    final shoe1Y = isJumping ? h * 0.72 : h * 0.72 + legPhase * 6;
    final shoe2Y = isJumping ? h * 0.72 : h * 0.72 + (1 - legPhase) * 6;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(4, shoe1Y, 15, 8), const Radius.circular(3)),
      shoePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w - 19, shoe2Y, 15, 8), const Radius.circular(3)),
      shoePaint,
    );

    // — Pantalón —
    final pantPaint = Paint()..color = const Color(0xFF1565C0);
    final pant1Top = isJumping ? h * 0.56 : h * 0.56 + legPhase * 6;
    final pant2Top = isJumping ? h * 0.56 : h * 0.56 + (1 - legPhase) * 6;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(5, pant1Top, 14, shoe1Y - pant1Top), const Radius.circular(3)),
      pantPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w - 19, pant2Top, 14, shoe2Y - pant2Top), const Radius.circular(3)),
      pantPaint,
    );

    // — Camiseta (franjas colombianas: amarillo, azul, rojo) —
    final bodyTop = h * 0.32;
    final bodyH = h * 0.27;
    // Clip body area
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(4, bodyTop, w - 8, bodyH),
        const Radius.circular(7),
      ),
    );
    canvas.drawRect(
      Rect.fromLTWH(4, bodyTop, w - 8, bodyH * 0.5),
      Paint()..color = const Color(0xFFFDD835), // amarillo
    );
    canvas.drawRect(
      Rect.fromLTWH(4, bodyTop + bodyH * 0.5, w - 8, bodyH * 0.25),
      Paint()..color = const Color(0xFF1A237E), // azul
    );
    canvas.drawRect(
      Rect.fromLTWH(4, bodyTop + bodyH * 0.75, w - 8, bodyH * 0.25),
      Paint()..color = const Color(0xFFB71C1C), // rojo
    );
    canvas.restore();

    // — Brazos —
    final armPaint = Paint()..color = const Color(0xFFFFCC99);
    if (isJumping) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(-3, bodyTop - 2, 9, 20), const Radius.circular(4)),
        armPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(w - 6, bodyTop - 2, 9, 20), const Radius.circular(4)),
        armPaint,
      );
    } else {
      final armSwing = math.sin(_animTime * 7) * 4;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(-3, bodyTop + 2 + armSwing, 9, 18), const Radius.circular(4)),
        armPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(w - 6, bodyTop + 2 - armSwing, 9, 18), const Radius.circular(4)),
        armPaint,
      );
    }

    // — Cabeza —
    final headCx = w / 2;
    final headCy = h * 0.2;
    final headR = h * 0.16;
    canvas.drawCircle(Offset(headCx, headCy), headR, Paint()..color = const Color(0xFFFFCC99));

    // — Pelo (arco superior) —
    canvas.drawArc(
      Rect.fromCenter(center: Offset(headCx, headCy), width: headR * 2 + 2, height: headR * 2 + 2),
      math.pi, math.pi, // top half
      true,
      Paint()..color = const Color(0xFF4E342E),
    );

    // — Ojos —
    final eyeP = Paint()..color = const Color(0xFF1A1A1A);
    canvas.drawCircle(Offset(headCx - 5, headCy + 1), 2.5, eyeP);
    canvas.drawCircle(Offset(headCx + 5, headCy + 1), 2.5, eyeP);
    // brillo
    final glintP = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(headCx - 4, headCy), 1, glintP);
    canvas.drawCircle(Offset(headCx + 6, headCy), 1, glintP);

    // — Boca (smile) —
    canvas.drawArc(
      Rect.fromCenter(center: Offset(headCx, headCy + 5), width: 10, height: 7),
      0, math.pi,
      false,
      Paint()
        ..color = const Color(0xFFBF6B3B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  static void _playSfx(String path) {
    try {
      FlameAudio.play(path);
    } catch (_) {}
  }
}
