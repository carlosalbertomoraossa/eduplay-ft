---
spec-version: 1.0.0
type: tasks
status: done
owner: equipo-frontend
last-updated: 2026-08-17
related-plan: specs/games/g4-adventure-plan.md
related-spec: specs/games/g4-adventure-platformer.md
---

# Tasks — La Aventura del Cuarto Grado

> Cada tarea = 1 commit. Marcar `[x]` al completar antes de hacer el commit.  
> Orden de ejecución: seguir los IDs en secuencia. No saltar fases.  
> Mensaje de commit sugerido incluido en cada tarea.

---

## FASE 0 — Setup (~30 min)

### T-01 — Agregar dependencias Flame en pubspec.yaml
- **Archivo**: `eduplay-ft/pubspec.yaml`
- **Cambios**:
  - Agregar bajo `dependencies:`:
    ```yaml
    flame: ^1.18.0
    flame_bloc: ^1.4.0
    flame_audio: ^2.1.1
    ```
  - Agregar bajo `flutter: / assets:`:
    ```yaml
    - assets/games/g4/
    ```
- **Comando**: `flutter pub get`
- **Hecho cuando**: `flutter pub get` sin errores y `import 'package:flame/flame.dart'` compila.
- **Commit**: `chore(eduplay-ft): agregar dependencias Flame para juego plataformas 2D`
- [x] Completado

---

### T-02 — Crear estructura de carpetas del juego
- **Archivos a crear** (todos vacíos con comentario `// TODO`):
  ```
  lib/features/games/g4_adventure/
    data/game_questions_provider.dart
    domain/entities/game_question.dart
    domain/entities/game_result.dart
    presentation/bloc/game_bloc.dart
    presentation/bloc/game_event.dart
    presentation/bloc/game_state.dart
    presentation/components/player_component.dart
    presentation/components/value_block_component.dart
    presentation/components/answer_block_component.dart
    presentation/components/background_component.dart
    presentation/components/question_bubble_component.dart
    presentation/overlays/hud_overlay.dart
    presentation/overlays/game_over_overlay.dart
    presentation/overlays/level_complete_overlay.dart
    presentation/screens/game_level_select_screen.dart
    presentation/screens/game_play_screen.dart
    presentation/screens/game_result_screen.dart
    g4_adventure_game.dart
  ```
- **Hecho cuando**: Todos los archivos existen. `flutter analyze` sin errores (solo warnings de TODO vacíos).
- **Commit**: `chore(eduplay-ft): estructura de carpetas juego g4-adventure`
- [x] Completado

---

### T-03 — Crear assets placeholder del juego
- **Directorio**: `eduplay-ft/assets/games/g4/`
- **Archivos a crear**: PNGs de 64×64 en color sólido (para desarrollo):
  - `player_idle.png` (azul)
  - `player_run.png` (azul)
  - `player_jump.png` (cyan)
  - `block_value.png` (morado)
  - `block_answer.png` (verde)
  - `bg_sky.png` (1920×360, celeste)
  - `bg_hills.png` (1920×200, verde)
  - `bg_ground.png` (64×32, marrón)
- **Archivos de audio**: crear archivos `.mp3` vacíos (0 bytes) como placeholder:
  - `sfx_correct.mp3`, `sfx_wrong.mp3`, `sfx_jump.mp3`, `sfx_block_hit.mp3`, `music_theme.mp3`
- **Hecho cuando**: `flutter run -d chrome` compila y carga assets sin error `Unable to load asset`.
- **Commit**: `chore(eduplay-ft): assets placeholder para juego g4-adventure`
- [x] Completado

---

## FASE 1 — Domain: Entidades y BLoC (~3 h)

### T-04 — Entidad GameQuestion
- **Archivo**: `lib/features/games/g4_adventure/domain/entities/game_question.dart`
- **Contenido**:
  ```dart
  import 'package:equatable/equatable.dart';
  import '../../../lesson/domain/entities/lesson.dart';

  class GameQuestion extends Equatable {
    final String id;
    final String question;
    final List<String> options;   // exactamente 3
    final int correctIndex;       // 0, 1 o 2
    final int xpReward;
    final Difficulty difficulty;

    const GameQuestion({
      required this.id,
      required this.question,
      required this.options,
      required this.correctIndex,
      required this.xpReward,
      required this.difficulty,
    });

    @override
    List<Object?> get props => [id];
  }
  ```
