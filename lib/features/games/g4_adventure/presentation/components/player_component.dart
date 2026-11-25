import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../../../../core/providers/lumi_customization_provider.dart';
import '../../data/game_audio_service.dart';
import 'particle_component.dart';
import 'platform_component.dart';

/// Protagonista jugable de EduPlay: **Lumi el Leoncito Explorador**.
/// Versión aventurera de la mascota oficial de EduPlay dibujada en Canvas:
/// melena esponjosa, orejitas redondas, colita con pompón animada, pañoleta
/// esmeralda ondeante y látigo de cadena dorada y liana luminosa.
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
  double _celebrateTimer = 0;

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

  // Personalización equipada desde el Armario de Lumi
  LumiOutfit outfit;

  // Callbacks visuales al mundo
  void Function(Vector2 pos, Color color, int count)? onSpawnParticles;
  void Function(Vector2 pos, SlashDirection dir)? onSpawnSlash;
  void Function(Vector2 pos, bool facingRight)? onSpawnAfterimage;

  PlayerComponent({
    required Vector2 startPosition,
    this.outfit = const LumiOutfit(),
  })  : lastSafePosition = startPosition.clone(),
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
      GameAudioService.playJump();
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
    GameAudioService.playWhip();
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
    GameAudioService.playBounce();
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
    GameAudioService.playJump();
  }

  void releaseGrapple() {
    grappleAnchor = null;
  }

  void celebrate() {
    _celebrateTimer = 1.3;
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
    if (_celebrateTimer > 0) _celebrateTimer = (_celebrateTimer - dt).clamp(0.0, 2.0);

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
        GameAudioService.playJump();
      } else if (hasDoubleJump) {
        vy = doubleJumpVelocity;
        hasDoubleJump = false;
        _jumpBufferTimer = 0;
        onSpawnParticles?.call(
          Vector2(position.x, position.y - 8),
          const Color(0xFF34D399),
          9,
        );
        GameAudioService.playJump();
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

  // ── Renderizado Canvas (Lumi el Leoncito Explorador: Melena + Orejitas + Pañoleta) ─

  @override
  void render(Canvas canvas) {
    // Parpadeo sutil durante invulnerabilidad
    if (isInvulnerable && ((_invulnTimer * 18).floor().isEven)) {
      return;
    }

    final w = size.x; // 28
    final h = size.y; // 44

    // Paleta oficial cálida de Lumi el Leoncito
    const maneDark = Color(0xFFB45309); // Castaño miel oscuro
    const maneMid = Color(0xFFD97706); // Ámbar cálido
    const furGold = Color(0xFFFBBF24); // Dorado leoncito
    const furShadow = Color(0xFFF59E0B); // Dorado intenso
    const creamFur = Color(0xFFFEF3C7); // Cremita hocico y pancita
    const innerEarPink = Color(0xFFFDBA74); // Durazno orejas / almohadillas
    const noseColor = Color(0xFF9A3412); // Naricita terracota
    const lineBrown = Color(0xFF78350F); // Líneas faciales
    final scarfEmerald = outfit.scarfPrimaryColor;
    final scarfDark = outfit.scarfSecondaryColor;
    final trailColor = outfit.trailPrimaryColor;

    // 1. Suave aura soleada alrededor de Lumi para que destaque en cualquier cielo
    final pulse = 1.0 + 0.06 * math.sin(_animTime * 7);
    final lightCenter = Offset(w * 0.5, h * 0.46);
    final lightRadius = 46.0 * pulse;
    canvas.drawCircle(
      lightCenter,
      lightRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFEF08A).withValues(alpha: 0.28),
            const Color(0xFFFBBF24).withValues(alpha: 0.10),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: lightCenter, radius: lightRadius)),
    );

    canvas.save();
    if (!facingRight) {
      canvas.translate(w, 0);
      canvas.scale(-1, 1);
    }

    final isRunning = isOnGround && vx.abs() > 25;
    final isJumping = !isOnGround && vy < -40;
    final isFalling = !isOnGround && vy > 80;
    final isCelebrating = _celebrateTimer > 0;
    final bob = isRunning
        ? math.sin(_animTime * 16).abs() * 2.4
        : math.sin(_animTime * 3.4) * 1.3;
    final lean = isDashing
        ? 0.24
        : (isRunning ? 0.10 : (isGrappling ? -0.10 : 0.0));

    // Ligero squash & stretch al saltar/caer para darle vida
    final scaleX = isDashing
        ? 1.12
        : (isJumping ? 0.92 : (isFalling ? 0.96 : 1.0));
    final scaleY = isDashing
        ? 0.90
        : (isJumping ? 1.08 : (isFalling ? 1.04 : 1.0));

    canvas.translate(w / 2, h);
    canvas.rotate(lean);
    canvas.scale(scaleX, scaleY);
    canvas.translate(-w / 2, -h);

    // 2. Sombra proyectada en el suelo
    if (isOnGround) {
      canvas.drawOval(
        Rect.fromCenter(center: Offset(w / 2, h - 1), width: 22, height: 5),
        Paint()..color = const Color(0x55000000),
      );
    }

    // 3. Colita de leoncito con pompón animado (detrás del cuerpo)
    final tailWag = isRunning || !isOnGround
        ? math.sin(_animTime * 15) * 4.5
        : math.sin(_animTime * 4.2) * 2.5;
    final tailTip = Offset(-6.5, 25.5 - bob + tailWag);
    final tailPath = Path()
      ..moveTo(w * 0.28, h - 11 - bob * 0.4)
      ..quadraticBezierTo(-5.0, h - 10 + tailWag * 0.6, tailTip.dx, tailTip.dy);
    canvas.drawPath(
      tailPath,
      Paint()
        ..color = furShadow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.2
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(tailTip, 3.8, Paint()..color = maneDark);
    canvas.drawCircle(
      tailTip + const Offset(0.7, -0.7),
      2.5,
      Paint()..color = maneMid,
    );

    // 4. Patitas traseras / piernas animadas de Lumi
    final stride = isRunning
        ? math.sin(_animTime * 16) * 5.2
        : (isJumping ? 2.5 : (isFalling ? -2.0 : 0.0));
    final backFootX = w * 0.36 + stride;
    final frontFootX = w * 0.64 - stride;
    final footLiftBack = isRunning ? math.max(0.0, -math.cos(_animTime * 16)) * 2.4 : (isJumping ? 2.0 : 0.0);
    final footLiftFront = isRunning ? math.max(0.0, math.cos(_animTime * 16)) * 2.4 : (isJumping ? 1.0 : 0.0);

    final legPaint = Paint()
      ..color = furShadow
      ..strokeWidth = 4.6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.38, h - 11 - bob * 0.3),
      Offset(backFootX, h - 2.6 - footLiftBack),
      legPaint,
    );
    canvas.drawLine(
      Offset(w * 0.62, h - 11 - bob * 0.3),
      Offset(frontFootX, h - 2.6 - footLiftFront),
      legPaint..color = furGold,
    );
    // Patitas redondas doradas con deditos cremita
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(backFootX + 1.0, h - 2.2 - footLiftBack),
        width: 7.2,
        height: 4.4,
      ),
      Paint()..color = furShadow,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(frontFootX + 1.2, h - 2.2 - footLiftFront),
        width: 7.6,
        height: 4.6,
      ),
      Paint()..color = furGold,
    );

    // 5. Cuerpecito de leoncito + pancita cremita
    final bodyRect = Rect.fromCenter(
      center: Offset(w * 0.50, 30.5 - bob),
      width: 17.5,
      height: 15.5,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(8)),
      Paint()..color = furShadow,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(8)),
      Paint()
        ..color = maneDark.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    // Pancita cremita orientada hacia adelante
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.56, 31.2 - bob),
        width: 10.5,
        height: 10.8,
      ),
      Paint()..color = creamFur,
    );

    // 6. Pañoleta de explorador esmeralda con punta ondeando al viento
    final scarfSway = (isRunning || !isOnGround || isDashing)
        ? math.sin(_animTime * 18) * 3.0
        : math.sin(_animTime * 3.5) * 1.1;
    // Cola flotante de la pañoleta atrás
    final scarfTail = Path()
      ..moveTo(w * 0.24, 24.0 - bob)
      ..quadraticBezierTo(
        -2.5,
        24.5 - bob + scarfSway * 0.5,
        -6.0 - (isDashing ? 4.0 : 0.0),
        27.5 - bob + scarfSway,
      )
      ..lineTo(-2.5, 30.0 - bob + scarfSway * 0.7)
      ..lineTo(w * 0.28, 26.8 - bob)
      ..close();
    canvas.drawPath(scarfTail, Paint()..color = scarfDark);

    // Pañoleta frontal (soporta bandera tricolor Colombia)
    final scarfFront = Path()
      ..moveTo(w * 0.20, 23.2 - bob)
      ..quadraticBezierTo(w * 0.52, 26.8 - bob, w * 0.80, 23.2 - bob)
      ..lineTo(w * 0.62, 29.2 - bob)
      ..lineTo(w * 0.44, 29.2 - bob)
      ..close();
    if (outfit.isTricolorScarf) {
      canvas.save();
      canvas.clipPath(scarfFront);
      canvas.drawRect(Rect.fromLTWH(w * 0.18, 22.8 - bob, w * 0.66, 2.8), Paint()..color = const Color(0xFFFACC15));
      canvas.drawRect(Rect.fromLTWH(w * 0.18, 25.6 - bob, w * 0.66, 1.8), Paint()..color = const Color(0xFF1D4ED8));
      canvas.drawRect(Rect.fromLTWH(w * 0.18, 27.4 - bob, w * 0.66, 2.2), Paint()..color = const Color(0xFFEF4444));
      canvas.restore();
    } else {
      canvas.drawPath(scarfFront, Paint()..color = scarfEmerald);
    }
    canvas.drawCircle(
      Offset(w * 0.56, 26.2 - bob),
      2.1,
      Paint()..color = const Color(0xFFFDE047),
    );

    // 7. Orejitas redondas de león (bien visibles arriba de la melena)
    final headCenter = Offset(w * 0.52, 15.0 - bob);
    final leftEar = headCenter + const Offset(-8.2, -9.2);
    final rightEar = headCenter + const Offset(7.6, -9.2);
    for (final ear in [leftEar, rightEar]) {
      canvas.drawCircle(ear, 5.0, Paint()..color = furShadow);
      canvas.drawCircle(
        ear,
        5.0,
        Paint()
          ..color = maneDark.withValues(alpha: 0.55)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
      canvas.drawCircle(ear, 2.8, Paint()..color = innerEarPink);
    }

    // 8. Melena esponjosa de Lumi (corona de pétalos redondeados en dos tonos ámbar)
    const petalCount = 12;
    const maneRadius = 10.6;
    for (var i = 0; i < petalCount; i++) {
      final angle = (i * 2 * math.pi) / petalCount;
      final px = headCenter.dx + math.cos(angle) * maneRadius;
      final py = headCenter.dy + math.sin(angle) * maneRadius;
      canvas.drawCircle(
        Offset(px, py),
        4.6,
        Paint()..color = i.isEven ? maneDark : maneMid,
      );
    }
    canvas.drawCircle(headCenter, 11.0, Paint()..color = maneDark);
    canvas.drawCircle(headCenter, 9.8, Paint()..color = maneMid);

    // 9. Carita dorada de Lumi (perfil 3/4 mirando hacia adelante)
    final faceCenter = headCenter + const Offset(1.3, 0.3);
    canvas.drawCircle(faceCenter, 8.2, Paint()..color = furGold);

    // Mechoncito tierno en la frente
    final tuft = Path()
      ..moveTo(faceCenter.dx - 2.2, faceCenter.dy - 7.0)
      ..quadraticBezierTo(
        faceCenter.dx + 0.5,
        faceCenter.dy - 10.4,
        faceCenter.dx + 2.6,
        faceCenter.dy - 6.8,
      )
      ..close();
    canvas.drawPath(tuft, Paint()..color = maneMid);

    // Mejilla sonrojada
    canvas.drawOval(
      Rect.fromCenter(
        center: faceCenter + const Offset(-3.2, 2.4),
        width: 3.4,
        height: 2.0,
      ),
      Paint()..color = const Color(0xFFFB7185).withValues(alpha: 0.5),
    );

    // Ojos grandes y expresivos (con parpadeo natural y reacción al celebrar)
    final isBlinking = !isAttacking &&
        !isDashing &&
        !isCelebrating &&
        (_animTime % 3.6) > 3.47;
    final eyeLeft = faceCenter + const Offset(-1.2, -1.2);
    final eyeRight = faceCenter + const Offset(4.2, -1.2);

    if (isCelebrating) {
      // Ojitos felices en arco (^ ^) al resolver un tótem
      final happyEyePaint = Paint()
        ..color = const Color(0xFF1E1B18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round;
      for (final eye in [eyeLeft, eyeRight]) {
        canvas.drawArc(
          Rect.fromCenter(center: eye, width: 4.0, height: 3.6),
          math.pi + 0.2,
          math.pi - 0.4,
          false,
          happyEyePaint,
        );
      }
    } else if (isBlinking) {
      final blinkPaint = Paint()
        ..color = lineBrown
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        eyeLeft + const Offset(-2.0, 0),
        eyeLeft + const Offset(2.0, 0),
        blinkPaint,
      );
      canvas.drawLine(
        eyeRight + const Offset(-1.7, 0),
        eyeRight + const Offset(1.7, 0),
        blinkPaint,
      );
    } else {
      // Sclera blanca + pupila oscura + brillito
      canvas.drawOval(
        Rect.fromCenter(center: eyeLeft, width: 4.8, height: 5.2),
        Paint()..color = Colors.white,
      );
      canvas.drawOval(
        Rect.fromCenter(center: eyeRight, width: 4.2, height: 5.0),
        Paint()..color = Colors.white,
      );
      final pupilShiftY = isJumping ? -0.5 : (isFalling ? 0.5 : 0.0);
      canvas.drawCircle(
        eyeLeft + Offset(0.7, pupilShiftY),
        1.8,
        Paint()..color = const Color(0xFF1E1B18),
      );
      canvas.drawCircle(
        eyeRight + Offset(0.6, pupilShiftY),
        1.6,
        Paint()..color = const Color(0xFF1E1B18),
      );
      canvas.drawCircle(
        eyeLeft + const Offset(-0.2, -1.0),
        0.75,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        eyeRight + const Offset(-0.1, -1.0),
        0.7,
        Paint()..color = Colors.white,
      );

      // Cejas determinadas al atacar o hacer dash
      if (isAttacking || isDashing) {
        final browPaint = Paint()
          ..color = maneDark
          ..strokeWidth = 1.3
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          eyeLeft + const Offset(-2.0, -3.2),
          eyeLeft + const Offset(1.8, -2.1),
          browPaint,
        );
        canvas.drawLine(
          eyeRight + const Offset(-1.5, -2.1),
          eyeRight + const Offset(1.8, -3.2),
          browPaint,
        );
      }
    }

    // Hocico cremita + naricita terracota + sonrisa tierna
    final muzzleCenter = faceCenter + const Offset(2.5, 2.4);
    canvas.drawCircle(
      muzzleCenter + const Offset(-1.8, 0),
      2.6,
      Paint()..color = creamFur,
    );
    canvas.drawCircle(
      muzzleCenter + const Offset(1.8, 0),
      2.6,
      Paint()..color = creamFur,
    );
    // Naricita triangular de león
    final nose = Path()
      ..moveTo(muzzleCenter.dx - 2.0, muzzleCenter.dy - 1.6)
      ..lineTo(muzzleCenter.dx + 2.0, muzzleCenter.dy - 1.6)
      ..lineTo(muzzleCenter.dx, muzzleCenter.dy + 0.6)
      ..close();
    canvas.drawPath(nose, Paint()..color = noseColor);

    // Boquita abierta alegre al saltar, atacar o celebrar; sonrisa suave en reposo
    if (isCelebrating || isJumping || isAttacking) {
      canvas.drawArc(
        Rect.fromCenter(
          center: muzzleCenter + const Offset(0, 1.4),
          width: 4.2,
          height: 3.4,
        ),
        0,
        math.pi,
        true,
        Paint()..color = const Color(0xFFFB7185),
      );
    }
    final mouthPaint = Paint()
      ..color = lineBrown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(
        center: muzzleCenter + const Offset(-1.3, 1.0),
        width: 2.8,
        height: 2.2,
      ),
      0.15,
      math.pi - 0.3,
      false,
      mouthPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: muzzleCenter + const Offset(1.3, 1.0),
        width: 2.8,
        height: 2.2,
      ),
      0.15,
      math.pi - 0.3,
      false,
      mouthPaint,
    );

    // Bigoticos sutiles
    final whiskerPaint = Paint()
      ..color = lineBrown.withValues(alpha: 0.6)
      ..strokeWidth = 0.85
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      muzzleCenter + const Offset(-4.0, -0.3),
      muzzleCenter + const Offset(-7.2, -1.0),
      whiskerPaint,
    );
    canvas.drawLine(
      muzzleCenter + const Offset(-4.0, 1.1),
      muzzleCenter + const Offset(-7.0, 1.8),
      whiskerPaint,
    );

    // 9b. Accesorio opcional equipado desde el Armario de Lumi
    _drawEquippedAccessory(canvas, headCenter, faceCenter);

    // 10. Patita delantera sosteniendo el Látigo de Cadena Dorada y Liana Esmeralda
    final hiltAngle = isAttacking ? 0.35 : -0.18 + math.sin(_animTime * 4) * 0.06;
    canvas.save();
    canvas.translate(w * 0.76, 29.5 - bob);
    canvas.rotate(hiltAngle);

    // Empuñadura dorada
    canvas.drawLine(
      const Offset(-2, 1.5),
      const Offset(8, -2),
      Paint()
        ..color = const Color(0xFFF59E0B)
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      const Offset(8.5, -2.2),
      2.4,
      Paint()..color = scarfEmerald,
    );

    // Patita dorada de Lumi sujetando la empuñadura
    canvas.drawCircle(const Offset(1.0, 0.5), 3.4, Paint()..color = furGold);
    canvas.drawCircle(
      const Offset(1.0, 0.5),
      3.4,
      Paint()
        ..color = maneMid.withValues(alpha: 0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9,
    );

    // Rollo de cadena dorada + liana luminosa cuando no está atacando ni colgado
    if (!isAttacking && !isGrappling) {
      final coilWave = math.sin(_animTime * 7) * 1.6;
      final coilPath = Path()
        ..moveTo(8.5, -1.5)
        ..quadraticBezierTo(15, 2 + coilWave, 11, 8)
        ..quadraticBezierTo(6, 11 - coilWave, 13, 12);
      canvas.drawPath(
        coilPath,
        Paint()
          ..color = trailColor
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
        Paint()..color = Colors.white.withValues(alpha: 0.9),
      );
    }

    canvas.restore();
    canvas.restore();
  }

  void _drawEquippedAccessory(
    Canvas canvas,
    Offset headCenter,
    Offset faceCenter,
  ) {
    switch (outfit.accessory) {
      case LumiAccessoryId.none:
        return;
      case LumiAccessoryId.explorerGoggles:
        final gy = faceCenter.dy - 6.8;
        canvas.drawLine(
          Offset(headCenter.dx - 7.5, gy),
          Offset(headCenter.dx + 8.5, gy),
          Paint()
            ..color = const Color(0xFF0F172A)
            ..strokeWidth = 2.0,
        );
        for (final gx in [faceCenter.dx - 1.5, faceCenter.dx + 4.5]) {
          canvas.drawCircle(Offset(gx, gy), 3.0, Paint()..color = const Color(0xFF38BDF8));
          canvas.drawCircle(
            Offset(gx, gy),
            3.0,
            Paint()
              ..color = const Color(0xFF1E293B)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.1,
          );
        }
      case LumiAccessoryId.goldenStar:
        final sc = headCenter + const Offset(6.5, -10.0);
        final star = Path();
        for (var i = 0; i < 10; i++) {
          final r = i.isEven ? 4.4 : 2.0;
          final a = -math.pi / 2 + (i * math.pi) / 5;
          final pt = sc + Offset(math.cos(a) * r, math.sin(a) * r);
          if (i == 0) {
            star.moveTo(pt.dx, pt.dy);
          } else {
            star.lineTo(pt.dx, pt.dy);
          }
        }
        star.close();
        canvas.drawPath(star, Paint()..color = const Color(0xFFFACC15));
        canvas.drawPath(
          star,
          Paint()
            ..color = const Color(0xFFB45309)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.9,
        );
      case LumiAccessoryId.gamerHeadset:
        canvas.drawArc(
          Rect.fromCenter(center: headCenter + const Offset(0, -1), width: 23, height: 23),
          math.pi + 0.3,
          math.pi - 0.6,
          false,
          Paint()
            ..color = const Color(0xFFEC4899)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.2
            ..strokeCap = StrokeCap.round,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: headCenter + const Offset(-10.5, -1), width: 4, height: 8),
            const Radius.circular(2),
          ),
          Paint()..color = const Color(0xFF8B5CF6),
        );
      case LumiAccessoryId.royalCrown:
        final crown = Path()
          ..moveTo(headCenter.dx - 5.5, headCenter.dy - 11.5)
          ..lineTo(headCenter.dx - 4.2, headCenter.dy - 17.5)
          ..lineTo(headCenter.dx - 1.2, headCenter.dy - 14.0)
          ..lineTo(headCenter.dx + 0.5, headCenter.dy - 18.8)
          ..lineTo(headCenter.dx + 2.2, headCenter.dy - 14.0)
          ..lineTo(headCenter.dx + 5.0, headCenter.dy - 17.5)
          ..lineTo(headCenter.dx + 6.2, headCenter.dy - 11.5)
          ..close();
        canvas.drawPath(crown, Paint()..color = const Color(0xFFFACC15));
        canvas.drawPath(
          crown,
          Paint()
            ..color = const Color(0xFFB45309)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0,
        );
    }
  }
}
