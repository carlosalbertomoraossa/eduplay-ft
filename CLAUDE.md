# eduplay-ft — Flutter Frontend

## Qué es
App móvil de EduPlay para niños colombianos de primaria (6-12 años). Gamificada estilo Duolingo, enfocada en el currículo del MEN Colombia. Target principal: Android.

## Specs de referencia
- Arquitectura Flutter: `specs/flutter-arch.md`
- Plan contenido matemáticas 2°–5°: `specs/math-content-plan.md`
- UX niños: `../specs/product/ux-children.md`
- Dominio learning: `../specs/domains/learning/spec.md`
- Currículo MEN grados 1°–5°: `../specs/domains/learning/curriculum-men.md`
- Dominio gamificación: `../specs/domains/gamification/spec.md`
- MVP: `../specs/product/mvp.md`
- **Juego G4**: `specs/games/g4-adventure-platformer.md`, `specs/games/g4-adventure-plan.md`, `specs/games/g4-adventure-tasks.md`

## Stack
- **Flutter** 3.x / Dart SDK ≥ 3.4.0
- **Estado**: flutter_bloc + riverpod (BLoC para lecciones y juego, Riverpod para progreso)
- **Navegación**: go_router con guards de autenticación por rol (público/padre/niño)
- **Animaciones**: flutter_animate
- **Motor de juego**: Flame 1.37 + flame_bloc + flame_audio
- **HTTP**: dio (ApiClient registrado en DI, pendiente de conectar)
- **DI**: get_it (registro manual de 6 dependencias en injection.dart)
- **Persistencia**: shared_preferences (grado seleccionado), drift (listado, sin implementar)
- **Tests**: flutter_test + bloc_test + mocktail

## Estructura de carpetas
```
lib/
  core/
    di/           → injection.dart (get_it, 6 registros: repos, ApiClient, BLoCs)
    l10n/         → app_strings.dart (60+ strings centralizados, futuro .arb)
    network/      → api_client.dart (dio, @singleton, pendiente de conectar)
    providers/    → lesson_progress_provider, selected_grade_provider (Riverpod, SharedPreferences)
    router/       → app_router.dart (go_router con redirect guards por rol)
    theme/        → app_theme.dart (colores EduPlayColors, tipografía Nunito, Material 3)
  features/
    auth/         → splash, onboarding, login padre, selector niño
      data/       → mock_auth_repository.dart
      domain/     → auth_entities, auth_repository (interfaz)
      presentation/ → auth_cubit, screens
    home/         → home_screen del niño (mock data)
    lesson/
      data/       → curriculum_data.dart (índice) + curriculum_grade1–5.dart (75 lecciones)
      domain/     → lesson.dart (entities: Lesson, Exercise, LessonResult, Difficulty)
      presentation/
        bloc/     → lesson_bloc.dart (flujo completo de lección, try/catch)
        screens/  → lesson_screen, lesson_result_screen
        widgets/  → exercise_multiple_choice, exercise_fill_blank, exercise_drag_drop
    subjects/
      presentation/screens/ → units_screen (dinámico por grado), lessons_screen
    games/
      g4_adventure/
        data/     → game_questions_provider.dart (80 ejercicios MC mapeados a 8 niveles)
        domain/   → game_question.dart, game_result.dart (toLessonResult)
        presentation/
          bloc/   → game_bloc.dart (correctAnswersCount preciso, _maxLevel=8), game_event.dart, game_state.dart
          components/ → background, player, value_block, answer_block, question_bubble, flag
          overlays/   → hud_overlay, question_overlay, game_over_overlay, level_complete_overlay, game_complete_overlay
          screens/    → game_play_screen, game_level_select_screen, game_result_screen
        g4_adventure_game.dart → FlameGame principal (sin hack Future.delayed)
    onboarding/   → onboarding_screen
    parent_dashboard/ → parent_dashboard_screen, child_progress_screen
  shared/
    widgets/      → ep_button (con Semantics), ep_card, xp_bar, streak_badge, heart_indicator, confetti_overlay
assets/
  images/games/g4/  → sprites PNG placeholder 64×64 (canvas-drawing evita depender de ellos)
  audio/games/g4/   → SFX MP3 placeholder (0 bytes)
```

## Correr localmente
```bash
cd eduplay-ft
flutter pub get
flutter run          # requiere dispositivo/emulador conectado
flutter run -d chrome  # web (para desarrollo rápido)
```

## Tests
```bash
flutter test                     # 33 tests (lesson_bloc, game_bloc, game_questions_provider)
flutter analyze                  # 0 errores
```

