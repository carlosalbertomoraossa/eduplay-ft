import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Temas de mundos infantiles ilustrados para toda la plataforma EduPlay.
enum PlayfulWorldTheme {
  sunnyMeadow, // Cielo soleado + colinas verdes (Home / Período 1)
  magicForest, // Bosque encantado lavanda/esmeralda (Período 2 / Preparación)
  treasureIsland, // Isla tropical turquesa/arena (Período 3 / Camino)
  starrySpace, // Cielo estelar dorado/azul (Período 4 / Retos)
}

/// Patrón visual reutilizable de fondo infantil ilustrado (Estilo Khan Academy Kids /
/// Matific / Duolingo ABC). Dibuja cielo en degradado, sol/planeta brillante,
/// nubes esponjosas, garabatos matemáticos flotantes (+, ×, %, figuras) y
/// colinas suaves en capas para eliminar la apariencia plana de la plataforma.
class PlayfulWorldBackground extends StatelessWidget {
  final Widget child;
  final PlayfulWorldTheme theme;
  final bool showBottomHills;

  const PlayfulWorldBackground({
    super.key,
    required this.child,
    this.theme = PlayfulWorldTheme.sunnyMeadow,
    this.showBottomHills = true,
  });

  static PlayfulWorldTheme fromPeriod(int? period) {
    return switch (period) {
      1 => PlayfulWorldTheme.sunnyMeadow,
      2 => PlayfulWorldTheme.magicForest,
      3 => PlayfulWorldTheme.treasureIsland,
      4 => PlayfulWorldTheme.starrySpace,
      _ => PlayfulWorldTheme.sunnyMeadow,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: PlayfulWorldPainter(
              theme: theme,
              showBottomHills: showBottomHills,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

/// Tarjeta táctil 3D estilo bloque de juguete (con borde inferior grueso tipo bisel).
class Playful3DCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final Color? bottomLipColor;
  final Color backgroundColor;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  const Playful3DCard({
    super.key,
    required this.child,
    required this.borderColor,
    this.bottomLipColor,
    this.backgroundColor = Colors.white,
    this.gradient,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 22,
  });

  @override
  Widget build(BuildContext context) {
    final lip = bottomLipColor ?? borderColor;
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: lip,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.16),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: gradient == null ? backgroundColor : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius - 1),
          border: Border.all(
            color: borderColor,
            width: 2.2,
          ),
        ),
        child: child,
      ),
    );
  }
}

class PlayfulWorldPainter extends CustomPainter {
  final PlayfulWorldTheme theme;
  final bool showBottomHills;

