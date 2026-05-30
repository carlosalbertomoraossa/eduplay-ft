// Spec: specs/games/g4-adventure-plan.md Fase 3 §3.3

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'player_component.dart';

enum _BlockState { idle, bumpUp, bumpDown, cooldown }

/// Bloque "V" morado estilo Mario. Se dibuja en canvas (sin PNGs).
/// El jugador lo golpea desde abajo para activar una pregunta.
class ValueBlockComponent extends PositionComponent with CollisionCallbacks {
  final VoidCallback onHit;

  _BlockState _state = _BlockState.idle;
  double _bumpProgress = 0;
  static const double _bumpDuration = 0.14;
  static const double _bumpOffset = 20.0;
  double _originalY = 0;

  // Etiqueta "V" dibujada como TextComponent hijo
  late final TextComponent _label;

  ValueBlockComponent({
    required Vector2 position,
    required this.onHit,
  }) : super(size: Vector2(64, 64), position: position, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    _originalY = position.y;

    _label = TextComponent(
      text: 'V',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w900,
          fontFamily: 'Nunito',
          shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
    );
    add(_label);

    add(RectangleHitbox());
  }

  void reset() {
    _state = _BlockState.idle;
    position.y = _originalY;
  }

  void triggerBump() {
    if (_state != _BlockState.idle) return;
    _state = _BlockState.bumpUp;
    _bumpProgress = 0;
    try { FlameAudio.play('games/g4/sfx_block_hit.mp3'); } catch (_) {}
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (_state) {
      case _BlockState.bumpUp:
        _bumpProgress += dt;
        final t = (_bumpProgress / _bumpDuration).clamp(0.0, 1.0);
        position.y = _originalY - _bumpOffset * t;
        if (_bumpProgress >= _bumpDuration) {
          _bumpProgress = 0;
          _state = _BlockState.bumpDown;
        }
      case _BlockState.bumpDown:
        _bumpProgress += dt;
        final t = (_bumpProgress / _bumpDuration).clamp(0.0, 1.0);
        position.y = (_originalY - _bumpOffset) + _bumpOffset * t;
        if (_bumpProgress >= _bumpDuration) {
          position.y = _originalY;
          _bumpProgress = 0;
          _state = _BlockState.cooldown;
        }
      case _BlockState.idle:
      case _BlockState.cooldown:
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    _drawBlock(canvas);
    super.render(canvas);
  }

  void _drawBlock(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final isHit = _state == _BlockState.cooldown;

    // Sombra
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(3, 4, w, h), const Radius.circular(10)),
      Paint()..color = const Color(0x55000000),
    );

    // Cuerpo principal (morado / gris si ya fue golpeado)
    final baseColor = isHit ? const Color(0xFF757575) : const Color(0xFF6A1B9A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), const Radius.circular(10)),
      Paint()..color = baseColor,
    );

    // Borde dorado
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), const Radius.circular(10)),
      Paint()
        ..color = isHit ? const Color(0xFF9E9E9E) : const Color(0xFFFFD600)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Brillo superior (efecto 3D)
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(4, 4, w - 8, h * 0.3), const Radius.circular(7)),
      Paint()..color = isHit ? const Color(0x22FFFFFF) : const Color(0x449C27B0),
    );
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (_state != _BlockState.idle) return;
    if (other is! PlayerComponent) return;

    final avgY = intersectionPoints.fold(0.0, (s, p) => s + p.y) / intersectionPoints.length;
    final blockBottom = absolutePosition.y + size.y * 0.5;
    if (avgY < blockBottom) return;

    _state = _BlockState.bumpUp;
    _bumpProgress = 0;
    try {
      FlameAudio.play('games/g4/sfx_block_hit.mp3');
    } catch (_) {}
    onHit();
  }
}
