import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../data/level_map_data.dart';

/// Criaturas traviesas y coloridas pensadas para niños:
/// - [EnemyKind.crawler]: Escarabajo Mariquita saltarín (2 HP)
/// - [EnemyKind.floater]: Abejita Traviesa voladora (2 HP)
/// - [EnemyKind.sentinel]: Monstruito Morado Saltarín (4 HP)
/// - [EnemyKind.boss]: Rey Estrella Travieso del nivel 8 (6 HP)
class EnemyComponent extends PositionComponent {
  final EnemyKind kind;
  final double patrolMinX;
  final double patrolMaxX;
  final double baseY;
  final Color accentColor;

  late int maxHp;
  late int hp;
  late double _speed;

  double _dir = 1;
  double _vx = 0;
  double _vy = 0;
  double _time = 0;
  double _hitFlash = 0;
  double _actionTimer = 1.6;
  bool isDead = false;

  EnemyComponent({
    required this.kind,
    required double x,
    required double y,
    required this.patrolMinX,
    required this.patrolMaxX,
    required this.accentColor,
  })  : baseY = y,
        super(
          position: Vector2(x, y),
          size: _sizeFor(kind),
          anchor: kind == EnemyKind.floater ? Anchor.center : Anchor.bottomCenter,
          priority: 8,
        ) {
    switch (kind) {
      case EnemyKind.crawler:
        maxHp = 2;
        _speed = 72;
      case EnemyKind.floater:
        maxHp = 2;
        _speed = 82;
      case EnemyKind.sentinel:
        maxHp = 4;
        _speed = 95;
      case EnemyKind.boss:
        maxHp = 6;
        _speed = 128;
    }
    hp = maxHp;
  }

  static Vector2 _sizeFor(EnemyKind kind) {
    switch (kind) {
      case EnemyKind.crawler:
        return Vector2(38, 28);
      case EnemyKind.floater:
        return Vector2(36, 30);
      case EnemyKind.sentinel:
        return Vector2(44, 54);
      case EnemyKind.boss:
        return Vector2(64, 78);
    }
  }

  int get scoreReward {
    switch (kind) {
      case EnemyKind.crawler:
        return 25;
      case EnemyKind.floater:
        return 30;
      case EnemyKind.sentinel:
        return 60;
      case EnemyKind.boss:
        return 150;
    }
  }

  Rect get hitRect {
    if (kind == EnemyKind.floater) {
      return Rect.fromCenter(
        center: Offset(position.x, position.y),
        width: size.x - 4,
        height: size.y - 4,
      );
    }
    return Rect.fromLTWH(
      position.x - size.x / 2 + 3,
      position.y - size.y + 3,
      size.x - 6,
      size.y - 3,
    );
  }

  Vector2 get centerPos => kind == EnemyKind.floater
      ? position.clone()
      : Vector2(position.x, position.y - size.y / 2);

  /// Recibe daño del ataque luminoso del jugador; devuelve true si muere.
  bool takeHit(int damage, double knockbackDirX) {
    if (isDead) return false;
    hp -= damage;
    _hitFlash = 0.16;
    _vx = knockbackDirX * (kind == EnemyKind.boss ? 140 : 210);
    if (kind != EnemyKind.floater && position.y >= baseY - 2) {
      _vy = -170;
    }
    if (hp <= 0) {
      isDead = true;
      return true;
    }
    return false;
  }

  void updateAi(double dt, Vector2 playerPos) {
    if (isDead) return;
    _time += dt;
    if (_hitFlash > 0) _hitFlash = (_hitFlash - dt).clamp(0.0, 1.0);

    // Decay del retroceso (knockback)
    if (_vx.abs() > 8) {
      position.x += _vx * dt;
      _vx *= math.pow(0.04, dt).toDouble();
    } else {
      _vx = 0;
      if (kind == EnemyKind.boss) {
        _updateBoss(dt, playerPos);
      } else if (kind == EnemyKind.sentinel) {
        _updateSentinel(dt, playerPos);
      } else if (kind == EnemyKind.floater) {
        _updateFloater(dt);
      } else {
        _updateCrawler(dt);
      }
    }

    // Gravedad para enemigos terrestres
    if (kind != EnemyKind.floater) {
      _vy += 900 * dt;
      position.y += _vy * dt;
      if (position.y >= baseY) {
        position.y = baseY;
        _vy = 0;
      }
    }

    // Mantener dentro del rango de patrulla
    if (position.x <= patrolMinX) {
      position.x = patrolMinX;
      _dir = 1;
    } else if (position.x >= patrolMaxX) {
      position.x = patrolMaxX;
      _dir = -1;
    }
  }

