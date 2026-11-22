import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/level_map_data.dart';
import 'presentation/bloc/game_bloc.dart';
import 'presentation/bloc/game_event.dart';
import 'presentation/bloc/game_state.dart';
import 'presentation/components/cavern_background_component.dart';
import 'presentation/components/enemy_component.dart';
import 'presentation/components/particle_component.dart';
import 'presentation/components/platform_component.dart';
import 'presentation/components/player_component.dart';
import 'presentation/components/portal_component.dart';
import 'presentation/components/totem_component.dart';

/// FlameGame estilo Hollow Knight / Well Dweller para La Aventura del Cuarto Grado.
///
/// - Mundo 2D explorable con plataformas, espinas, hongos rebotadores y cámara suave.
/// - Protagonista encapuchado con fósforo-aguja luminoso: correr, doble salto,
///   salto variable, dash, ataque cuerpo a cuerpo y rebote pogo hacia abajo.
/// - Enemigos de sombra derrotables + 9 Tótems de Luz sellados + 1 Portal Final
///   integrados con las 10 preguntas matemáticas del currículo por nivel.
class G4AdventureGame extends FlameGame with KeyboardEvents {
  static const String overlayHud = 'hud';
  static const String overlayControls = 'controls';
  static const String overlayQuestion = 'question';
  static const String overlayGameOver = 'game_over';
  static const String overlayLevelComplete = 'level_complete';
  static const String overlayGameComplete = 'game_complete';

  final GameBloc gameBloc;
  final int initialLevel;

  // Notificadores ligeros para el HUD (bioma, dirección al próximo sello, hint)
  final ValueNotifier<String> biomeNameNotifier = ValueNotifier<String>('');
  final ValueNotifier<int> targetDirectionNotifier = ValueNotifier<int>(1);
  final ValueNotifier<int> sealsClearedNotifier = ValueNotifier<int>(0);
  final ValueNotifier<String?> toastMessageNotifier = ValueNotifier<String?>(null);

  StreamSubscription<GameState>? _stateSub;

  late LevelMapData _mapData;
  late CavernBackgroundComponent _background;
  PlayerComponent? _player;
  PortalComponent? _portal;

  final List<CavernPlatformComponent> _platforms = [];
  final List<SpikeHazardComponent> _spikes = [];
  final List<BounceMushroomComponent> _mushrooms = [];
  final List<HookRingComponent> _hookRings = [];
  final List<EnemyComponent> _enemies = [];
  final List<TotemComponent> _totems = [];
  final List<HeartPickupComponent> _hearts = [];

  TotemComponent? _activeTotem;
  bool _portalTrialActive = false;

  // Seguimiento de impactos por golpe (attackId -> conjunto de hashes golpeados)
  int _lastProcessedAttackId = -1;
  final Set<int> _hitTargetsThisSwing = {};

  // Estado de ejecución / micro-juice
  bool _paused = false;
  int _loadedLevel = 0;
  double _hitStopTimer = 0;
  double _shakeTimer = 0;
  double _shakeIntensity = 0;
  double _toastTimer = 0;
  Vector2 _camPos = Vector2(320, 380);
  final math.Random _rng = math.Random();

  // Estado combinado de entrada (teclado + táctil)
  bool _keyLeft = false;
  bool _keyRight = false;
  bool _keyDown = false;
  bool _keyUp = false;
  bool _touchLeft = false;
  bool _touchRight = false;
  bool _touchDown = false;

  G4AdventureGame({
    required this.gameBloc,
    this.initialLevel = 1,
  });

  // ── API para controles táctiles (ControlsOverlay) ──────────────────────────

  void setTouchLeft(bool pressed) => _touchLeft = pressed;
  void setTouchRight(bool pressed) => _touchRight = pressed;
  void setTouchDown(bool pressed) => _touchDown = pressed;

  void pressJump() {
    if (_paused) return;
    _player?.requestJump();
  }

  void releaseJump() {
    _player?.releaseJump();
  }

