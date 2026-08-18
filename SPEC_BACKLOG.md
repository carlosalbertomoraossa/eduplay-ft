# EduPlay Frontend — Backlog de Specs

> Metodología SDD. Los contratos compartidos (ADRs, domain specs, OpenAPI, AsyncAPI, database schema) viven centralizados en `../specs/` (raíz del monorepo) — son la fuente de verdad entre back y front. Este backlog es el seguimiento de ejecución **propio del frontend**, no se mezcla con el del backend.
>
> - Tu contraparte (backend) lee tu estado real en [`specs/frontend-status.md`](specs/frontend-status.md) — **actualízalo cada vez que un mock cambie o se conecte algo real** (no basta con marcar aquí, el backend no lee este archivo).
> - Para saber qué expone hoy el backend (qué servicio ya se puede integrar sin usar mock), lee `../eduplay/specs/backend-status.md`.
> - Decisiones de producto y bloques cross-repo (testing E2E, lanzamiento) están en `../SPEC_BACKLOG.md` (raíz).
> - Ver también `STATUS.md` (bitácora técnica interna) y `MEMORY.md` (decisiones de diseño) — ninguno de los dos reemplaza a este backlog ni a `specs/frontend-status.md`.

**Leyenda de estado**:
- `📋 SPEC LISTA` — spec escrita y aprobada, lista para implementar
- `🔨 EN CURSO` — en implementación activa
- `✅ IMPLEMENTADO` — código existe y pasa tests
- `⏳ PENDIENTE` — spec aún no escrita
- `🚫 BLOQUEADO` — depende de otro ítem sin completar

**Leyenda de dependencia cross-repo**:
- 🔓 **INDEPENDIENTE** — no requiere nada del backend, se puede ejecutar en cualquier momento (incluye todo lo que hoy corre sobre mock)
- 🔗 **DEPENDE DE** `<id>` (backend) — bloqueada hasta que esa tarea del backend esté hecha; ver `../eduplay/specs/backend-status.md` para confirmar el estado real antes de empezar

---

## 🔍 Auditoría de realidad — 2026-08-17

Código real auditado (ver detalle completo en `../SPEC_BACKLOG.md`):

- `flutter analyze`: 0 errores, 159 warnings/infos (APIs deprecadas `withOpacity`/`scale`, `prefer_const_constructors`, 1 import sin usar). **Resuelto en `F3` (2026-08-17) → ahora 0 issues.**
- `flutter test`: 33/33 tests verdes originalmente (`lesson_bloc`, `game_bloc`, `game_questions_provider`). **`F3` encontró que buena parte de las aserciones de `game_bloc_test`/`lesson_bloc_test` eran no-ops (bug de cascade `..having`) — corregido.** Tras sumar `F2` (tests de auth) y `F5` (tests de gamificación/settings), el proyecto quedó en **86 tests, todos verdes**.
- Dependencias "fantasma" en `pubspec.yaml`: `drift`/`drift_dev` (11.15, offline) y `lottie` (11.3, Lumi) declaradas sin una sola línea de código que las use. **Resuelto en `F4` (2026-08-17)** — se quitaron, junto con `sqlite3_flutter_libs`/`path_provider`/`path` (soporte exclusivo de Drift, también sin uso real). Carpetas vacías que dan falsa sensación de avance: `lib/core/storage/`, `lib/features/gamification/`, `lib/features/settings/`, `integration_test/`.
- Todo el frontend corre sobre mocks: `ApiClient` (Dio real, con interceptores) registrado en DI pero nunca conectado. Detalle completo de qué simula cada mock y qué contrato asume en `specs/frontend-status.md`.
- El backend está funcionalmente en cero — ningún servicio arranca hoy. Antes de conectar cualquier feature a datos reales, confirmar en `../eduplay/specs/backend-status.md` que el servicio correspondiente ya está 🟢.

---

## BLOQUE 1.4 — CI/CD Flutter

