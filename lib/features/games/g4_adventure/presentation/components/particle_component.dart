import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Partícula ligera (chispas de luz, polvo de salto, sombras derrotadas).
class SparkParticle extends PositionComponent {
  Vector2 velocity;
  final Color color;
  final double lifetime;
  final double gravity;
  final double initialRadius;
  double _age = 0;

  SparkParticle({
    required Vector2 position,
    required this.velocity,
    required this.color,
    this.lifetime = 0.45,
    this.gravity = 180,
    this.initialRadius = 4.0,
  }) : super(position: position, priority: 25);

  @override
  void update(double dt) {
    super.update(dt);
    _age += dt;
    if (_age >= lifetime) {
      removeFromParent();
      return;
    }
    velocity.y += gravity * dt;
    position += velocity * dt;
  }

  @override
  void render(Canvas canvas) {
    final t = (1.0 - _age / lifetime).clamp(0.0, 1.0);
    final r = initialRadius * (0.3 + 0.7 * t);
    canvas.drawCircle(
      Offset.zero,
      r * 1.9,
      Paint()..color = color.withValues(alpha: t * 0.28),
    );
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()..color = color.withValues(alpha: t),
    );
  }
}

enum SlashDirection { right, left, down, up }

/// Látigo de Cadena Dorada y Liana Esmeralda:
/// Se extiende con una onda fluida desde el Guardián, barre enemigos a media
/// distancia y termina en una punta de esmeralda que chasquea con luz.
class WhipLashComponent extends PositionComponent {
  final Vector2 Function() getOrigin;
  final SlashDirection direction;
  final double maxLength;
  static const double duration = 0.22;
  double _age = 0;

  WhipLashComponent({
    required this.getOrigin,
    required this.direction,
    this.maxLength = 114,
  }) : super(priority: 22);

  @override
  void update(double dt) {
    super.update(dt);
    _age += dt;
    if (_age >= duration) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final p = (_age / duration).clamp(0.0, 1.0);
    // Extensión rápida (0..0.38), chasquido en punta (0.38..0.68), recogida (0.68..1)
    final reachFactor = p < 0.38
        ? Curves.easeOutCubic.transform(p / 0.38)
        : (p < 0.68 ? 1.0 : (1.0 - (p - 0.68) / 0.32).clamp(0.0, 1.0));
    final length = maxLength * reachFactor;
    if (length < 6) return;

    final alpha = p < 0.72 ? 1.0 : ((1.0 - p) / 0.28).clamp(0.0, 1.0);
    final origin = getOrigin();

    canvas.save();
    canvas.translate(origin.x, origin.y);
    switch (direction) {
      case SlashDirection.right:
        break;
      case SlashDirection.left:
        canvas.scale(-1, 1);
      case SlashDirection.down:
        canvas.rotate(math.pi / 2);
      case SlashDirection.up:
        canvas.rotate(-math.pi / 2);
    }

    // Construir la curva ondulante de la cadena/liana
    const segments = 14;
    final vinePath = Path();
    final chainPoints = <Offset>[];
    final waveAmp = (1.0 - p * 0.55) * 14.0;
    final phase = p * math.pi * 3.2;

    for (var i = 0; i <= segments; i++) {
      final t = i / segments;
      final x = t * length;
      // La base sale recta de la mano y la onda crece hacia la punta
      final envelope = math.sin(t * math.pi);
      final y = math.sin(t * math.pi * 2.2 - phase) * waveAmp * envelope;
      final pt = Offset(x, y);
      chainPoints.add(pt);
      if (i == 0) {
        vinePath.moveTo(x, y);
      } else {
        vinePath.lineTo(x, y);
      }
    }

    // 1. Halo bioluminiscente esmeralda alrededor del látigo
    canvas.drawPath(
      vinePath,
      Paint()
        ..color = const Color(0xFF10B981).withValues(alpha: alpha * 0.34)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 11
        ..strokeCap = StrokeCap.round,
    );

    // 2. Liana esmeralda luminosa principal
    canvas.drawPath(
      vinePath,
      Paint()
        ..color = const Color(0xFF34D399).withValues(alpha: alpha * 0.92)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.2
        ..strokeCap = StrokeCap.round,
    );

    // 3. Eslabones de cadena dorada Muisca a lo largo de la liana
    final linkPaint = Paint()
      ..color = const Color(0xFFFBBF24).withValues(alpha: alpha * 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.1;
    for (var i = 1; i < chainPoints.length - 1; i += 2) {
      canvas.drawCircle(chainPoints[i], 3.2, linkPaint);
    }

    // 4. Punta de cristal esmeralda + destello de chasquido dorado
    final tip = chainPoints.last;
    if (p >= 0.25 && p <= 0.78) {
      final crackR = 10.0 + (p - 0.25) * 28.0;
      canvas.drawCircle(
        tip,
        crackR,
        Paint()
          ..color = const Color(0xFFFEF08A).withValues(alpha: alpha * 0.45)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2,
      );
    }

    final crystalTip = Path()
      ..moveTo(tip.dx + 9, tip.dy)
      ..lineTo(tip.dx, tip.dy - 5.5)
      ..lineTo(tip.dx - 5, tip.dy)
      ..lineTo(tip.dx, tip.dy + 5.5)
      ..close();
    canvas.drawPath(
      crystalTip,
      Paint()..color = const Color(0xFFA7F3D0).withValues(alpha: alpha),
    );
    canvas.drawPath(
      crystalTip,
      Paint()
        ..color = const Color(0xFFFDE047).withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );

    canvas.restore();
  }
}

/// Cadena dorada + liana luminosa tensa que sostiene al Guardián mientras
/// permanece enganchado a un anillo dorado (hasta que vuelva a oprimir Salto).
class GrappleTetherComponent extends Component {
  final Vector2 Function() getOrigin;
  final Vector2 anchorPos;
  final bool Function() isActive;

