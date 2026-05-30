# STATUS — eduplay-ft — 2026-05-29

## Estado funcional

### Completado
- Splash screen con animación de entrada
- Onboarding (3 pantallas con ilustraciones)
- Login padre con email/contraseña (mock)
- Selector de perfil de niño con acceso a panel parental
- **Home del niño**: selector de grado (1°–5°), barra de avance, estrellas/monedas, streak, banner "Juegos"
- **UnitsScreen dinámico por grado** — lee `selectedGradeProvider`
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
- Progreso persistente por sesión (Riverpod)
- Dashboard parental: resumen por hijo, actividad semanal, avance por unidad
- **JUEGO 16 — La Aventura del Cuarto Grado** (Flame 1.37 — T-01 a T-24 ✅)
  - Domain: `GameQuestion`, `GameResult` (toLessonResult) + sealed BLoC events/states
  - GameBloc: score × multiplicador de racha, vidas, nivel, LevelComplete / GameOver / GameComplete
  - GameQuestionsProvider: mapeo CurriculumData → GameQuestion por nivel (8 niveles, progresión temática)
  - Componentes Flame **canvas-drawn** (sin PNGs): cielo degradado + nubes animadas + colinas parallax, personaje colombiano animado con camiseta tricolor, bloques morado/azul/verde/rojo
  - `G4AdventureGame` (FlameGame): detección de hit por proximidad (no colisión Flame), stream listener con fix race condition (procesa estado actual al iniciar)
  - Overlays Flutter: `HudOverlay` (nivel centrado, corazones arriba-derecha), `QuestionOverlay` (card animada con 3 botones táctiles + feedback), `GameOverOverlay`, `LevelCompleteOverlay`
  - Screens: `GamePlayScreen`, `GameLevelSelectScreen` (grid 2×4), `GameResultScreen`
  - Rutas: `/games/g4-adventure`, `/games/g4-adventure/play/:level`, `/games/g4-adventure/result`
  - Banner `_GamesBanner` en HomeScreen con animación

### En curso
- Verificación visual del flujo completo del juego G4 (bloque V → pregunta → respuesta → reset)
- T-25, T-26: Tests unitarios GameBloc + GameQuestionsProvider (pendientes)
- T-27: flutter analyze global + limpieza final

### Próximo (según roadmap)
- Smoke-test: verificar CurriculumData.getLesson(id) ≠ null para los 75 IDs (Feature 13)
- Conectar api_client.dart con auth-service real (Bloque 11)
- Assets pixel-art finales para el juego (Fase 5 del plan G4)

### Blockers
- Backend sin implementar → todo el frontend corre con datos mock
- Assets de sprites placeholder (64×64 color sólido) — requieren pixel-art final
- MP3 de audio vacíos (0 bytes) — requieren SFX reales

## Estado técnico

- **Build**: ✅ Compila (web + APK debug verificado en sesiones anteriores)
- **Linter**: ✅ Sin errores — todos los archivos del juego analizados individualmente
- **Tests**: ⚠️ Solo widget_test.dart auto-generado; T-25/T-26 pendientes
- **Cobertura**: N/A
- **Último deploy**: nunca
- **Errores conocidos**: ninguno
- **Deuda técnica**:
  - Assets placeholder en `assets/games/g4/` (PNGs 64×64 sólidos, MP3s vacíos)
  - Datos mock en `home_screen.dart` y `auth_cubit.dart`
  - `api_client.dart` existe pero no se usa
  - `widget_test.dart` auto-generado falla (MyApp no existe)
  - Progreso de niveles del juego no persiste entre sesiones (SharedPreferences pendiente)
