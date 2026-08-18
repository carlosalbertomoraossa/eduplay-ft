---
spec-version: 1.0.0
type: implementation-plan
status: approved
owner: equipo-frontend
last-updated: 2026-05-28
related-spec: specs/games/g4-adventure-platformer.md
---

# Plan de Implementación — La Aventura del Cuarto Grado

## Stack técnico

| Capa | Tecnología | Razón |
|------|-----------|-------|
| Motor de juego | `flame ^1.18.0` + `flame_bloc ^1.4.0` | Único motor 2D maduro para Flutter; integración nativa con BLoC ya usado en el proyecto |
| Estado del juego | BLoC (mismo patrón que `LessonBloc`) | Coherencia con arquitectura existente; estados explícitos y trazables |
| Preguntas | `CurriculumData` existente | Reutiliza los 45+ ejercicios `multipleChoice` de lecciones 401–415 sin duplicar contenido |
| Resultado | `LessonResultScreen` existente | El `GameResult` se convierte en `LessonResult` — misma pantalla de celebración |
| Navegación | `go_router` (ya instalado) | Dos rutas nuevas, sin cambios estructurales |

---

## Fases de implementación

### Fase 0 — Setup (30 min)

**Objetivo**: Flame funcionando, carpetas creadas, assets declarados.

#### 0.1 Agregar dependencias en `pubspec.yaml`

```yaml
# Juego 2D
flame: ^1.18.0
flame_bloc: ^1.4.0
flame_audio: ^2.1.1  # para SFX y música de fondo
```

#### 0.2 Declarar assets del juego en `pubspec.yaml`

```yaml
flutter:
  assets:
    - assets/animations/
    - assets/images/
    - assets/games/g4/        # NUEVO — sprites, backgrounds, audio
```

#### 0.3 Crear estructura de carpetas

```
lib/features/games/
  g4_adventure/
    data/
      game_questions_provider.dart
    domain/
      entities/
        game_question.dart
        game_state.dart
        game_result.dart
    presentation/
      bloc/
        game_bloc.dart
        game_event.dart
        game_state_ui.dart
      components/
        player_component.dart
        value_block_component.dart
        answer_block_component.dart
        background_component.dart
        question_bubble_component.dart
      overlays/
        hud_overlay.dart
        game_over_overlay.dart
        level_complete_overlay.dart
      screens/
        game_level_select_screen.dart
        game_play_screen.dart
        game_result_screen.dart
      g4_adventure_game.dart       # FlameGame principal
```

#### 0.4 Assets placeholder (para desarrollo)

Crear PNGs de 64×64 en color sólido para cada sprite — reemplazar por pixel-art final en Fase 5.

**Criterio de aceptación Fase 0**: `flutter run -d chrome` compila sin errores con Flame instalado.

---

### Fase 1 — Domain: entidades y GameBloc (2–3 h)

**Objetivo**: Toda la lógica de juego sin UI. Testeable en aislamiento.

#### 1.1 `game_question.dart`

```dart
// Spec: specs/games/g4-adventure-platformer.md §5.1
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

#### 1.2 `game_result.dart`

```dart
class GameResult extends Equatable {
  final int finalScore;
  final int levelsCompleted;
  final int questionsCorrect;
  final int questionsTotal;
  final int xpEarned;
  final int coinsEarned;
  final bool isHighScore;

  const GameResult({ ... });

  // Convierte a LessonResult para integrar con el sistema existente
  LessonResult toLessonResult() => LessonResult(
    lessonId: 'game-g4-lvl-$levelsCompleted',
    score: questionsTotal > 0 ? questionsCorrect / questionsTotal : 0,
    isCompleted: questionsCorrect / questionsTotal >= 0.7,
    xpEarned: xpEarned,
    coinsEarned: coinsEarned,
    achievementsUnlocked: [],
  );
}
```

#### 1.3 `game_bloc.dart` — Eventos

```dart
// Misma estructura sealed que LessonBloc
sealed class GameEvent extends Equatable {}

class GameStarted extends GameEvent {
  final int level;           // 1–8
  final List<GameQuestion> questions;
}

class BlockHit extends GameEvent {
  final BlockType blockType; // BlockType.value | BlockType.answer
  final int? answerIndex;    // solo para BlockType.answer
}

