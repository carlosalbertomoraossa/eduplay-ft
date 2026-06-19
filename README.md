# EduPlay — Flutter Frontend

App educativa gamificada para niños colombianos de primaria. Similar a Duolingo pero alineada con el currículo del MEN (Ministerio de Educación Nacional de Colombia).

## Specs
- [Arquitectura Flutter](specs/flutter-arch.md)
- [UX para niños](../specs/product/ux-children.md)
- [Dominio Learning](../specs/domains/learning/spec.md)
- [MVP](../specs/product/mvp.md)

## Requisitos

- Flutter SDK ≥ 3.4.0 / Dart ≥ 3.4.0
- Android Studio o VS Code con extensión Flutter
- Para Android: Android SDK con emulador o dispositivo físico

```bash
flutter --version  # verificar instalación
```

## Instalación

```bash
cd eduplay-ft
flutter pub get
```

## Correr la app

```bash
# Dispositivo/emulador Android
flutter run

# Web (desarrollo rápido sin emulador)
flutter run -d chrome

# Listar dispositivos disponibles
flutter devices
```

## Tests y análisis

```bash
flutter test       # 33 tests unitarios
flutter analyze    # 0 errores de compilación
```

## Build

```bash
# APK debug
flutter build apk --debug

# APK release
flutter build apk --release

# Web
flutter build web
```

## Variables de entorno

Actualmente la app corre en modo **mock** (sin backend real). Cuando se conecte el backend, se configurarán mediante `--dart-define`:

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8000
```

## Estado del frontend

| Feature | Estado |
|---------|--------|
| Splash + Onboarding | ✅ Implementado |
| Login padre (mock) | ✅ Implementado |
| Selector de niño (mock) | ✅ Implementado |
| Home del niño | ✅ Implementado |
| Camino de lecciones (Duolingo) | ✅ Implementado |
| 75 lecciones Matemáticas (DBA MEN, grados 1°–5°) | ✅ Implementado |
| Ejercicios (múltiple choice, completar, arrastrar) | ✅ Implementado |
| Pantalla de resultados | ✅ Implementado |
| Sistema de vidas (3 corazones) | ✅ Implementado |
| Juego G4 — Aventura del Cuarto Grado (Flame) | ✅ 8 niveles funcionales |
| Dashboard parental | ✅ Implementado |
| DI con get_it | ✅ 6 registros |
| Guards de ruta (GoRouter redirect) | ✅ Por rol |
| Widgets compartidos (6) | ✅ ep_button, ep_card, xp_bar, streak_badge, heart_indicator, confetti_overlay |
| Strings centralizados (l10n) | ✅ EduPlayStrings |
| Tests unitarios | ✅ 33 tests |
| Conexión con backend real | ⏳ Pendiente |
| Offline support (Drift) | ⏳ Pendiente |
| Pantallas Logros/Ranking/Configuración | ⏳ Placeholder |
| Features profile/ y gamification/ | ⏳ Pendiente |

## Estructura del proyecto

```
lib/
  core/
    di/           → injection.dart (get_it, 6 registros)
    l10n/         → app_strings.dart (60+ strings)
    network/      → api_client.dart (dio)
    providers/    → lesson_progress_provider, selected_grade_provider
    router/       → app_router.dart (GoRouter + guards)
    theme/        → app_theme.dart (EduPlayColors, Nunito)
  features/
    auth/         → splash, onboarding, login, child selector
    home/         → home_screen del niño
    lesson/
      data/       → curriculum_data.dart + curriculum_grade1–5.dart (75 lecciones)
      domain/     → lesson.dart (Lesson, Exercise, LessonResult)
      presentation/ → bloc, screens, widgets (3 tipos de ejercicio)
    subjects/     → units_screen, lessons_screen
    games/
      g4_adventure/
        data/     → game_questions_provider.dart (80 ejercicios, 8 niveles)
        domain/   → game_question.dart, game_result.dart
        presentation/
          bloc/   → game_bloc.dart (maxLevel=8, correctAnswersCount)
          components/ → 6 componentes Flame canvas-drawn
          overlays/   → 5 overlays (hud, question, game_over, level_complete, game_complete)
          screens/    → 3 screens (play, level_select, result)
        g4_adventure_game.dart → FlameGame principal
    onboarding/   → onboarding_screen
    parent_dashboard/ → dashboard + child_progress
  shared/
    widgets/      → ep_button, ep_card, xp_bar, streak_badge, heart_indicator, confetti_overlay
```

## Contribuir

Seguir la metodología SDD: toda feature nueva necesita su spec en `/specs` antes de implementar.
Ver [STATUS.md](STATUS.md) para el estado detallado.
