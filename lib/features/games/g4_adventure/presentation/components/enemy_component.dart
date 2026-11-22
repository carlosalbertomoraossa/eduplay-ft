import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../data/level_map_data.dart';

/// Criaturas de sombra estilo Hollow Knight / Well Dweller:
/// - [EnemyKind.crawler]: Escarabajo Sombra terrestre (2 HP)
/// - [EnemyKind.floater]: Polilla del Pozo voladora (2 HP)
/// - [EnemyKind.sentinel]: Centinela Cornudo con saltos (4 HP)
/// - [EnemyKind.boss]: Reina Sombra del nivel 8 (6 HP)
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
    final shellColor = flash ? Colors.white : const Color(0xFF1E1B2E);
    final rimColor = flash ? Colors.white : const Color(0xFF818CF8);

    // Patitas rápidas
    final legPaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    final legWave = math.sin(_time * 16) * 3;
    for (var i = 0; i < 3; i++) {
      final lx = 8.0 + i * 10;
      canvas.drawLine(Offset(lx, h - 7), Offset(lx - 2 + (i.isEven ? legWave : -legWave), h), legPaint);
    }

    // Caparazón abombado estilo Hollow Knight
    final shell = Path()
      ..moveTo(3, h - 6)
      ..quadraticBezierTo(w * 0.5, -4, w - 3, h - 6)
      ..close();
    canvas.drawPath(shell, Paint()..color = shellColor);
    canvas.drawPath(
      shell,
      Paint()
        ..color = rimColor.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Ojos brillantes naranja/carmesí
    final eyeColor = flash ? Colors.amber : const Color(0xFFFB7185);
    canvas.drawCircle(Offset(w * 0.72, h * 0.56), 3.0, Paint()..color = eyeColor);
    canvas.drawCircle(Offset(w * 0.85, h * 0.58), 2.3, Paint()..color = eyeColor);
  }

  void _drawFloater(Canvas canvas, bool flash) {
    final w = size.x;
    final h = size.y;
    final wingFlap = math.sin(_time * 14) * 7;

    // Halo oscuro-violeta
    canvas.drawCircle(
      Offset(w / 2, h / 2),
      20,
      Paint()..color = accentColor.withValues(alpha: 0.18),
    );

    // Alas translúcidas de polilla
    final wingPaint = Paint()
      ..color = flash ? Colors.white : accentColor.withValues(alpha: 0.55);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.28, h * 0.35 + wingFlap * 0.4), width: 18, height: 11),
      wingPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.72, h * 0.35 - wingFlap * 0.4), width: 18, height: 11),
      wingPaint,
    );

    // Cuerpo oscuro
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w / 2, h * 0.55), width: 18, height: 22),
      Paint()..color = flash ? Colors.white : const Color(0xFF17132B),
    );

    // Ojos luminosos
    final eyeP = Paint()..color = const Color(0xFFFDE047);
    canvas.drawCircle(Offset(w * 0.58, h * 0.48), 2.5, eyeP);
    canvas.drawCircle(Offset(w * 0.44, h * 0.48), 2.5, eyeP);
  }

  void _drawSentinel(Canvas canvas, bool flash) {
    final w = size.x;
    final h = size.y;
    final bodyColor = flash ? Colors.white : const Color(0xFF181428);

    // Capa oscura rasgada
    final cloak = Path()
      ..moveTo(w * 0.5, 16)
      ..lineTo(4, h)
      ..lineTo(w * 0.3, h - 6)
      ..lineTo(w * 0.5, h)
      ..lineTo(w * 0.72, h - 6)
      ..lineTo(w - 4, h)
      ..close();
    canvas.drawPath(cloak, Paint()..color = bodyColor);
    canvas.drawPath(
      cloak,
      Paint()
        ..color = const Color(0xFFA855F7).withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8,
    );

    // Máscara pálida con cuernos
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.52, 16), width: 22, height: 20),
      Paint()..color = flash ? Colors.white : const Color(0xFFE2E8F0),
    );
    final hornPaint = Paint()
      ..color = flash ? Colors.white : const Color(0xFFE2E8F0)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.38, 8), Offset(w * 0.25, -2), hornPaint);
    canvas.drawLine(Offset(w * 0.66, 8), Offset(w * 0.78, -2), hornPaint);

    // Ojos vacíos brillantes
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.62, 16), width: 5, height: 7),
      Paint()..color = const Color(0xFFF43F5E),
    );
  }

  void _drawBoss(Canvas canvas, bool flash) {
    final w = size.x;
    final h = size.y;

    // Aura real de sombra y oro
    canvas.drawCircle(
      Offset(w / 2, h * 0.48),
      52 + math.sin(_time * 4) * 5,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFF472B6).withValues(alpha: 0.30),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: Offset(w / 2, h * 0.48), radius: 56)),
    );

    // Manto real flotante
    final cloak = Path()
      ..moveTo(w * 0.5, 22)
      ..lineTo(2, h)
      ..lineTo(w * 0.25, h - 9)
      ..lineTo(w * 0.5, h)
      ..lineTo(w * 0.75, h - 9)
      ..lineTo(w - 2, h)
      ..close();
    canvas.drawPath(cloak, Paint()..color = flash ? Colors.white : const Color(0xFF230B2E));
    canvas.drawPath(
      cloak,
      Paint()
        ..color = const Color(0xFFF472B6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2,
    );

    // Máscara de la Reina Sombra
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, 22), width: 30, height: 28),
      Paint()..color = flash ? Colors.white : const Color(0xFFF8FAFC),
    );

    // Corona de espinas dorada
    final crown = Path()
      ..moveTo(w * 0.26, 12)
      ..lineTo(w * 0.32, -4)
      ..lineTo(w * 0.44, 7)
      ..lineTo(w * 0.50, -8)
      ..lineTo(w * 0.56, 7)
      ..lineTo(w * 0.68, -4)
      ..lineTo(w * 0.74, 12)
      ..close();
    canvas.drawPath(crown, Paint()..color = const Color(0xFFFDE047));

    // Ojos carmesí luminosos
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.60, 22), width: 6, height: 8),
      Paint()..color = const Color(0xFFE11D48),
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.42, 22), width: 5, height: 7),
      Paint()..color = const Color(0xFFE11D48),
    );
  }

  void _drawHpBar(Canvas canvas) {
    final barW = kind == EnemyKind.boss ? 56.0 : 32.0;
    const barH = 5.0;
    final startX = (size.x - barW) / 2;
    const y = -12.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(startX, y, barW, barH), const Radius.circular(3)),
      Paint()..color = Colors.black.withValues(alpha: 0.65),
    );
    final fillW = barW * (hp / maxHp).clamp(0.0, 1.0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(startX, y, fillW, barH), const Radius.circular(3)),
      Paint()
        ..color = kind == EnemyKind.boss
            ? const Color(0xFFF472B6)
            : const Color(0xFFFB7185),
    );
  }
}
