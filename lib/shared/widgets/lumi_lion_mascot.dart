import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Mascota oficial de EduPlay: **Lumi el Leoncito**.
///
/// Reemplaza cualquier ícono o dibujo anterior por un leoncito infantil
/// dibujado en Canvas con melena esponjosa, orejitas redondas, hocico cremita,
/// bigoticos, colita con pompón y pañoleta de explorador.
class LumiLionMascot extends StatelessWidget {
  final double size;
  final int grade;
  final Color accentColor;
  final int expressionVariant;
  final bool interactive;
  final VoidCallback? onTap;

  const LumiLionMascot({
    super.key,
    this.size = 84,
    this.grade = 1,
    this.accentColor = const Color(0xFF3B82F6),
    this.expressionVariant = 0,
    this.interactive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final illustration = SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: LumiLionPainter(
          grade: grade,
          accentColor: accentColor,
          expressionVariant: expressionVariant,
        ),
      ),
    );

    if (!interactive && onTap == null) {
      return illustration;
    }

    return GestureDetector(
      onTap: onTap,
      child: illustration,
    );
  }
}

class LumiLionPainter extends CustomPainter {
  final int grade;
  final Color accentColor;
  final int expressionVariant;

  const LumiLionPainter({
    this.grade = 1,
    this.accentColor = const Color(0xFF3B82F6),
    this.expressionVariant = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final s = math.min(size.width, size.height) / 88.0;
    final cx = size.width / 2;
    final cy = size.height / 2 + 2 * s;

    // Paleta cálida de leoncito
    const maneDark = Color(0xFFB45309); // Castaño miel oscuro
    const maneMid = Color(0xFFD97706); // Ámbar cálido
    const furGold = Color(0xFFFBBF24); // Dorado leoncito
    const furShadow = Color(0xFFF59E0B); // Dorado intenso
    const creamFur = Color(0xFFFEF3C7); // Cremita hocico y pancita
    const innerEarPink = Color(0xFFFDBA74); // Durazno interior oreja
    const noseColor = Color(0xFF9A3412); // Naricita terracota
    const lineBrown = Color(0xFF78350F); // Líneas faciales suaves

    // 1. Halo suave de fondo
    canvas.drawCircle(
      Offset(cx, cy),
      38 * s,
      Paint()..color = const Color(0xFFFDE68A).withValues(alpha: 0.35),
    );
    canvas.drawCircle(
      Offset(cx, cy),
      33 * s,
      Paint()..color = accentColor.withValues(alpha: 0.12),
    );

    // 2. Colita de leoncito con pompón (asomando a la derecha)
    final tailSwing = expressionVariant.isOdd ? -4.0 * s : 2.0 * s;
    final tailPath = Path()
      ..moveTo(cx + 14 * s, cy + 22 * s)
      ..quadraticBezierTo(
        cx + 34 * s,
        cy + 20 * s + tailSwing,
        cx + 31 * s,
        cy + 4 * s + tailSwing,
      );
    canvas.drawPath(
      tailPath,
      Paint()
        ..color = furShadow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.5 * s
        ..strokeCap = StrokeCap.round,
    );
    // Pompón de la cola
    final tuftCenter = Offset(cx + 31 * s, cy + 2 * s + tailSwing);
    canvas.drawCircle(tuftCenter, 6.2 * s, Paint()..color = maneDark);
    canvas.drawCircle(
      tuftCenter + Offset(-1.2 * s, -1.2 * s),
      4.2 * s,
      Paint()..color = maneMid,
    );

    // 3. Cuerpecito sentado del leoncito
    final bodyRect = Rect.fromCenter(
      center: Offset(cx, cy + 17 * s),
      width: 38 * s,
      height: 32 * s,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, Radius.circular(16 * s)),
      Paint()..color = furShadow,
    );

    // Pancita cremita
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + 18 * s),
        width: 24 * s,
        height: 22 * s,
      ),
      Paint()..color = creamFur,
    );

    // Pañoleta de explorador con el color del período/grado
    final scarfPath = Path()
      ..moveTo(cx - 16 * s, cy + 5 * s)
      ..quadraticBezierTo(cx, cy + 12 * s, cx + 16 * s, cy + 5 * s)
      ..lineTo(cx + 4 * s, cy + 16 * s)
      ..lineTo(cx - 4 * s, cy + 16 * s)
      ..close();
    canvas.drawPath(scarfPath, Paint()..color = accentColor);
    canvas.drawCircle(
      Offset(cx, cy + 10.5 * s),
      2.6 * s,
      Paint()..color = const Color(0xFFFDE047),
    );

    // 4. Orejitas redondas de león (asomando arriba de la melena)
    final headCenter = Offset(cx, cy - 8 * s);
    final leftEarCenter = headCenter + Offset(-18 * s, -17 * s);
    final rightEarCenter = headCenter + Offset(18 * s, -17 * s);

    for (final ear in [leftEarCenter, rightEarCenter]) {
      canvas.drawCircle(ear, 9.5 * s, Paint()..color = furShadow);
      canvas.drawCircle(ear, 5.5 * s, Paint()..color = innerEarPink);
    }

    // 5. Melena esponjosa de leoncito (corona de pétalos redondeados)
    const petalCount = 12;
    final maneRadius = 23.5 * s;
    for (int i = 0; i < petalCount; i++) {
      final angle = (i * 2 * math.pi) / petalCount;
      final px = headCenter.dx + math.cos(angle) * maneRadius;
      final py = headCenter.dy + math.sin(angle) * maneRadius;
      canvas.drawCircle(
        Offset(px, py),
        9.2 * s,
        Paint()..color = i.isEven ? maneDark : maneMid,
      );
    }
    // Relleno central de la melena
    canvas.drawCircle(headCenter, 25 * s, Paint()..color = maneDark);
    canvas.drawCircle(headCenter, 22.5 * s, Paint()..color = maneMid);

    // 6. Carita dorada del leoncito
    canvas.drawCircle(headCenter, 18.5 * s, Paint()..color = furGold);

    // Mechoncito tierno en la frente
    final tuftPath = Path()
      ..moveTo(headCenter.dx - 5 * s, headCenter.dy - 16 * s)
      ..quadraticBezierTo(
        headCenter.dx,
        headCenter.dy - 24 * s,
        headCenter.dx + 5 * s,
        headCenter.dy - 16 * s,
      )
      ..close();
    canvas.drawPath(tuftPath, Paint()..color = maneMid);

    // Corona o gorrito de explorador según el grado (arriba de la melena)
    if (grade >= 4) {
      // Gorrita de capitán explorador
      final capRect = Rect.fromCenter(
        center: Offset(headCenter.dx, headCenter.dy - 26 * s),
        width: 22 * s,
        height: 8 * s,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(capRect, Radius.circular(4 * s)),
        Paint()..color = accentColor,
      );
      canvas.drawCircle(
        Offset(headCenter.dx, headCenter.dy - 26 * s),
        2.5 * s,
        Paint()..color = const Color(0xFFFDE047),
      );
    } else {
      // Coronita real del rey de la selva
      final crown = Path()
        ..moveTo(headCenter.dx - 9 * s, headCenter.dy - 23 * s)
        ..lineTo(headCenter.dx - 7 * s, headCenter.dy - 31 * s)
        ..lineTo(headCenter.dx - 2 * s, headCenter.dy - 26 * s)
        ..lineTo(headCenter.dx, headCenter.dy - 33 * s)
        ..lineTo(headCenter.dx + 2 * s, headCenter.dy - 26 * s)
        ..lineTo(headCenter.dx + 7 * s, headCenter.dy - 31 * s)
        ..lineTo(headCenter.dx + 9 * s, headCenter.dy - 23 * s)
        ..close();
      canvas.drawPath(crown, Paint()..color = const Color(0xFFFACC15));
      canvas.drawPath(
        crown,
        Paint()
          ..color = maneDark
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2 * s,
      );
    }

    // 7. Mejillas sonrojadas
    canvas.drawOval(
      Rect.fromCenter(
        center: headCenter + Offset(-12 * s, 4 * s),
        width: 6.5 * s,
        height: 4 * s,
      ),
      Paint()..color = const Color(0xFFFB7185).withValues(alpha: 0.45),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: headCenter + Offset(12 * s, 4 * s),
        width: 6.5 * s,
        height: 4 * s,
      ),
      Paint()..color = const Color(0xFFFB7185).withValues(alpha: 0.45),
    );

    // 8. Ojos grandes expresivos de cachorro de león
    final leftEye = headCenter + Offset(-7.5 * s, -3 * s);
    final rightEye = headCenter + Offset(7.5 * s, -3 * s);

    for (final eye in [leftEye, rightEye]) {
      canvas.drawCircle(eye, 5.8 * s, Paint()..color = Colors.white);
    }

    final pupilShift = switch (expressionVariant % 4) {
      1 => Offset(1.0 * s, -0.8 * s),
      2 => Offset(-1.0 * s, 0),
      3 => Offset(0, -1.0 * s),
      _ => Offset.zero,
    };

    for (final eye in [leftEye, rightEye]) {
      canvas.drawCircle(
        eye + pupilShift,
        3.6 * s,
        Paint()..color = const Color(0xFF1E1B18),
      );
      // Brillito principal y secundario
      canvas.drawCircle(
        eye + Offset(-1.4 * s, -1.6 * s),
        1.5 * s,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        eye + Offset(1.2 * s, 1.2 * s),
        0.7 * s,
        Paint()..color = Colors.white,
      );
    }

    // Cejas expresivas
    final browPaint = Paint()
      ..color = maneDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8 * s
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(
        center: leftEye + Offset(0, -5.5 * s),
        width: 8 * s,
        height: 4 * s,
      ),
      math.pi + 0.3,
      math.pi - 0.6,
      false,
      browPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: rightEye + Offset(0, -5.5 * s),
        width: 8 * s,
        height: 4 * s,
      ),
      math.pi + 0.3,
      math.pi - 0.6,
      false,
      browPaint,
    );

    // 9. Hocico cremita de leoncito (dos almohadillas redondas + barbilla)
    final muzzleY = headCenter.dy + 5.5 * s;
    canvas.drawCircle(
      Offset(headCenter.dx - 4.2 * s, muzzleY),
      5.5 * s,
      Paint()..color = creamFur,
    );
    canvas.drawCircle(
      Offset(headCenter.dx + 4.2 * s, muzzleY),
      5.5 * s,
      Paint()..color = creamFur,
    );

    // Naricita triangular redondeada de león
    final nosePath = Path()
      ..moveTo(headCenter.dx - 4.5 * s, muzzleY - 4.2 * s)
      ..quadraticBezierTo(
        headCenter.dx,
        muzzleY - 5.2 * s,
        headCenter.dx + 4.5 * s,
        muzzleY - 4.2 * s,
      )
      ..quadraticBezierTo(
        headCenter.dx + 2 * s,
        muzzleY + 0.8 * s,
        headCenter.dx,
        muzzleY + 1.2 * s,
      )
      ..quadraticBezierTo(
        headCenter.dx - 2 * s,
        muzzleY + 0.8 * s,
        headCenter.dx - 4.5 * s,
        muzzleY - 4.2 * s,
      )
      ..close();
    canvas.drawPath(nosePath, Paint()..color = noseColor);

    // Sonrisa tierna en forma de ω de leoncito
    final mouthPaint = Paint()
      ..color = lineBrown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6 * s
      ..strokeCap = StrokeCap.round;

    // Boquita abierta alegre cuando está celebrando
    if (expressionVariant.isOdd) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(headCenter.dx, muzzleY + 2.5 * s),
          width: 8.5 * s,
          height: 7.5 * s,
        ),
        0,
        math.pi,
        true,
        Paint()..color = const Color(0xFFFB7185),
      );
    }

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(headCenter.dx - 3.2 * s, muzzleY + 1.5 * s),
        width: 6.4 * s,
        height: 5.2 * s,
      ),
      0.1,
      math.pi - 0.2,
      false,
      mouthPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(headCenter.dx + 3.2 * s, muzzleY + 1.5 * s),
        width: 6.4 * s,
        height: 5.2 * s,
      ),
      0.1,
      math.pi - 0.2,
      false,
      mouthPaint,
    );

    // 10. Bigoticos de leoncito (2 a cada lado)
    final whiskerPaint = Paint()
      ..color = lineBrown.withValues(alpha: 0.65)
      ..strokeWidth = 1.3 * s
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(headCenter.dx - 9 * s, muzzleY - 0.5 * s),
      Offset(headCenter.dx - 16 * s, muzzleY - 2 * s),
      whiskerPaint,
    );
    canvas.drawLine(
      Offset(headCenter.dx - 9 * s, muzzleY + 2 * s),
      Offset(headCenter.dx - 15.5 * s, muzzleY + 3.5 * s),
      whiskerPaint,
    );
    canvas.drawLine(
      Offset(headCenter.dx + 9 * s, muzzleY - 0.5 * s),
      Offset(headCenter.dx + 16 * s, muzzleY - 2 * s),
      whiskerPaint,
    );
    canvas.drawLine(
      Offset(headCenter.dx + 9 * s, muzzleY + 2 * s),
      Offset(headCenter.dx + 15.5 * s, muzzleY + 3.5 * s),
      whiskerPaint,
    );

    // 11. Manitas y patitas con almohadillas de leoncito
    final leftPaw = Offset(cx - 18 * s, cy + 16 * s);
    final rightPaw = Offset(
      cx + 19 * s,
      expressionVariant.isOdd ? cy + 5 * s : cy + 14 * s,
    );

    for (final paw in [leftPaw, rightPaw]) {
      canvas.drawCircle(paw, 6.2 * s, Paint()..color = furGold);
      canvas.drawCircle(
        paw,
        6.2 * s,
        Paint()
          ..color = maneMid.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.1 * s,
      );
      // Almohadillas de la garrita
      canvas.drawCircle(
        paw + Offset(0, 1.2 * s),
        2.1 * s,
        Paint()..color = innerEarPink,
      );
      for (final dx in [-2.4 * s, 0.0, 2.4 * s]) {
        canvas.drawCircle(
          paw + Offset(dx, -2.0 * s),
          1.0 * s,
          Paint()..color = innerEarPink,
        );
      }
    }

    // Patitas inferiores sentadas
    for (final dx in [-11 * s, 11 * s]) {
      final footCenter = Offset(cx + dx, cy + 31 * s);
      canvas.drawOval(
        Rect.fromCenter(center: footCenter, width: 13 * s, height: 8.5 * s),
        Paint()..color = furGold,
      );
      canvas.drawCircle(
        footCenter + Offset(0, 1 * s),
        2.3 * s,
        Paint()..color = innerEarPink,
      );
    }
  }

  @override
  bool shouldRepaint(covariant LumiLionPainter old) =>
      old.grade != grade ||
      old.accentColor != accentColor ||
      old.expressionVariant != expressionVariant;
}