class GamePaused extends GameEvent {}
class GameResumed extends GameEvent {}
class GameRestarted extends GameEvent {}
```

#### 1.4 `game_bloc.dart` — Estados

```dart
sealed class GameState extends Equatable {}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final int score;
  final int lives;             // 1–5, inicia en 3
  final int currentLevel;
  final int questionsAnswered; // 0–10
  final int streakCount;
  final int scoreMultiplier;   // 1, 2 o 3
  final GameQuestion? activeQuestion;  // null si no hay pregunta activa
  final bool waitingForAnswer; // true: bloques de respuesta visibles
  final GameQuestion? lastAnswered;
  final bool lastAnswerCorrect;
}

class GameOver extends GameState {
  final GameResult result;
}

class LevelComplete extends GameState {
  final int level;
  final int score;
  final GameResult partialResult;
}

class GameComplete extends GameState {
  final GameResult result;
}
```

#### 1.5 `game_bloc.dart` — Lógica

Reglas de negocio (sin UI):

| Evento | Transición | Efecto |
|--------|-----------|--------|
| `GameStarted` | Initial → InProgress | Carga preguntas del nivel |
| `BlockHit(value)` | InProgress → InProgress | Activa pregunta → `waitingForAnswer = true` |
| `BlockHit(answer, correct)` | InProgress → InProgress | score += 100×multiplier, streak++, si streak==3 → ×2, si streak==5 → ×3 + vida |
| `BlockHit(answer, wrong)` | InProgress → InProgress | lives--, streak=0, multiplier=1 |
| `lives == 0` | InProgress → GameOver | Emite `GameOver` con `GameResult` |
| `questionsAnswered == 10` | InProgress → LevelComplete | Emite `LevelComplete` |
| `level == 8 && complete` | InProgress → GameComplete | Emite `GameComplete` |

**Criterio de aceptación Fase 1**: `bloc_test` unitario cubre los 7 eventos con mock de preguntas. `flutter analyze` limpio.

---

### Fase 2 — Data: GameQuestionsProvider (1 h)

**Objetivo**: Convertir `CurriculumData` en `List<GameQuestion>` por nivel.

#### 2.1 `game_questions_provider.dart`

```dart
// Spec: specs/games/g4-adventure-platformer.md §4
import '../../../lesson/data/curriculum_data.dart';
import '../../../lesson/domain/entities/lesson.dart';
import '../domain/entities/game_question.dart';

class GameQuestionsProvider {
  // IDs de ejercicios multipleChoice de Grado 4° por nivel
  static const Map<int, List<String>> _levelExerciseIds = {
    1: ['l406-e1', 'l406-e2', 'l406-e3', 'l406-e4', /* ... */],  // multiplicar por decenas
    2: ['l401-e1', 'l401-e2', 'l402-e1', 'l402-e2', /* ... */],  // fracciones básicas
    3: ['l407-e1', 'l407-e2', 'l407-e3', 'l407-e4', /* ... */],  // mult 2×2 cifras
    4: ['l404-e1', 'l404-e2', 'l404-e3', 'l404-e4', /* ... */],  // fracciones equiv.
    5: ['l411-e1', 'l411-e2', 'l412-e1', 'l412-e2', /* ... */],  // decimales
    6: ['l408-e1', 'l408-e2', 'l408-e3', 'l408-e4', /* ... */],  // div con residuo
    7: ['l414-e1', 'l414-e2', 'l414-e3', 'l414-e4', /* ... */],  // precios COP
    8: [/* mix de todos los niveles */],
  };

  static List<GameQuestion> getQuestionsForLevel(int level) {
    final ids = _levelExerciseIds[level] ?? [];
    final questions = <GameQuestion>[];

    for (final lessonId in CurriculumData.allLessonIds) {
      final lesson = CurriculumData.getLesson(lessonId);
      if (lesson == null) continue;

      for (final exercise in lesson.exercises) {
        if (!ids.contains(exercise.id)) continue;
        if (exercise.type != ExerciseType.multipleChoice) continue;

        final opts = List<String>.from(exercise.content['options'] as List);
        final correct = exercise.content['correct_index'] as int;

        // Tomar 3 opciones: la correcta + 2 distractores
        questions.add(GameQuestion(
          id: exercise.id,
          question: exercise.content['question'] as String,
          options: _pickThreeOptions(opts, correct),
          correctIndex: 0, // la correcta siempre va primero, luego se baraja
          xpReward: lesson.xpReward ~/ lesson.exercises.length,
          difficulty: lesson.difficulty,
        ));
      }
    }

    return questions..shuffle(); // orden aleatorio cada partida
  }

