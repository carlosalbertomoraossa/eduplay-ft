---
spec-version: 1.0.0
type: integration-status
status: draft
owner: equipo-frontend
last-updated: 2026-08-17
consumed-by: eduplay (backend)
related-specs:
  - flutter-arch.md
  - ../../specs/domains/auth/spec.md
  - ../../specs/domains/learning/spec.md
  - ../SPEC_BACKLOG.md
---

# Frontend — Estado real para el Backend

> **Lo mantiene el frontend.** El backend lo lee para saber qué contrato debe cumplir para que el frontend pueda dejar de usar mocks sin refactor, y qué feature del frontend queda desbloqueada al terminar cada servicio.
>
> Actualizar este archivo cuando un mock cambie de forma, o cuando algo pase de mock a datasource real — no dejar que quede desincronizado del código.

## Resumen: todo corre sobre mocks hoy

`ApiClient` (`lib/core/network/api_client.dart`) es un cliente Dio real, con interceptor de auth y logging, **registrado en DI pero sin ningún repositorio que lo use todavía**. Los 3 puntos de mock activos:

| Área | Mock | Contrato que asume |
|---|---|---|
| Auth | `MockAuthRepository` (`lib/features/auth/data/repositories/mock_auth_repository.dart`) | Ver sección "Contrato de auth" abajo |
| Lecciones | `CurriculumData` (`lib/features/lesson/data/curriculum_data.dart` — 75 lecciones hardcoded) | Ver sección "Contrato de learning" abajo |
| Dashboard parental | Datos hardcoded en `parent_dashboard_screen.dart` / `child_progress_screen.dart` | Agregado de progress + gamification por hijo |

Antes de que el backend declare un servicio 🟢 en `../eduplay/specs/backend-status.md`, el frontend seguirá con estos mocks — no tiene sentido que el backend intente coordinar timing con el frontend para esto, es una migración explícita por tarea (`F1`, `11.8`, etc. en `SPEC_BACKLOG.md`).

## Contrato de auth (lo que `AuthRepository` espera)

```dart
// lib/features/auth/domain/repositories/auth_repository.dart
Future<AuthTokens> loginParent({required String email, required String password});
Future<AuthTokens> loginChild({required String childId, required String pin});
Future<void> register({required String email, required String password, required bool consentGiven});
Future<List<ChildProfile>> getChildren();
Future<void> logout();
```

```dart
// lib/features/auth/domain/entities/auth_entities.dart
class AuthTokens {
  String accessToken; String refreshToken; String actorType; // 'parent' | 'child'
  String actorId;
}
class ChildProfile {
  String id; String displayName; int grade; // 1-5
  String avatarId; String avatarUrl;
}
class ParentAccount {
  String id; String email; String subscriptionTier; List<ChildProfile> children;
}
```

### ✅ Gap cerrado (2026-08-17) — antes avisado también en `eduplay/specs/backend-status.md`

`register()` ya recibe `consentGiven: bool` (antes solo `email`/`password`). Se agregó junto con la pantalla `ParentRegisterScreen` (`10.15` en `SPEC_BACKLOG.md`), que antes no existía — el link "Regístrate" navegaba a una ruta rota. El formulario exige el checkbox de consentimiento parental marcado antes de poder enviar, alineado con el `enum: [true]` que el OpenAPI exige en `consent_given`.

**Pendiente para cuando el backend implemente `2.5`/`2.6`**: mapear el nombre exacto del campo — el frontend usa `consentGiven` (camelCase, convención Dart) y el OpenAPI usa `consent_given` (snake_case); el datasource remoto de `10.7` deberá hacer esa conversión al serializar el request.

Fuera de eso, `AuthTokens`/`ChildProfile` calzan 1:1 con `AuthTokensResponse`/`ChildProfileResponse` del OpenAPI — bajo riesgo de reshape.

## Contrato de learning (lo que `CurriculumData` simula)

```dart
// lib/features/lesson/domain/entities/lesson.dart
class Lesson {
  String id; String unitId; int orderNum; String title;
  LessonType type; // intro | standard | boss | review
  int estimatedMinutes; int xpReward; int coinReward;
  Difficulty difficulty; // easy | medium | hard
  List<Exercise> exercises; bool isLocked; bool isCompleted;
}
class Exercise {
  String id; int orderNum;
  ExerciseType type; // multipleChoice | dragDrop | fillBlank | match | sort | draw
  Map<String, dynamic> content; String? hint; Map<String, String> mediaUrls;
}
class LessonResult {
  String lessonId; double score; // 0.0–1.0, isCompleted = score >= 0.70
  bool isCompleted; int exercisesCorrect; int exercisesTotal;
  int xpEarned; int coinsEarned; int? newLevel; List<String> achievementsUnlocked;
}
```

Las 75 lecciones reales (grados 1°-5°, alineadas a DBA MEN) están en `lib/features/lesson/data/curriculum_grade1-5.dart` — son el dataset candidato para portar directo a los seeds de `learning-service` (tareas `3.8-3.10` en `eduplay/SPEC_BACKLOG.md`), evita rehacer el contenido en Python.

## Qué queda desbloqueado en el frontend por cada servicio backend

| Servicio backend (🟢) | Tarea frontend que se desbloquea |
|---|---|
| auth-service | `10.7`, `F1` — reemplazar `MockAuthRepository` |
| learning-service | `11.8` — datasource remoto de lecciones |
| progress-service | `12.5`, `12.6` — dashboard parental con datos reales |
| gamification-service | `12.1`, `12.2` — Logros/Ranking con datos reales |
| parent-service | `12.7` — controles parentales persistentes |
| content-service | `11.15`, `13.6` — cache offline y audio narrativo |

## Tareas frontend que NO dependen de nada del backend

`F2` (tests auth, ✅ hecho), `F3` (limpieza `flutter analyze`, ✅ hecho), `F4` (Lumi/Drift, ✅ hecho — dependencias fantasma quitadas de `pubspec.yaml`, ver más abajo), UI-only de `12.1/12.2/12.7` con datos mock, `12.8` (tests de integración contra mocks) — ver `SPEC_BACKLOG.md` para el detalle completo.

## Dependencias removidas (2026-08-17)

`drift`, `drift_dev`, `lottie`, `sqlite3_flutter_libs`, `path_provider`, `path` se quitaron de `pubspec.yaml` — estaban declaradas sin ninguna línea de código real usándolas (ver `F4`). Si el backend nota que `11.3` (Lumi) o `11.15` (offline) siguen `⏳ PENDIENTE` en el backlog, es intencional: se retoman cuando haya una decisión de producto (Lumi) o cuando `7.6` del backend (bundle manifest de content-service) exista (offline).
