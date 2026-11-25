import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../data/level_map_data.dart';

/// Plataforma estilo **Cuaderno Escolar Mágico**:
/// - Plataformas elevadas (`h <= 40`): Reglas escolares coloridas con marquitas numéricas.
/// - Suelos y bloques grandes (`h > 40`): Libros ilustrados apilados con lomo colorido,
///   hojas cremita y cintas decorativas (*washi tape*).
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

    // Sombra suave sobre el papel del cuaderno
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(3, 5, w, h),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0x220F172A),
    );

    if (h <= 40) {
      _drawRulerPlatform(canvas, w, h);
    } else {
      _drawStackedBookPlatform(canvas, w, h);
    }
  }

  static final List<TextPainter> _rulerDigitPainters = List.generate(
    9,
    (i) => TextPainter(
      text: TextSpan(
        text: '${i + 1}',
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 8.5,
          fontWeight: FontWeight.w900,
          color: Color(0xFF0F172A),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(),
  );

  /// Regla escolar colorida con marcas de centímetros y pestañitas adhesivas.
  void _drawRulerPlatform(Canvas canvas, double w, double h) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(6),
    );

    // Cuerpo principal de la regla
    canvas.drawRRect(rrect, Paint()..color = theme.stoneTop);

    // Franja superior clara para resaltar las medidas
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, w, h * 0.42),
        topLeft: const Radius.circular(6),
        topRight: const Radius.circular(6),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.28),
    );

    // Borde definido estilo ilustración infantil
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = theme.stoneBody.withValues(alpha: 0.78)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    // Marcas de centímetros y milímetros a lo largo de la regla
    final tickPaint = Paint()
      ..color = const Color(0xFF1E293B).withValues(alpha: 0.65)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    var cm = 1;
    for (var tx = 14.0; tx < w - 10; tx += 12.0) {
      final isMajor = ((tx - 14.0) / 12.0).round() % 3 == 0;
      canvas.drawLine(
        Offset(tx, 1.5),
        Offset(tx, isMajor ? 11.0 : 6.5),
        tickPaint,
      );
      if (isMajor && tx < w - 20 && cm <= 9) {
        final tp = _rulerDigitPainters[cm - 1];
        tp.paint(canvas, Offset(tx - tp.width / 2, 12.5));
        cm++;
      }
    }

    // Banderita adhesiva (post-it tab) decorativa en plataformas especiales
    if (hasCrystalAccent && w >= 120) {
      _drawStickyTab(canvas, 18, 0, const Color(0xFFFB7185));
      _drawStickyTab(canvas, w - 28, 0, const Color(0xFF38BDF8));
    }
  }

  /// Bloque tipo libro de cuentos gigante con tapa de color, páginas crema y washi tape.
  void _drawStackedBookPlatform(Canvas canvas, double w, double h) {
    final bodyRRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, w, h),
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
    );

    // Tapa principal del libro en color vivo del capítulo
    canvas.drawRRect(bodyRRect, Paint()..color = theme.stoneBody);

    // Franja gruesa de hojas blancas/cremita de libro en la parte superior
    final pagesRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(6, 12, w - 12, 22),
      const Radius.circular(4),
    );
    canvas.drawRRect(pagesRect, Paint()..color = const Color(0xFFFFFBEB));
    final pageLinePaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.0;
    canvas.drawLine(const Offset(10, 18), Offset(w - 10, 18), pageLinePaint);
    canvas.drawLine(const Offset(10, 24), Offset(w - 10, 24), pageLinePaint);
    canvas.drawLine(const Offset(10, 30), Offset(w - 10, 30), pageLinePaint);

    // Lomo / tapa superior contrastante
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, w, 12),
        topLeft: const Radius.circular(10),
        topRight: const Radius.circular(10),
      ),
      Paint()..color = theme.stoneTop,
    );

    // Puntadas decorativas de encuadernación
    final stitchPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.65)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    for (var sx = 14.0; sx < w - 16; sx += 22) {
      canvas.drawLine(Offset(sx, 6), Offset(sx + 9, 6), stitchPaint);
    }

    // Franjas geométricas suaves en la portada inferior del libro
    final stripePaint = Paint()..color = Colors.white.withValues(alpha: 0.14);
    for (var bx = 26.0; bx < w - 30; bx += 68) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(bx, 46, 38, 12),
          const Radius.circular(6),
        ),
        stripePaint,
      );
    }

    // Cinta adhesiva decorativa (*washi tape*) en la esquina
    canvas.save();
    canvas.translate(22, 6);
    canvas.rotate(-0.22);
    canvas.drawRect(
      const Rect.fromLTWH(-14, -4, 28, 9),
      Paint()..color = theme.accentGlow.withValues(alpha: 0.78),
    );
    canvas.restore();

    // Contorno definido de libro ilustrado
    canvas.drawRRect(
      bodyRRect,
      Paint()
        ..color = const Color(0xFF0F172A).withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8,
    );

    // Separadores de colores sobresaliendo en plataformas destacadas
    if (hasCrystalAccent && w >= 120) {
      _drawStickyTab(canvas, 34, 0, const Color(0xFFFACC15));
      _drawStickyTab(canvas, w - 34, 0, const Color(0xFFFB7185));
    }
  }

  void _drawStickyTab(Canvas canvas, double cx, double baseY, Color color) {
    final tab = RRect.fromRectAndCorners(
      Rect.fromLTWH(cx - 8, baseY - 12, 16, 13),
      topLeft: const Radius.circular(5),
      topRight: const Radius.circular(5),
    );
    canvas.drawRRect(tab, Paint()..color = color);
    canvas.drawRRect(
      tab,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );
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

    final woodPaint = Paint()..color = const Color(0xFFFDE68A);
    final leadPaint = Paint()..color = const Color(0xFFE11D48);
    final rimPaint = Paint()
      ..color = const Color(0xFF78350F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    // Puntas afiladas de lápices de colores (obstáculo 100% escolar)
    for (var i = 0; i < count; i++) {
      final lx = i * actualW;
      final tipX = lx + actualW * 0.5;
      final cone = Path()
        ..moveTo(lx + 1, size.y)
        ..lineTo(tipX, 1)
        ..lineTo(lx + actualW - 1, size.y)
        ..close();
      canvas.drawPath(cone, woodPaint);

      final lead = Path()
        ..moveTo(tipX - actualW * 0.18, 7.5)
        ..lineTo(tipX, 1)
        ..lineTo(tipX + actualW * 0.18, 7.5)
        ..close();
      canvas.drawPath(lead, leadPaint);
      canvas.drawPath(cone, rimPaint);
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

    // Resorte de espiral de cuaderno debajo del borrador
    final springPaint = Paint()
      ..color = const Color(0xFF64748B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round;
    final spring = Path()
      ..moveTo(w * 0.30, h)
      ..lineTo(w * 0.70, h - 5)
      ..lineTo(w * 0.30, h - 10)
      ..lineTo(w * 0.70, h - 15);
    canvas.drawPath(spring, springPaint);

    // Borrador escolar clásico bicolor elástico (rosa + azul cielo)
    final eraserRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3, 4, w - 6, 18),
      const Radius.circular(6),
    );
    // Mitad izquierda rosa pastel
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(3, 4, (w - 6) * 0.62, 18),
        topLeft: const Radius.circular(6),
        bottomLeft: const Radius.circular(6),
      ),
      Paint()..color = const Color(0xFFFB7185),
    );
    // Mitad derecha azul cielo
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(3 + (w - 6) * 0.58, 4, (w - 6) * 0.42, 18),
        topRight: const Radius.circular(6),
        bottomRight: const Radius.circular(6),
      ),
      Paint()..color = const Color(0xFF38BDF8),
    );
    // Banda blanca de papel en el centro
    canvas.drawRect(
      Rect.fromLTWH(w * 0.45, 4, 8, 18),
      Paint()..color = Colors.white,
    );
    // Contorno y brillo del borrador
    canvas.drawRRect(
      eraserRect,
      Paint()
        ..color = const Color(0xFF334155)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8,
    );
    canvas.drawLine(
      const Offset(8, 8),
      Offset(w - 10, 8),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.55)
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round,
    );

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