  // Selecciona la respuesta correcta + 2 de los 3 distractores
  static List<String> _pickThreeOptions(List<String> opts, int correctIdx) {
    final correct = opts[correctIdx];
    final distractors = [...opts]..removeAt(correctIdx)..shuffle();
    return [correct, distractors[0], distractors[1]]..shuffle();
    // NOTA: tras el shuffle, correctIndex se recalcula en GameQuestion.fromExercise
  }
}
```

> **Nota**: `CurriculumData` necesita exponer un getter `allLessonIds` o el proveedor itera los IDs conocidos (401–415). Agregar ese getter en Fase 2.

**Criterio de aceptación Fase 2**: `GameQuestionsProvider.getQuestionsForLevel(3)` retorna ≥ 10 preguntas con opciones correctas verificables.

---

### Fase 3 — Flame Components (4–6 h)

**Objetivo**: Los 5 componentes visuales del juego funcionando en el canvas.

#### 3.1 `background_component.dart` — Parallax scroll

```
BackgroundComponent (PositionComponent)
  ├─ ParallaxComponent (3 capas)
  │    ├─ capa sky   → velocidad 0.1x
  │    ├─ capa hills → velocidad 0.3x
  │    └─ capa ground (tile) → velocidad 1x (scroll completo)
  └─ Suelo sólido con detección de colisión
```

Configuración Flame:
```dart
class G4AdventureGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    await add(ParallaxComponent.load([
      ParallaxImageData('games/g4/bg_sky.png'),
      ParallaxImageData('games/g4/bg_hills.png'),
    ], baseVelocity: Vector2(20, 0),
       velocityMultiplierDelta: Vector2(1.8, 1)));
    await add(BackgroundGround());
  }
}
```

#### 3.2 `player_component.dart` — Personaje

```
PlayerComponent (SpriteAnimationGroupComponent + HasCollisionDetection)
  ├─ Estado: idle | running | jumping | hit_correct | hit_wrong
  ├─ Spritesheets: player_idle.png (4f), player_run.png (8f), player_jump.png (4f)
  ├─ Física: velocityY con gravedad (Vector2(0, 400)), salto impulso -600
  ├─ Colisión: RectangleHitbox 48×56px
  └─ Auto-scroll: translate X += 60px/s (pausa durante respuesta)
```

Física de salto simplificada:
```dart
@override
void update(double dt) {
  // Gravedad
  velocity.y += gravity * dt;
  position += velocity * dt;

  // Suelo
  if (position.y >= groundY) {
    position.y = groundY;
    velocity.y = 0;
    isOnGround = true;
  }
}

void jump() {
  if (isOnGround) {
    velocity.y = -600;
    isOnGround = false;
    current = PlayerState.jumping;
  }
}
```

#### 3.3 `value_block_component.dart` — Bloque morado "V"

```
ValueBlockComponent (SpriteComponent + HasCollisionDetection)
  ├─ Sprite: block_value.png (64×64, morado con "V")
  ├─ Posición: fija en el suelo, aparece a 400px por delante del personaje
  ├─ Estado: waiting | hit | broken
  ├─ Colisión superior: cuando PlayerComponent choca desde abajo → emite BlockHit(value)
  └─ Animación hit: escala 1.0 → 1.3 → 0.8 → desaparece (150ms)
```

Detección de golpe desde abajo:
```dart
@override
void onCollisionStart(Set<Vector2> points, PositionComponent other) {
  if (other is PlayerComponent) {
    // Verificar que el jugador viene de abajo
    final playerBottom = other.position.y + other.size.y;
    if (playerBottom <= position.y + 8) {  // margen de 8px
      gameRef.add(BlockHitEvent(BlockType.value));
      _playHitAnimation();
    }
  }
}
```

#### 3.4 `answer_block_component.dart` — Bloques de respuesta

```
AnswerBlockComponent (SpriteComponent + HasCollisionDetection)
  ├─ Sprite: block_answer.png (estados: normal=azul, correct=verde, wrong=rojo)
  ├─ Posición: flotante, 3 bloques en fila a 200px del personaje (altura variable)
  ├─ Label: texto centrado con la opción de respuesta
  ├─ Estado: hidden | floating | hit_correct | hit_wrong
  └─ Animación: bounce suave ±4px en Y con sin() cada frame