  void pressAttack() {
    if (_paused) return;
    _player?.triggerAttack(
      holdingDown: _keyDown || _touchDown,
      holdingUp: _keyUp,
    );
  }

  void pressDash() {
    if (_paused) return;
    _player?.triggerDash();
  }

  void clearInputs() {
    _keyLeft = false;
    _keyRight = false;
    _keyDown = false;
    _keyUp = false;
    _touchLeft = false;
    _touchRight = false;
    _touchDown = false;
  }

  // ── Ciclo de vida Flame ────────────────────────────────────────────────────

  @override
  Future<void> onLoad() async {
    _mapData = LevelMapData.forLevel(initialLevel);

    _background = CavernBackgroundComponent(
      theme: _mapData.biome,
      getCameraPosition: () => _camPos,
      getViewportSize: () => size,
    );
    camera.backdrop.add(_background);
    camera.viewport.add(_CavernVignetteComponent(getViewportSize: () => size));
    camera.viewfinder.anchor = Anchor.center;

    _updateZoom();
    await _loadLevel(initialLevel);

    overlays.add(overlayHud);
    overlays.add(overlayControls);

    _stateSub = gameBloc.stream.listen(_onStateChange);
    _onStateChange(gameBloc.state);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _updateZoom();
  }

  void _updateZoom() {
    if (size.x <= 0 || size.y <= 0) return;
    final zoomY = size.y / 590.0;
    final zoomX = size.x / 460.0;
    camera.viewfinder.zoom = math.min(zoomY, zoomX).clamp(0.68, 1.22);
  }

  Future<void> _loadLevel(int level) async {
    // Limpiar mundo anterior
    world.removeAll(world.children.toList());
    _platforms.clear();
    _spikes.clear();
    _mushrooms.clear();
    _hookRings.clear();
    _enemies.clear();
    _totems.clear();
    _hearts.clear();
    _activeTotem = null;
    _portalTrialActive = false;
    _lastProcessedAttackId = -1;
    _hitTargetsThisSwing.clear();
    clearInputs();

    _loadedLevel = level;
    _mapData = LevelMapData.forLevel(level);
    _background.updateTheme(_mapData.biome);
    biomeNameNotifier.value = _mapData.biome.name;
    sealsClearedNotifier.value = 0;

    // 1. Plataformas
    for (final p in _mapData.platforms) {
      final comp = CavernPlatformComponent(
        position: Vector2(p.x, p.y),
        size: Vector2(p.width, p.height),
        theme: _mapData.biome,
        hasCrystalAccent: p.hasCrystalAccent,
      );
      _platforms.add(comp);
      await world.add(comp);
    }

    // 2. Espinas
    for (final s in _mapData.spikes) {
      final comp = SpikeHazardComponent(
        x: s.x,
        surfaceY: s.y,
        width: s.width,
        theme: _mapData.biome,
      );
      _spikes.add(comp);
      await world.add(comp);
    }

    // 3. Hongos rebotadores
    for (final m in _mapData.mushrooms) {
      final comp = BounceMushroomComponent(
        x: m.x,
        baseY: m.y,
        theme: _mapData.biome,
      );
      _mushrooms.add(comp);
      await world.add(comp);
    }

    // 3b. Anillos dorados de enganche (para el Látigo de Cadena Dorada)
    for (final r in _mapData.hookRings) {
      final comp = HookRingComponent(
        x: r.x,
        y: r.y,
        theme: _mapData.biome,
      );
      _hookRings.add(comp);
      await world.add(comp);
    }

    // 4. Tótems de Luz (9 por nivel)
    for (final t in _mapData.totems) {
      final comp = TotemComponent(
        totemIndex: t.index,
        x: t.x,
        baseY: t.y,
        theme: _mapData.biome,
      );
      _totems.add(comp);
      await world.add(comp);
    }

    // 5. Portal Antiguo (10° Sello)
    _portal = PortalComponent(
      x: _mapData.portalX,
      baseY: _mapData.portalY,
      theme: _mapData.biome,
    );
    await world.add(_portal!);

    // 6. Enemigos de sombra
    for (final e in _mapData.enemies) {
      final comp = EnemyComponent(
        kind: e.kind,
        x: e.x,
        y: e.y,
        patrolMinX: e.patrolMinX,
        patrolMaxX: e.patrolMaxX,
        accentColor: _mapData.biome.accentGlow,
      );
      _enemies.add(comp);
      await world.add(comp);
    }

    // 7. Corazones luminosos escondidos
    for (final h in _mapData.hearts) {
      final comp = HeartPickupComponent(position: Vector2(h.x, h.y));
      _hearts.add(comp);
      await world.add(comp);
    }

    // 8. Protagonista
    final player = PlayerComponent(
      startPosition: Vector2(_mapData.spawnX, _mapData.spawnY),
    )
      ..onSpawnParticles = _spawnParticles
      ..onSpawnSlash = _spawnSlash
      ..onSpawnAfterimage = _spawnAfterimage;
    _player = player;
    await world.add(player);

    // Centrar cámara de inmediato
    _camPos = Vector2(_mapData.spawnX + 120, _mapData.spawnY - 60);
    _applyCameraPosition(1.0);
    _showToast('Nivel $level · ${_mapData.biome.name}');
  }

