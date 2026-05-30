// Spec: specs/games/g4-adventure-plan.md Fase 3 §3.4

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'player_component.dart';

enum _AnswerState { hidden, idle, correct, wrong }

/// Bloque de respuesta dibujado en canvas (sin PNGs).
/// Cambia de color según estado: azul (idle), verde (correct), rojo (wrong).
class AnswerBlockComponent extends PositionComponent with CollisionCallbacks {
  final int answerIndex;
  final void Function(int index) onAnswer;

  late final TextComponent _label;
  late final RectangleHitbox _hitbox;
  _AnswerState _state = _AnswerState.hidden;
  double _feedbackTimer = 0;
  static const double _feedbackDuration = 0.5;

  AnswerBlockComponent({
    required Vector2 position,
    required this.answerIndex,
    required this.onAnswer,
  }) : super(size: Vector2(80, 80), position: position, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    _label = TextComponent(
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w900,
          fontFamily: 'Nunito',
          shadows: [Shadow(color: Colors.black45, blurRadius: 3)],
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
    );
    add(_label);

    _hitbox = RectangleHitbox()..collisionType = CollisionType.inactive;
    add(_hitbox);
  }

  void show(String optionText) {
    _label.text = optionText;
    _state = _AnswerState.idle;
    _hitbox.collisionType = CollisionType.active;
  }

  void hide() {
    _state = _AnswerState.hidden;
    _hitbox.collisionType = CollisionType.inactive;
  }

  void markCorrect() {
    if (_state != _AnswerState.idle) return;
    _state = _AnswerState.correct;
    _feedbackTimer = 0;
    try { FlameAudio.play('games/g4/sfx_correct.mp3'); } catch (_) {}
  }

  void markWrong() {
    if (_state != _AnswerState.idle) return;
    _state = _AnswerState.wrong;
    _feedbackTimer = 0;
    try { FlameAudio.play('games/g4/sfx_wrong.mp3'); } catch (_) {}
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_state == _AnswerState.correct || _state == _AnswerState.wrong) {
      _feedbackTimer += dt;
      if (_feedbackTimer >= _feedbackDuration) hide();
    }
  }

  @override
  void renderTree(Canvas canvas) {
    if (_state == _AnswerState.hidden) return;
    super.renderTree(canvas);
  }

  @override
  void render(Canvas canvas) {
    _drawBlock(canvas);
    super.render(canvas);
  }

  void _drawBlock(Canvas canvas) {
    final w = size.x;
    final h = size.y;

    final Color base;
    final Color border;
    final Color highlight;
    switch (_state) {
      case _AnswerState.correct:
        base = const Color(0xFF1B5E20);
        border = const Color(0xFF69F0AE);
        highlight = const Color(0x4400E676);
      case _AnswerState.wrong:
        base = const Color(0xFFB71C1C);
        border = const Color(0xFFFF5252);
        highlight = const Color(0x44FF1744);
      case _AnswerState.idle:
      case _AnswerState.hidden:
        base = const Color(0xFF0D47A1);
        border = const Color(0xFF64B5F6);
        highlight = const Color(0x331E88E5);
    }

    // Sombra
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(3, 5, w, h), const Radius.circular(12)),
      Paint()..color = const Color(0x55000000),
    );

    // Cuerpo
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), const Radius.circular(12)),
      Paint()..color = base,
    );

    // Borde
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), const Radius.circular(12)),
      Paint()
        ..color = border
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Brillo superior
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(5, 5, w - 10, h * 0.35), const Radius.circular(8)),
      Paint()..color = highlight,
    );
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (_state != _AnswerState.idle) return;
    if (other is! PlayerComponent) return;
    _hitbox.collisionType = CollisionType.inactive;
    onAnswer(answerIndex);
  }
}
