import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../data/level_map_data.dart';

/// Plataforma de piedra tallada con borde bioluminiscente/musgoso y cristales.
class CavernPlatformComponent extends PositionComponent {
  final BiomeTheme theme;
  final bool hasCrystalAccent;

  CavernPlatformComponent({
    required Vector2 position,
    required Vector2 size,
    required this.theme,
    this.hasCrystalAccent = false,
  }) : super(position: position, size: size, priority: 1);

  Rect get worldRect => Rect.fromLTWH(position.x, position.y, size.x, size.y);

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final bodyRRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, w, h),
      topLeft: const Radius.circular(8),
      topRight: const Radius.circular(8),
      bottomLeft: Radius.circular(h > 40 ? 0 : 8),
      bottomRight: Radius.circular(h > 40 ? 0 : 8),
    );

    // Sombra inferior proyectada
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2, 4, w, h),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0x55000000),
    );

    // Cuerpo principal de roca oscura
    canvas.drawRRect(
      bodyRRect,
      Paint()..color = theme.stoneBody,
    );

    // Textura sutil de bloques tallados
    final brickPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (var bx = 36.0; bx < w - 16; bx += 46) {
      canvas.drawLine(Offset(bx, 10), Offset(bx, math.min(h - 4, 34)), brickPaint);
    }
    if (h > 40) {
      canvas.drawLine(const Offset(6, 36), Offset(w - 6, 36), brickPaint);
      for (var bx = 18.0; bx < w - 16; bx += 54) {
        canvas.drawLine(Offset(bx, 36), Offset(bx, math.min(h - 4, 72)), brickPaint);
      }
    }

    // Franja superior luminosa / musgo subterráneo
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, w, 8),
        topLeft: const Radius.circular(8),
        topRight: const Radius.circular(8),
      ),
      Paint()..color = theme.stoneTop,
    );

    // Línea de brillo fino en el borde superior
    canvas.drawLine(
      const Offset(6, 1.5),
      Offset(w - 6, 1.5),
      Paint()
        ..color = theme.accentGlow.withValues(alpha: 0.65)
        ..strokeWidth = 1.5,
    );

    // Pequeños cristales decorativos en los extremos
    if (hasCrystalAccent && w >= 120) {
      _drawCrystalCluster(canvas, 18, 0);
      _drawCrystalCluster(canvas, w - 26, 0);
    }
  }

  void _drawCrystalCluster(Canvas canvas, double cx, double baseY) {
    final glow = Paint()..color = theme.accentGlow.withValues(alpha: 0.22);
    canvas.drawCircle(Offset(cx, baseY - 6), 14, glow);

    final crystalPaint = Paint()..color = theme.accentGlow.withValues(alpha: 0.85);
    final p1 = Path()
      ..moveTo(cx - 5, baseY)
      ..lineTo(cx - 2, baseY - 13)
      ..lineTo(cx + 2, baseY)
      ..close();
    final p2 = Path()
      ..moveTo(cx + 1, baseY)
      ..lineTo(cx + 6, baseY - 9)
      ..lineTo(cx + 9, baseY)
      ..close();
    canvas.drawPath(p1, crystalPaint);
    canvas.drawPath(p2, Paint()..color = theme.stoneTop);
  }
}

/// Espinas de sombra (pueden esquivarse o usarse para hacer pogo con golpe hacia abajo).
class SpikeHazardComponent extends PositionComponent {
  final BiomeTheme theme;

  SpikeHazardComponent({
    required double x,
    required double surfaceY,
    required double width,
    required this.theme,
  }) : super(
          position: Vector2(x, surfaceY - 18),
          size: Vector2(width, 18),
          priority: 2,
        );

  Rect get damageRect => Rect.fromLTWH(
        position.x + 4,
        position.y + 4,
        size.x - 8,
        size.y - 4,
      );

  Rect get pogoRect => Rect.fromLTWH(
        position.x - 2,
        position.y - 6,
        size.x + 4,
        size.y + 6,
      );

  @override
  void render(Canvas canvas) {
    const toothW = 16.0;
    final count = (size.x / toothW).floor().clamp(1, 20);
    final actualW = size.x / count;

    final darkPaint = Paint()..color = const Color(0xFF1A1024);
    final rimPaint = Paint()
      ..color = const Color(0xFFF43F5E).withValues(alpha: 0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (var i = 0; i < count; i++) {
      final lx = i * actualW;
      final path = Path()
        ..moveTo(lx + 1, size.y)
        ..lineTo(lx + actualW * 0.5, 1)
        ..lineTo(lx + actualW - 1, size.y)
        ..close();
      canvas.drawPath(path, darkPaint);
      canvas.drawPath(path, rimPaint);
    }
  }
}

/// Hongo bioluminiscente rebotador (estilo Well Dweller / Hollow Knight Fungal Wastes).
/// Al caer encima o golpearlo hacia abajo (pogo), impulsa al viajero hacia arriba.
class BounceMushroomComponent extends PositionComponent {
  final BiomeTheme theme;
  double _squash = 0;
  double _pulseTime = 0;

  BounceMushroomComponent({
    required double x,
    required double baseY,
    required this.theme,
  }) : super(
          position: Vector2(x, baseY),
          size: Vector2(46, 36),
          anchor: Anchor.bottomCenter,
          priority: 2,
        );