  // ── Game loop principal ────────────────────────────────────────────────────

  @override
  void update(double dt) {
    final safeDt = dt.clamp(0.0, 0.05);
    super.update(safeDt);

    if (_toastTimer > 0) {
      _toastTimer -= safeDt;
      if (_toastTimer <= 0) toastMessageNotifier.value = null;
    }

    if (_paused || _player == null) return;

    // Breve hit-stop en golpes de combate
    if (_hitStopTimer > 0) {
      _hitStopTimer -= safeDt;
      return;
    }

    final player = _player!;

    // 1. Física del jugador
    double moveDir = 0;
    if (_keyLeft || _touchLeft) moveDir -= 1;
    if (_keyRight || _touchRight) moveDir += 1;

    player.stepPhysics(
      dt: safeDt,
      moveDir: moveDir,
      platforms: _platforms,
      worldWidth: _mapData.worldWidth,
    );

    // 2. Recuperación si cae en un abismo
    if (player.position.y > _mapData.worldHeight + 90) {
      player.respawnAtSafeSpot();
      _triggerShake(0.18, 5);
      gameBloc.add(PlayerDamaged());
    }

    // 3. Actualizar IA de enemigos
    for (final enemy in _enemies) {
      if (!enemy.isDead) {
        enemy.updateAi(safeDt, player.position);
      }
    }

    // 4. Procesar combate, pogo, hongos, espinas, tótems, corazones y portal
    _handleAttackCollisions(player);
    _handleWorldInteractions(player);
    _updateTargetCompass(player);

    // 5. Cámara suave con look-ahead y shake
    _updateCamera(safeDt, player);
  }

