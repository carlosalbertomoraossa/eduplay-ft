// Spec: specs/games/g4-adventure-plan.md Fase 3 §3.5

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Burbuja de diálogo que aparece sobre el jugador mostrando la pregunta activa.
///
/// Se posiciona con anchor [Anchor.bottomCenter] para que [position] apunte
/// al borde superior de la cabeza del jugador.
/// Usa [renderTree] override para ocultar la burbuja Y el texto en conjunto.
class QuestionBubbleComponent extends PositionComponent {
  static const double _bubbleW = 230.0;
  static const double _bubbleH = 68.0;
  static const double _tailH = 12.0;
  static const double _radius = 12.0;

  bool _hidden = true;
  late final TextBoxComponent _textBox;

  final _bgPaint = Paint()..color = const Color(0xEE1A237E);
  final _borderPaint = Paint()
    ..color = const Color(0xFFFFD700)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5;

  QuestionBubbleComponent({required Vector2 position})
      : super(
          size: Vector2(_bubbleW, _bubbleH + _tailH),
          position: position,
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    _textBox = TextBoxComponent(
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
      boxConfig: const TextBoxConfig(
        maxWidth: _bubbleW - 20,
        margins: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        growingBox: false,
        timePerChar: 0,
      ),
      size: Vector2(_bubbleW, _bubbleH),
      position: Vector2.zero(),
    );
    add(_textBox);
  }

  /// Muestra la burbuja con la pregunta indicada.
  void show(String question) {
    _textBox.text = question;
    _hidden = false;
  }

  /// Oculta la burbuja (cuando no hay pregunta activa).
  void hide() {
    _hidden = true;
  }

  // Dibuja el fondo antes de que los hijos (TextBoxComponent) se rendericen.
  @override
  void render(Canvas canvas) {
    if (_hidden) return;
    _drawBubble(canvas);
  }

  // Oculta el árbol completo (fondo + texto hijo) cuando hidden.
  @override
  void renderTree(Canvas canvas) {
    if (_hidden) return;
    super.renderTree(canvas);
  }

  void _drawBubble(Canvas canvas) {
    final bodyRect = RRect.fromLTRBR(
      0, 0, _bubbleW, _bubbleH,
      const Radius.circular(_radius),
    );
    canvas.drawRRect(bodyRect, _bgPaint);
    canvas.drawRRect(bodyRect, _borderPaint);

    // Cola triangular apuntando hacia abajo (hacia el jugador)
    const cx = _bubbleW / 2;
    final tailPath = Path()
      ..moveTo(cx - 9, _bubbleH)
      ..lineTo(cx + 9, _bubbleH)
      ..lineTo(cx, _bubbleH + _tailH)
      ..close();
    canvas.drawPath(tailPath, _bgPaint);
    canvas.drawPath(tailPath, _borderPaint);
  }
}
