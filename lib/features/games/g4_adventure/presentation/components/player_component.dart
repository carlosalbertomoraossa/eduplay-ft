import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'particle_component.dart';
import 'platform_component.dart';

/// Protagonista original de EduPlay: "El Guardián de la Esmeralda".
/// Mezcla entre explorador Muisca / El Dorado (sombrero vueltiao estilizado +
/// ruana índigo con ribetes dorados) y espíritu de piedra tallada con corazón
/// de esmeralda brillante y hoja prismática de oro y esmeralda.
class PlayerComponent extends PositionComponent {
  // ── Constantes de física ──
  static const double gravity = 1150;
  static const double maxFallSpeed = 680;
  static const double moveSpeed = 255;
  static const double groundAccel = 2200;
  static const double airAccel = 1600;
  static const double jumpVelocity = -485;
  static const double doubleJumpVelocity = -445;
  static const double pogoVelocity = -480;
  static const double mushroomBounceVelocity = -590;
  static const double dashSpeed = 630;
  static const double dashDuration = 0.15;
  static const double dashCooldownTime = 0.52;
  static const double attackDuration = 0.22;
  static const double attackCooldownTime = 0.28;
  static const double coyoteDuration = 0.12;
  static const double jumpBufferDuration = 0.12;
  static const double invulnDuration = 1.35;

  // ── Estado físico ──
  double vx = 0;
  double vy = 0;
  bool isOnGround = false;
  bool facingRight = true;
  bool hasDoubleJump = true;
  bool hasAirDash = true;

  // Timers
  double _coyoteTimer = 0;
  double _jumpBufferTimer = 0;
  double _dashTimer = 0;
  double _dashCooldown = 0;
  double _attackTimer = 0;
  double _attackCooldown = 0;
  double _invulnTimer = 0;
  double _knockbackTimer = 0;
  double _animTime = 0;
  double _afterimageTimer = 0;

  // Ataque activo
  SlashDirection? activeSlashDir;
  int attackId = 0;

  // Enganche activo con el Látigo (péndulo sostenido hasta presionar Salto)
  Vector2? grappleAnchor;
  double _grappleLength = 92;
  double _targetGrappleLength = 86;
  double _swingAngle = 0;
  double _swingAngularVel = 0;

  // Última posición segura para recuperación tras caer en un foso
  Vector2 lastSafePosition = Vector2(100, 540);

  // Callbacks visuales al mundo
  void Function(Vector2 pos, Color color, int count)? onSpawnParticles;
  void Function(Vector2 pos, SlashDirection dir)? onSpawnSlash;
  void Function(Vector2 pos, bool facingRight)? onSpawnAfterimage;

  PlayerComponent({required Vector2 startPosition})
      : lastSafePosition = startPosition.clone(),
        super(
          position: startPosition.clone(),
          size: Vector2(28, 44),
          anchor: Anchor.bottomCenter,
          priority: 15,
        );

  bool get isDashing => _dashTimer > 0;
  bool get isAttacking => _attackTimer > 0;
  bool get isInvulnerable => _invulnTimer > 0;
  bool get isGrappling => grappleAnchor != null;

  Vector2 get centerPos => Vector2(position.x, position.y - size.y / 2);

  Rect get bodyRect => Rect.fromLTWH(
        position.x - size.x / 2,
        position.y - size.y,
        size.x,
        size.y,
      );

  /// Hitbox amplia del Látigo de Cadena Dorada y Liana Luminosa (alcance medio).
  Rect? get attackHitbox {
    if (!isAttacking || activeSlashDir == null) return null;
    final cx = position.x;
    final cy = position.y - size.y * 0.52;
    switch (activeSlashDir!) {
      case SlashDirection.right:
        return Rect.fromLTWH(cx + 2, cy - 26, 118, 52);
      case SlashDirection.left:
        return Rect.fromLTWH(cx - 120, cy - 26, 118, 52);
      case SlashDirection.down:
        return Rect.fromLTWH(cx - 28, cy + 6, 56, 102);
      case SlashDirection.up:
        return Rect.fromLTWH(cx - 28, cy - 114, 56, 110);
    }
  }

  // ── Acciones del jugador ───────────────────────────────────────────────────

