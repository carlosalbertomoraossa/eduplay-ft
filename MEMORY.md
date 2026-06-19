# MEMORY — eduplay-ft

## Decisiones técnicas

### BLoC para lecciones, Riverpod para progreso
**Qué**: Flujo de lección usa BLoC (LessonBloc); progreso global usa Riverpod (lessonProgressProvider).
**Por qué**: BLoC es ideal para flujos de estados complejos con muchos eventos. Riverpod es más simple para estado compartido entre pantallas.
**Alternativa descartada**: Riverpod para todo — LessonBloc tiene muchos eventos/estados; BLoC es más explícito.

### CurriculumData como fuente de verdad del contenido
**Qué**: `lib/features/lesson/data/curriculum_data.dart` centraliza las 75 lecciones como `static final Map<String, Lesson>` compuesto por spread de 5 archivos (`curriculum_grade1.dart` … `curriculum_grade5.dart`).
**Por qué**: Mantiene datos separados de lógica del BLoC. Al conectar backend, solo se reemplaza `CurriculumData.getLesson(id)` por llamada HTTP. El particionamiento por grado (6 archivos en vez de 1 monolito de 4206 líneas) facilita mantenimiento.
**Alternativa descartada**: Un solo archivo monolítico — difícil de mantener y navegar. JSON assets — más difícil de tipar y verificar en compile-time.

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

### selectedGradeProvider (SharedPreferences)
**Qué**: `lib/core/providers/selected_grade_provider.dart` persiste el grado activo (1–5) en SharedPreferences via `SelectedGradeNotifier`.
**Por qué**: El grado seleccionado debe sobrevivir reinicios de la app. Se inyecta en `main.dart` via `ProviderScope.overrides`.
**Alternativa descartada**: `StateProvider<int>` sin persistencia — se perdía al cerrar la app.

### Canvas-drawing en componentes Flame (sin PNGs)
**Qué**: BackgroundComponent, PlayerComponent, ValueBlockComponent y AnswerBlockComponent dibujan todo en `render(Canvas canvas)` usando Paint/Path/RRect/LinearGradient. No cargan sprites PNG.
**Por qué**: Los assets placeholder (64×64 color sólido) cubrían toda la pantalla con un color marrón cuando ParallaxComponent los tileaba. El canvas-drawing garantiza visuals funcionales sin depender de assets finales.
**Alternativa descartada**: ParallaxComponent con PNGs placeholder — cubría el canvas completo con el color del sprite.

### Detección de hit por proximidad en lugar de colisión Flame
**Qué**: `G4AdventureGame.update()` detecta manualmente cuando `playerTopY <= blockBottomY + 20 && dx < 45` para activar el bloque V.
**Por qué**: El bloque está a `gY-170`, borde inferior a `gY-68`. El jugador en el suelo tiene `playerTopY = gY-64`. La diferencia es de 4px — la colisión de Flame fallaba por margenes mínimos y por la condición `isRising` que requería salto activo.
**Alternativa descartada**: `HasCollisionDetection` + `onCollisionStart` — frágil para este caso (1px de margen); `isRising` check — excluía el caso normal de caminar bajo el bloque.

### QuestionOverlay Flutter en lugar de componentes Flame para preguntas
**Qué**: Las preguntas y opciones se muestran en `question_overlay.dart` (overlay Flutter registrado en `overlayBuilderMap`). Los `AnswerBlockComponent` y `QuestionBubbleComponent` quedan desactivados del flujo principal.
**Por qué**: Los componentes Flame para texto/interacción son frágiles y difíciles de posicionar. Un overlay Flutter da control total sobre tipografía, animaciones y tap targets apropiados para niños.
**Alternativa descartada**: `QuestionBubbleComponent` + `AnswerBlockComponent` Flame — requerían colisión física para responder, poco confiable y confuso para niños 6-12 años.

### Fix race condition GameStarted vs stream listener
**Qué**: En `G4AdventureGame.onLoad()`, después de `_stateSub = gameBloc.stream.listen(...)`, se llama `_onStateChange(gameBloc.state)` explícitamente.
**Por qué**: `addPostFrameCallback` en `GamePlayScreen` puede disparar `GameStarted` antes de que `onLoad` termine de attachar el listener. Procesar el estado actual cubre ambos casos de timing.
**Alternativa descartada**: Solo stream.listen — perdía el estado emitido durante el gap de carga.