  const PlayfulWorldPainter({
    required this.theme,
    this.showBottomHills = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final (skyTop, skyMid, skyBottom, hillBack, hillFront, accentDoodle) =
        switch (theme) {
      PlayfulWorldTheme.sunnyMeadow => (
          const Color(0xFFBAE6FD),
          const Color(0xFFE0F2FE),
          const Color(0xFFFEF9C3),
          const Color(0xFF86EFAC),
          const Color(0xFF4ADE80),
          const Color(0xFF0284C7),
        ),
      PlayfulWorldTheme.magicForest => (
          const Color(0xFFDDD6FE),
          const Color(0xFFEDE9FE),
          const Color(0xFFD1FAE5),
          const Color(0xFFA78BFA),
          const Color(0xFF34D399),
          const Color(0xFF7C3AED),
        ),
      PlayfulWorldTheme.treasureIsland => (
          const Color(0xFFA5F3FC),
          const Color(0xFFCCFBF1),
          const Color(0xFFFEF3C7),
          const Color(0xFF2DD4BF),
          const Color(0xFFFBBF24),
          const Color(0xFF0D9488),
        ),
      PlayfulWorldTheme.starrySpace => (
          const Color(0xFFC7D2FE),
          const Color(0xFFE0E7FF),
          const Color(0xFFFCE7F3),
          const Color(0xFF818CF8),
          const Color(0xFFF472B6),
          const Color(0xFF4F46E5),
        ),
    };

    // 1. Cielo degradado vibrante infantil
    final skyRect = Rect.fromLTWH(0, 0, w, h);
    canvas.drawRect(
      skyRect,
      Paint()
        ..shader = LinearGradient(
          colors: [skyTop, skyMid, skyBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.58, 1.0],
        ).createShader(skyRect),
    );

    // 2. Sol / Planeta amigable con halo luminoso arriba a la derecha
    final sunCenter = Offset(w * 0.86, 68);
    canvas.drawCircle(
      sunCenter,
      48,
      Paint()..color = const Color(0xFFFDE047).withValues(alpha: 0.25),
    );
    canvas.drawCircle(
      sunCenter,
      32,
      Paint()..color = const Color(0xFFFACC15).withValues(alpha: 0.45),
    );
    canvas.drawCircle(
      sunCenter,
      20,
      Paint()..color = const Color(0xFFFDE047),
    );

    // 3. Banderines de fiesta infantiles en la parte superior
    _drawBuntingFlags(canvas, w);

    // 4. Nubes esponjosas distribuidas por el fondo
    _drawFluffyCloud(canvas, Offset(w * 0.14, 78), 1.0);
    _drawFluffyCloud(canvas, Offset(w * 0.56, 52), 0.78);
    _drawFluffyCloud(canvas, Offset(w * 0.82, 165), 0.85);
    _drawFluffyCloud(canvas, Offset(w * 0.22, 275), 0.90);
    if (h > 480) {
      _drawFluffyCloud(canvas, Offset(w * 0.76, 420), 0.95);
      _drawFluffyCloud(canvas, Offset(w * 0.16, 560), 0.80);
    }

    // 5. Símbolos matemáticos y figuras geométricas flotantes (burbujas suaves)
    final doodles = [
      ('+', Offset(w * 0.08, 135), const Color(0xFF3B82F6)),
      ('★', Offset(w * 0.91, 128), const Color(0xFFF59E0B)),
      ('×', Offset(w * 0.88, 245), const Color(0xFFEC4899)),
      ('△', Offset(w * 0.10, 345), const Color(0xFF10B981)),
      ('½', Offset(w * 0.90, 365), const Color(0xFF8B5CF6)),
      ('÷', Offset(w * 0.07, 470), const Color(0xFFEA580C)),
      ('123', Offset(w * 0.89, 510), accentDoodle),
    ];

    for (final d in doodles) {
      if (d.$2.dy > h - 30) continue;
      // Burbuja translúcida detrás del símbolo
      canvas.drawCircle(
        d.$2,
        18,
        Paint()..color = Colors.white.withValues(alpha: 0.55),
      );
      canvas.drawCircle(
        d.$2,
        18,
        Paint()
          ..color = d.$3.withValues(alpha: 0.28)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: d.$1,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: d.$3.withValues(alpha: 0.65),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(d.$2.dx - tp.width / 2, d.$2.dy - tp.height / 2),
      );
    }

    // 6. Colinas infantiles en capas en la base
    if (showBottomHills) {
      final backHillPath = Path()
        ..moveTo(0, h)
        ..lineTo(0, h - 78)
        ..quadraticBezierTo(w * 0.28, h - 125, w * 0.58, h - 72)
        ..quadraticBezierTo(w * 0.82, h - 35, w, h - 88)
        ..lineTo(w, h)
        ..close();
      canvas.drawPath(
        backHillPath,
        Paint()..color = hillBack.withValues(alpha: 0.42),
      );

      final frontHillPath = Path()
        ..moveTo(0, h)
        ..lineTo(0, h - 42)
        ..quadraticBezierTo(w * 0.35, h - 10, w * 0.68, h - 56)
        ..quadraticBezierTo(w * 0.88, h - 82, w, h - 38)
        ..lineTo(w, h)
        ..close();
      canvas.drawPath(
        frontHillPath,
        Paint()..color = hillFront.withValues(alpha: 0.45),
      );

      // Arbolitos / pinitos redondos decorativos sobre las colinas
      _drawLittleTree(canvas, Offset(w * 0.12, h - 62), hillFront);
      _drawLittleTree(canvas, Offset(w * 0.85, h - 58), hillBack);
    }
  }

  void _drawBuntingFlags(Canvas canvas, double w) {
    final colors = [
      const Color(0xFFEF4444),
      const Color(0xFFF59E0B),
      const Color(0xFF10B981),
      const Color(0xFF3B82F6),
      const Color(0xFF8B5CF6),
      const Color(0xFFEC4899),
    ];
    const flagW = 28.0;
    final count = (w / flagW).ceil().clamp(4, 30);
    for (int i = 0; i < count; i++) {
      final x = i * flagW;
      final path = Path()
        ..moveTo(x + 2, 0)
        ..lineTo(x + flagW - 2, 0)
        ..lineTo(x + flagW / 2, 14)
        ..close();
      canvas.drawPath(
        path,
        Paint()..color = colors[i % colors.length].withValues(alpha: 0.38),
      );
    }
  }

  void _drawFluffyCloud(Canvas canvas, Offset center, double scale) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.78);
    canvas.drawCircle(center, 18 * scale, paint);
    canvas.drawCircle(
      center + Offset(-15 * scale, 4 * scale),
      13 * scale,
      paint,
    );
    canvas.drawCircle(
      center + Offset(15 * scale, 4 * scale),
      14 * scale,
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center + Offset(0, 8 * scale),
          width: 44 * scale,
          height: 16 * scale,
        ),
        Radius.circular(8 * scale),
      ),
      paint,
    );
  }

  void _drawLittleTree(Canvas canvas, Offset base, Color foliageColor) {
    // Tronco
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: base, width: 6, height: 14),
        const Radius.circular(3),
      ),
      Paint()..color = const Color(0xFF92400E).withValues(alpha: 0.45),
    );
    // Copa redonda
    canvas.drawCircle(
      base + const Offset(0, -12),
      13,
      Paint()..color = const Color(0xFF16A34A).withValues(alpha: 0.45),
    );
    canvas.drawCircle(
      base + const Offset(-4, -15),
      6,
      Paint()..color = const Color(0xFF86EFAC).withValues(alpha: 0.55),
    );
  }

  @override
  bool shouldRepaint(covariant PlayfulWorldPainter oldDelegate) =>
      oldDelegate.theme != theme ||
      oldDelegate.showBottomHills != showBottomHills;
}