  void _updateCrawler(double dt) {
    position.x += _dir * _speed * dt;
  }

  void _updateFloater(double dt) {
    position.x += _dir * _speed * dt;
    position.y = baseY + math.sin(_time * 3.2) * 26;
  }

  void _updateSentinel(double dt, Vector2 playerPos) {
    final dist = (playerPos.x - position.x).abs();
    if (dist < 220) {
      _dir = playerPos.x >= position.x ? 1 : -1;
    }
    position.x += _dir * _speed * dt;
    _actionTimer -= dt;
    if (_actionTimer <= 0 && position.y >= baseY - 2) {
      _vy = -310;
      _actionTimer = 2.1;
    }
  }

  void _updateBoss(double dt, Vector2 playerPos) {
    final dx = playerPos.x - position.x;
    if (dx.abs() < 460) {
      _dir = dx >= 0 ? 1 : -1;
    }
    position.x += _dir * _speed * dt;
    _actionTimer -= dt;
    if (_actionTimer <= 0 && position.y >= baseY - 2) {
      // Salto con embestida telegrafiada
      _vy = -380;
      _vx = _dir * 240;
      _actionTimer = 2.0;
    }
  }

  @override
  void render(Canvas canvas) {
    if (isDead) return;
    final flash = _hitFlash > 0;

    canvas.save();
    if (_dir < 0) {
      canvas.translate(size.x, 0);
      canvas.scale(-1, 1);
    }

    switch (kind) {
      case EnemyKind.crawler:
        _drawCrawler(canvas, flash);
      case EnemyKind.floater:
        _drawFloater(canvas, flash);
      case EnemyKind.sentinel:
        _drawSentinel(canvas, flash);
      case EnemyKind.boss:
        _drawBoss(canvas, flash);
    }

    canvas.restore();

    // Pips de vida cuando ha recibido daño (o siempre en el jefe)
    if (hp < maxHp || kind == EnemyKind.boss) {
      _drawHpBar(canvas);
    }
  }

