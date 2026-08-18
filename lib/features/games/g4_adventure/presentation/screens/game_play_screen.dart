// Spec: specs/games/g4-adventure-plan.md Fase 4 §4.2

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../data/game_questions_provider.dart';
import '../../g4_adventure_game.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import '../overlays/game_complete_overlay.dart';
import '../overlays/game_over_overlay.dart';
import '../overlays/hud_overlay.dart';
import '../overlays/level_complete_overlay.dart';
import '../overlays/question_overlay.dart';

/// Pantalla principal del juego.
///
/// Crea [GameBloc] y [G4AdventureGame], arranca el nivel [level] y
/// gestiona transiciones entre niveles (LevelComplete → siguiente nivel)
/// y reinicios (GameOver → GameRestarted → mismo nivel).
class GamePlayScreen extends StatefulWidget {
  final int level;

  const GamePlayScreen({super.key, required this.level});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  late final GameBloc _gameBloc;
  late final G4AdventureGame _game;

  // Nivel siguiente preparado por LevelComplete; null = reinicio del nivel actual
  int? _nextLevel;

  @override
  void initState() {
    super.initState();
    _gameBloc = getIt<GameBloc>();
    _game = G4AdventureGame(gameBloc: _gameBloc);

    // Esperar primer frame para que el GameWidget monte el canvas antes de
    // emitir GameStarted (garantiza que el stream listener de _game está activo)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startLevel(widget.level);
    });
  }

  @override
  void dispose() {
    _gameBloc.close();
    super.dispose();
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  void _startLevel(int level) {
    final questions = GameQuestionsProvider.getQuestionsForLevel(level);
    _gameBloc.add(GameStarted(level: level, questions: questions));
  }

  void _onExit() => context.pop();

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<GameBloc, GameState>(
        bloc: _gameBloc,
        listener: (context, state) {
          if (state is LevelComplete) {
            // Guardar nivel siguiente antes de que NextLevel emita GameInitial
            _nextLevel = state.level + 1;
          } else if (state is GameInitial) {
            // Reacción a GameRestarted o NextLevel — limpiar overlays y relanzar
            final level = _nextLevel ?? widget.level;
            _nextLevel = null;
            _game.overlays.remove(G4AdventureGame.overlayGameOver);
            _game.overlays.remove(G4AdventureGame.overlayLevelComplete);
            _game.overlays.remove(G4AdventureGame.overlayGameComplete);
            _startLevel(level);
          }
        },
        child: Stack(
          children: [
            GameWidget<G4AdventureGame>(
              game: _game,
              overlayBuilderMap: {
                G4AdventureGame.overlayHud: (context, _) =>
                    HudOverlay(gameBloc: _gameBloc),
                G4AdventureGame.overlayQuestion: (context, _) =>
                    QuestionOverlay(gameBloc: _gameBloc),
                G4AdventureGame.overlayGameOver: (context, _) =>
                    GameOverOverlay(
                      gameBloc: _gameBloc,
                      onExit: _onExit,
                    ),
                G4AdventureGame.overlayLevelComplete: (context, _) =>
                    LevelCompleteOverlay(
                      gameBloc: _gameBloc,
                      onExit: _onExit,
                    ),
                G4AdventureGame.overlayGameComplete: (context, _) =>
                    GameCompleteOverlay(
                      gameBloc: _gameBloc,
                      onExit: _onExit,
                    ),
              },
            ),
            // Botón de salida en la esquina superior izquierda (fuera del HUD overlay)
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, top: 4),
                  child: BlocBuilder<GameBloc, GameState>(
                    bloc: _gameBloc,
                    buildWhen: (_, curr) =>
                        curr is GameOver ||
                        curr is LevelComplete ||
                        curr is GameComplete ||
                        curr is GameInProgress,
                    builder: (context, state) {
                      // Ocultar durante overlays (tienen su propio botón Salir)
                      final isOverlay = state is GameOver ||
                          state is LevelComplete ||
                          state is GameComplete;
                      if (isOverlay) return const SizedBox.shrink();
                      return _ExitButton(onTap: _onExit);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExitButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ExitButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close_rounded,
          color: EduPlayColors.surfaceWhite,
          size: 22,
        ),
      ),
    );
  }
}