  void _handleAttackCollisions(PlayerComponent player) {
    final slashRect = player.attackHitbox;
    if (slashRect == null) return;

    if (player.attackId != _lastProcessedAttackId) {
      _lastProcessedAttackId = player.attackId;
      _hitTargetsThisSwing.clear();
    }

    final isPogoSlash = player.activeSlashDir == SlashDirection.down;

    // 1. Golpear enemigos de sombra
    for (final enemy in _enemies) {
      if (enemy.isDead) continue;
      final id = identityHashCode(enemy);
      if (_hitTargetsThisSwing.contains(id)) continue;
      if (!slashRect.overlaps(enemy.hitRect)) continue;

      _hitTargetsThisSwing.add(id);
      final knockDir = enemy.position.x >= player.position.x ? 1.0 : -1.0;
      final died = enemy.takeHit(1, knockDir);
      _hitStopTimer = 0.032;
      _triggerShake(0.12, died ? 5.5 : 3.0);
      _spawnParticles(enemy.centerPos, const Color(0xFFFDE68A), died ? 14 : 7);

      if (isPogoSlash) {
        player.bounce(velocity: PlayerComponent.pogoVelocity);
      }

      if (died) {
        _spawnParticles(enemy.centerPos, const Color(0xFFA855F7), 12);
        // Enemigos grandes o chance de soltar un corazón si faltan vidas
        if (enemy.kind == EnemyKind.sentinel || enemy.kind == EnemyKind.boss) {
          final heart = HeartPickupComponent(position: enemy.centerPos);
          _hearts.add(heart);
          world.add(heart);
        }
        enemy.removeFromParent();
        gameBloc.add(EnemyDefeated(bonusPoints: enemy.scoreReward));
      }
    }

    // 2. Pogo sobre espinas (mecánica icónica de Hollow Knight!)
    if (isPogoSlash) {
      for (final spike in _spikes) {
        final id = identityHashCode(spike);
        if (_hitTargetsThisSwing.contains(id)) continue;
        if (slashRect.overlaps(spike.pogoRect)) {
          _hitTargetsThisSwing.add(id);
          player.bounce(velocity: PlayerComponent.pogoVelocity);
          _spawnParticles(
            Vector2(player.position.x, spike.position.y),
            Colors.white,
            8,
          );
          break;
        }
      }
    }

    // 3. Enganche sostenido con el Látigo sobre Anillos Dorados Muiscas
    // El Guardián queda colgado y balanceándose hasta que vuelva a oprimir Salto
    if (!player.isGrappling) {
      for (final ring in _hookRings) {
        final id = identityHashCode(ring);
        if (_hitTargetsThisSwing.contains(id)) continue;
        if (slashRect.overlaps(ring.hookRect)) {
          _hitTargetsThisSwing.add(id);
          ring.triggerHook();
          player.startGrapple(ring.position, _platforms);
          final anchor = ring.position.clone();
          world.add(GrappleTetherComponent(
            getOrigin: () => _player?.centerPos ?? anchor,
            anchorPos: anchor,
            isActive: () =>
                _player != null &&
                _player!.isGrappling &&
                _player!.grappleAnchor == anchor,
          ));
          _triggerShake(0.08, 2.2);
          _spawnParticles(ring.position, const Color(0xFFFDE047), 10);
          break;
        }
      }
    }

    // 3b. Látigo / Pogo sobre hongos rebotadores
    for (final mushroom in _mushrooms) {
      final id = identityHashCode(mushroom);
      if (_hitTargetsThisSwing.contains(id)) continue;
      if (slashRect.overlaps(mushroom.bounceRect)) {
        _hitTargetsThisSwing.add(id);
        mushroom.triggerBounce();
        final topPos = Vector2(mushroom.position.x, mushroom.position.y - 24);
        player.bounce(velocity: PlayerComponent.mushroomBounceVelocity);
        _spawnParticles(topPos, _mapData.biome.accentGlow, 8);
      }
    }

    // 4. Golpear un Tótem de Luz sellado -> abre pregunta matemática!
    for (final totem in _totems) {
      if (!totem.isSealed) continue;
      final id = identityHashCode(totem);
      if (_hitTargetsThisSwing.contains(id)) continue;
      if (slashRect.overlaps(totem.hitRect)) {
        _hitTargetsThisSwing.add(id);
        _activateTotem(totem);
        return;
      }
    }

    // 5. Golpear el Portal desbloqueado -> 10° reto final!
    final portal = _portal;
    if (portal != null && !portal.activated && slashRect.overlaps(portal.interactRect)) {
      if (portal.isUnlocked) {
        _activatePortalTrial(portal);
      } else {
        _showToast('Purifica ${portal.remainingSeals} sellos más para abrir el portal');
      }
    }
  }