```

Aparición de los 3 bloques:
```dart
void showAnswerBlocks(GameQuestion question) {
  for (int i = 0; i < 3; i++) {
    add(AnswerBlockComponent(
      text: question.options[i],
      isCorrect: i == question.correctIndex,
      position: Vector2(startX + i * 120, floatY - i * 20), // escalonado
      onHit: (correct) => gameRef.read(gameBlocContext).add(
        BlockHit(answerIndex: i),
      ),
    ));
  }
}
```

#### 3.5 `question_bubble_component.dart` — Burbuja de pregunta

```
QuestionBubbleComponent (PositionComponent)
  ├─ Sigue la posición X del PlayerComponent + offset Y -80px
  ├─ Renderiza: burbuja blanca redondeada (Canvas drawRRect) + texto de pregunta
  ├─ Visible solo cuando waitingForAnswer == true
  └─ Animación: fadeIn 200ms al aparecer
```

Render custom con Canvas:
```dart
@override
void render(Canvas canvas) {
  // Burbuja
  final paint = Paint()..color = Colors.white;
  canvas.drawRRect(
    RRect.fromRectAndRadius(bubbleRect, const Radius.circular(12)),
    paint,
  );
  // Texto
  final tp = TextPainter(text: TextSpan(text: question, style: textStyle));
  tp.layout();
  tp.paint(canvas, textOffset);
}
```

---

### Fase 4 — Game Screen y HUD (2–3 h)

**Objetivo**: Pantalla completa jugable con HUD Flutter sobre canvas Flame.

#### 4.1 `g4_adventure_game.dart` — FlameGame principal

```dart
class G4AdventureGame extends FlameGame
    with HasCollisionDetection, FlameBloc {

  final GameBloc gameBloc;
  late PlayerComponent player;
  late ValueBlockComponent currentValueBlock;

  G4AdventureGame({required this.gameBloc});

  @override
  Future<void> onLoad() async {
    await _loadComponents();
    gameBloc.stream.listen(_onStateChange);
  }

  void _onStateChange(GameState state) {
    if (state is GameInProgress && state.waitingForAnswer) {
      _spawnAnswerBlocks(state.activeQuestion!);
    }
    if (state is GameOver) {
      overlays.add('GameOver');
    }
    if (state is LevelComplete) {
      overlays.add('LevelComplete');
    }
  }
}
```

#### 4.2 `game_play_screen.dart` — Wrapper Flutter + Flame

```dart
class GamePlayScreen extends StatelessWidget {
  final int level;
  const GamePlayScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc()
        ..add(GameStarted(
          level: level,
          questions: GameQuestionsProvider.getQuestionsForLevel(level),
        )),
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Scaffold(
            body: GameWidget<G4AdventureGame>(
              game: G4AdventureGame(gameBloc: context.read<GameBloc>()),
              overlayBuilderMap: {
                'HUD': (ctx, game) => HudOverlay(game: game),
                'GameOver': (ctx, game) => GameOverOverlay(game: game),
                'LevelComplete': (ctx, game) => LevelCompleteOverlay(game: game),
              },
              initialActiveOverlays: const ['HUD'],
            ),
          );
        },
      ),
    );
  }
}
```

#### 4.3 `hud_overlay.dart` — HUD Flutter (sobre el canvas)

```dart
class HudOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is! GameInProgress) return const SizedBox();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HudChip('SCORE', '${state.score}'),
                _HudChip('LEVEL', '${(state.questionsAnswered / 10 * 100).round()}%'),
                _HudChip('VIDAS', '❤️' * state.lives),
                if (state.scoreMultiplier > 1)
                  _MultiplierBadge(state.scoreMultiplier),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

#### 4.4 Controles (mobile + web)

```dart
// En GamePlayScreen — botones virtuales para mobile
Positioned(
  bottom: 20, left: 20,
  child: Row(children: [
    _GameButton(icon: Icons.arrow_left, onPressed: () => game.player.moveLeft()),
    _GameButton(icon: Icons.arrow_right, onPressed: () => game.player.moveRight()),
  ]),
),
Positioned(
  bottom: 20, right: 20,
  child: _GameButton(icon: Icons.arrow_upward, onPressed: () => game.player.jump()),
),

// RawKeyboardListener para web
RawKeyboardListener(
  focusNode: FocusNode(),
  onKey: (event) {
    if (event.logicalKey == LogicalKeyboardKey.space ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      game.player.jump();
    }
  },
  child: gameWidget,
),
```

---

### Fase 5 — Integración de resultado y assets finales (1–2 h)

**Objetivo**: El resultado del juego se registra igual que una lección completada.

#### 5.1 `game_result_screen.dart`

