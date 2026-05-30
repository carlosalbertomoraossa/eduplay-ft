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
- **Navegación**: go_router
- **Animaciones**: flutter_animate
- **Motor de juego**: Flame 1.37 + flame_bloc + flame_audio
- **HTTP**: dio (pendiente de conectar)
- **DI**: get_it

## Estructura de carpetas
```
lib/
  core/
    di/           → inyección de dependencias (get_it)
    network/      → api_client.dart (dio, pendiente de usar)
    providers/    → lesson_progress_provider, selected_grade_provider (Riverpod)
    router/       → app_router.dart (go_router)
    theme/        → app_theme.dart (colores, tipografía Nunito)
  features/
    auth/         → splash, onboarding, login padre, selector niño
    home/         → home_screen del niño (mock data)
    lesson/
      data/       → curriculum_data.dart (75 lecciones MEN Colombia, getter allLessonIds)
      domain/     → lesson.dart (entities: Lesson, Exercise, LessonResult, Difficulty)
      presentation/
        bloc/     → lesson_bloc.dart (flujo completo de lección)
        screens/  → lesson_screen, lesson_result_screen
        widgets/  → exercise_multiple_choice, exercise_fill_blank, exercise_drag_drop
    subjects/
      presentation/screens/ → units_screen (dinámico por grado), lessons_screen
    games/
      g4_adventure/
        data/     → game_questions_provider.dart (mapeo CurriculumData → GameQuestion)
        domain/   → game_question.dart, game_result.dart
        presentation/
          bloc/   → game_bloc.dart, game_event.dart, game_state.dart
          components/ → background, player, value_block, answer_block, question_bubble
          overlays/   → hud_overlay, question_overlay, game_over_overlay, level_complete_overlay
          screens/    → game_play_screen, game_level_select_screen, game_result_screen
        g4_adventure_game.dart  → FlameGame principal
    onboarding/   → onboarding_screen
  shared/
    widgets/      → ep_button, heart_indicator, xp_bar
assets/
  images/games/g4/  → sprites PNG placeholder 64×64 (Flame resuelve assets/images/ como raíz)
  audio/games/g4/   → SFX MP3 placeholder (Flame resuelve assets/audio/ como raíz)
```

## Correr localmente
```bash
cd eduplay-ft
flutter pub get
flutter run          # requiere dispositivo/emulador conectado
flutter run -d chrome  # web (para desarrollo rápido)
```

## Archivos clave antes de tocar el código
1. `lib/features/lesson/data/curriculum_data.dart` — fuente de verdad de las 75 lecciones
2. `lib/features/lesson/domain/entities/lesson.dart` — modelos Lesson, Exercise, LessonResult, Difficulty
3. `lib/features/lesson/presentation/bloc/lesson_bloc.dart` — lógica del flujo de lección
4. `lib/features/games/g4_adventure/presentation/bloc/game_bloc.dart` — lógica del juego G4
5. `lib/features/games/g4_adventure/g4_adventure_game.dart` — FlameGame ensamblador
6. `lib/core/router/app_router.dart` — todas las rutas de la app
7. `lib/core/theme/app_theme.dart` — sistema de colores EduPlayColors

## Reglas del dominio importantes
- Todo dato de lección viene de `CurriculumData` (no hardcoded en widgets)
- Las lecciones dentro de una unidad son secuenciales (no se puede saltar)
- La "boss lesson" es la última de cada unidad (LessonType.boss)
- Sistema de 3 vidas (corazones) por lección
- Score ≥ 70% para completar una lección
- Los datos mock se reemplazan por APIs reales en el Bloque 11 del backlog

## Reglas del juego G4 (La Aventura del Cuarto Grado)
- `GameBloc` es puro Dart — no depende de Flame; testeable en aislamiento
- `G4AdventureGame` recibe `GameBloc` por constructor; llama `_onStateChange(gameBloc.state)` tras attach del stream para evitar race condition con `GameStarted`
- `GameQuestionsProvider.getQuestionsForLevel(level)` convierte CurriculumData a GameQuestion
- Componentes Flame usan `HasGameReference` (no `HasGameRef`, deprecado en Flame 1.37)
- **Todos los componentes se dibujan en Canvas** (sin PNGs): BackgroundComponent (cielo degradado + nubes + colinas parallax), PlayerComponent (personaje colombiano animado), ValueBlockComponent (bloque morado + borde dorado), AnswerBlockComponent (azul/verde/rojo)
- **Detección de hits por proximidad** en `G4AdventureGame.update()` — NO usa colisión Flame para el bloque V (demasiado frágil); detecta cuando `playerTopY <= blockBottomY + 8` && `dx < 55`
- **Preguntas en overlay Flutter** (`question_overlay.dart`) — NO en componentes Flame. El overlay sube animado desde abajo, muestra pregunta + 3 botones táctiles con feedback visual
- **HUD**: nivel centrado arriba (`Stack`), corazones + score arriba-derecha
- Los overlays Flutter se registran en `GameWidget.overlayBuilderMap` con las constantes de `G4AdventureGame` (overlayHud, overlayQuestion, overlayGameOver, overlayLevelComplete, overlayGameComplete)
- Assets en `assets/images/games/g4/` y `assets/audio/games/g4/` son placeholders — reemplazar con arte final antes de producción

## Convenciones
- Usar `const` constructors donde sea posible
- No usar `withOpacity` (deprecated) — usar `withValues(alpha: x)`
- Textos en español colombiano (tú/usted según audiencia: "tú" para niños, "usted" para padres)
- Font: Nunito (todos los textos de UI)
