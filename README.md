# EduPlay — Flutter Frontend

App educativa gamificada para niños colombianos de primaria. Similar a Duolingo pero alineada con el currículo del MEN (Ministerio de Educación Nacional de Colombia).

## Specs
- [Arquitectura Flutter](../specs/frontend/flutter-arch.md)
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

## Análisis estático

```bash
flutter analyze
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
| Home del niño | ✅ Implementado (mock) |
| Camino de lecciones (Duolingo) | ✅ Implementado |
| Ejercicios (múltiple choice, completar, arrastrar) | ✅ Implementado |
| Pantalla de resultados | ✅ Implementado |
| 15 lecciones de Matemáticas (DBA MEN) | ✅ Implementado |
| Dashboard parental | ⏳ Pendiente |
| Conexión con backend real | ⏳ Pendiente |
| Offline support | ⏳ Pendiente |

## Estructura del proyecto

```
lib/
  core/          → DI, red, router, tema
  features/
    auth/        → autenticación padre y niño
    home/        → pantalla principal
    lesson/      → lecciones y ejercicios
    subjects/    → unidades y camino de aprendizaje
    onboarding/  → flujo de bienvenida
  shared/        → widgets reutilizables
```

## Contribuir

Seguir la metodología SDD: toda feature nueva necesita su spec en `/specs` antes de implementar.
Ver [SPEC_BACKLOG.md](../SPEC_BACKLOG.md) para el backlog priorizado.