  void _handleWorldInteractions(PlayerComponent player) {
    final pRect = player.bodyRect;

    // 1. Rebote al caer sobre hongos bioluminiscentes
    if (player.vy > 0) {
      for (final m in _mushrooms) {
        if (pRect.overlaps(m.bounceRect) && player.position.y <= m.position.y - 6) {
          m.triggerBounce();
          player.bounce(velocity: PlayerComponent.mushroomBounceVelocity);
          _spawnParticles(
            Vector2(m.position.x, m.position.y - 24),
            _mapData.biome.accentGlow,
            10,
          );
          break;
        }
      }
    }

    // 2. Daño por espinas
    if (!player.isInvulnerable) {
      for (final s in _spikes) {
        if (pRect.overlaps(s.damageRect)) {
          if (player.applyDamageKnockback(s.position.x + s.size.x / 2)) {
            _triggerShake(0.2, 6);
            gameBloc.add(PlayerDamaged());
          }
          break;
        }
      }
    }

    // 3. Daño por contacto con enemigos vivos
    if (!player.isInvulnerable) {
      for (final enemy in _enemies) {
        if (enemy.isDead) continue;
        if (pRect.overlaps(enemy.hitRect)) {
          if (player.applyDamageKnockback(enemy.position.x)) {
            _triggerShake(0.2, 6);
            gameBloc.add(PlayerDamaged());
          }
          break;
        }
      }
    }

    // 4. Recoger corazones luminosos
    for (final heart in _hearts) {
      if (heart.collected) continue;
      if (pRect.overlaps(heart.pickupRect)) {
        heart.collected = true;
        heart.removeFromParent();
        _spawnParticles(heart.position, const Color(0xFFFB7185), 12);
        gameBloc.add(HeartCollected());
        _showToast('¡+1 Vida recuperada!');
      }
    }

    // 5. Proximidad a Tótems y Anillos de Enganche
    for (final totem in _totems) {
      if (!totem.isSealed) {
        totem.playerNearby = false;
        continue;
      }
      final dist = (totem.position - player.position).length;
      totem.playerNearby = dist < 110;
    }
    for (final ring in _hookRings) {
      ring.isHooked =
          player.isGrappling && player.grappleAnchor == ring.position;
      ring.isInRange = !ring.isHooked &&
          (ring.position - player.centerPos).length < 150;
    }

    // 6. Entrar al Portal desbloqueado también activa la prueba final
    final portal = _portal;
    if (portal != null &&
        portal.isUnlocked &&
        !portal.activated &&
        pRect.overlaps(portal.interactRect)) {
      _activatePortalTrial(portal);
    }
  }

  void _activateTotem(TotemComponent totem) {
    _activeTotem = totem;
    _portalTrialActive = false;
    totem.triggerShake();
    _paused = true;
    clearInputs();
    _triggerShake(0.14, 4);
    _spawnParticles(
      Vector2(totem.position.x, totem.position.y - 36),
      _mapData.biome.accentGlow,
      14,
    );
    gameBloc.add(ValueBlockHit());
  }

  void _activatePortalTrial(PortalComponent portal) {
    portal.activated = true;
    _activeTotem = null;
    _portalTrialActive = true;
    _paused = true;
    clearInputs();
    _triggerShake(0.18, 5);
    _spawnParticles(
      Vector2(portal.position.x, portal.position.y - 54),
      const Color(0xFFFDE047),
      18,
    );
    gameBloc.add(ValueBlockHit());
  }

  void _updateTargetCompass(PlayerComponent player) {
    double? targetX;
    double bestDist = double.infinity;

    for (final t in _totems) {
      if (!t.isSealed) continue;
      final d = (t.position.x - player.position.x).abs();
      if (d < bestDist) {
        bestDist = d;
        targetX = t.position.x;
      }
    }

    // Si todos los tótems están resueltos, apuntar al Portal
    if (targetX == null && _portal != null) {
      targetX = _portal!.position.x;
    }

    if (targetX == null) {
      targetDirectionNotifier.value = 0;
    } else if ((targetX - player.position.x).abs() < 110) {
      targetDirectionNotifier.value = 0;
    } else {
      targetDirectionNotifier.value = targetX > player.position.x ? 1 : -1;
    }
  }

  void _updateCamera(double dt, PlayerComponent player) {
    final lookAheadX = player.facingRight ? 65.0 : -65.0;
    final desiredX = player.position.x + lookAheadX;
    final desiredY = player.position.y - 75.0;

    final t = 1.0 - math.exp(-7.5 * dt);
    _camPos.x += (desiredX - _camPos.x) * t;
    _camPos.y += (desiredY - _camPos.y) * t;

    _applyCameraPosition(dt);
  }