### GameInitial activa movimiento del jugador
**Qué**: `G4AdventureGame._onStateChange()` maneja el estado `GameInitial` llamando a `_player.startMoving()`.
**Por qué**: Cuando el juego se carga, el estado inicial es `GameInitial`. Sin este manejo, el jugador nunca recibía la instrucción de moverse hasta que el estado cambiara a `GameInProgress`.
**Alternativa descartada**: Inicializar `_moving = true` en PlayerComponent — no era suficiente.

### DI con get_it (reemplaza instanciación inline)
**Qué**: `lib/core/di/injection.dart` registra 6 dependencias: AuthRepository (singleton), ApiClient (singleton), AuthCubit, LessonBloc, GameBloc (factories). `main.dart`, `lesson_screen.dart` y `game_play_screen.dart` obtienen dependencias via `getIt<T>()`.
**Por qué**: Centraliza creación de dependencias, facilita testing (mock injection), evita acoplamiento a implementaciones concretas (MockAuthRepository hardcodeado).
**Alternativa descartada**: `new AuthCubit(MockAuthRepository())` inline en main.dart — acopla la app a implementaciones mock.

### Guards de ruta por rol (GoRouter.redirect)
**Qué**: `app_router.dart` implementa `redirect` que verifica `AuthCubit.state` y redirige según rol: no autenticado → onboarding, padre → /parent/dashboard, niño → /home. Rutas públicas (/, /onboarding, /auth/*) siempre accesibles.
**Por qué**: Previene acceso no autorizado a rutas protegidas sin depender de los builders individuales. Centraliza la lógica de autorización.
**Alternativa descartada**: Guards en cada pantalla — lógica duplicada y frágil.

### correctAnswersCount en GameInProgress
**Qué**: `GameInProgress` ahora tiene campo `correctAnswersCount` que se incrementa en `_handleCorrectAnswer`. `_buildResult` usa este conteo real en vez de aproximar desde el score.
**Por qué**: La aproximación anterior dividía score por multiplicador y era imprecisa (especialmente con streak multipliers variables). El conteo real es exacto y más simple.
**Alternativa descartada**: Aproximación `score ~/ (_baseScore * multiplier)` — imprecisa cuando el multiplicador cambia durante el nivel.

### GameCompleteOverlay dedicado (no reusar LevelCompleteOverlay)
**Qué**: `game_complete_overlay.dart` es un overlay independiente con gradiente morado, borde dorado, 6 métricas finales (puntos, correctas, precisión, niveles completados, XP, monedas).
**Por qué**: El overlay de "juego completo" requiere celebración diferente al de "nivel completado": todas las métricas acumuladas, sin botón "Siguiente", mensaje de campeón.
**Alternativa descartada**: Reusar `LevelCompleteOverlay` — confuso para el usuario (botón "Siguiente" cuando ya no hay niveles).

### Strings centralizados en EduPlayStrings
**Qué**: `lib/core/l10n/app_strings.dart` centraliza 60+ strings de UI en la clase `EduPlayStrings`, organizados por módulo (auth, home, lesson, game, etc.).
**Por qué**: Prepara la app para migración a `.arb`/internacionalización. Elimina strings hardcodeados dispersos en widgets. Facilita cambios de copy sin tocar lógica.
**Alternativa descartada**: Strings inline en cada widget — difíciles de localizar y modificar.

### Semantics en EpButton
**Qué**: `EpButton` envuelve su widget en `Semantics(button: true, enabled:, label:)`.
**Por qué**: El botón más usado de toda la app debe ser accesible para TalkBack/VoiceOver.
**Alternativa descartada**: Sin Semantics — inaccesible para lectores de pantalla.

---

## Semana actual (2026-06-19)

**Trabajo realizado** — Refactor arquitectónico completo en 3 sesiones:

**Prioridad 1 (crítico)**:
- `_maxLevel = 1 → 8` en GameBloc — el juego ahora soporta los 8 niveles
- 80 ejercicios MC mapeados a 8 niveles desde CurriculumData (grados 4 y 5)
- `correctAnswersCount` preciso en GameInProgress (reemplaza aproximación desde score)
- Guards de ruta con GoRouter.redirect verificando AuthCubit.state por rol

**Prioridad 2 (deuda técnica)**:
- CurriculumData partido en 6 archivos: curriculum_data.dart + curriculum_grade1–5.dart
- DI con get_it: 6 registros (AuthRepository, ApiClient, AuthCubit, LessonBloc, GameBloc)
- main.dart usa getIt en vez de instanciar MockAuthRepository inline
- GameCompleteOverlay dedicado (morado, borde dorado, 6 métricas)
- Eliminado hack `_ensureQuestionOverlay()` con Future.delayed
- selectedGradeProvider persistente en SharedPreferences
- Assets duplicados (assets/games/g4/) eliminados

**Prioridad 3 (calidad)**:
- Eliminado Future.delayed(400ms) innecesario en LessonBloc._onStarted
- 3 widgets compartidos nuevos: ep_card, streak_badge, confetti_overlay
- Semantics en EpButton
- try/catch en _onStarted y _onSubmitted del LessonBloc
- Strings centralizados en EduPlayStrings (core/l10n/app_strings.dart)
- 32 tests unitarios nuevos: lesson_bloc (10), game_bloc (11), game_questions_provider (11)

**Estado al cerrar**: `flutter analyze` 0 errores. `flutter test` 33/33 pasando.

**Archivos modificados/creados**:
- `lib/core/di/injection.dart` — registros de dependencias
- `lib/core/l10n/app_strings.dart` — NUEVO, 60+ strings
- `lib/core/providers/selected_grade_provider.dart` — SharedPreferences
- `lib/core/router/app_router.dart` — guards de ruta
- `lib/main.dart` — DI + SharedPreferences
- `lib/features/lesson/data/curriculum_grade1–5.dart` — NUEVOS (5 archivos)
- `lib/features/lesson/data/curriculum_data.dart` — reducido de 4206 a 217 líneas
- `lib/features/lesson/presentation/bloc/lesson_bloc.dart` — sin delay, con try/catch
- `lib/features/lesson/presentation/screens/lesson_screen.dart` — usa getIt
- `lib/features/games/g4_adventure/data/game_questions_provider.dart` — 8 niveles
- `lib/features/games/g4_adventure/presentation/bloc/game_bloc.dart` — maxLevel=8, correctAnswersCount
- `lib/features/games/g4_adventure/presentation/bloc/game_state.dart` — correctAnswersCount
- `lib/features/games/g4_adventure/presentation/overlays/game_complete_overlay.dart` — NUEVO
- `lib/features/games/g4_adventure/presentation/screens/game_play_screen.dart` — getIt + GameCompleteOverlay
- `lib/features/games/g4_adventure/g4_adventure_game.dart` — sin hack Future.delayed
- `lib/shared/widgets/ep_button.dart` — Semantics
- `lib/shared/widgets/ep_card.dart` — NUEVO
- `lib/shared/widgets/streak_badge.dart` — NUEVO
- `lib/shared/widgets/confetti_overlay.dart` — NUEVO
- `pubspec.yaml` — shared_preferences
- `test/features/lesson/bloc/lesson_bloc_test.dart` — NUEVO (10 tests)
- `test/features/games/g4_adventure/bloc/game_bloc_test.dart` — NUEVO (11 tests)
- `test/features/games/g4_adventure/data/game_questions_provider_test.dart` — NUEVO (11 tests)

## Semana anterior (2026-05-29) — resumen
Corrección visual y funcional completa del JUEGO G4: assets movidos a rutas correctas, canvas-drawing en todos los componentes, auto-movimiento del jugador, QuestionOverlay Flutter con animación, HUD rediseñado, salto manual con Tap/Space/ArrowUp.

## 2026-05-26 — resumen
Implementación completa del JUEGO G4 (T-01 a T-24): entidades, GameBloc con score/vidas/racha, GameQuestionsProvider mapeando 33 MC a 8 niveles, componentes Flame, overlays, pantallas, rutas y banner en HomeScreen.