| # | Spec / Tarea | Archivo | Estado | Dependencia |
|---|-------------|---------|--------|--------------|
| 1.4 | CI/CD — pipeline Flutter (GitHub Actions) | `../.github/workflows/ci-flutter.yml` | ✅ IMPLEMENTADO (pipeline real: tests + analyze funcionan) | 🔓 INDEPENDIENTE |

---

## BLOQUE 10 — Flutter: Core y Auth

| # | Spec / Tarea | Archivo | Estado | Dependencia |
|---|-------------|---------|--------|--------------|
| 10.1 | Spec arquitectura Flutter | `specs/flutter-arch.md` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.2 | Tema EduPlay (colores, tipografía, componentes) | `lib/core/theme/app_theme.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.3 | Router (GoRouter, guardias de ruta) | `lib/core/router/app_router.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.4 | API Client (Dio + interceptor auth) | `lib/core/network/api_client.dart` | ✅ IMPLEMENTADO ⚠️ (existe pero no está conectado a nada, registrado en DI sin uso real) | 🔓 INDEPENDIENTE |
| 10.5 | DI setup (GetIt + Injectable) | `lib/core/di/injection.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.6 | Feature auth — entidades y repositorio (interfaz) | `lib/features/auth/domain/` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.7 | Feature auth — datasource remoto (auth-service API) | `lib/features/auth/data/` | 🔨 EN CURSO (mock implementado, remoto pendiente) | 🔗 DEPENDE DE: `B5` (backend, ver `eduplay/SPEC_BACKLOG.md`) |
| 10.8 | Feature auth — Cubit (login padre, login niño) | `lib/features/auth/presentation/` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.9 | Pantalla: Splash | `lib/features/auth/presentation/screens/splash_screen.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.10 | Pantalla: Onboarding (3 pasos) | `lib/features/onboarding/` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.11 | Pantalla: Login padre | `lib/features/auth/presentation/screens/parent_login_screen.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.12 | Pantalla: Selector de niño (PIN) | `lib/features/auth/presentation/screens/child_selector_screen.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 10.13 | Persistencia local de tokens (Flutter Secure Storage) | `lib/core/storage/` | ⏳ PENDIENTE — carpeta existe pero vacía, `flutter_secure_storage` no está en pubspec | 🔓 INDEPENDIENTE (se puede implementar sin backend real, guardando tokens mock) |
| 10.14 | Tests widgets: auth screens | `test/features/auth/` | ✅ IMPLEMENTADO (2026-08-17) — 34 tests: `bloc/auth_cubit_test.dart` (11), `screens/splash_screen_test.dart` (3), `screens/parent_login_screen_test.dart` (9), `screens/child_selector_screen_test.dart` (6), `screens/parent_register_screen_test.dart` (7) | 🔓 INDEPENDIENTE |
| 10.15 | Pantalla de registro (`/auth/register`) — no existía, el link "Regístrate" de `parent_login_screen.dart` navegaba a una ruta inexistente | `lib/features/auth/presentation/screens/parent_register_screen.dart` | ✅ IMPLEMENTADO (2026-08-17) — formulario con email/contraseña/confirmar + checkbox de consentimiento parental obligatorio (regla COPPA-like del proyecto). `AuthRepository.register()` ahora exige `consentGiven: bool` (cierra el gap ya detectado en `specs/frontend-status.md` contra el OpenAPI); nuevo estado `AuthRegistered` en `AuthCubit`; ruta agregada a `_publicRoutes` en `app_router.dart` | 🔓 INDEPENDIENTE |

---

## BLOQUE 11 — Flutter: Home y Lección