  void requestJump() {
    if (isGrappling) {
      // Soltar del enganche con impulso hacia arriba + inercia del balanceo
      final launchVx = (vx * 1.15).clamp(-340.0, 340.0);
      grappleAnchor = null;
      vx = launchVx;
      vy = -515;
      isOnGround = false;
      hasDoubleJump = true;
      hasAirDash = true;
      _jumpBufferTimer = 0;
      onSpawnParticles?.call(centerPos, const Color(0xFFFDE047), 9);
      _playSfx('games/g4/sfx_jump.mp3');
      return;
    }
    _jumpBufferTimer = jumpBufferDuration;
  }

  /// Altura de salto variable (soltar antes recorta el ascenso, estilo Hollow Knight).
  void releaseJump() {
    if (vy < -180 && !isDashing && !isGrappling) {
      vy *= 0.52;
    }
  }

  void triggerDash() {
    if (isGrappling) {
      grappleAnchor = null;
    }
    if (_dashCooldown > 0 || isDashing) return;
    if (!isOnGround && !hasAirDash) return;

    _dashTimer = dashDuration;
    _dashCooldown = dashCooldownTime;
    if (!isOnGround) hasAirDash = false;
    vx = (facingRight ? 1 : -1) * dashSpeed;
    vy = 0;
    _afterimageTimer = 0;
    onSpawnParticles?.call(centerPos, const Color(0xFF34D399), 6);
  }

  void triggerAttack({bool holdingDown = false, bool holdingUp = false}) {
    if (_attackCooldown > 0 || isGrappling) return;

    SlashDirection dir;
    if (!isOnGround && holdingDown) {
      dir = SlashDirection.down;
    } else if (holdingUp) {
      dir = SlashDirection.up;
    } else {
      dir = facingRight ? SlashDirection.right : SlashDirection.left;
    }

    activeSlashDir = dir;
    _attackTimer = attackDuration;
    _attackCooldown = attackCooldownTime;
    attackId++;

    final slashOffset = switch (dir) {
      SlashDirection.right => Vector2(22, -size.y * 0.52),
      SlashDirection.left => Vector2(-22, -size.y * 0.52),
      SlashDirection.down => Vector2(0, -4),
      SlashDirection.up => Vector2(0, -size.y - 8),
    };
    onSpawnSlash?.call(position + slashOffset, dir);
    _playSfx('games/g4/sfx_block_hit.mp3');
  }

  /// Rebote pogo (golpe hacia abajo sobre enemigo/espinas/hongo) o hongo rebotador.
  void bounce({required double velocity, bool spawnRing = true}) {
    vy = velocity;
    isOnGround = false;
    hasDoubleJump = true;
    hasAirDash = true;
    _dashTimer = 0;
    if (spawnRing) {
      onSpawnParticles?.call(
        Vector2(position.x, position.y - 6),
        const Color(0xFFFDE047),
        8,
      );
    }
    _playSfx('games/g4/sfx_jump.mp3');
  }

  /// Engancha al Guardián en el anillo dorado y lo mantiene colgado/balanceándose
  /// hasta que el jugador presione Salto (o Dash).
  /// Calcula la altura segura sobre el suelo/plataformas cercanas para recoger
  /// la cuerda automáticamente y evitar que los pies frenen el péndulo.
  void startGrapple(
    Vector2 anchorPos, [
    List<CavernPlatformComponent> platforms = const [],
  ]) {
    final c = centerPos;
    final dx = c.x - anchorPos.x;
    final dy = math.max(c.y - anchorPos.y, 24.0);

    grappleAnchor = anchorPos.clone();
    final rawLen = math.sqrt(dx * dx + dy * dy).clamp(52.0, 118.0);
    _grappleLength = rawLen;

    // Calcular distancia libre hasta la plataforma más alta bajo el arco del anillo
    double safeMaxLen = 104.0;
    for (final p in platforms) {
      final pr = p.worldRect;
      final nearHorizontally =
          pr.left < anchorPos.x + 88 && pr.right > anchorPos.x - 88;
      if (nearHorizontally && pr.top > anchorPos.y + 32) {
        final clearance = pr.top - anchorPos.y - size.y / 2 - 14;
        if (clearance < safeMaxLen) {
          safeMaxLen = clearance;
        }
      }
    }
    _targetGrappleLength = math.min(rawLen, safeMaxLen.clamp(42.0, 104.0));
    _swingAngle = math.atan2(dx, dy).clamp(-1.2, 1.2);

    // Transferir la velocidad actual al balanceo del péndulo
    final tangVel =
        vx * math.cos(_swingAngle) - vy * math.sin(_swingAngle);
    _swingAngularVel = (tangVel / _grappleLength).clamp(-4.6, 4.6);
    if (_swingAngularVel.abs() < 1.1) {
      _swingAngularVel = facingRight ? 1.8 : -1.8;
    }

    isOnGround = false;
    hasDoubleJump = true;
    hasAirDash = true;
    _dashTimer = 0;
    _jumpBufferTimer = 0;
    onSpawnParticles?.call(anchorPos, const Color(0xFF34D399), 10);
    _playSfx('games/g4/sfx_jump.mp3');
  }

