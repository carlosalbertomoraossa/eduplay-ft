// Spec: specs/games/g4-adventure-plan.md Fase 4 §4.1

import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'presentation/bloc/game_bloc.dart';
import 'presentation/bloc/game_event.dart';
import 'presentation/bloc/game_state.dart';
import 'presentation/components/background_component.dart';
import 'presentation/components/flag_component.dart';
import 'presentation/components/player_component.dart';
import 'presentation/components/value_block_component.dart';

/// FlameGame principal de La Aventura del Cuarto Grado.
///
/// El jugador avanza automáticamente hacia la derecha (auto-camina).
/// El bloque V viene desde la derecha deslizándose.
/// El jugador debe SALTAR (tap) para golpear el bloque con la cabeza.
/// Si no salta, el bloque pasa de largo y regresa. Solo el contacto físico activa la pregunta.
class G4AdventureGame extends FlameGame
    with HasCollisionDetection, TapCallbacks, KeyboardEvents {
  static const String overlayHud = 'hud';
  static const String overlayQuestion = 'question';
  static const String overlayGameOver = 'game_over';
  static const String overlayLevelComplete = 'level_complete';
  static const String overlayGameComplete = 'game_complete';

  static const double _blockSpeed = 110.0;

  final GameBloc gameBloc;

  late BackgroundComponent _background;
  late PlayerComponent _player;
  late ValueBlockComponent _valueBlock;
  late FlagComponent _flag;

  StreamSubscription<GameState>? _stateSub;

  bool _blockCanHit = true;
  bool _paused = false;

  G4AdventureGame({required this.gameBloc});

  double get _playerStartX => size.x * 0.10;
  double get _blockStartX => size.x + 80;

  @override
  Future<void> onLoad() async {
    _background = BackgroundComponent();
    await add(_background);

    final gY = _background.groundY;

    // Jugador: empieza en el 10% izquierdo
    _player = PlayerComponent(groundY: gY);
    _player.position = Vector2(_playerStartX, gY);
    await add(_player);

    // Bloque V: alto (170 px sobre el suelo), empieza fuera de pantalla a la derecha
    _valueBlock = ValueBlockComponent(
      position: Vector2(_blockStartX, gY - 170),
      onHit: () {},
    );
    await add(_valueBlock);

    // Bandera de meta: siempre visible en el extremo derecho
    _flag = FlagComponent(position: Vector2(size.x - 30, gY));
    await add(_flag);

    overlays.add(overlayHud);

    _stateSub = gameBloc.stream.listen(_onStateChange);
    _onStateChange(gameBloc.state);
  }

  // ── Game loop ────────────────────────────────────────────────────────────────

  @override
  void update(double dt) {
    super.update(dt);
    if (_paused) return;

    // Bloque se desplaza hacia el jugador desde la derecha
    _valueBlock.position.x -= _blockSpeed * dt;

    // Si el bloque ya pasó sin activarse, reposicionarlo (no debería pasar,
    // pero es un safety reset)
    if (_valueBlock.position.x < _player.position.x - 100) {
      _respawnBlock();
    }

    // El jugador se restringe a ≤ 80% de pantalla (para que la bandera siempre sea visible)
    if (_player.position.x > size.x * 0.80) {
      _player.position.x = size.x * 0.80;
    }

    _checkBlockHit();
  }

  void _respawnBlock() {
    _valueBlock.position.x = _blockStartX;
    _valueBlock.reset();
    _blockCanHit = true;
  }

  void _checkBlockHit() {
    if (!_blockCanHit) return;
    // El bloque solo activa si el jugador está saltando (no parado en el suelo)
    if (_player.isOnGround) return;

    final playerCenterX = _player.position.x + _player.size.x / 2;
    final blockCenterX = _valueBlock.position.x;
    final dx = (playerCenterX - blockCenterX).abs();
    if (dx >= 45) return;

    // La cabeza del jugador debe llegar cerca del fondo del bloque.
    // Margen 20 = zona de golpe generosa (buen feel para niños).
    final playerTopY = _player.position.y - _player.size.y;
    final blockBottomY = _valueBlock.position.y + _valueBlock.size.y / 2;
    if (playerTopY <= blockBottomY + 20) {
      _blockCanHit = false;
      _paused = true;
      _background.scrolling = false;
      _player.stopMoving();
      _valueBlock.triggerBump();
      gameBloc.add(ValueBlockHit());
      // Respaldo: si el stream no lo muestra, lo mostramos en el próximo event loop
      Future.delayed(Duration.zero, _ensureQuestionOverlay);
    }
  }

  void _ensureQuestionOverlay() {
    final s = gameBloc.state;
    if (s is GameInProgress && s.waitingForAnswer) {
      if (!overlays.isActive(overlayQuestion)) {
        overlays.add(overlayQuestion);
      }
    }
  }

  // ── Reacción al GameBloc ─────────────────────────────────────────────────────

  void _onStateChange(GameState state) {
    if (state is GameInProgress) {
      if (state.waitingForAnswer) {
        // Ya estamos en pausa desde _checkBlockHit; solo mostrar overlay
        if (!overlays.isActive(overlayQuestion)) {
          overlays.add(overlayQuestion);
        }
      } else {
        _onAnswerProcessed(state.lastAnswerCorrect);
      }
    } else if (state is LevelComplete) {
      _paused = true;
      _background.scrolling = false;
      _player.stopMoving();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      overlays.add(overlayLevelComplete);
    } else if (state is GameOver) {
      _paused = true;
      _background.scrolling = false;
      _player.stopMoving();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      overlays.add(overlayGameOver);
    } else if (state is GameComplete) {
      _paused = true;
      _background.scrolling = false;
      _player.stopMoving();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      overlays.add(overlayGameComplete);
    } else if (state is GameInitial) {
      _resetWorld();
    }
  }

  void _onAnswerProcessed(bool? wasCorrect) {
    if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
    _respawnBlock();
    _paused = false;
    _background.scrolling = true;
    _player.startMoving(); // reanudar auto-caminar
    if (wasCorrect == true) _player.celebrate();
  }

  void _resetWorld() {
    _paused = false;
    _background.scrolling = true;
    _player.position.x = _playerStartX;
    _player.startMoving(); // el jugador avanza automáticamente
    _respawnBlock();
  }

  // ── Input táctil ─────────────────────────────────────────────────────────────
  // Tap = saltar para golpear el bloque con la cabeza (como Mario Bros)

  @override
  void onTapDown(TapDownEvent event) {
    if (_paused) return;
    _player.jump();
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent && !_paused) {
      if (keysPressed.contains(LogicalKeyboardKey.space) ||
          keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        _player.jump();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  void onRemove() {
    _stateSub?.cancel();
    super.onRemove();
  }
}