- **Hecho cuando**: `flutter analyze lib/features/games/g4_adventure/domain/` sin errores.
- **Commit**: `feat(eduplay-ft): entidad GameQuestion para juego plataformas`
- [x] Completado

---

### T-05 — Entidad GameResult + toLessonResult()
- **Archivo**: `lib/features/games/g4_adventure/domain/entities/game_result.dart`
- **Contenido**:
  ```dart
  import 'package:equatable/equatable.dart';
  import '../../../lesson/domain/entities/lesson.dart';

  class GameResult extends Equatable {
    final int finalScore;
    final int levelsCompleted;
    final int questionsCorrect;
    final int questionsTotal;
    final int xpEarned;
    final int coinsEarned;
    final bool isHighScore;

    const GameResult({
      required this.finalScore,
      required this.levelsCompleted,
      required this.questionsCorrect,
      required this.questionsTotal,
      required this.xpEarned,
      required this.coinsEarned,
      this.isHighScore = false,
    });

    LessonResult toLessonResult() => LessonResult(
      lessonId: 'game-g4-lvl-$levelsCompleted',
      score: questionsTotal > 0 ? questionsCorrect / questionsTotal : 0,
      isCompleted: questionsTotal > 0 && questionsCorrect / questionsTotal >= 0.7,
      xpEarned: xpEarned,
      coinsEarned: coinsEarned,
      achievementsUnlocked: const [],
    );

    @override
    List<Object?> get props => [finalScore, levelsCompleted, questionsCorrect];
  }
  ```
- **Hecho cuando**: `flutter analyze` sin errores. `GameResult(...).toLessonResult()` retorna `LessonResult` válido.
- **Commit**: `feat(eduplay-ft): entidad GameResult con conversión a LessonResult`
- [x] Completado

---

### T-06 — GameEvent (eventos del BLoC)
- **Archivo**: `lib/features/games/g4_adventure/presentation/bloc/game_event.dart`
- **Contenido**:
  ```dart
  import 'package:equatable/equatable.dart';
  import '../../domain/entities/game_question.dart';

  enum BlockType { value, answer }

  sealed class GameEvent extends Equatable {
    @override
    List<Object?> get props => [];
  }

  class GameStarted extends GameEvent {
    final int level;
    final List<GameQuestion> questions;
    GameStarted({required this.level, required this.questions});
    @override
    List<Object?> get props => [level];
  }

  class ValueBlockHit extends GameEvent {}

  class AnswerBlockHit extends GameEvent {
    final int answerIndex;
    AnswerBlockHit(this.answerIndex);
    @override
    List<Object?> get props => [answerIndex];
  }

  class GamePaused extends GameEvent {}
  class GameResumed extends GameEvent {}
  class GameRestarted extends GameEvent {
    final int level;
    GameRestarted(this.level);
    @override
    List<Object?> get props => [level];
  }

  class NextLevel extends GameEvent {}
  ```
- **Hecho cuando**: `flutter analyze` sin errores.
- **Commit**: `feat(eduplay-ft): eventos GameBloc para juego plataformas`
- [x] Completado

---