  void _applyCameraPosition(double dt) {
    final zoom = camera.viewfinder.zoom;
    final halfW = (size.x / 2) / zoom;
    final halfH = (size.y / 2) / zoom;

    if (_mapData.worldWidth > halfW * 2) {
      _camPos.x = _camPos.x.clamp(halfW, _mapData.worldWidth - halfW);
    } else {
      _camPos.x = _mapData.worldWidth / 2;
    }

    if (_mapData.worldHeight > halfH * 2) {
      _camPos.y = _camPos.y.clamp(halfH, _mapData.worldHeight - halfH);
    } else {
      _camPos.y = _mapData.worldHeight / 2;
    }

    double sx = 0;
    double sy = 0;
    if (_shakeTimer > 0) {
      _shakeTimer = (_shakeTimer - dt).clamp(0.0, 1.0);
      sx = (_rng.nextDouble() * 2 - 1) * _shakeIntensity;
      sy = (_rng.nextDouble() * 2 - 1) * _shakeIntensity;
    }

    camera.viewfinder.position = Vector2(_camPos.x + sx, _camPos.y + sy);
  }

  // ── Efectos visuales (partículas, slash, afterimages, shake) ───────────────

  void _triggerShake(double duration, double intensity) {
    _shakeTimer = math.max(_shakeTimer, duration);
    _shakeIntensity = math.max(_shakeIntensity, intensity);
  }

  void _showToast(String msg) {
    toastMessageNotifier.value = msg;
    _toastTimer = 2.6;
  }

  void _spawnParticles(Vector2 pos, Color color, int count) {
    for (var i = 0; i < count; i++) {
      final angle = _rng.nextDouble() * math.pi * 2;
      final speed = 45 + _rng.nextDouble() * 145;
      world.add(SparkParticle(
        position: pos.clone(),
        velocity: Vector2(math.cos(angle) * speed, math.sin(angle) * speed - 40),
        color: color,
        lifetime: 0.28 + _rng.nextDouble() * 0.26,
        gravity: 220,
        initialRadius: 2.5 + _rng.nextDouble() * 2.5,
      ));
    }
  }

  void _spawnSlash(Vector2 pos, SlashDirection dir) {
    world.add(WhipLashComponent(
      getOrigin: () => _player?.centerPos ?? pos,
      direction: dir,
    ));
  }

  void _spawnAfterimage(Vector2 pos, bool facingRight) {
    world.add(DashAfterimageComponent(
      position: pos,
      facingRight: facingRight,
    ));
  }

  // ── Reacción al GameBloc ───────────────────────────────────────────────────

  void _onStateChange(GameState state) {
    if (state is GameInProgress) {
      if (state.currentLevel != _loadedLevel) {
        _loadLevel(state.currentLevel);
      }

      if (state.waitingForAnswer) {
        _paused = true;
        if (overlays.isActive(overlayControls)) overlays.remove(overlayControls);
        if (!overlays.isActive(overlayQuestion)) overlays.add(overlayQuestion);
      } else {
        _onQuestionClosed(state);
      }
    } else if (state is LevelComplete) {
      _paused = true;
      clearInputs();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      if (overlays.isActive(overlayControls)) overlays.remove(overlayControls);
      overlays.add(overlayLevelComplete);
    } else if (state is GameOver) {
      _paused = true;
      clearInputs();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      if (overlays.isActive(overlayControls)) overlays.remove(overlayControls);
      overlays.add(overlayGameOver);
    } else if (state is GameComplete) {
      _paused = true;
      clearInputs();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      if (overlays.isActive(overlayControls)) overlays.remove(overlayControls);
      overlays.add(overlayGameComplete);
    } else if (state is GameInitial) {
      _paused = false;
      _loadedLevel = 0; // fuerza recarga limpia del nuevo nivel o reinicio
      if (!overlays.isActive(overlayControls)) overlays.add(overlayControls);
    }
  }

