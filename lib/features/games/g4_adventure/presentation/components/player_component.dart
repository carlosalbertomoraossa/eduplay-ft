// Spec: .sdd/implemented/features/g4-adventure/g4-adventure-plan.md Fase 3 §3.2

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

    // — Colita de leoncito con pompón —
    final tailSwing = math.sin(_animTime * 9) * 3;
    final tailPath = Path()
      ..moveTo(6, bodyTop + bodyH * 0.75)
      ..quadraticBezierTo(-7, bodyTop + bodyH * 0.5 + tailSwing, -5, bodyTop + 2 + tailSwing);
    canvas.drawPath(
      tailPath,
      Paint()
        ..color = const Color(0xFFF59E0B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      Offset(-5, bodyTop + 1 + tailSwing),
      4,
      Paint()..color = const Color(0xFFB45309),
    );

    // — Brazos / garritas doradas de Lumi el Leoncito —
    final armPaint = Paint()..color = const Color(0xFFFBBF24);
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

    // — Cabeza de Lumi el Leoncito (orejitas + melena esponjosa + carita dorada) —
    final headCx = w / 2;
    final headCy = h * 0.2;
    final headR = h * 0.16;

    // Orejitas redondas de león
    for (final dx in [-headR * 0.85, headR * 0.85]) {
      final earCenter = Offset(headCx + dx, headCy - headR * 0.82);
      canvas.drawCircle(earCenter, 5.2, Paint()..color = const Color(0xFFF59E0B));
      canvas.drawCircle(earCenter, 2.8, Paint()..color = const Color(0xFFFDBA74));
    }

    // Melena esponjosa alrededor de la cabeza
    for (int i = 0; i < 10; i++) {
      final angle = (i * 2 * math.pi) / 10;
      final mx = headCx + math.cos(angle) * (headR + 1.8);
      final my = headCy + math.sin(angle) * (headR + 1.8);
      canvas.drawCircle(
        Offset(mx, my),
        4.8,
        Paint()..color = i.isEven ? const Color(0xFFB45309) : const Color(0xFFD97706),
      );
    }
    canvas.drawCircle(
      Offset(headCx, headCy),
      headR + 2.2,
      Paint()..color = const Color(0xFFB45309),
    );

    // Carita dorada
    canvas.drawCircle(Offset(headCx, headCy), headR, Paint()..color = const Color(0xFFFBBF24));

    // — Ojos —
    final eyeP = Paint()..color = const Color(0xFF1A1A1A);
    canvas.drawCircle(Offset(headCx - 4.5, headCy - 1), 2.5, eyeP);
    canvas.drawCircle(Offset(headCx + 4.5, headCy - 1), 2.5, eyeP);
    // brillo
    final glintP = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(headCx - 3.7, headCy - 1.8), 1, glintP);
    canvas.drawCircle(Offset(headCx + 5.3, headCy - 1.8), 1, glintP);

    // — Hocico cremita y naricita de león —
    canvas.drawOval(
      Rect.fromCenter(center: Offset(headCx, headCy + 4), width: 11, height: 6.5),
      Paint()..color = const Color(0xFFFEF3C7),
    );
    canvas.drawCircle(
      Offset(headCx, headCy + 2.2),
      2.0,
      Paint()..color = const Color(0xFF9A3412),
    );
    canvas.drawArc(
      Rect.fromCenter(center: Offset(headCx, headCy + 4.5), width: 7, height: 4),
      0,
      math.pi,
      false,
      Paint()
        ..color = const Color(0xFF78350F)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );
  }

  static void _playSfx(String path) {
    try {
      FlameAudio.play(path);
    } catch (_) {}
  }
}