### T-07 — GameState (estados del BLoC)
- **Archivo**: `lib/features/games/g4_adventure/presentation/bloc/game_state.dart`
- **Contenido**:
  ```dart
  import 'package:equatable/equatable.dart';
  import '../../domain/entities/game_question.dart';
  import '../../domain/entities/game_result.dart';

  sealed class GameState extends Equatable {
    @override
    List<Object?> get props => [];
  }

  class GameInitial extends GameState {}

  class GameInProgress extends GameState {
    final int score;
    final int lives;
    final int currentLevel;
    final int questionsAnswered;
    final int streakCount;
    final int scoreMultiplier;
    final List<GameQuestion> questions;
    final GameQuestion? activeQuestion;
    final bool waitingForAnswer;
    final bool? lastAnswerCorrect;

    const GameInProgress({
      required this.score,
      required this.lives,
      required this.currentLevel,
      required this.questionsAnswered,
      required this.streakCount,
      required this.scoreMultiplier,
      required this.questions,
      this.activeQuestion,
      this.waitingForAnswer = false,
      this.lastAnswerCorrect,
    });

    GameInProgress copyWith({
      int? score, int? lives, int? currentLevel, int? questionsAnswered,
      int? streakCount, int? scoreMultiplier, List<GameQuestion>? questions,
      GameQuestion? activeQuestion, bool? waitingForAnswer, bool? lastAnswerCorrect,
    }) => GameInProgress(
      score: score ?? this.score,
      lives: lives ?? this.lives,
      currentLevel: currentLevel ?? this.currentLevel,
      questionsAnswered: questionsAnswered ?? this.questionsAnswered,
      streakCount: streakCount ?? this.streakCount,
      scoreMultiplier: scoreMultiplier ?? this.scoreMultiplier,
      questions: questions ?? this.questions,
      activeQuestion: activeQuestion ?? this.activeQuestion,
      waitingForAnswer: waitingForAnswer ?? this.waitingForAnswer,
      lastAnswerCorrect: lastAnswerCorrect,
    );

    @override
    List<Object?> get props => [score, lives, questionsAnswered, waitingForAnswer, lastAnswerCorrect];
  }

  class GameOver extends GameState {
    final GameResult result;
    const GameOver(this.result);
    @override
    List<Object?> get props => [result];
  }

  class LevelComplete extends GameState {
    final int level;
    final int score;
    final GameResult partialResult;
    const LevelComplete({required this.level, required this.score, required this.partialResult});
    @override
    List<Object?> get props => [level, score];
  }

  class GameComplete extends GameState {
    final GameResult result;
    const GameComplete(this.result);
    @override
    List<Object?> get props => [result];
  }
  ```
- **Hecho cuando**: `flutter analyze` sin errores.
- **Commit**: `feat(eduplay-ft): estados GameBloc para juego plataformas`
- [x] Completado

---

### T-08 — GameBloc (lógica de negocio completa)
- **Archivo**: `lib/features/games/g4_adventure/presentation/bloc/game_bloc.dart`
- **Reglas a implementar** (ver plan §1.5):

| Evento | Acción |
|--------|--------|
| `GameStarted` | Emite `GameInProgress` inicial con score=0, lives=3, multiplier=1 |
| `ValueBlockHit` | Saca siguiente pregunta de la lista → `waitingForAnswer=true` |
| `AnswerBlockHit(correct)` | score += 100×multiplier, streak++, si streak≥3 → ×2, si streak≥5 → ×3 + vida extra |
| `AnswerBlockHit(wrong)` | lives--, streak=0, multiplier=1 |
| `lives == 0` | Emite `GameOver` con `GameResult` calculado |
| `questionsAnswered == 10` | Emite `LevelComplete` |
| `NextLevel + level == 8` | Emite `GameComplete` |
| `GameRestarted` | Vuelve a `GameInProgress` inicial |

- **Hecho cuando**: `flutter analyze` sin errores. Lógica de multiplicador verificable manualmente.
- **Commit**: `feat(eduplay-ft): GameBloc con lógica de score, vidas y multiplicador de racha`
- [x] Completado

---

## FASE 2 — Data: GameQuestionsProvider (~1 h)

### T-09 — Exponer allLessonIds en CurriculumData
- **Archivo**: `lib/features/lesson/data/curriculum_data.dart`
- **Cambio mínimo**: agregar un getter estático al final de la clase:
  ```dart
  static List<String> get allLessonIds => _allLessons.keys.toList();
  ```
- **Hecho cuando**: `CurriculumData.allLessonIds` retorna lista de 75 IDs (lesson-001 a lesson-515).
- **Commit**: `feat(eduplay-ft): exponer allLessonIds en CurriculumData`
- [x] Completado

---

### T-10 — GameQuestionsProvider con mapeo por nivel
- **Archivo**: `lib/features/games/g4_adventure/data/game_questions_provider.dart`
- **Implementar**:
  - Constante `_levelExerciseIds` con los IDs de ejercicios `multipleChoice` de Grado 4° por nivel (8 niveles, mínimo 10 IDs cada uno — ver plan §2.1)
  - Método `getQuestionsForLevel(int level)` que itera `CurriculumData.allLessonIds`, filtra por ID y tipo `multipleChoice`, convierte a `GameQuestion` con 3 opciones (correcta + 2 distractores)
  - Método privado `_buildOptions(List<String> opts, int correctIdx)` que retorna lista de 3 con índice correcto actualizado tras shuffle
- **Hecho cuando**:
  - `getQuestionsForLevel(1)` retorna ≥ 10 preguntas
  - Cada pregunta tiene exactamente 3 opciones
  - `options[correctIndex]` es siempre la respuesta correcta