  void releaseGrapple() {
    grappleAnchor = null;
  }

  void celebrate() {
    onSpawnParticles?.call(centerPos, const Color(0xFFFDE047), 14);
  }

  /// Aplica retroceso e invulnerabilidad al recibir daño. Devuelve true si se aplicó.
  bool applyDamageKnockback(double fromX) {
    if (isInvulnerable) return false;
    grappleAnchor = null;
    _invulnTimer = invulnDuration;
    _knockbackTimer = 0.22;
    _dashTimer = 0;
    final dir = position.x >= fromX ? 1.0 : -1.0;
    vx = dir * 240;
    vy = -290;
    isOnGround = false;
    onSpawnParticles?.call(centerPos, const Color(0xFFFB7185), 10);
    return true;
  }

  void respawnAtSafeSpot() {
    grappleAnchor = null;
    position.setFrom(lastSafePosition);
    vx = 0;
    vy = -120;
    _dashTimer = 0;
    _invulnTimer = invulnDuration;
    hasDoubleJump = true;
    hasAirDash = true;
    onSpawnParticles?.call(centerPos, const Color(0xFF99F6E4), 12);
  }

  // ── Simulación paso a paso con colisión AABB contra plataformas ──────────────

  void stepPhysics({
    required double dt,
    required double moveDir,
    required List<CavernPlatformComponent> platforms,
    required double worldWidth,
  }) {
    _animTime += dt;
    if (_coyoteTimer > 0) _coyoteTimer = (_coyoteTimer - dt).clamp(0.0, 1.0);
    if (_jumpBufferTimer > 0) _jumpBufferTimer = (_jumpBufferTimer - dt).clamp(0.0, 1.0);
    if (_dashCooldown > 0) _dashCooldown = (_dashCooldown - dt).clamp(0.0, 1.0);
    if (_attackCooldown > 0) _attackCooldown = (_attackCooldown - dt).clamp(0.0, 1.0);
    if (_invulnTimer > 0) _invulnTimer = (_invulnTimer - dt).clamp(0.0, 2.0);
    if (_knockbackTimer > 0) _knockbackTimer = (_knockbackTimer - dt).clamp(0.0, 1.0);

    if (_attackTimer > 0) {
      _attackTimer -= dt;
      if (_attackTimer <= 0) {
        _attackTimer = 0;
        activeSlashDir = null;
      }
    }

    // ── Modo colgado / balanceo con el Látigo (hasta oprimir Salto) ──
    if (grappleAnchor != null) {
      final anchor = grappleAnchor!;

      // Recoger suavemente la cuerda hacia la longitud libre de obstáculos
      if (_grappleLength > _targetGrappleLength) {
        _grappleLength =
            math.max(_targetGrappleLength, _grappleLength - 260 * dt);
      }

      // Física de péndulo + impulso lateral del jugador con Izq/Der
      double angularAccel = -(gravity / _grappleLength) * math.sin(_swingAngle);
      angularAccel += moveDir * 9.5;

      _swingAngularVel += angularAccel * dt;
      _swingAngularVel *= math.pow(0.94, dt).toDouble();
      _swingAngularVel = _swingAngularVel.clamp(-5.2, 5.2);

      final prevAngle = _swingAngle;
      _swingAngle += _swingAngularVel * dt;
      if (_swingAngle > 1.28) {
        _swingAngle = 1.28;
        if (_swingAngularVel > 0) _swingAngularVel = -_swingAngularVel * 0.4;
      } else if (_swingAngle < -1.28) {
        _swingAngle = -1.28;
        if (_swingAngularVel < 0) _swingAngularVel = -_swingAngularVel * 0.4;
      }

      if (moveDir.abs() > 0.1) {
        facingRight = moveDir > 0;
      } else if (_swingAngularVel.abs() > 0.2) {
        facingRight = _swingAngularVel > 0;
      }

      double computeX(double angle, double len) =>
          (anchor.x + math.sin(angle) * len)
              .clamp(size.x / 2 + 6, worldWidth - size.x / 2 - 6);
      double computeY(double angle, double len) =>
          anchor.y + math.cos(angle) * len + size.y / 2;

      final prevPos = position.clone();
      position.setValues(
        computeX(_swingAngle, _grappleLength),
        computeY(_swingAngle, _grappleLength),
      );

      // Resolver contacto con plataformas SIN matar el balanceo del péndulo:
      // - Si los pies rozan el suelo/techo de una plataforma: acortar la cuerda
      //   para elevar los pies por encima y conservar el 100% del impulso.
      // - Si golpea una pared lateral: rebotar elásticamente en sentido contrario.
      for (final p in platforms) {
        final pr = p.worldRect;
        final br = bodyRect;
        if (!br.overlaps(pr)) continue;

        final isFloorTouch = br.bottom > pr.top && (br.top + size.y * 0.65) < pr.top + 18;
        if (isFloorTouch) {
          final cosA = math.cos(_swingAngle).clamp(0.35, 1.0);
          final clearanceLen =
              ((pr.top - 4 - size.y / 2 - anchor.y) / cosA).clamp(36.0, _grappleLength);
          _grappleLength = clearanceLen;
          _targetGrappleLength = math.min(_targetGrappleLength, clearanceLen);
          position.setValues(
            computeX(_swingAngle, _grappleLength),
            math.min(computeY(_swingAngle, _grappleLength), pr.top - 2),
          );
        } else {
          // Rebote elástico contra pared lateral para seguir columpíandose
          position.setFrom(prevPos);
          _swingAngle = prevAngle;
          _swingAngularVel = -_swingAngularVel * 0.82;
          if (_swingAngularVel.abs() < 1.4) {
            _swingAngularVel = _swingAngle >= 0 ? -1.6 : 1.6;
          }
          break;
        }
      }

      // Actualizar velocidad tangencial para que el salto al soltar conserve la inercia
      vx = _swingAngularVel * _grappleLength * math.cos(_swingAngle);
      vy = -_swingAngularVel * _grappleLength * math.sin(_swingAngle);
      isOnGround = false;
      return;
    }

    // Orientación según dirección de movimiento
    if (!isDashing && _knockbackTimer <= 0 && moveDir.abs() > 0.1) {
      facingRight = moveDir > 0;
    }

    // 1. Movimiento horizontal / Dash
    if (isDashing) {
      _dashTimer -= dt;
      vy = 0;
      _afterimageTimer -= dt;
      if (_afterimageTimer <= 0) {
        _afterimageTimer = 0.04;
        onSpawnAfterimage?.call(position.clone(), facingRight);
      }
      if (_dashTimer <= 0) {
        vx *= 0.45;
      }
    } else if (_knockbackTimer <= 0) {
      final targetVx = moveDir * moveSpeed;
      final accel = isOnGround ? groundAccel : airAccel;
      if (vx < targetVx) {
        vx = math.min(vx + accel * dt, targetVx);
      } else if (vx > targetVx) {
        vx = math.max(vx - accel * dt, targetVx);
      }
    }

    // 2. Ejecutar salto (buffer + coyote + doble salto)
    if (_jumpBufferTimer > 0 && !isDashing) {
      if (isOnGround || _coyoteTimer > 0) {
        vy = jumpVelocity;
        isOnGround = false;
        _coyoteTimer = 0;
        _jumpBufferTimer = 0;
        onSpawnParticles?.call(position.clone(), const Color(0xFFCBD5E1), 5);
        _playSfx('games/g4/sfx_jump.mp3');
      } else if (hasDoubleJump) {
        vy = doubleJumpVelocity;
        hasDoubleJump = false;
        _jumpBufferTimer = 0;
        onSpawnParticles?.call(
          Vector2(position.x, position.y - 8),
          const Color(0xFF34D399),
          9,
        );
        _playSfx('games/g4/sfx_jump.mp3');
      }
    }

    // 3. Gravedad
    if (!isDashing) {
      vy = math.min(vy + gravity * dt, maxFallSpeed);
    }

    // 4. Desplazamiento horizontal + resolución contra paredes de plataformas
    position.x += vx * dt;
    final halfW = size.x / 2;
    position.x = position.x.clamp(halfW + 6, worldWidth - halfW - 6);

    for (final p in platforms) {
      final pr = p.worldRect;
      final br = bodyRect;
      if (br.overlaps(pr)) {
        // Ignorar contacto tangencial en pies/cabeza
        if (br.bottom <= pr.top + 8 || br.top >= pr.bottom - 8) continue;
        if (vx > 0) {
          position.x = pr.left - halfW;
          vx = 0;
        } else if (vx < 0) {
          position.x = pr.right + halfW;
          vx = 0;
        }
      }
    }

    // 5. Desplazamiento vertical + resolución suelo/techo
    final wasOnGround = isOnGround;
    final prevBottom = position.y;
    final prevTop = position.y - size.y;
    position.y += vy * dt;
    isOnGround = false;

    for (final p in platforms) {
      final pr = p.worldRect;
      final br = bodyRect;
      if (br.overlaps(pr)) {
        if (vy >= 0 && prevBottom <= pr.top + 14) {
          position.y = pr.top;
          vy = 0;
          isOnGround = true;
          hasDoubleJump = true;
          hasAirDash = true;
          if (!wasOnGround) {
            onSpawnParticles?.call(position.clone(), const Color(0xFF94A3B8), 4);
          }
          // Guardar punto seguro si estamos bien centrados sobre la plataforma
          if (position.x > pr.left + 22 && position.x < pr.right - 22) {
            lastSafePosition = Vector2(position.x, pr.top);
          }
        } else if (vy < 0 && prevTop >= pr.bottom - 14) {
          position.y = pr.bottom + size.y;
          vy = 0;
        }
      }
    }

    if (wasOnGround && !isOnGround && vy >= 0) {
      _coyoteTimer = coyoteDuration;
    }
  }

