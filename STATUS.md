# STATUS — eduplay-ft — 2026-06-19

## Estado funcional

### Completado
- Splash screen con animación de entrada
- Onboarding (3 pantallas con ilustraciones)
- Login padre con email/contraseña (mock)
- Selector de perfil de niño con acceso a panel parental
- **Home del niño**: selector de grado (1°–5°), barra de avance, estrellas/monedas, streak, banner "Juegos"
- **UnitsScreen dinámico por grado** — lee `selectedGradeProvider` (persistente en SharedPreferences)
- Camino de lecciones estilo Duolingo (path bezier animado)
- Flujo completo de lección: ejercicio → feedback → siguiente → resultado
- Widgets ejercicio: selección múltiple, completar espacio, arrastrar y soltar
- Pantalla de resultado post-lección (score, XP, estrellas)
- Sistema de vidas (3 corazones) con pantalla de lección fallida
- Fix navegación post-lección: redirige a la unidad correcta según grado
- **75 lecciones de Matemáticas alineadas con DBA MEN Colombia** (Grados 1°–5°)
  - Grado 1° — Unidades 1, 2, 3 (15 lecciones completas)
  - Grado 2° — Unidades 201–203 (15 lecciones: números, suma/resta, tablas ×2×3×5)
  - Grado 3° — Unidades 301–303 (15 lecciones: números hasta 100.000, tablas 1–10, división)
  - Grado 4° — Unidades 401–403 (15 lecciones: fracciones, mult/div 2 cifras, decimales COP)
  - Grado 5° — Unidades 501–503 (15 lecciones: enteros negativos, porcentajes, razones)
  - **CurriculumData partido en 6 archivos** (curriculum_data.dart + curriculum_grade1–5.dart)
- Progreso de lecciones por sesión (Riverpod)
- **Grado seleccionado persistente** en SharedPreferences (sobrevive reinicios)
- Dashboard parental: resumen por hijo, actividad semanal, avance por unidad
- **JUEGO G4 — La Aventura del Cuarto Grado** (Flame 1.37 — T-01 a T-27 ✅)
  - Domain: `GameQuestion`, `GameResult` (toLessonResult) + sealed BLoC events/states
  - GameBloc: score × multiplicador de racha, vidas, **correctAnswersCount preciso**, _maxLevel=8
  - GameQuestionsProvider: **80 ejercicios MC mapeados a 8 niveles** (grados 4° y 5°)
  - Componentes Flame canvas-drawn: cielo degradado + nubes animadas + colinas parallax, personaje colombiano animado con camiseta tricolor, bloques morado/azul/verde/rojo
  - `G4AdventureGame`: detección de hit por proximidad, stream listener con fix race condition, **sin hack Future.delayed**
  - Overlays Flutter: `HudOverlay`, `QuestionOverlay`, `GameOverOverlay`, `LevelCompleteOverlay`, **`GameCompleteOverlay` dedicado**
  - Screens: `GamePlayScreen`, `GameLevelSelectScreen` (grid 2×4), `GameResultScreen`
  - Rutas: `/games/g4-adventure`, `/games/g4-adventure/play/:level`, `/games/g4-adventure/result`
  - Banner `_GamesBanner` en HomeScreen con animación
- **DI con get_it**: 6 registros (AuthRepository, ApiClient, AuthCubit, LessonBloc, GameBloc)
- **Guards de ruta**: GoRouter.redirect verificando AuthCubit.state por rol (público/padre/niño)
- **Widgets compartidos**: ep_button (con Semantics), ep_card, xp_bar, streak_badge, heart_indicator, confetti_overlay
- **Strings centralizados**: EduPlayStrings en core/l10n/app_strings.dart (preparación para .arb)
- **Tests unitarios**: 33 tests pasando (10 lesson_bloc, 11 game_bloc, 11 game_questions_provider, 1 widget placeholder)
- **Assets duplicados eliminados**: solo quedan assets/images/games/g4/ y assets/audio/games/g4/

### Próximo (según roadmap)
- Persistir lessonProgressProvider en SharedPreferences
- Conectar api_client.dart con auth-service real (Bloque 11)
- Assets pixel-art finales para el juego (Fase 5 del plan G4)
- Implementar features profile/ y gamification/
- Implementar pantallas placeholder: Logros, Ranking, Configuración

### Blockers
- Backend sin implementar → todo el frontend corre con datos mock
- Assets de sprites placeholder (64×64 color sólido) — requieren pixel-art final
- MP3 de audio vacíos (0 bytes) — requieren SFX reales

## Estado técnico

- **Build**: ✅ Compila (web + APK debug)
- **Linter**: ✅ 0 errores, 162 info/warning (withOpacity deprecado, prefer_const)
- **Tests**: ✅ 33 tests, todos pasando
- **Cobertura**: Parcial (lesson_bloc, game_bloc, game_questions_provider)
- **Último deploy**: nunca
- **Errores conocidos**: ninguno
- **Deuda técnica**:
  - `lessonProgressProvider` solo persiste en memoria (no SharedPreferences)
  - Game progress (niveles completados) no persiste entre sesiones
  - Datos mock en `home_screen.dart` y `auth_cubit.dart`
  - `api_client.dart` existe pero no se usa
  - Drift listado en pubspec.yaml pero sin implementar (offline-first pendiente)
  - Features `profile/`, `gamification/`, `settings/` sin implementar
  - Pantallas placeholder (`/achievements`, `/leaderboard`, `/settings`)
  - 162 issues info-level (limpiar con `dart fix --apply`)
