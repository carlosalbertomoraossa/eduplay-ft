// Spec: .sdd/implemented/features/g4-adventure/g4-adventure-plan.md Fase 4 §4.2

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/providers/child_progress_provider.dart';
import '../../../../../core/providers/daily_quests_provider.dart';
import '../../../../../core/providers/game_progress_provider.dart';
import '../../../../../core/providers/lumi_customization_provider.dart';
import '../../../../../core/providers/selected_grade_provider.dart';
import '../../data/game_audio_service.dart';
import '../../data/game_questions_provider.dart';
import '../../g4_adventure_game.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import '../overlays/controls_overlay.dart';
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
class GamePlayScreen extends ConsumerStatefulWidget {
  final int level;

  const GamePlayScreen({super.key, required this.level});

  @override
  ConsumerState<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends ConsumerState<GamePlayScreen> {
  late final GameBloc _gameBloc;
  late final G4AdventureGame _game;
  late final int _activeGrade;
  late final LumiOutfit _equippedOutfit;

  // Nivel siguiente preparado por LevelComplete; null = reinicio del nivel actual
  int? _nextLevel;

  @override
  void initState() {
    super.initState();
    _gameBloc = getIt<GameBloc>();
    _activeGrade = _readGradeSafely();
    _equippedOutfit = ref.read(lumiCustomizationProvider).equipped;
    _game = G4AdventureGame(
      gameBloc: _gameBloc,
      initialLevel: widget.level,
      outfit: _equippedOutfit,
      onStarCollected: () {
        if (!mounted) return;
        ref
            .read(dailyQuestsProvider.notifier)
            .addProgress(DailyQuestType.collectStars, 1);
      },
      onQuestionAnswered: () {
        if (!mounted) return;
        ref
            .read(dailyQuestsProvider.notifier)
            .addProgress(DailyQuestType.gameChallenges, 1);
      },
    );

    // Esperar primer frame para que el GameWidget monte el canvas antes de
    // emitir GameStarted (garantiza que el stream listener de _game está activo)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startLevel(widget.level);
    });
  }

  int _readGradeSafely() {
    try {
      return ref.read(selectedGradeProvider);
    } catch (_) {
      return 4;
    }
  }

  @override
  void dispose() {
    _gameBloc.close();
    super.dispose();
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  void _startLevel(int level) {
    final questions = GameQuestionsProvider.getQuestionsForGradeAndLevel(
      grade: _activeGrade,
      level: level,
    );
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
            ref.read(gameProgressProvider.notifier).recordLevelCompleted(
                  level: state.level,
                  score: state.partialResult.finalScore,
                  accuracy: state.partialResult.accuracy,
                );
            ref.read(childProgressProvider.notifier).recordGameCompleted(
                  xpEarned: state.partialResult.xpEarned,
                  coinsEarned: state.partialResult.coinsEarned + 15,
                  starsEarned: state.partialResult.accuracy >= 0.9 ? 3 : 2,
                  chapterStampId: 'game-g$_activeGrade-l${state.level}',
                );
            // Guardar nivel siguiente antes de que NextLevel emita GameInitial
            _nextLevel = state.level + 1;
          } else if (state is GameComplete) {
            ref.read(gameProgressProvider.notifier).recordLevelCompleted(
                  level: 8,
                  score: state.result.finalScore,
                  accuracy: state.result.accuracy,
                );
            ref.read(childProgressProvider.notifier).recordGameCompleted(
                  xpEarned: state.result.xpEarned + 50,
                  coinsEarned: state.result.coinsEarned + 40,
                  starsEarned: 3,
                  chapterStampId: 'game-g$_activeGrade-boss',
                );
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
              autofocus: true,
              overlayBuilderMap: {
                G4AdventureGame.overlayHud: (context, game) =>
                    HudOverlay(gameBloc: _gameBloc, game: game),
                G4AdventureGame.overlayControls: (context, game) =>
                    ControlsOverlay(game: game),
                G4AdventureGame.overlayQuestion: (context, _) =>
                    QuestionOverlay(
                      gameBloc: _gameBloc,
                      outfit: _equippedOutfit,
                    ),
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
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ExitButton(onTap: _onExit),
                          const _SoundToggleButton(),
                        ],
                      );
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
        margin: const EdgeInsets.fromLTRB(8, 8, 4, 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.90),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF38BDF8), width: 1.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.close_rounded,
          color: Color(0xFF0F172A),
          size: 20,
        ),
      ),
    );
  }
}

class _SoundToggleButton extends StatelessWidget {
  const _SoundToggleButton();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GameAudioService.soundEnabled,
      builder: (_, enabled, __) {
        return GestureDetector(
          onTap: GameAudioService.toggleSound,
          child: Container(
            margin: const EdgeInsets.fromLTRB(4, 8, 8, 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: enabled
                  ? const Color(0xFFFEF08A).withValues(alpha: 0.94)
                  : Colors.white.withValues(alpha: 0.85),
              shape: BoxShape.circle,
              border: Border.all(
                color: enabled ? const Color(0xFFF59E0B) : const Color(0xFF94A3B8),
                width: 1.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.14),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              enabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
              color: enabled ? const Color(0xFF92400E) : const Color(0xFF64748B),
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