- **Commit**: `feat(eduplay-ft): GameQuestionsProvider desde CurriculumData Grado 4°`
- [x] Completado

---

## FASE 3 — Flame Components (~6 h)

### T-11 — BackgroundComponent (parallax + suelo)
- **Archivo**: `lib/features/games/g4_adventure/presentation/components/background_component.dart`
- **Implementar**:
  - `BackgroundComponent extends PositionComponent` con `ParallaxComponent` de 2 capas (sky, hills) velocidad 20px/s base
  - `GroundComponent extends PositionComponent with CollisionCallbacks` — rectángulo sólido en Y=600, ancho = `gameSize.x * 3`
  - El suelo se repite con tiles de `bg_ground.png`
- **Hecho cuando**: Fondo hace scroll horizontal. Personaje (placeholder) cae y se para en el suelo.
- **Commit**: `feat(eduplay-ft): BackgroundComponent con parallax y suelo colisionable`
- [x] Completado

---

### T-12 — PlayerComponent (sprite + física de salto)
- **Archivo**: `lib/features/games/g4_adventure/presentation/components/player_component.dart`
- **Implementar**:
  - `PlayerComponent extends SpriteAnimationGroupComponent<PlayerState>`
  - Estados: `idle`, `running`, `jumping`
  - Sprite placeholder (rectángulo azul 48×56) hasta tener pixel-art final
  - `RectangleHitbox(Vector2(40, 50), position: Vector2(4, 6))`
  - Física: `velocity.y += 800 * dt` (gravedad), salto `velocity.y = -550`
  - Auto-scroll: `position.x += 60 * dt` cuando `!waitingForAnswer`
  - Colisión con `GroundComponent` → detiene caída
- **Hecho cuando**: El personaje corre hacia la derecha, salta con espacio/tap, y cae de vuelta al suelo.
- **Commit**: `feat(eduplay-ft): PlayerComponent con física de salto y auto-scroll`
- [x] Completado

---

### T-13 — ValueBlockComponent (bloque "V" golpeable)
- **Archivo**: `lib/features/games/g4_adventure/presentation/components/value_block_component.dart`
- **Implementar**:
  - `ValueBlockComponent extends SpriteComponent with CollisionCallbacks`
  - Sprite: `block_value.png` (placeholder morado 64×64)
  - `RectangleHitbox` tamaño completo
  - `onCollisionStart`: verificar que el `PlayerComponent` colisiona desde abajo (`playerBottom <= blockTop + 8`) → emitir evento al `G4AdventureGame` mediante callback
  - Animación de golpe: escala `1.0 → 1.3 → 1.0 → removeFromParent()` en 300ms usando `add(ScaleEffect...)`
  - Se genera automáticamente a 600px por delante del jugador cuando el anterior fue golpeado
- **Hecho cuando**: Personaje salta y golpea el bloque desde abajo → bloque desaparece con animación → callback disparado.
- **Commit**: `feat(eduplay-ft): ValueBlockComponent golpeable desde abajo`
- [x] Completado

---

### T-14 — AnswerBlockComponent (3 bloques de respuesta)
- **Archivo**: `lib/features/games/g4_adventure/presentation/components/answer_block_component.dart`
- **Implementar**:
  - `AnswerBlockComponent extends SpriteComponent with CollisionCallbacks`
  - Constructor: `text`, `isCorrect`, `position`, `onHit`
  - Sprite base: `block_answer.png` (placeholder: azul=normal, verde=correcto, rojo=incorrecto)
  - Label centrado con Nunito Bold 18px usando `TextComponent`
  - Animación idle: bounce `±6px` en Y usando `MoveEffect.by(Vector2(0, 6), EffectController(duration: 0.8, infinite: true, reverseDuration: 0.8))`
  - `onCollisionStart` desde arriba (jugador aterriza encima): llama `onHit(isCorrect)`
  - Animación respuesta correcta: verde + escala 1.3 + `removeFromParent()` tras 500ms
  - Animación respuesta incorrecta: rojo + vibración horizontal ±8px + `removeFromParent()` tras 800ms
- **Hecho cuando**: Los 3 bloques flotan, el personaje puede aterrizar sobre cada uno, el callback correcto/incorrecto se dispara.
- **Commit**: `feat(eduplay-ft): AnswerBlockComponent con 3 opciones y feedback visual`
- [x] Completado

---