## Archivos clave antes de tocar el código
1. `lib/core/di/injection.dart` — DI con get_it (AuthCubit, LessonBloc, GameBloc, repos, ApiClient)
2. `lib/core/router/app_router.dart` — rutas + guards de autenticación por rol
3. `lib/core/providers/selected_grade_provider.dart` — grado activo persistente (SharedPreferences)
4. `lib/core/l10n/app_strings.dart` — strings centralizados (preparación .arb)
5. `lib/features/lesson/data/curriculum_data.dart` — índice de las 75 lecciones (agrega curriculum_grade1–5.dart)
6. `lib/features/lesson/domain/entities/lesson.dart` — modelos Lesson, Exercise, LessonResult, Difficulty
7. `lib/features/lesson/presentation/bloc/lesson_bloc.dart` — flujo de lección con try/catch
8. `lib/features/games/g4_adventure/presentation/bloc/game_bloc.dart` — lógica del juego G4 (_maxLevel=8, correctAnswersCount)
9. `lib/features/games/g4_adventure/g4_adventure_game.dart` — FlameGame ensamblador (sin hacks)
10. `lib/features/games/g4_adventure/data/game_questions_provider.dart` — 80 ejercicios MC × 8 niveles
11. `lib/core/theme/app_theme.dart` — sistema de colores EduPlayColors

## Reglas del dominio importantes
- Todo dato de lección viene de `CurriculumData` (no hardcoded en widgets)
- Las lecciones dentro de una unidad son secuenciales (no se puede saltar)
- La "boss lesson" es la última de cada unidad (LessonType.boss)
- Sistema de 3 vidas (corazones) por lección
- Score ≥ 70% para completar una lección
- Los datos mock se reemplazan por APIs reales en el Bloque 11 del backlog
- Todos los BLoCs se obtienen via `getIt<T>()` (no instanciar con `new`)

## Reglas del juego G4 (La Aventura del Cuarto Grado)
- `GameBloc` es puro Dart — no depende de Flame; testeable en aislamiento (11 tests)
- `G4AdventureGame` recibe `GameBloc` por constructor; llama `_onStateChange(gameBloc.state)` tras attach del stream para evitar race condition con `GameStarted`
- `GameQuestionsProvider.getQuestionsForLevel(level)` convierte CurriculumData a GameQuestion — 8 niveles con 10 preguntas c/u
- Componentes Flame usan `HasGameReference` (no `HasGameRef`, deprecado en Flame 1.37)
- **Todos los componentes se dibujan en Canvas** (sin PNGs): BackgroundComponent (cielo degradado + nubes + colinas parallax), PlayerComponent (personaje colombiano animado), ValueBlockComponent (bloque morado + borde dorado), AnswerBlockComponent (azul/verde/rojo)
- **Detección de hits por proximidad** en `G4AdventureGame.update()` — NO usa colisión Flame para el bloque V; detecta cuando `playerTopY <= blockBottomY + 20` && `dx < 45`
- **Preguntas en overlay Flutter** (`question_overlay.dart`) — NO en componentes Flame. El overlay sube animado desde abajo, muestra pregunta + 3 botones táctiles con feedback visual
- **HUD**: nivel centrado arriba (`Stack`), corazones + score arriba-derecha
- **GameCompleteOverlay** dedicado (morado, borde dorado, 6 métricas) — NO reusar LevelCompleteOverlay
- Los overlays Flutter se registran en `GameWidget.overlayBuilderMap` con las constantes de `G4AdventureGame` (overlayHud, overlayQuestion, overlayGameOver, overlayLevelComplete, overlayGameComplete)
- Assets en `assets/images/games/g4/` y `assets/audio/games/g4/` son placeholders — reemplazar con arte final antes de producción
- `GameBloc.correctAnswersCount` trackea respuestas correctas reales (no aproximación desde score)

## Convenciones
- Usar `const` constructors donde sea posible
- No usar `withOpacity` (deprecated) — usar `withValues(alpha: x)`
- Textos en español colombiano (tú/usted según audiencia: "tú" para niños, "usted" para padres)
- Font: Nunito (todos los textos de UI)
- Strings visibles al usuario: usar `EduPlayStrings` de `core/l10n/app_strings.dart`
- Tests: `flutter_test` + `bloc_test` + `mocktail`; carpeta `test/features/<feature>/`
- DI: `getIt<T>()` para obtener dependencias; `configureDependencies()` las registra todas