| # | Spec / Tarea | Archivo | Estado | Dependencia |
|---|-------------|---------|--------|--------------|
| 11.1 | Widgets compartidos: EpButton, XpBar, HeartIndicator | `lib/shared/widgets/` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.2 | Widget: StreakBadge (fuego animado) | `lib/shared/widgets/streak_badge.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.3 | Widget: Lumi (personaje guía, Lottie) | `lib/shared/widgets/lumi_character.dart` | ⏳ PENDIENTE (diferido a propósito) — "Lumi" solo existe como texto en copy; sin widget ni animación. `lottie` se quitó de `pubspec.yaml` el 2026-08-17 (decisión P1: no fingir que está en progreso; se retoma en Fase 2 según roadmap) | 🔓 INDEPENDIENTE |
| 11.4 | Widget: ConfettiOverlay (celebración) | `lib/shared/widgets/confetti_overlay.dart` | ✅ IMPLEMENTADO (1 import sin usar de flutter_animate, limpiar) | 🔓 INDEPENDIENTE |
| 11.5 | Pantalla: Home niño (streak, XP, materias) | `lib/features/home/` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.6 | Pantalla: Listado de materias y cursos | `lib/features/subjects/` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.7 | Feature lesson — entidades (Lesson, Exercise, LessonResult) | `lib/features/lesson/domain/` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.8 | Feature lesson — datasource remoto (learning-service API) | `lib/features/lesson/data/` | 🔨 EN CURSO (CurriculumData local implementado, remoto pendiente) | 🔗 DEPENDE DE: `3.6` (backend, routers de learning-service, ver `eduplay/SPEC_BACKLOG.md`) |
| 11.9 | Feature lesson — Bloc (flujo completo de lección) | `lib/features/lesson/presentation/bloc/lesson_bloc.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.10 | Pantalla: Lección (ejercicios, corazones, progreso) | `lib/features/lesson/presentation/screens/lesson_screen.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.11 | Widget: Ejercicio selección múltiple | `lib/features/lesson/presentation/widgets/exercise_multiple_choice.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.12 | Widget: Ejercicio drag & drop | `lib/features/lesson/presentation/widgets/exercise_drag_drop.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.13 | Widget: Ejercicio completar espacio | `lib/features/lesson/presentation/widgets/exercise_fill_blank.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.14 | Pantalla: Resultado de lección (XP, monedas, celebración) | `lib/features/lesson/presentation/screens/lesson_result_screen.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 11.15 | Soporte offline: cache de lecciones (Drift) | `lib/features/lesson/data/datasources/lesson_local_datasource.dart` | ⏳ PENDIENTE (diferido a propósito) — `drift`/`drift_dev`/`sqlite3_flutter_libs`/`path_provider`/`path` se quitaron de `pubspec.yaml` el 2026-08-17 (decisión: el diseño depende de `7.6` en el backend, que ni empezó — construir el cache ahora se rehace después) | 🔗 DEPENDE DE: `7.6` (backend, bundle manifest de content-service) para el diseño final |
| 11.16 | Tests Bloc: lesson_bloc | `test/features/lesson/` | ✅ IMPLEMENTADO (9 tests) | 🔓 INDEPENDIENTE |

---

## BLOQUE 12 — Flutter: Gamificación y Padres

| # | Spec / Tarea | Archivo | Estado | Dependencia |
|---|-------------|---------|--------|--------------|
| 12.1 | Pantalla: Logros (achievements grid) | `lib/features/gamification/presentation/screens/achievements_screen.dart` | ✅ IMPLEMENTADO (2026-08-17, mock) — grid con el catálogo real de 10 logros MVP (`specs/domains/gamification/spec.md`), 4/10 desbloqueados. Accesible desde Home | 🔗 DEPENDE DE: `5.10` (backend, routers gamification) para datos reales |
| 12.2 | Pantalla: Ranking (leaderboard) | `lib/features/gamification/presentation/screens/leaderboard_screen.dart` | ✅ IMPLEMENTADO (2026-08-17, mock) — leaderboard semanal, 8 niños, medallas top 3. Accesible desde Home | 🔗 DEPENDE DE: `5.11` (backend, rankings Redis) para datos reales |
| 12.3 | Animación: Level Up (Lottie) | `assets/animations/level_up.json` | ⏳ PENDIENTE | 🔓 INDEPENDIENTE |
| 12.4 | Animación: Streak milestone | `assets/animations/streak_fire.json` | ⏳ PENDIENTE | 🔓 INDEPENDIENTE |
| 12.5 | Pantalla: Dashboard parental | `lib/features/parent_dashboard/` | ✅ IMPLEMENTADO (mock) | 🔗 DEPENDE DE: `4.7` (backend, routers progress-service) para datos reales — la UI ya está lista |
| 12.6 | Pantalla: Progreso detallado del niño | `lib/features/parent_dashboard/` | ✅ IMPLEMENTADO (mock) | 🔗 DEPENDE DE: `4.7` (backend) para datos reales — la UI ya está lista |
| 12.7 | Pantalla: Configuración y controles parentales | `lib/features/settings/presentation/screens/settings_screen.dart` (niño, ruta `/settings`) y `parent_settings_screen.dart` (padre, ruta nueva `/parent/settings`) | ✅ IMPLEMENTADO (2026-08-17, mock) — se separó en dos rutas porque `/settings` solo estaba en `_childRoutes` y el botón del dashboard parental redirigía de vuelta al dashboard (bug real, corregido). Controles: límite de lecciones/día, horario permitido, ranking público, notificaciones, bloqueo temporal | 🔓 INDEPENDIENTE para UI local; 🔗 DEPENDE DE: `9.5` (backend, parent-service) para persistir controles reales |
| 12.8 | Tests de integración: flujo onboarding → primera lección | `integration_test/` | ⏳ PENDIENTE | 🔓 INDEPENDIENTE (puede correr contra mocks) |
| 12.9 | Juego: "La Aventura del Cuarto Grado" (plataformas 2D Flame) | `lib/features/games/g4_adventure/` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |

---

## BLOQUE 13 — Contenido educativo (MEN Colombia)

> Hoy este contenido vive 100% en el frontend (`curriculum_data.dart`). Cuando el backend implemente `3.8-3.10` (seeds de learning-service, ver `eduplay/SPEC_BACKLOG.md`), este bloque se porta como fuente y el frontend pasa a consumirlo vía API en vez de tenerlo hardcoded.

| # | Tarea | Archivo | Estado | Dependencia |
|---|-------|---------|--------|--------------|
| 13.1 | Spec de alineación curricular MEN | `../specs/domains/learning/curriculum-men.md` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 13.2 | 15 lecciones Matemáticas 1° (DBA verificado con docente) | `lib/features/lesson/data/curriculum_grade1.dart` | ✅ IMPLEMENTADO (contenido en código; verificación con docente sigue pendiente — ver P4 en `../SPEC_BACKLOG.md`) | 🔓 INDEPENDIENTE |
| 13.3 | 15 lecciones Matemáticas 2° | `lib/features/lesson/data/curriculum_grade2.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 13.4 | 15 lecciones Matemáticas 3° | `lib/features/lesson/data/curriculum_grade3.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 13.4b | 15 lecciones Matemáticas 4° | `lib/features/lesson/data/curriculum_grade4.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 13.4c | 15 lecciones Matemáticas 5° | `lib/features/lesson/data/curriculum_grade5.dart` | ✅ IMPLEMENTADO | 🔓 INDEPENDIENTE |
| 13.5 | Assets visuales para ejercicios (ilustraciones niños colombianos) | `assets/images/` | ⏳ PENDIENTE | 🔓 INDEPENDIENTE |
| 13.6 | Audio narrativo Lumi (voz colombiana) | — | ⏳ PENDIENTE | 🔗 DEPENDE DE: `7.x` (backend, content-service) para hosting; el audio en sí se puede grabar antes |
| 13.7 | Animaciones Lottie: celebración, error suave, Lumi | `assets/animations/` | ⏳ PENDIENTE | 🔓 INDEPENDIENTE |
| 13.8 | 8 avatares iniciales para selección del niño | `assets/images/avatars/` | ⏳ PENDIENTE | 🔓 INDEPENDIENTE |