### T-15 — QuestionBubbleComponent (burbuja de pregunta)
- **Archivo**: `lib/features/games/g4_adventure/presentation/components/question_bubble_component.dart`
- **Implementar**:
  - `QuestionBubbleComponent extends PositionComponent`
  - Sigue al `PlayerComponent`: `position = player.position + Vector2(0, -70)`
  - Render con Canvas: `drawRRect` burbuja blanca + cola triangular + `TextPainter` con la pregunta
  - Font: Nunito Bold 16px, color textDark
  - Visible solo cuando `waitingForAnswer == true`
  - FadeIn 200ms al aparecer, fadeOut 150ms al desaparecer
- **Hecho cuando**: La burbuja aparece sobre el personaje con el texto "7 × 8 = ?" cuando hay pregunta activa.
- **Commit**: `feat(eduplay-ft): QuestionBubbleComponent sobre el personaje`
- [x] Completado

---

## FASE 4 — Game Screen + HUD (~3 h)

### T-16 — G4AdventureGame (FlameGame principal)
- **Archivo**: `lib/features/games/g4_adventure/g4_adventure_game.dart`
- **Implementar**:
  ```dart
  class G4AdventureGame extends FlameGame with HasCollisionDetection {
    final GameBloc gameBloc;
    late PlayerComponent player;

    G4AdventureGame({required this.gameBloc});

    @override
    Future<void> onLoad() async {
      await add(BackgroundComponent());
      player = PlayerComponent(position: Vector2(100, 400));
      await add(player);
      _spawnNextValueBlock();
      gameBloc.stream.listen(_onStateChange);
    }

    void _onStateChange(GameState state) { ... }
    void _spawnNextValueBlock() { ... }
    void _spawnAnswerBlocks(GameQuestion question) { ... }
    void onValueBlockHit() => gameBloc.add(ValueBlockHit());
    void onAnswerHit(int index) => gameBloc.add(AnswerBlockHit(index));
  }
  ```
- **Hecho cuando**: `G4AdventureGame` instancia sin errores. Background y personaje visibles en pantalla.
- **Commit**: `feat(eduplay-ft): G4AdventureGame FlameGame principal`
- [x] Completado

---

### T-17 — HudOverlay (score, vidas, nivel — Flutter sobre Flame)
- **Archivo**: `lib/features/games/g4_adventure/presentation/overlays/hud_overlay.dart`
- **Implementar**:
  - `BlocBuilder<GameBloc, GameState>` mostrando:
    - `SCORE: ${state.score}` — Nunito ExtraBold blanco con sombra negra
    - `LEVEL: ${pct}%` — igual
    - `VIDAS: ${'❤️' * state.lives}` — igual
    - Badge `×${state.scoreMultiplier}` dorado cuando multiplier > 1, con animación pulse
  - Layout: `Row` con `MainAxisAlignment.spaceBetween` en `SafeArea` top
  - Fondo semitransparente negro 40% detrás de los chips
- **Hecho cuando**: El HUD muestra los 3 valores correctos. Al responder bien el score sube en tiempo real.
- **Commit**: `feat(eduplay-ft): HudOverlay score/vidas/nivel con BlocBuilder`
- [x] Completado

---

### T-18 — GameOverOverlay
- **Archivo**: `lib/features/games/g4_adventure/presentation/overlays/game_over_overlay.dart`
- **Implementar**:
  - Fondo negro semitransparente cubriendo todo el canvas
  - Texto "GAME OVER" pixel-art grande (Nunito ExtraBold 48px, rojo)
  - Score final y preguntas correctas/total
  - Dos botones: "🔄 Reintentar" → `GameRestarted(level)` y "🏠 Inicio" → `context.go('/home')`
  - Animación: fadeIn completo en 500ms
- **Hecho cuando**: Al llegar a 0 vidas aparece la pantalla con los botones funcionales.
- **Commit**: `feat(eduplay-ft): GameOverOverlay con opción reintentar o ir al inicio`
- [x] Completado

---

### T-19 — LevelCompleteOverlay
- **Archivo**: `lib/features/games/g4_adventure/presentation/overlays/level_complete_overlay.dart`
- **Implementar**:
  - Fondo verde semitransparente
  - "¡Nivel ${level} completado!" + score acumulado + estrellas (1–3 según aciertos)
  - Botón "Siguiente nivel →" → `NextLevel()` si `level < 8`
  - Botón "Ver resultado" → navega a `GameResultScreen` si `level == 8`
  - Animación: slide desde arriba en 400ms
