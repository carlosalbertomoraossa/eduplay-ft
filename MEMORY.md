# MEMORY — eduplay-ft

## Decisiones técnicas

### BLoC para lecciones, Riverpod para progreso
**Qué**: Flujo de lección usa BLoC (LessonBloc); progreso global usa Riverpod (lessonProgressProvider).
**Por qué**: BLoC es ideal para flujos de estados complejos con muchos eventos. Riverpod es más simple para estado compartido entre pantallas.
**Alternativa descartada**: Riverpod para todo — LessonBloc tiene muchos eventos/estados; BLoC es más explícito.

### CurriculumData como fuente de verdad del contenido
**Qué**: `lib/features/lesson/data/curriculum_data.dart` centraliza las 75 lecciones como `static final Map<String, Lesson>`.
**Por qué**: Mantiene datos separados de lógica del BLoC. Al conectar backend, solo se reemplaza `CurriculumData.getLesson(id)` por llamada HTTP.
**Alternativa descartada**: JSON assets — más difícil de tipar y verificar en compile-time.

### LessonSummary vs Lesson en pantallas de navegación
**Qué**: UnitsScreen/LessonsScreen usan `LessonSummary` (id, order, title, xpReward) en vez del objeto `Lesson` completo.
**Por qué**: Las pantallas de navegación no necesitan los ejercicios. Cargar 75 objetos `Lesson` completos sería overhead innecesario.

### GameBloc desacoplado del FlameGame (paso por referencia)
**Qué**: `G4AdventureGame` recibe `GameBloc` como constructor param y escucha su stream con `StreamSubscription`.
**Por qué**: Separa lógica de juego (GameBloc, puro Dart) de la presentación Flame. El bloc es testeable sin el motor de juego.
**Alternativa descartada**: `flame_bloc` mixin — añade complejidad innecesaria; el stream directo es más simple y suficiente.

### HasGameReference en componentes Flame (no HasGameRef)
**Qué**: Todos los componentes Flame usan `HasGameReference` en lugar de `HasGameRef`.
**Por qué**: `HasGameRef` fue deprecado en Flame 1.37. La API pública cambió de `gameRef` a `game`.
**Alternativa descartada**: `HasGameRef` — produce warning de deprecación en el analyzer.

### renderTree override para visibilidad en componentes Flame
**Qué**: `AnswerBlockComponent` y `QuestionBubbleComponent` ocultan via `renderTree` override + `collisionType = CollisionType.inactive`.
**Por qué**: Flame 1.37 no tiene `isVisible` en `Component`. `renderTree` oculta el componente Y todos sus hijos (incluido `TextComponent`) en una sola llamada.
**Alternativa descartada**: `opacity = 0` — no existe en `SpriteComponent`; `removeFromParent()` — destruye el componente y requiere re-add.

### GameQuestionsProvider: 4→3 opciones de CurriculumData
**Qué**: Los ejercicios de CurriculumData tienen 4 opciones; `GameQuestion` requiere exactamente 3. Si `correct_index ≤ 2`: tomar primeras 3; si `correct_index == 3`: tomar opciones[1..3] y remap índice a 2.
**Por qué**: El diseño del juego (3 bloques de respuesta) requiere 3 opciones. No se pueden eliminar arbitrariamente ya que la respuesta correcta debe estar incluida.

### selectedGradeProvider (Riverpod StateProvider<int>)
**Qué**: `lib/core/providers/selected_grade_provider.dart` expone el grado activo (1–5).
**Por qué**: Estado UI global que afecta home, unidades y progreso. Riverpod StateProvider suficiente para MVP.
**Alternativa descartada**: Prop-drilling — 3+ screens necesitan el grado.

### Canvas-drawing en componentes Flame (sin PNGs)
**Qué**: BackgroundComponent, PlayerComponent, ValueBlockComponent y AnswerBlockComponent dibujan todo en `render(Canvas canvas)` usando Paint/Path/RRect/LinearGradient. No cargan sprites PNG.
**Por qué**: Los assets placeholder (64×64 color sólido) cubrían toda la pantalla con un color marrón cuando ParallaxComponent los tileaba. El canvas-drawing garantiza visuals funcionales sin depender de assets finales.
**Alternativa descartada**: ParallaxComponent con PNGs placeholder — cubría el canvas completo con el color del sprite.

### Detección de hit por proximidad en lugar de colisión Flame
**Qué**: `G4AdventureGame.update()` detecta manualmente cuando `playerTopY <= blockBottomY + 8 && dx < 55` para activar el bloque V.
**Por qué**: El bloque está a `gY-100` (centro), borde inferior a `gY-68`. El jugador en el suelo tiene `playerTopY = gY-64`. La diferencia es de 4px — la colisión de Flame fallaba por margenes mínimos y por la condición `isRising` que requería salto activo.
**Alternativa descartada**: `HasCollisionDetection` + `onCollisionStart` — frágil para este caso (1px de margen); `isRising` check — excluía el caso normal de caminar bajo el bloque.