  // ── Renderizado Canvas (Guardián de la Esmeralda: Sombrero Vueltiao + Ruana + Hoja Esmeralda) ─

  @override
  void render(Canvas canvas) {
    // Parpadeo sutil durante invulnerabilidad
    if (isInvulnerable && ((_invulnTimer * 18).floor().isEven)) {
      return;
    }

    final w = size.x; // 28
    final h = size.y; // 44

    // 1. Halo bioluminiscente esmeralda-dorado que irradia del corazón y la hoja
    final pulse = 1.0 + 0.05 * math.sin(_animTime * 9);
    final lightCenter = Offset(w * 0.5, h * 0.48);
    final lightRadius = 158.0 * pulse;
    canvas.drawCircle(
      lightCenter,
      lightRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF34D399).withValues(alpha: 0.25),
            const Color(0xFFFBBF24).withValues(alpha: 0.11),
            Colors.transparent,
          ],
          stops: const [0.0, 0.42, 1.0],
        ).createShader(Rect.fromCircle(center: lightCenter, radius: lightRadius)),
    );

    canvas.save();
    if (!facingRight) {
      canvas.translate(w, 0);
      canvas.scale(-1, 1);
    }

    final isRunning = isOnGround && vx.abs() > 25;
    final bob = isRunning
        ? math.sin(_animTime * 16).abs() * 2.4
        : math.sin(_animTime * 3.2) * 1.4;
    final lean = isDashing ? 0.22 : (isRunning ? 0.09 : 0.0);

    canvas.translate(w / 2, h);
    canvas.rotate(lean);
    canvas.translate(-w / 2, -h);

    // Sombra proyectada en el suelo
    if (isOnGround) {
      canvas.drawOval(
        Rect.fromCenter(center: Offset(w / 2, h - 1), width: 22, height: 5),
        Paint()..color = const Color(0x55000000),
      );
    }

    // Pies de piedra tallada / botitas de explorador
    final footPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    final stride = isRunning ? math.sin(_animTime * 16) * 5.0 : 0.0;
    canvas.drawLine(
      Offset(w * 0.36, h - 10),
      Offset(w * 0.34 + stride, h - 1.5),
      footPaint,
    );
    canvas.drawLine(
      Offset(w * 0.64, h - 10),
      Offset(w * 0.66 - stride, h - 1.5),
      footPaint,
    );

    // ── Ruana Muisca índigo oscuro con ondeo y ribetes dorados (El Dorado) ──
    final sway = (isRunning || !isOnGround)
        ? math.sin(_animTime * 17) * 3.2
        : math.sin(_animTime * 3) * 1.0;

    final ruanaPath = Path()
      ..moveTo(w * 0.22, 20 - bob)
      ..lineTo(w * 0.78, 20 - bob)
      ..lineTo(w + 1, h - 9)
      ..lineTo(w * 0.56, h - 5)
      ..lineTo(-2 - sway, h - 8)
      ..close();
    canvas.drawPath(ruanaPath, Paint()..color = const Color(0xFF172554));

    // Ribete dorado inferior estilo orfebrería Muisca
    final goldBorder = Path()
      ..moveTo(-1 - sway, h - 10.5)
      ..lineTo(w * 0.56, h - 7.5)
      ..lineTo(w, h - 11.5);
    canvas.drawPath(
      goldBorder,
      Paint()
        ..color = const Color(0xFFFBBF24)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round,
    );

    // Borde sutil de la ruana
    canvas.drawPath(
      ruanaPath,
      Paint()
        ..color = const Color(0xFF60A5FA).withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // ── Corazón de Esmeralda Colombiana incrustado en el pecho ──
    final gemCx = w * 0.54;
    final gemCy = 27.5 - bob;
    final gemGlow = 0.40 + 0.20 * math.sin(_animTime * 6);
    canvas.drawCircle(
      Offset(gemCx, gemCy),
      8.5,
      Paint()..color = const Color(0xFF10B981).withValues(alpha: gemGlow),
    );
    final emeraldHex = Path()
      ..moveTo(gemCx, gemCy - 5.2)
      ..lineTo(gemCx + 4.2, gemCy - 2.2)
      ..lineTo(gemCx + 4.2, gemCy + 2.2)
      ..lineTo(gemCx, gemCy + 5.2)
      ..lineTo(gemCx - 4.2, gemCy + 2.2)
      ..lineTo(gemCx - 4.2, gemCy - 2.2)
      ..close();
    canvas.drawPath(emeraldHex, Paint()..color = const Color(0xFF10B981));
    canvas.drawPath(
      emeraldHex,
      Paint()
        ..color = const Color(0xFFA7F3D0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
    );
    // Destello interior del cristal
    canvas.drawCircle(
      Offset(gemCx - 1.0, gemCy - 1.4),
      1.3,
      Paint()..color = Colors.white.withValues(alpha: 0.9),
    );

    // ── Cabeza: Espíritu de Piedra Tallada Oscura con Ojos Esmeralda ──
    final headCx = w * 0.50;
    final headCy = 15.0 - bob;
    final headRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(headCx, headCy), width: 17, height: 14),
      const Radius.circular(6),
    );
    canvas.drawRRect(headRRect, Paint()..color = const Color(0xFF1E293B));
    canvas.drawRRect(
      headRRect,
      Paint()
        ..color = const Color(0xFF475569)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // Ojos luminosos verde-esmeralda (expresivos y cálidos)
    final eyeGlow = Paint()..color = const Color(0xFF34D399).withValues(alpha: 0.45);
    final eyeCore = Paint()..color = const Color(0xFFA7F3D0);
    canvas.drawCircle(Offset(headCx + 1.8, headCy + 0.5), 3.6, eyeGlow);
    canvas.drawCircle(Offset(headCx + 6.4, headCy + 0.5), 3.2, eyeGlow);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(headCx + 1.8, headCy + 0.5), width: 3.4, height: 4.6),
      eyeCore,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(headCx + 6.4, headCy + 0.5), width: 2.8, height: 4.2),
      eyeCore,
    );

    // ── Sombrero Vueltiao Estilizado (Silueta icónica colombiana!) ──
    final hatY = 10.5 - bob;
    // Ala ancha ligeramente curvada
    final brimRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(headCx, hatY), width: 36, height: 5.5),
      const Radius.circular(3),
    );
    canvas.drawRRect(brimRect, Paint()..color = const Color(0xFFF5E6C8));
    // Franjas negras tejidas características del sombrero vueltiao en el ala
    final weaveDark = Paint()..color = const Color(0xFF111827);
    canvas.drawRect(Rect.fromLTWH(headCx - 14, hatY - 2.5, 4.5, 5), weaveDark);
    canvas.drawRect(Rect.fromLTWH(headCx - 4, hatY - 2.5, 4.5, 5), weaveDark);
    canvas.drawRect(Rect.fromLTWH(headCx + 6, hatY - 2.5, 4.5, 5), weaveDark);
    canvas.drawRRect(
      brimRect,
      Paint()
        ..color = const Color(0xFFD97706)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
    );

    // Copa cónica del sombrero vueltiao
    final crownPath = Path()
      ..moveTo(headCx - 10, hatY - 1.5)
      ..lineTo(headCx - 5.5, hatY - 10.5)
      ..quadraticBezierTo(headCx, hatY - 12.2, headCx + 5.5, hatY - 10.5)
      ..lineTo(headCx + 10, hatY - 1.5)
      ..close();
    canvas.drawPath(crownPath, Paint()..color = const Color(0xFFF5E6C8));

    // Banda trenzada oscura + pequeño broche dorado-esmeralda en la copa
    canvas.drawRect(
      Rect.fromLTWH(headCx - 8.5, hatY - 5.2, 17, 3.4),
      weaveDark,
    );
    // Patrón romboidal dorado en la cinta
    final diamondBelt = Path()
      ..moveTo(headCx + 2.5, hatY - 5.4)
      ..lineTo(headCx + 5.2, hatY - 3.5)
      ..lineTo(headCx + 2.5, hatY - 1.6)
      ..lineTo(headCx - 0.2, hatY - 3.5)
      ..close();
    canvas.drawPath(diamondBelt, Paint()..color = const Color(0xFF10B981));
    canvas.drawPath(
      diamondBelt,
      Paint()
        ..color = const Color(0xFFFBBF24)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    canvas.drawPath(
      crownPath,
      Paint()
        ..color = const Color(0xFF111827).withValues(alpha: 0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
    );

    // ── Arma: Empuñadura del Látigo de Cadena Dorada y Liana Esmeralda ──
    final hiltAngle = isAttacking ? 0.35 : -0.18 + math.sin(_animTime * 4) * 0.06;
    canvas.save();
    canvas.translate(w * 0.78, 27 - bob);
    canvas.rotate(hiltAngle);

    // Empuñadura Muisca dorada
    canvas.drawLine(
      const Offset(-3, 2),
      const Offset(8, -2),
      Paint()
        ..color = const Color(0xFFF59E0B)
        ..strokeWidth = 3.2
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      const Offset(8.5, -2.2),
      2.6,
      Paint()..color = const Color(0xFF10B981),
    );

    // Cuando no está extendido el látigo ni enganchado, muestra el rollo de cadena dorada + liana brillante
    if (!isAttacking && !isGrappling) {
      final coilWave = math.sin(_animTime * 7) * 1.6;
      final coilPath = Path()
        ..moveTo(8.5, -1.5)
        ..quadraticBezierTo(15, 2 + coilWave, 11, 8)
        ..quadraticBezierTo(6, 11 - coilWave, 13, 12);
      canvas.drawPath(
        coilPath,
        Paint()
          ..color = const Color(0xFF34D399)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawCircle(
        const Offset(12.5, 4.5),
        2.3,
        Paint()
          ..color = const Color(0xFFFBBF24)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
      canvas.drawCircle(
        const Offset(13.2, 12),
        2.2,
        Paint()..color = const Color(0xFFA7F3D0),
      );
    }

    canvas.restore();
    canvas.restore();
  }

  /// Los archivos SFX en assets/audio/games/g4/ son placeholders de 0 bytes;
  /// activar cuando se incluyan audios reales para evitar MediaError en Web.
  static bool sfxEnabled = false;

  static void _playSfx(String path) {
    if (!sfxEnabled) return;
    try {
      FlameAudio.play(path).then<void>((_) {}, onError: (_) {});
    } catch (_) {}
  }
}