  GrappleTetherComponent({
    required this.getOrigin,
    required this.anchorPos,
    required this.isActive,
  }) : super(priority: 14);

  @override
  void update(double dt) {
    super.update(dt);
    if (!isActive()) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    if (!isActive()) return;
    final a = getOrigin();
    final b = anchorPos;

    // Halo esmeralda a lo largo de la cadena tensa
    canvas.drawLine(
      Offset(a.x, a.y),
      Offset(b.x, b.y),
      Paint()
        ..color = const Color(0xFF10B981).withValues(alpha: 0.36)
        ..strokeWidth = 9
        ..strokeCap = StrokeCap.round,
    );

    // Liana esmeralda principal
    canvas.drawLine(
      Offset(a.x, a.y),
      Offset(b.x, b.y),
      Paint()
        ..color = const Color(0xFF34D399)
        ..strokeWidth = 3.2
        ..strokeCap = StrokeCap.round,
    );

    // Eslabones dorados Muiscas a lo largo de la cuerda
    final dx = b.x - a.x;
    final dy = b.y - a.y;
    final dist = math.sqrt(dx * dx + dy * dy);
    final linkCount = (dist / 16).floor().clamp(2, 12);
    final linkPaint = Paint()
      ..color = const Color(0xFFFDE047)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.9;
    for (var i = 1; i < linkCount; i++) {
      final t = i / linkCount;
      canvas.drawCircle(Offset(a.x + dx * t, a.y + dy * t), 2.8, linkPaint);
    }

    // Nudo / destello brillante en el punto de enganche
    canvas.drawCircle(
      Offset(b.x, b.y),
      6.5,
      Paint()..color = const Color(0xFFA7F3D0).withValues(alpha: 0.85),
    );
  }
}

/// Silueta fantasma traslúcida del Guardián (sombrero vueltiao + ruana) durante el dash.
class DashAfterimageComponent extends PositionComponent {
  final bool facingRight;
  double _age = 0;
  static const double _duration = 0.22;

  DashAfterimageComponent({
    required Vector2 position,
    required this.facingRight,
  }) : super(
          position: position,
          size: Vector2(28, 44),
          anchor: Anchor.bottomCenter,
          priority: 12,
        );

  @override
  void update(double dt) {
    super.update(dt);
    _age += dt;
    if (_age >= _duration) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final alpha = (1.0 - _age / _duration).clamp(0.0, 1.0) * 0.46;
    final paint = Paint()..color = const Color(0xFF34D399).withValues(alpha: alpha);

    // Silueta de la ruana
    final ruana = Path()
      ..moveTo(size.x * 0.22, 18)
      ..lineTo(size.x * 0.78, 18)
      ..lineTo(size.x, size.y - 6)
      ..lineTo(0, size.y - 6)
      ..close();
    canvas.drawPath(ruana, paint);

    // Silueta del sombrero vueltiao
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(size.x * 0.5, 10.5), width: 34, height: 5),
        const Radius.circular(3),
      ),
      paint,
    );
    final crown = Path()
      ..moveTo(size.x * 0.5 - 9, 9)
      ..lineTo(size.x * 0.5, 0)
      ..lineTo(size.x * 0.5 + 9, 9)
      ..close();
    canvas.drawPath(crown, paint);
  }
}

/// Orbe de corazón luminoso coleccionable para recuperar 1 vida (hasta 5).
class HeartPickupComponent extends PositionComponent {
  double _time = 0;
  bool collected = false;

  HeartPickupComponent({required Vector2 position})
      : super(
          position: position,
          size: Vector2(26, 26),
          anchor: Anchor.center,
          priority: 10,
        );

  Rect get pickupRect => Rect.fromCenter(
        center: Offset(position.x, position.y),
        width: 30,
        height: 30,
      );

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
  }

  @override
  void render(Canvas canvas) {
    if (collected) return;
    final bob = math.sin(_time * 3.8) * 4.5;
    final cx = size.x / 2;
    final cy = size.y / 2 + bob;

    // Halo rosado-cálido
    canvas.drawCircle(
      Offset(cx, cy),
      17,
      Paint()..color = const Color(0xFFF43F5E).withValues(alpha: 0.25),
    );

    // Corazón estilizado
    final heart = Path()
      ..moveTo(cx, cy + 7)
      ..cubicTo(cx - 12, cy - 1, cx - 9, cy - 10, cx, cy - 4)
      ..cubicTo(cx + 9, cy - 10, cx + 12, cy - 1, cx, cy + 7)
      ..close();
    canvas.drawPath(heart, Paint()..color = const Color(0xFFFB7185));
    canvas.drawPath(
      heart,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }
}