- **Hecho cuando**: Al completar 10 preguntas aparece overlay con estrellas y botón de continuar.
- **Commit**: `feat(eduplay-ft): LevelCompleteOverlay con progresión de niveles`
- [x] Completado

---

### T-20 — GamePlayScreen (Scaffold + GameWidget + controles)
- **Archivo**: `lib/features/games/g4_adventure/presentation/screens/game_play_screen.dart`
- **Implementar**:
  - `BlocProvider<GameBloc>` con `GameStarted` en `create`
  - `GameWidget<G4AdventureGame>` con `overlayBuilderMap` para HUD, GameOver, LevelComplete
  - Botones virtuales mobile (izq, der, saltar) posicionados con `Positioned`
  - `RawKeyboardListener` para web (espacio, flechas)
  - `WillPopScope` para pausar al presionar atrás
- **Hecho cuando**: `flutter run -d chrome` → la pantalla muestra el juego completo con controles funcionales.
- **Commit**: `feat(eduplay-ft): GamePlayScreen con GameWidget y controles mobile+web`
- [x] Completado

---

### T-21 — GameLevelSelectScreen (selector de nivel)
- **Archivo**: `lib/features/games/g4_adventure/presentation/screens/game_level_select_screen.dart`
- **Implementar**:
  - Grid 2×4 de 8 niveles
  - Cada tarjeta: número de nivel, nombre (ej. "Fracciones"), dificultad (⭐/⭐⭐/⭐⭐⭐), estado (desbloqueado/bloqueado)
  - Nivel 1 siempre desbloqueado. Nivel N se desbloquea al completar N-1.
  - Estado de progreso leído desde un `SharedPreferences` simple o hardcodeado nivel 1 libre para MVP.
  - AppBar con "← La Aventura del Cuarto Grado"
- **Hecho cuando**: La pantalla muestra los 8 niveles. Tap en nivel 1 navega a `/games/g4-adventure/play/1`.
- **Commit**: `feat(eduplay-ft): GameLevelSelectScreen con grid de 8 niveles`
- [x] Completado

---

## FASE 5 — Resultado e integración con sistema existente (~1 h)

### T-22 — GameResultScreen (integra con LessonResultScreen)
- **Archivo**: `lib/features/games/g4_adventure/presentation/screens/game_result_screen.dart`
- **Implementar**:
  ```dart
  class GameResultScreen extends ConsumerWidget {
    final GameResult result;
    const GameResultScreen({super.key, required this.result});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final lessonResult = result.toLessonResult();

      // Registrar en el sistema de progreso
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (lessonResult.isCompleted) {
          ref.read(lessonProgressProvider.notifier)
             .completeLesson(lessonResult.lessonId);
        }
      });

      // Reutilizar LessonResultScreen existente
      return LessonResultScreen(result: lessonResult);
    }
  }
  ```
- **Hecho cuando**: Al completar el juego se muestra `LessonResultScreen` con XP y monedas correctos. El progreso queda registrado.
- **Commit**: `feat(eduplay-ft): GameResultScreen integra resultado juego con LessonResultScreen`
- [x] Completado

---

## FASE 6 — Navegación (~30 min)

### T-23 — Rutas del juego en app_router.dart
- **Archivo**: `lib/core/router/app_router.dart`
- **Cambios**: Agregar dos rutas antes de `/achievements`:
  ```dart
  GoRoute(
    path: '/games/g4-adventure',
    builder: (_, __) => const GameLevelSelectScreen(),
  ),
  GoRoute(
    path: '/games/g4-adventure/play/:level',
    builder: (_, state) => GamePlayScreen(
      level: int.tryParse(state.pathParameters['level'] ?? '1') ?? 1,
    ),
  ),
  ```
- **Hecho cuando**: `context.go('/games/g4-adventure')` desde cualquier pantalla navega al selector de niveles.
- **Commit**: `feat(eduplay-ft): rutas /games/g4-adventure en app_router`
- [x] Completado

---

### T-24 — Acceso desde HomeScreen (solo Grado 4°)
- **Archivo**: `lib/features/home/presentation/screens/home_screen.dart`
- **Cambio**: En el grid de materias, agregar tarjeta "🎮 Juegos" que:
  - Solo se muestra cuando `selectedGradeProvider == 4`
  - Navega a `/games/g4-adventure` al tocar
  - Misma altura/estilo que las otras tarjetas del grid
