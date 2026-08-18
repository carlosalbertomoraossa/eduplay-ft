---
spec-version: 1.0.0
type: frontend-spec
platform: flutter
status: approved
owner: frontend
last-updated: 2026-05-26
---

# EduPlay Flutter — Arquitectura Frontend

## Proyecto: `eduplay-ft`

## Stack

| Capa | Tecnología | Versión |
|------|-----------|---------|
| Framework | Flutter | 3.22+ |
| Lenguaje | Dart | 3.4+ |
| Estado (lógica) | flutter_bloc / Cubit | 8.x |
| Estado (UI simple) | Riverpod | 2.x |
| Navegación | GoRouter | 14.x |
| HTTP | Dio | 5.x |
| Persistencia local | Drift (SQLite) | 2.x |
| Animaciones | Lottie + flutter_animate | - |
| Assets | flutter_svg, cached_network_image | - |
| Testing | flutter_test, mocktail, bloc_test | - |

## Arquitectura: Feature-Based + Clean

```
lib/
├── core/                        # Núcleo transversal
│   ├── router/                  # GoRouter configuración
│   ├── theme/                   # Tema visual (colores, tipografía, spacing)
│   ├── di/                      # Inyección de dependencias
│   ├── network/                 # Dio client, interceptores
│   ├── storage/                 # Drift DB, Hive
│   ├── constants/               # URLs, keys, constantes
│   └── utils/                   # Helpers, extensions
│
├── features/                    # Una carpeta por feature
│   ├── auth/
│   │   ├── data/               # Repositorios + datasources
│   │   ├── domain/             # Entidades + use cases
│   │   └── presentation/       # Screens + Cubits/Blocs
│   │
│   ├── home/                    # Pantalla principal del niño
│   ├── lesson/                  # Flujo de lección + ejercicios
│   ├── gamification/            # XP, nivel, streak, logros
│   ├── subjects/                # Exploración de materias y cursos
│   ├── parent_dashboard/        # Dashboard parental
│   ├── onboarding/             # Onboarding de nuevo usuario
│   ├── profile/                 # Perfil del niño, avatar
│   └── settings/                # Configuración y controles
│
├── shared/                      # Widgets y componentes reutilizables
│   ├── widgets/
│   │   ├── ep_button.dart       # Botón estilo EduPlay
│   │   ├── ep_card.dart         # Tarjeta con estilo gamificado
│   │   ├── xp_bar.dart          # Barra de XP animada
│   │   ├── streak_badge.dart    # Badge de streak con fuego
│   │   ├── lumi_character.dart  # Personaje guía animado
│   │   ├── heart_indicator.dart # Corazones de vida
│   │   └── confetti_overlay.dart# Celebración de confeti
│   └── animations/
│       └── celebration_animation.dart
│
└── main.dart
```

## Estructura interna de cada feature

```
features/lesson/
├── data/
│   ├── datasources/
│   │   ├── lesson_remote_datasource.dart   # Llama a learning-service API
│   │   └── lesson_local_datasource.dart    # Drift: lecciones offline
│   ├── models/                             # DTOs (desde JSON de API)
│   └── repositories/
│       └── lesson_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── lesson.dart
│   │   └── exercise.dart
│   ├── repositories/
│   │   └── lesson_repository.dart         # Interfaz (abstract)
│   └── usecases/
│       ├── get_lesson.dart
│       ├── submit_lesson.dart
│       └── get_next_lesson.dart
└── presentation/
    ├── screens/
    │   ├── lesson_screen.dart
    │   └── lesson_result_screen.dart
    ├── widgets/
    │   ├── exercise_multiple_choice.dart
    │   ├── exercise_drag_drop.dart
    │   ├── exercise_fill_blank.dart
    │   └── exercise_match.dart
    └── bloc/
        ├── lesson_bloc.dart
        └── lesson_state.dart
```

## Manejo de estado

| Caso de uso | Solución | Justificación |
|-------------|---------|---------------|
| Flujo de lección (multi-step) | Bloc | Estado complejo con múltiples transiciones |
| Autenticación | Cubit | Estado más simple: loading/auth/unauth |
| Perfil gamificado | Cubit + Riverpod provider | Datos compartidos en múltiples widgets |
| Tema / configuración | Riverpod StateProvider | Estado global simple |
| Datos de formulario | Cubit | Validación local sencilla |