---

## ⚡ PRIORIDAD ACTUAL — conectar a lo real + limpieza

Ver contexto completo en `../SPEC_BACKLOG.md` y `../specs/adrs/ADR-006-vertical-slice-backend.md`.

| # | Tarea | Depende de | Dependencia cross-repo |
|---|-------|-----------|--------------------------|
| F1 | Implementar `flutter_secure_storage`, reemplazar `MockAuthRepository` por datasource real contra `ApiClient` (10.13, 10.7) | — | 🔗 DEPENDE DE: `B5` (backend) — **antes de eso, no tiene sentido empezar** |
| F2 | ✅ HECHO (2026-08-17) — ver 10.14. `AuthCubit` no tenía ningún test (bloc puro, ahora 9 tests, luego 11 con `register`). Route `/auth/register` referenciada por el link "Regístrate" en `parent_login_screen.dart` **no existía** en `app_router.dart` — hallazgo del testing. Resuelto por separado, ver nueva fila `10.15`. | — | 🔓 INDEPENDIENTE |
| F3 | ✅ HECHO (2026-08-17) — `flutter analyze` en 0 issues (era 159). Además corrigió 2 bugs reales encontrados en el camino: `home_screen.dart` pisaba `.state` en vez de llamar `setGrade()` (el grado seleccionado no se persistía); los tests de `game_bloc`/`lesson_bloc` usaban `..having(...)` (cascade) en vez de `.having(...)` (chaining) — como `having()` retorna un matcher nuevo en vez de mutar, el cascade descartaba cada condición y los tests solo verificaban el tipo del estado, nunca los valores de los campos. Corregido en ambos archivos + 1 caso de test con datos matemáticamente imposibles (2/3 no puede ser ≥70%). | — | 🔓 INDEPENDIENTE |
| F4 | ✅ HECHO (2026-08-17) — se quitaron `drift`, `drift_dev`, `lottie` de `pubspec.yaml`, y de paso `sqlite3_flutter_libs`/`path_provider`/`path` (soporte exclusivo de Drift, también sin uso real — `shared_preferences` se mantuvo, sí está en uso). `flutter pub get`/`analyze`/`test` verificados: 0 issues, 70/70 tests. Ambas features quedan como pendientes genuinas (11.3, 11.15), no como dependencias fantasma. | Decisión de Producto (P1 en `../SPEC_BACKLOG.md`) | 🔓 INDEPENDIENTE |
| F5 | ✅ HECHO (2026-08-17) — ver 12.1, 12.2, 12.7. 18 tests de widget nuevos en `test/features/gamification/` y `test/features/settings/`. Agregó accesos de navegación reales a Logros/Ranking desde `home_screen.dart` (antes ninguna pantalla los enlazaba). Resolvió el bug de `/settings` (ver 12.7). | Decisión de alcance (P3 en `../SPEC_BACKLOG.md`) | 🔓 INDEPENDIENTE para UI; 🔗 DEPENDE DE: `5.10`/`9.5` (backend) solo para datos reales |

*Siguiente ítem a iniciar: **F1** — depende de que `eduplay/specs/backend-status.md` marque `auth-service` 🟢. El resto de tareas independientes (F2-F5) ya están hechas.*

---

## Resumen de progreso (frontend)

| Bloque | Total | Spec Lista | En Curso | Implementado |
|--------|-------|-----------|---------|-------------|
| 1.4 CI Flutter | 1 | 0 | 0 | 1 |
| 10. Flutter Core + Auth | 15 | 0 | 1 | 13 |
| 11. Flutter Lección | 16 | 0 | 1 | 13 |
| 12. Flutter Gamif. + Padres | 9 | 0 | 0 | 6 |
| 13. Contenido MEN | 10 | 0 | 0 | 6 |
| **TOTAL FRONTEND** | **51** | **0** | **2** | **39** |