  void _onQuestionClosed(GameInProgress state) {
    if (overlays.isActive(overlayQuestion)) {
      overlays.remove(overlayQuestion);
    }
    if (!overlays.isActive(overlayControls)) {
      overlays.add(overlayControls);
    }

    if (_activeTotem != null && state.lastAnswerCorrect != null) {
      final totem = _activeTotem!;
      _activeTotem = null;
      final ok = state.lastAnswerCorrect == true;
      totem.resolve(correct: ok);
      _spawnParticles(
        Vector2(totem.position.x, totem.position.y - 38),
        ok ? const Color(0xFFFDE047) : const Color(0xFFFB7185),
        16,
      );
      if (ok) {
        _player?.celebrate();
      }
    }

    if (_portalTrialActive && state.lastAnswerCorrect != null) {
      _portalTrialActive = false;
    }

    final remaining = _totems.where((t) => t.isSealed).length;
    _portal?.remainingSeals = remaining;
    sealsClearedNotifier.value = state.questionsAnswered;

    if (remaining == 0 && state.questionsAnswered == 9) {
      _showToast('¡Todos los sellos rotos! Cruza el Portal al final');
    }

    _paused = false;
  }

  // ── Input de teclado (Web / Desktop) ───────────────────────────────────────

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final key = event.logicalKey;

    if (event is KeyDownEvent) {
      if (key == LogicalKeyboardKey.arrowLeft || key == LogicalKeyboardKey.keyA) {
        _keyLeft = true;
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.arrowRight || key == LogicalKeyboardKey.keyD) {
        _keyRight = true;
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.arrowDown || key == LogicalKeyboardKey.keyS) {
        _keyDown = true;
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.arrowUp ||
          key == LogicalKeyboardKey.keyW ||
          key == LogicalKeyboardKey.space) {
        if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.keyW) {
          _keyUp = true;
        }
        pressJump();
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.keyJ ||
          key == LogicalKeyboardKey.keyZ ||
          key == LogicalKeyboardKey.keyX) {
        pressAttack();
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.keyK ||
          key == LogicalKeyboardKey.keyC ||
          key == LogicalKeyboardKey.shiftLeft ||
          key == LogicalKeyboardKey.shiftRight) {
        pressDash();
        return KeyEventResult.handled;
      }
    } else if (event is KeyUpEvent) {
      if (key == LogicalKeyboardKey.arrowLeft || key == LogicalKeyboardKey.keyA) {
        _keyLeft = false;
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.arrowRight || key == LogicalKeyboardKey.keyD) {
        _keyRight = false;
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.arrowDown || key == LogicalKeyboardKey.keyS) {
        _keyDown = false;
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.arrowUp ||
          key == LogicalKeyboardKey.keyW ||
          key == LogicalKeyboardKey.space) {
        if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.keyW) {
          _keyUp = false;
        }
        releaseJump();
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }

  @override
  void onRemove() {
    _stateSub?.cancel();
    biomeNameNotifier.dispose();
    targetDirectionNotifier.dispose();
    sealsClearedNotifier.dispose();
    toastMessageNotifier.dispose();
    super.onRemove();
  }
}

/// Viñeta oscura sutil en los bordes de la pantalla para reforzar la atmósfera
/// subterránea de caverna iluminada por el fósforo.
class _CavernVignetteComponent extends Component {
  final Vector2 Function() getViewportSize;

  _CavernVignetteComponent({required this.getViewportSize}) : super(priority: 50);

  @override
  void render(Canvas canvas) {
    final view = getViewportSize();
    if (view.x <= 0 || view.y <= 0) return;

    final rect = Rect.fromLTWH(0, 0, view.x, view.y);
    final radius = math.max(view.x, view.y) * 0.72;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            Colors.transparent,
            const Color(0xFF030712).withValues(alpha: 0.42),
          ],
          stops: const [0.55, 1.0],
        ).createShader(Rect.fromCircle(
          center: Offset(view.x / 2, view.y / 2),
          radius: radius,
        )),
    );
  }
}