- **Hecho cuando**: En Grado 4° aparece la tarjeta de Juegos. En otros grados no aparece.
- **Commit**: `feat(eduplay-ft): tarjeta Juegos en HomeScreen visible para Grado 4°`
- [x] Completado

---

## FASE 7 — Tests (~2 h)

### T-25 — Tests unitarios GameBloc (7 escenarios)
- **Archivo**: `test/features/games/game_bloc_test.dart`
- **Tests a cubrir**:
  1. `GameStarted` → emite `GameInProgress` con score=0, lives=3
  2. `ValueBlockHit` → activa pregunta (`waitingForAnswer=true`)
  3. `AnswerBlockHit` correcto → score += 100, streak = 1
  4. `AnswerBlockHit` correcto ×3 → multiplier = 2
  5. `AnswerBlockHit` incorrecto → lives -= 1, streak = 0, multiplier = 1
  6. Lives llega a 0 → emite `GameOver`
  7. questionsAnswered == 10 → emite `LevelComplete`
- **Hecho cuando**: `flutter test test/features/games/game_bloc_test.dart` — todos los tests pasan.
- **Commit**: `test(eduplay-ft): tests unitarios GameBloc — 7 escenarios`
- [x] Completado

---

### T-26 — Tests unitarios GameQuestionsProvider
- **Archivo**: `test/features/games/game_questions_provider_test.dart`
- **Tests a cubrir**:
  1. Nivel 1 retorna ≥ 10 preguntas
  2. Cada pregunta tiene exactamente 3 opciones
  3. `options[correctIndex]` siempre es la respuesta correcta
  4. Dos llamadas con el mismo nivel retornan orden diferente (shuffle)
  5. Nivel 8 (mix) retorna preguntas de múltiples unidades
- **Hecho cuando**: `flutter test test/features/games/` — todos los tests pasan.
- **Commit**: `test(eduplay-ft): tests unitarios GameQuestionsProvider`
- [x] Completado

---

### T-27 — flutter analyze final + corrección de warnings
- **Alcance**: Todo `lib/features/games/`
- **Comando**: `flutter analyze lib/features/games/`
- **Criterio**: Cero errores. Cero warnings de `withOpacity`. Cero `prefer_const_constructors` ignorados.
- **Hecho cuando**: `flutter analyze lib/features/games/` retorna `No issues found!`
- **Commit**: `fix(eduplay-ft): corregir warnings flutter analyze en g4-adventure`
- [x] Completado

---

## Resumen de tareas

| Fase | Tareas | Tiempo estimado | Estado |
|------|--------|----------------|--------|
| 0 — Setup | T-01, T-02, T-03 | 30 min | ✅ |
| 1 — Domain + BLoC | T-04, T-05, T-06, T-07, T-08 | 3 h | ✅ |
| 2 — Data provider | T-09, T-10 | 1 h | ✅ |
| 3 — Flame components | T-11, T-12, T-13, T-14, T-15 | 6 h | ✅ |
| 4 — Game screen + HUD | T-16, T-17, T-18, T-19, T-20, T-21 | 3 h | ✅ |
| 5 — Resultado | T-22 | 1 h | ✅ |
| 6 — Navegación | T-23, T-24 | 30 min | ✅ |
| 7 — Tests | T-25, T-26, T-27 | 2 h | ✅ |
| **TOTAL** | **27 tareas** | **~16 h** | ✅ |

---

## Orden crítico de dependencias

```
T-01 → T-02 → T-03        (Setup — paralelo posible)
T-04 → T-05               (Entidades — T-05 depende de T-04)
T-06 → T-07 → T-08        (BLoC — secuencial)
T-09 → T-10               (Data — T-10 depende de T-09)
T-11 → T-12               (Background antes que Player)
T-12 → T-13 → T-14 → T-15 (Componentes — secuencial por colisión)
T-16 → T-17, T-18, T-19   (Game después de todos los components)
T-20 → T-21               (Screens)
T-22 → T-23 → T-24        (Integración y nav)
T-25, T-26 → T-27         (Tests al final)
```

> **Tip**: Las Fases 1 y 2 se pueden desarrollar en paralelo con la Fase 3 si hay 2 personas.  
> Si hay 1 persona: completar Fases 0 → 1 → 2 → 3 → 4 → 5 → 6 → 7 en ese orden.