/// Lienzo decorativo de Mapa de Isla / Sendero de Aventura para LessonsScreen.
class AdventureMapLandscapePainter extends CustomPainter {
  final int nodeCount;
  const AdventureMapLandscapePainter({required this.nodeCount});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Pradera mágica con degradado cálido infantil
    final bgRect = Rect.fromLTWH(0, 0, w, h);
    canvas.drawRect(
      bgRect,
      Paint()
        ..shader = const LinearGradient(
          colors: [
            Color(0xFFDCFCE7),
            Color(0xFFFEF9C3),
            Color(0xFFE0F2FE),
            Color(0xFFF3E8FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bgRect),
    );

    // 2. Río serpenteante azul claro que cruza el mapa
    final riverPath = Path()
      ..moveTo(0, h * 0.32)
      ..quadraticBezierTo(w * 0.45, h * 0.27, w, h * 0.36)
      ..lineTo(w, h * 0.41)
      ..quadraticBezierTo(w * 0.45, h * 0.32, 0, h * 0.37)
      ..close();
    canvas.drawPath(
      riverPath,
      Paint()..color = const Color(0xFF7DD3FC).withValues(alpha: 0.55),
    );

    // 3. Colinas laterales, arbolitos, flores y estrellas a lo largo del camino
    final rng = math.Random(42);
    for (int i = 0; i < nodeCount + 3; i++) {
      final isLeft = i.isEven;
      final cx = isLeft ? w * 0.12 : w * 0.88;
      final cy = 90.0 + i * 125.0;
      if (cy > h - 40) break;

      // Loma suave
      canvas.drawOval(
        Rect.fromCenter(center: Offset(cx, cy + 16), width: 78, height: 34),
        Paint()..color = const Color(0xFF86EFAC).withValues(alpha: 0.55),
      );

      // Arbolito de cuento
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(cx, cy + 4), width: 7, height: 16),
          const Radius.circular(3),
        ),
        Paint()..color = const Color(0xFF92400E).withValues(alpha: 0.65),
      );
      canvas.drawCircle(
        Offset(cx, cy - 10),
        16,
        Paint()
          ..color = (i % 3 == 0
                  ? const Color(0xFF22C55E)
                  : i % 3 == 1
                      ? const Color(0xFF10B981)
                      : const Color(0xFF84CC16))
              .withValues(alpha: 0.75),
      );
      // Fruticas / flores en el árbol
      canvas.drawCircle(
        Offset(cx - 5 + rng.nextDouble() * 4, cy - 13),
        3,
        Paint()..color = const Color(0xFFEF4444),
      );
      canvas.drawCircle(
        Offset(cx + 5, cy - 8),
        3,
        Paint()..color = const Color(0xFFFACC15),
      );
    }
  }

  @override
  bool shouldRepaint(covariant AdventureMapLandscapePainter oldDelegate) =>
      oldDelegate.nodeCount != nodeCount;
}
