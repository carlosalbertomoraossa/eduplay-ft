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
import 'presentation/components/player_component.dart';
import 'presentation/components/value_block_component.dart';

/// FlameGame principal de La Aventura del Cuarto Grado.
///
/// Las preguntas se muestran en un overlay Flutter ([overlayQuestion])
/// para garantizar confiabilidad y usabilidad en niños.
class G4AdventureGame extends FlameGame
    with HasCollisionDetection, TapCallbacks, KeyboardEvents {
  static const String overlayHud = 'hud';
  static const String overlayQuestion = 'question';
  static const String overlayGameOver = 'game_over';
  static const String overlayLevelComplete = 'level_complete';
  static const String overlayGameComplete = 'game_complete';

  final GameBloc gameBloc;

  late BackgroundComponent _background;
  late PlayerComponent _player;
  late ValueBlockComponent _valueBlock;

  StreamSubscription<GameState>? _stateSub;
  bool _blockCanHit = true;

  G4AdventureGame({required this.gameBloc});

  @override
  Future<void> onLoad() async {
    _background = BackgroundComponent();
    await add(_background);

    final gY = _background.groundY;

    _player = PlayerComponent(groundY: gY);
    await add(_player);

    // Bloque V centrado horizontalmente, a 100px sobre el suelo
    _valueBlock = ValueBlockComponent(
      position: Vector2(size.x * 0.60, gY - 100),
      onHit: () {}, // el hit lo gestiona _checkBlockHit directamente
    );
    await add(_valueBlock);

    overlays.add(overlayHud);

    // Escuchar stream Y procesar estado actual (evita race condition con GameStarted)
    _stateSub = gameBloc.stream.listen(_onStateChange);
    _onStateChange(gameBloc.state);
  }

  // ── Game loop ────────────────────────────────────────────────────────────────

  @override
  void update(double dt) {
    super.update(dt);
    _checkBlockHit();
  }

  void _checkBlockHit() {
    if (!_blockCanHit) return;

    // Jugador: anchor bottomLeft → borde superior = position.y - size.y
    final playerTopY = _player.position.y - _player.size.y;
    // Bloque: anchor center → borde inferior = position.y + size.y/2
    final blockBottomY = _valueBlock.position.y + _valueBlock.size.y / 2;
    final dx =
        (_player.position.x + _player.size.x / 2 - _valueBlock.position.x)
            .abs();

    // El jugador camina bajo el bloque — la cabeza roza la base del bloque
    if (dx < 55 && playerTopY <= blockBottomY + 8) {
      _blockCanHit = false;
      _valueBlock.triggerBump();
      gameBloc.add(ValueBlockHit());
    }
  }

  // ── Reacción al GameBloc ─────────────────────────────────────────────────────

  void _onStateChange(GameState state) {
    if (state is GameInProgress) {
      if (state.waitingForAnswer) {
        _player.stopMoving();
        if (!overlays.isActive(overlayQuestion)) {
          overlays.add(overlayQuestion);
        }
      } else {
        _player.startMoving();
        if (overlays.isActive(overlayQuestion)) {
          overlays.remove(overlayQuestion);
        }
        _onAnswerProcessed(state.lastAnswerCorrect);
      }
    } else if (state is LevelComplete) {
      _player.stopMoving();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      overlays.add(overlayLevelComplete);
    } else if (state is GameOver) {
      _player.stopMoving();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      overlays.add(overlayGameOver);
    } else if (state is GameComplete) {
      _player.stopMoving();
      if (overlays.isActive(overlayQuestion)) overlays.remove(overlayQuestion);
      overlays.add(overlayGameComplete);
    }
  }

  void _onAnswerProcessed(bool? wasCorrect) {
    _valueBlock.reset();
    _blockCanHit = true;
    _player.resetX();
    if (wasCorrect == true) _player.celebrate();
  }

  // ── Input ────────────────────────────────────────────────────────────────────

  @override
  void onTapDown(TapDownEvent event) {
    // Solo saltar si no hay pregunta activa
    if (!overlays.isActive(overlayQuestion)) {
      _player.jump();
    }
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent && !overlays.isActive(overlayQuestion)) {
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