## Navegación (GoRouter)

```dart
// Rutas principales
/                     → SplashScreen
/onboarding           → OnboardingScreen
/auth/login-parent    → ParentLoginScreen
/auth/select-child    → ChildSelectorScreen
/home                 → HomeScreen (niño)
/subjects             → SubjectsScreen
/subjects/:id/units   → UnitsScreen
/lessons/:id          → LessonScreen
/lessons/:id/result   → LessonResultScreen
/achievements         → AchievementsScreen
/leaderboard          → LeaderboardScreen
/parent/dashboard     → ParentDashboardScreen
/parent/child/:id     → ChildProgressScreen
/settings             → SettingsScreen
```

Guardias de ruta:
- Rutas de niño requieren token `child` válido
- Rutas de padre requieren token `parent` válido
- Onboarding redirige a home si ya hay sesión activa

## Offline First

```
Estrategia de cache:
1. App solicita datos → primero revisa Drift (SQLite local)
2. Si hay cache válido (< TTL) → devuelve cache
3. En paralelo → fetch de API (si hay conexión)
4. Al recibir respuesta de API → actualiza cache local
5. Si no hay conexión → devuelve cache aunque esté stale

Datos offline prioritarios:
- Lecciones descargadas (contenido completo)
- Progreso del niño (sincronizar al reconectar)
- Perfil gamificado (XP, nivel, streak)
- Lista de materias y cursos
```

## Tema visual (EduPlay Design System)

```dart
// core/theme/app_theme.dart
class EduPlayTheme {
  static const primaryBlue = Color(0xFF3B82F6);
  static const successGreen = Color(0xFF22C55E);
  static const energyYellow = Color(0xFFFBBF24);
  static const softRed = Color(0xFFF87171);
  static const adventurePurple = Color(0xFFA855F7);
  static const backgroundLight = Color(0xFFF0F9FF);

  static ThemeData get light => ThemeData(
    colorSchemeSeed: primaryBlue,
    fontFamily: 'Nunito',
    // ... configuración completa
  );
}
```

Fuente: **Nunito** (redondeada, amigable para niños). Incluir en `pubspec.yaml`.

## Pipeline de animaciones

- **Lottie**: celebraciones, personajes animados, onboarding (archivos `.json` en `assets/animations/`)
- **flutter_animate**: micro-animaciones de UI (botones, aparición de elementos, feedback)
- **Rive** (futuro): personajes interactivos complejos con estado reactivo

Regla: todas las animaciones deben tener opción de reducción de movimiento (accessibility setting).

## Testing

| Tipo | Herramienta | Cobertura objetivo |
|------|-------------|-------------------|
| Unit (use cases, blocs) | flutter_test + bloc_test + mocktail | ≥ 80% |
| Widget | flutter_test (golden tests) | Componentes del design system |
| Integration | integration_test | Flujos críticos: onboarding, lección, login |

## Accesibilidad

- Todos los widgets interactivos tienen `Semantics` label
- Tamaño mínimo de tap: 48×48dp (enforced via lint)
- Contraste: verificar con `flutter_accessibility_tools`
- Soporte TalkBack (Android) y VoiceOver (iOS): flujos principales

## Rendimiento

- Objetivo: 60fps en Moto G Power (gama media, Android 10)
- Imágenes: `cached_network_image` con placeholder y fade-in
- Listas largas: `ListView.builder` siempre (nunca `Column` con más de 10 elementos)
- Evitar rebuilds: `const` constructors donde sea posible, `select()` en Blocs
- Profiling: DevTools en cada sprint, especialmente pantalla de lección

## pubspec.yaml (dependencias principales)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.5
  riverpod: ^2.5.1
  flutter_riverpod: ^2.5.1
  go_router: ^14.0.0
  dio: ^5.4.3
  drift: ^2.18.0
  sqlite3_flutter_libs: ^0.5.0
  lottie: ^3.1.0
  flutter_animate: ^4.5.0
  cached_network_image: ^3.3.1
  flutter_svg: ^2.0.10
  equatable: ^2.0.5
  get_it: ^7.7.0
  injectable: ^2.4.1
  json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.7
  mocktail: ^1.0.3
  build_runner: ^2.4.9
  json_serializable: ^6.8.0
  injectable_generator: ^2.4.2
```