```dart
class GameResultScreen extends ConsumerWidget {
  final GameResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Convierte GameResult → LessonResult y registra progreso
    final lessonResult = result.toLessonResult();

    // Registrar en lessonProgressProvider igual que una lección normal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(lessonProgressProvider.notifier)
         .completeLesson(lessonResult.lessonId);
    });

    // Reutilizar LessonResultScreen existente
    return LessonResultScreen(result: lessonResult);
  }
}
```

#### 5.2 Assets pixel-art finales

Recursos gratuitos recomendados para el estilo de la imagen:
- **OpenGameArt.org** — buscar: "platformer tileset", "pixel art character"
- **itch.io free assets** — buscar: "2d platformer pack free"
- **Kenney.nl** — Platformer Pack Redux (CC0, libre de uso)

Nomenclatura final esperada en `assets/games/g4/`:
```
player_idle.png     player_run.png      player_jump.png
block_value.png     block_answer.png
bg_sky.png          bg_hills.png        bg_ground.png
sfx_correct.mp3     sfx_wrong.mp3       sfx_jump.mp3
sfx_block_hit.mp3   music_theme.mp3
```

---

### Fase 6 — Navegación (30 min)

#### 6.1 Nuevas rutas en `app_router.dart`

```dart
GoRoute(
  path: '/games/g4-adventure',
  builder: (_, __) => const GameLevelSelectScreen(),
),
GoRoute(
  path: '/games/g4-adventure/play/:level',
  builder: (_, state) => GamePlayScreen(
    level: int.parse(state.pathParameters['level']!),
  ),
),
```

#### 6.2 Acceso desde `HomeScreen`

En el grid de materias del `HomeScreen`, agregar una tarjeta "Juegos" que navegue a `/games/g4-adventure`. Visible solo para Grado 4° (condicionado con `selectedGradeProvider`).

---

### Fase 7 — Tests (1–2 h)

#### 7.1 Unit tests — `GameBloc`

```dart
// test/features/games/game_bloc_test.dart
blocTest<GameBloc, GameState>(
  'respuesta correcta suma score y aumenta streak',
  build: () => GameBloc(),
  act: (bloc) {
    bloc.add(GameStarted(level: 1, questions: mockQuestions));
    bloc.add(BlockHit(BlockType.value, null));
    bloc.add(BlockHit(BlockType.answer, 0)); // índice correcto
  },
  expect: () => [
    isA<GameInProgress>().having((s) => s.score, 'score', 100),
    isA<GameInProgress>().having((s) => s.streakCount, 'streak', 1),
  ],
);
```

#### 7.2 Unit tests — `GameQuestionsProvider`

```dart
test('nivel 3 retorna al menos 10 preguntas multipleChoice de Grado 4', () {
  final questions = GameQuestionsProvider.getQuestionsForLevel(3);
  expect(questions.length, greaterThanOrEqualTo(10));
  expect(questions.every((q) => q.options.length == 3), isTrue);
});
```

---

## Cronograma estimado

| Fase | Duración | Dependencia |
|------|---------|-------------|
| 0 — Setup | 30 min | Ninguna — empezar aquí |
| 1 — Domain + BLoC | 2–3 h | Fase 0 |
| 2 — Data provider | 1 h | Fase 1 |
| 3 — Flame components | 4–6 h | Fases 1 + 2 |
| 4 — Game screen + HUD | 2–3 h | Fase 3 |
| 5 — Resultado + assets | 1–2 h | Fase 4 |
| 6 — Navegación | 30 min | Fase 5 |
| 7 — Tests | 1–2 h | Fases 1 + 2 |
| **TOTAL** | **~14 h** | |

## Riesgos y mitigaciones

| Riesgo | Probabilidad | Mitigación |
|--------|-------------|-----------|
| Rendimiento 60fps en Chrome con Flame | Media | Limitar componentes activos ≤ 10; usar `removeWhere` para limpiar bloques viejos |
| Colisión imprecisa jugador ↔ bloque | Alta | Usar `RectangleHitbox` con margen de 8px; testear en Fase 3 con `debugMode: true` |
| `CurriculumData` no expone iterador de todos los ejercicios | Media | Agregar `allLessonIds` getter o iterar IDs conocidos 401–415 directamente |
| Assets no disponibles al inicio | Alta | Usar sprites placeholder coloreados en Fases 0–4; reemplazar en Fase 5 |
| `flame_bloc` incompatible con `flutter_bloc ^8.x` | Baja | Verificar versiones antes de `pub get`; fallback: BLoC sin `flame_bloc` usando `stream.listen` |