### QuestionOverlay Flutter en lugar de componentes Flame para preguntas
**Qué**: Las preguntas y opciones se muestran en `question_overlay.dart` (overlay Flutter registrado en `overlayBuilderMap`). Los `AnswerBlockComponent` y `QuestionBubbleComponent` quedan desactivados del flujo principal.
**Por qué**: Los componentes Flame para texto/interacción son frágiles y difíciles de posicionar. Un overlay Flutter da control total sobre tipografía, animaciones y tap targets apropiados para niños.
**Alternativa descartada**: `QuestionBubbleComponent` + `AnswerBlockComponent` Flame — requerían colisión física para responder, poco confiable y confuso para niños 6-12 años.

### Fix race condition GameStarted vs stream listener
**Qué**: En `G4AdventureGame.onLoad()`, después de `_stateSub = gameBloc.stream.listen(...)`, se llama `_onStateChange(gameBloc.state)` explícitamente.
**Por qué**: `addPostFrameCallback` en `GamePlayScreen` puede disparar `GameStarted` antes de que `onLoad` termine de attachar el listener. Procesar el estado actual cubre ambos casos de timing.
**Alternativa descartada**: Solo stream.listen — perdía el estado emitido durante el gap de carga.

<!-- Agregar nuevas decisiones aquí, nunca borrar las existentes -->

---

## Semana actual (2026-05-29)

**Trabajo realizado**:
Corrección visual y funcional completa del **JUEGO G4 — La Aventura del Cuarto Grado**:

- **Assets**: Movidos de `assets/games/g4/` → `assets/images/games/g4/` (PNGs) y `assets/audio/games/g4/` (MP3s). Actualizados en `pubspec.yaml`. Flame resuelve imágenes desde `assets/images/` y audio desde `assets/audio/`.
- **Canvas-drawing**: BackgroundComponent reescrito — cielo degradado azul, nubes blancas animadas (parallax 0.12×), colinas verdes doble capa (0.25× y 0.45×), suelo marrón+césped verde. PlayerComponent reescrito — personaje colombiano con camiseta tricolor (amarillo/azul/rojo), animación de piernas/brazos al correr, pelo oscuro, ojos con brillo. ValueBlockComponent y AnswerBlockComponent reescritos en canvas.
- **Auto-movimiento**: PlayerComponent auto-camina a 100px/s con `_walkSpeed`. Detiene al pausar, regresa a x=80 tras cada respuesta.
- **Hit detection**: `G4AdventureGame._checkBlockHit()` usa proximidad en `update()` — elimina dependencia de Flame collision para el bloque V. Eliminado `_player.isRising` check y eliminado auto-salto (`_autoJump`).
- **QuestionOverlay**: Nuevo `question_overlay.dart` — card que sube animada desde abajo (SlideTransition), 3 botones táctiles con colores distintos, feedback visual verde/rojo al seleccionar, 750ms de delay antes de enviar `AnswerBlockHit` al bloc.
- **HUD**: Rediseñado con `Stack` — nivel centrado arriba, corazones+score arriba-derecha.
- **TapCallbacks + KeyboardEvents**: Salto manual con Espacio/↑/Tap (solo activo cuando no hay pregunta).

**Estado al cerrar**: `flutter analyze` 0 errores. Flujo pendiente de verificación visual completa (bloque V → pregunta → respuesta → reset jugador).

**Siguiente paso inmediato**: Verificar flujo completo del juego en hot restart. Si funciona: T-25 (tests GameBloc) y T-26 (tests GameQuestionsProvider).

**Archivos clave modificados**:
- `lib/features/games/g4_adventure/g4_adventure_game.dart` — reescrito completo
- `lib/features/games/g4_adventure/presentation/components/background_component.dart` — canvas-drawing
- `lib/features/games/g4_adventure/presentation/components/player_component.dart` — canvas-drawing + auto-walk
- `lib/features/games/g4_adventure/presentation/components/value_block_component.dart` — canvas-drawing + triggerBump()
- `lib/features/games/g4_adventure/presentation/components/answer_block_component.dart` — canvas-drawing
- `lib/features/games/g4_adventure/presentation/overlays/hud_overlay.dart` — Stack layout
- `lib/features/games/g4_adventure/presentation/overlays/question_overlay.dart` — NUEVO
- `lib/features/games/g4_adventure/presentation/screens/game_play_screen.dart` — registra overlayQuestion
- `pubspec.yaml` — rutas de assets corregidas

## Semana anterior (2026-05-26) — resumen
Implementación completa del JUEGO 16 — La Aventura del Cuarto Grado (T-01 a T-24): entidades, GameBloc con score/vidas/racha, GameQuestionsProvider mapeando 33 MC a 8 niveles, componentes Flame (BackgroundComponent/PlayerComponent/ValueBlockComponent/AnswerBlockComponent/QuestionBubbleComponent), G4AdventureGame ensamblador, overlays HUD/GameOver/LevelComplete, pantallas LevelSelect/Result, rutas y banner en HomeScreen. flutter analyze limpio al cierre.