  void _drawCrawler(Canvas canvas, bool flash) {
    final w = size.x;
    final h = size.y;
    final shellColor = flash ? Colors.white : const Color(0xFFEF4444);
    final rimColor = flash ? Colors.white : const Color(0xFF991B1B);

    // Patitas rápidas redondeadas
    final legPaint = Paint()
      ..color = const Color(0xFF451A03)
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round;
    final legWave = math.sin(_time * 16) * 3;
    for (var i = 0; i < 3; i++) {
      final lx = 8.0 + i * 10;
      canvas.drawLine(
        Offset(lx, h - 7),
        Offset(lx - 1.5 + (i.isEven ? legWave : -legWave), h - 1),
        legPaint,
      );
    }

    // Antenitas curiosas
    final antWave = math.sin(_time * 9) * 1.5;
    final antPaint = Paint()
      ..color = const Color(0xFF451A03)
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w - 9, 9), Offset(w - 3, 2 + antWave), antPaint);
    canvas.drawCircle(Offset(w - 3, 2 + antWave), 2.0, Paint()..color = const Color(0xFFFDE047));

    // Caparazón colorido de mariquita
    final shell = Path()
      ..moveTo(3, h - 6)
      ..quadraticBezierTo(w * 0.48, -4, w - 3, h - 6)
      ..close();
    canvas.drawPath(shell, Paint()..color = shellColor);
    canvas.drawPath(
      shell,
      Paint()
        ..color = rimColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );

    // Lunares simpáticos + brillo
    if (!flash) {
      final spotPaint = Paint()..color = const Color(0xFF7F1D1D);
      canvas.drawCircle(Offset(w * 0.30, h * 0.48), 3.0, spotPaint);
      canvas.drawCircle(Offset(w * 0.48, h * 0.32), 2.6, spotPaint);
      canvas.drawCircle(Offset(w * 0.38, h * 0.24), 1.8, Paint()..color = Colors.white.withValues(alpha: 0.45));
    }

    // Carita simpática con ojos grandes
    canvas.drawCircle(Offset(w * 0.78, h * 0.54), 6.2, Paint()..color = flash ? Colors.white : const Color(0xFFFEF3C7));
    canvas.drawCircle(Offset(w * 0.74, h * 0.50), 3.1, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.86, h * 0.51), 2.7, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.75, h * 0.50), 1.7, Paint()..color = const Color(0xFF1E293B));
    canvas.drawCircle(Offset(w * 0.87, h * 0.51), 1.5, Paint()..color = const Color(0xFF1E293B));
  }

  void _drawFloater(Canvas canvas, bool flash) {
    final w = size.x;
    final h = size.y;
    final wingFlap = math.sin(_time * 16) * 7;

    // Alitas celestes brillantes
    final wingPaint = Paint()
      ..color = flash ? Colors.white : const Color(0xFFE0F2FE).withValues(alpha: 0.90);
    final wingRim = Paint()
      ..color = const Color(0xFF38BDF8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final leftWing = Rect.fromCenter(center: Offset(w * 0.30, h * 0.28 + wingFlap * 0.4), width: 15, height: 10);
    final rightWing = Rect.fromCenter(center: Offset(w * 0.58, h * 0.24 - wingFlap * 0.4), width: 15, height: 10);
    canvas.drawOval(leftWing, wingPaint);
    canvas.drawOval(leftWing, wingRim);
    canvas.drawOval(rightWing, wingPaint);
    canvas.drawOval(rightWing, wingRim);

    // Cuerpo gordito de abejita traviesa (amarillo y morado)
    final bodyRect = Rect.fromCenter(center: Offset(w * 0.52, h * 0.58), width: 22, height: 18);
    canvas.drawOval(bodyRect, Paint()..color = flash ? Colors.white : const Color(0xFFFACC15));
    if (!flash) {
      // Franjas moradas divertidas
      final stripePaint = Paint()
        ..color = const Color(0xFF6D28D9)
        ..strokeWidth = 3.2
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(w * 0.38, h * 0.36), Offset(w * 0.38, h * 0.80), stripePaint);
      canvas.drawLine(Offset(w * 0.54, h * 0.32), Offset(w * 0.54, h * 0.84), stripePaint);
    }
    canvas.drawOval(
      bodyRect,
      Paint()
        ..color = const Color(0xFFB45309)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    // Ojos expresivos + mejilla rosada
    canvas.drawCircle(Offset(w * 0.72, h * 0.52), 3.4, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.74, h * 0.52), 1.8, Paint()..color = const Color(0xFF1E293B));
    canvas.drawCircle(Offset(w * 0.71, h * 0.48), 0.8, Paint()..color = Colors.white);
    canvas.drawCircle(
      Offset(w * 0.68, h * 0.66),
      2.2,
      Paint()..color = const Color(0xFFFB7185).withValues(alpha: 0.65),
    );
  }

  void _drawSentinel(Canvas canvas, bool flash) {
    final w = size.x;
    final h = size.y;
    final bodyColor = flash ? Colors.white : const Color(0xFF8B5CF6);

    // Patitas redondas
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.32, h - 4), width: 12, height: 8),
      Paint()..color = const Color(0xFF5B21B6),
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.68, h - 4), width: 12, height: 8),
      Paint()..color = const Color(0xFF5B21B6),
    );

    // Cuerpo redondo saltarín de monstruito morado
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4, 12, w - 8, h - 18),
      const Radius.circular(16),
    );
    canvas.drawRRect(bodyRect, Paint()..color = bodyColor);
    canvas.drawRRect(
      bodyRect,
      Paint()
        ..color = const Color(0xFF4C1D95)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8,
    );

    // Pancita lila clara
    if (!flash) {
      canvas.drawOval(
        Rect.fromCenter(center: Offset(w * 0.55, h * 0.66), width: 18, height: 16),
        Paint()..color = const Color(0xFFEDE9FE),
      );
    }

    // Hojita traviesa en la cabeza
    final leaf = Path()
      ..moveTo(w * 0.50, 12)
      ..quadraticBezierTo(w * 0.42, 0, w * 0.62, 2)
      ..quadraticBezierTo(w * 0.58, 10, w * 0.50, 12)
      ..close();
    canvas.drawPath(leaf, Paint()..color = const Color(0xFF4ADE80));

    // Ojos grandes y sonrisa chistosa
    canvas.drawCircle(Offset(w * 0.44, 24), 4.6, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.68, 24), 4.6, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.46, 24), 2.3, Paint()..color = const Color(0xFF1E1B4B));
    canvas.drawCircle(Offset(w * 0.70, 24), 2.3, Paint()..color = const Color(0xFF1E1B4B));
    canvas.drawCircle(Offset(w * 0.44, 22.5), 0.9, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.68, 22.5), 0.9, Paint()..color = Colors.white);

    // Dientecito pícaro
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.58, 33), width: 12, height: 7),
      0.1,
      math.pi - 0.2,
      false,
      Paint()
        ..color = const Color(0xFF3B0764)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawBoss(Canvas canvas, bool flash) {
    final w = size.x;
    final h = size.y;

    // Aura mágica arcoíris-dorada
    canvas.drawCircle(
      Offset(w / 2, h * 0.52),
      48 + math.sin(_time * 4) * 5,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFDE047).withValues(alpha: 0.35),
            const Color(0xFFF472B6).withValues(alpha: 0.20),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: Offset(w / 2, h * 0.52), radius: 52)),
    );

    // Capa festiva magenta-rosa
    final cape = Path()
      ..moveTo(w * 0.5, 22)
      ..lineTo(4, h - 4)
      ..quadraticBezierTo(w * 0.5, h + 4, w - 4, h - 4)
      ..close();
    canvas.drawPath(cape, Paint()..color = flash ? Colors.white : const Color(0xFFEC4899));

    // Cuerpo redondo real púrpura
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(10, 18, w - 20, h - 22),
      const Radius.circular(22),
    );
    canvas.drawRRect(body, Paint()..color = flash ? Colors.white : const Color(0xFF9333EA));
    canvas.drawRRect(
      body,
      Paint()
        ..color = const Color(0xFFFDE047)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4,
    );

    // Corona dorada brillante
    final crown = Path()
      ..moveTo(w * 0.26, 20)
      ..lineTo(w * 0.30, 4)
      ..lineTo(w * 0.42, 13)
      ..lineTo(w * 0.50, 0)
      ..lineTo(w * 0.58, 13)
      ..lineTo(w * 0.70, 4)
      ..lineTo(w * 0.74, 20)
      ..close();
    canvas.drawPath(crown, Paint()..color = const Color(0xFFFDE047));
    canvas.drawPath(
      crown,
      Paint()
        ..color = const Color(0xFFB45309)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );

    // Ojos grandes caricaturescos + sonrisa traviesa
    canvas.drawCircle(Offset(w * 0.42, 36), 6.2, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.64, 36), 6.2, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.44, 36), 3.2, Paint()..color = const Color(0xFF1E1B4B));
    canvas.drawCircle(Offset(w * 0.66, 36), 3.2, Paint()..color = const Color(0xFF1E1B4B));
    canvas.drawCircle(Offset(w * 0.42, 34), 1.3, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.64, 34), 1.3, Paint()..color = Colors.white);

    // Estrellita dorada en el pecho
    canvas.drawCircle(Offset(w * 0.52, 56), 6.5, Paint()..color = const Color(0xFFFDE047));
  }

  void _drawHpBar(Canvas canvas) {
    final barW = kind == EnemyKind.boss ? 58.0 : 34.0;
    const barH = 6.0;
    final startX = (size.x - barW) / 2;
    const y = -13.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(startX, y, barW, barH), const Radius.circular(4)),
      Paint()..color = Colors.white.withValues(alpha: 0.85),
    );
    final fillW = (barW - 2) * (hp / maxHp).clamp(0.0, 1.0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(startX + 1, y + 1, fillW, barH - 2),
        const Radius.circular(3),
      ),
      Paint()
        ..color = kind == EnemyKind.boss
            ? const Color(0xFFEC4899)
            : const Color(0xFFFB7185),
    );
  }
}