  Rect get bounceRect => Rect.fromLTWH(
        position.x - size.x / 2,
        position.y - size.y,
        size.x,
        size.y * 0.65,
      );

  void triggerBounce() {
    _squash = 1.0;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _pulseTime += dt;
    if (_squash > 0) {
      _squash = (_squash - dt * 5.0).clamp(0.0, 1.0);
    }
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final scaleY = 1.0 - _squash * 0.32;
    final scaleX = 1.0 + _squash * 0.25;

    canvas.save();
    canvas.translate(w / 2, h);
    canvas.scale(scaleX, scaleY);
    canvas.translate(-w / 2, -h);

    final glowAlpha = 0.22 + 0.1 * math.sin(_pulseTime * 3.5);
    canvas.drawCircle(
      Offset(w / 2, h * 0.35),
      26,
      Paint()..color = theme.accentGlow.withValues(alpha: glowAlpha),
    );

    // Tallo
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w / 2 - 6, h * 0.42, 12, h * 0.58),
        const Radius.circular(5),
      ),
      Paint()..color = const Color(0xFFCBD5E1),
    );

    // Sombrero del hongo
    final capPath = Path()
      ..moveTo(2, h * 0.48)
      ..quadraticBezierTo(w / 2, -6, w - 2, h * 0.48)
      ..quadraticBezierTo(w / 2, h * 0.58, 2, h * 0.48)
      ..close();
    canvas.drawPath(capPath, Paint()..color = theme.stoneTop);
    canvas.drawPath(
      capPath,
      Paint()
        ..color = theme.accentGlow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Manchas luminosas
    final dotPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawCircle(Offset(w * 0.32, h * 0.28), 3.2, dotPaint);
    canvas.drawCircle(Offset(w * 0.58, h * 0.20), 2.5, dotPaint);
    canvas.drawCircle(Offset(w * 0.72, h * 0.34), 2.8, dotPaint);

    canvas.restore();
  }
}

/// Anillo dorado Muisca colgante para enganchar con el Látigo de Cadena Dorada.
/// Al golpearlo con el látigo, impulsa al Guardián hacia arriba y adelante!
class HookRingComponent extends PositionComponent {
  final BiomeTheme theme;
  bool isInRange = false;
  bool isHooked = false;
  double _time = 0;
  double _hookFlash = 0;

  HookRingComponent({
    required double x,
    required double y,
    required this.theme,
  }) : super(
          position: Vector2(x, y),
          size: Vector2(36, 36),
          anchor: Anchor.center,
          priority: 6,
        );

  Rect get hookRect => Rect.fromCenter(
        center: Offset(position.x, position.y),
        width: 48,
        height: 48,
      );

  void triggerHook() {
    _hookFlash = 1.0;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
    if (_hookFlash > 0) {
      _hookFlash = (_hookFlash - dt * 3.4).clamp(0.0, 1.0);
    }
  }

  @override
  void render(Canvas canvas) {
    final cx = size.x / 2;
    final cy = size.y / 2;

    // Liana/cadena fina colgando hacia arriba
    canvas.drawLine(
      Offset(cx, -56),
      Offset(cx, cy - 11),
      Paint()
        ..color = const Color(0xFF94A3B8).withValues(alpha: 0.45)
        ..strokeWidth = 2,
    );

    // Halo dorado-esmeralda
    final haloR = isInRange ? 30.0 + math.sin(_time * 6) * 3 : 22.0;
    canvas.drawCircle(
      Offset(cx, cy),
      haloR,
      Paint()
        ..color = (isInRange
                ? const Color(0xFFFDE047)
                : const Color(0xFF34D399))
            .withValues(alpha: isInRange ? 0.28 : 0.16),
    );

    // Anillo pulsante cuando está al alcance del látigo
    if (isInRange) {
      canvas.drawCircle(
        Offset(cx, cy),
        19 + math.sin(_time * 7) * 2.5,
        Paint()
          ..color = const Color(0xFFFDE047).withValues(alpha: 0.65)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8,
      );
    }

    // Onda expansiva al enganchar
    if (_hookFlash > 0) {
      canvas.drawCircle(
        Offset(cx, cy),
        14 + (1 - _hookFlash) * 26,
        Paint()
          ..color = const Color(0xFF6EE7B7).withValues(alpha: _hookFlash * 0.85)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
    }

    // Aro dorado Muisca
    canvas.drawCircle(
      Offset(cx, cy),
      11,
      Paint()
        ..color = _hookFlash > 0.3 ? Colors.white : const Color(0xFFFBBF24)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.2,
    );

    // Gema esmeralda central
    final gem = Path()
      ..moveTo(cx, cy - 5)
      ..lineTo(cx + 4.5, cy)
      ..lineTo(cx, cy + 5)
      ..lineTo(cx - 4.5, cy)
      ..close();
    canvas.drawPath(gem, Paint()..color = const Color(0xFF10B981));
    canvas.drawCircle(
      Offset(cx - 1, cy - 1),
      1.3,
      Paint()..color = Colors.white.withValues(alpha: 0.9),
    );

    if (isHooked) {
      final tp = TextPainter(
        text: const TextSpan(
          text: 'Salto ▲',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFDE047),
            shadows: [Shadow(color: Colors.black, blurRadius: 4)],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(cx - tp.width / 2, -16));
    }
  }
}
