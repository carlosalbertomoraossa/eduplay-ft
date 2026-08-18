---
spec-version: 1.0.0
type: game-feature-spec
status: approved
owner: equipo-frontend
last-updated: 2026-05-28
related-specs:
  - specs/games/mechanics.md
  - specs/domains/learning/curriculum-men.md
  - specs/domains/gamification/spec.md
  - specs/frontend/flutter-arch.md (eduplay-ft/specs/flutter-arch.md)
dba-alignment:
  - DBA-MAT-G4-N2 (Multiplicación y división hasta 3 cifras)
  - DBA-MAT-G4-N3 (Fracciones equivalentes, propias e impropias)
  - DBA-MAT-G4-N4 (Decimales en contextos de medida y dinero COP)
---

# JUEGO 16 — "La Aventura del Cuarto Grado"
**Materia**: Matemáticas | **Grado**: 4° | **Tipo**: Plataformas 2D (estilo Mario Bros)

---

## 1. Objetivo pedagógico

Reforzar los tres ejes del currículo MEN para Grado 4° a través de mecánica de plataformas:
- Fracciones (equivalencias, propias/impropias)
- Multiplicación y división con hasta 2 cifras
- Decimales y operaciones con pesos colombianos (COP)

El niño practica cálculo mental en contexto lúdico de alta motivación. La mecánica de golpear bloques es la metáfora directa de "activar" el conocimiento.

---

## 2. Concepto visual

Mundo 2D de scroll horizontal estilo pixel-art con ambientación colombiana:

| Elemento | Descripción |
|----------|-------------|
| Escenario | Colinas verdes, castillo al fondo, suelo de tierra tipo Mario |
| Personaje | Niño colombiano en pixel-art (usa el avatar seleccionado en onboarding) |
| Fondo | Cielo azul, árboles tropicales, nubes blancas |
| Paleta | Verde esmeralda, azul cielo, marrón tierra, morado para bloques |

**HUD (cabecera)**:
```
SCORE: 1250    LEVEL: 10%    VIDAS: 3    [★]
```

**Pregunta activa** (burbuja de pensamiento sobre el personaje):
```
7 × 8 = ?
```

**Bloques en pantalla**:
- 1 "Bloque de Valores" morado con "V" (se golpea desde abajo para revelar la pregunta)
- 3 bloques de respuesta flotantes con los valores: `54` `56` `63`

---

## 3. Mecánica de juego

### 3.1 Flujo por ronda

```
Inicio de nivel
    ↓
Personaje corre automáticamente (auto-scroll suave)
    ↓
Aparece Bloque de Valores (morado con "V")
    ↓
Jugador salta y golpea el bloque desde abajo
    ↓
Bloque se rompe → aparece la pregunta en burbuja
    ↓
3 bloques de respuesta flotan a la derecha
    ↓
Jugador salta y golpea el bloque correcto
    ↓
  ┌── Correcto → ✅ +score, +XP, animación celebración, siguiente bloque
  └── Incorrecto → ❌ -1 vida, bloque rojo vibra, burbuja muestra respuesta correcta
    ↓
Nivel completo cuando se responden N preguntas seguidas
```

### 3.2 Controles (mobile + web)

| Plataforma | Saltar | Moverse izq/der |
|-----------|--------|----------------|
| Mobile | Tap en pantalla | Botones virtuales izq/der |
| Web/Chrome | Barra espaciadora o ↑ | ← → |

> El personaje tiene movimiento automático hacia la derecha por defecto. El jugador solo necesita controlar el salto para golpear bloques. Esto reduce la carga cognitiva y permite que el foco esté en la respuesta.

### 3.3 Sistema de vidas y score

| Evento | Efecto |
|--------|--------|
| Respuesta correcta | +100 puntos base × multiplicador de racha |
| Racha de 3 correctas | ×2 multiplicador activado (visual: fuego dorado) |
| Racha de 5 correctas | ×3 multiplicador + vida extra |
| Respuesta incorrecta | -1 vida, multiplicador resetea a ×1 |
| 0 vidas | Pantalla "Game Over" con opción de reintentar |
| Nivel completado | +500 puntos bonus + XP según dificultad |

**Vidas iniciales**: 3  
**Máximo vidas acumulables**: 5

### 3.4 Progresión de nivel

Cada nivel tiene **10 preguntas**. El nivel avanza al contestar las 10.

| Nivel | Dificultad | Contenido | Tiempo por pregunta |
|-------|-----------|-----------|---------------------|
| 1 | Fácil | Multiplicar por decenas (30×6, 50×4) | Sin tiempo |
| 2 | Fácil | Fracciones básicas (½, ¼, ⅓) | Sin tiempo |
| 3 | Medio | Multiplicación 2×2 cifras (23×14) | 20 segundos |
| 4 | Medio | Fracciones equivalentes (1/2 = ?/4) | 20 segundos |
| 5 | Medio | Decimales básicos (0.3, 0.7, 1.5) | 20 segundos |
| 6 | Difícil | Divisiones con residuo (17÷5) | 15 segundos |
| 7 | Difícil | Precios COP (suma/resta con decimales) | 15 segundos |
| 8 | Maestro | Mix de los 3 ejes | 10 segundos |

---

## 4. Banco de preguntas por nivel

Las preguntas vienen del `CurriculumData` existente en `curriculum_data.dart`. Se mapean los ejercicios de tipo `multipleChoice` y `fillBlank` de las lecciones 401–415.

### Mapeo lección → nivel de juego

| Lecciones origen | Nivel de juego | Tipo ejercicio usado |
|------------------|---------------|---------------------|
| lesson-401 a 403 (fracciones) | Niveles 2 y 4 | `multipleChoice` |
| lesson-406 a 407 (mult.) | Niveles 1 y 3 | `multipleChoice` |
| lesson-408 (div. con residuo) | Nivel 6 | `multipleChoice` |
| lesson-411 a 413 (decimales) | Niveles 5 y 7 | `multipleChoice` |
| lesson-414 (precios COP) | Nivel 7 | `multipleChoice` |
| lesson-404 (fracciones equiv.) | Nivel 4 | `multipleChoice` |

> Solo se usan ejercicios `multipleChoice` con exactamente 4 opciones. Los bloques flotantes muestran 3 de las 4 opciones (descartando 1 distractor para reducir dificultad en niveles 1–2, o mostrando las 3 más cercanas al resultado correcto para niveles 5–8).

---

## 5. Estructura de datos del juego

### 5.1 GameQuestion

```dart
class GameQuestion {
  final String id;          // referencia al Exercise.id de CurriculumData
  final String question;    // "7 × 8 = ?"
  final List<String> options;  // exactamente 3 opciones para los bloques
  final int correctIndex;   // índice de la respuesta correcta (0, 1 o 2)
  final int xpReward;       // XP al responder correctamente
  final Difficulty difficulty;
}
```

### 5.2 GameState

```dart
class GameState {
  final int score;
  final int lives;           // 1–5
  final int currentLevel;    // 1–8
  final int questionsAnswered;  // 0–10 por nivel
  final int streakCount;     // racha actual
  final int scoreMultiplier; // 1, 2 o 3
  final bool isGameOver;
  final bool isLevelComplete;
}
```

### 5.3 GameResult (al completar o perder)

```dart
class GameResult {
  final int finalScore;
  final int levelsCompleted;
  final int questionsCorrect;
  final int questionsTotal;
  final int xpEarned;
  final int coinsEarned;
  final bool isHighScore;
}
```

---

## 6. Arquitectura Flutter — Flame Engine

El juego usa **Flame** (`flame: ^1.x`) como motor de juego 2D sobre Flutter.

### 6.1 Estructura de archivos

```
lib/features/games/
  g4_adventure/
    data/
      game_questions_provider.dart   → convierte CurriculumData en GameQuestion[]
    domain/
      game_state.dart
      game_question.dart
      game_result.dart
    presentation/
      game_screen.dart               → FlameGame wrapper (Scaffold + GameWidget)
      components/
        player_component.dart        → sprite del niño, físicas de salto
        value_block_component.dart   → bloque morado "V" (golpeable desde abajo)
        answer_block_component.dart  → bloque flotante de respuesta (x3)
        hud_component.dart           → score, vidas, level (overlay Flutter)
        question_bubble_component.dart → burbuja de pregunta sobre el personaje
        background_component.dart    → scroll parallax (cielo, colinas, suelo)
      bloc/
        game_bloc.dart               → lógica de score, vidas, racha, progresión
      screens/
        game_over_screen.dart
        level_complete_screen.dart
        game_result_screen.dart      → integra con LessonResultScreen (XP/monedas)
```

### 6.2 Dependencias a agregar en pubspec.yaml

```yaml
dependencies:
  flame: ^1.18.0          # motor de juego 2D
  flame_bloc: ^1.4.0      # integración Flame + BLoC
```

### 6.3 Integración con sistema de progreso existente

Al completar el juego, `GameResult` se convierte en `LessonResult` equivalente:

```dart
// game_result_screen.dart
final lessonResult = LessonResult(
  lessonId: 'game-g4-adventure-${level}',
  score: gameResult.questionsCorrect / gameResult.questionsTotal,
  isCompleted: gameResult.questionsCorrect / gameResult.questionsTotal >= 0.7,
  xpEarned: gameResult.xpEarned,
  coinsEarned: gameResult.coinsEarned,
  achievementsUnlocked: [],
);
// Navegar a LessonResultScreen existente con este resultado
```

---

## 7. Ruta de navegación

Ruta nueva en `app_router.dart`:

```
/games/g4-adventure           → GameScreen (selector de nivel)
/games/g4-adventure/play/:level → GamePlayScreen (Flame GameWidget)
```

Punto de entrada desde `HomeScreen` del niño → nueva sección "Juegos" en el grid de materias.

---

## 8. Assets requeridos

| Asset | Descripción | Formato |
|-------|-------------|---------|
| `assets/games/g4/player_idle.png` | Spritesheet niño en reposo (4 frames) | PNG 64×64px |
| `assets/games/g4/player_run.png` | Spritesheet niño corriendo (8 frames) | PNG 64×64px |
| `assets/games/g4/player_jump.png` | Spritesheet salto (4 frames) | PNG 64×64px |
| `assets/games/g4/block_value.png` | Bloque morado "V" | PNG 64×64px |
| `assets/games/g4/block_answer.png` | Bloque de respuesta (azul/verde/rojo por estado) | PNG 64×64px |
| `assets/games/g4/bg_sky.png` | Fondo cielo (tile) | PNG 1920×360px |
| `assets/games/g4/bg_hills.png` | Colinas media distancia (parallax) | PNG 1920×200px |
| `assets/games/g4/bg_ground.png` | Suelo (tile) | PNG 64×32px |
| `assets/games/g4/sfx_correct.mp3` | Sonido respuesta correcta | MP3 <100KB |
| `assets/games/g4/sfx_wrong.mp3` | Sonido respuesta incorrecta | MP3 <100KB |
| `assets/games/g4/sfx_jump.mp3` | Sonido salto | MP3 <50KB |
| `assets/games/g4/sfx_block_hit.mp3` | Sonido golpear bloque | MP3 <50KB |
| `assets/games/g4/music_theme.mp3` | Música de fondo (loop) | MP3 <500KB |

> Los sprites pueden ser pixel-art generado con herramientas gratuitas (Piskel, Aseprite).  
> Estilo: 64×64px, paleta limitada, sin violencia.

---

## 9. Criterios de aceptación

### Funcionales
- [ ] El personaje salta al tocar pantalla / presionar espacio
- [ ] Al golpear el Bloque de Valores desde abajo, aparece la pregunta en burbuja
- [ ] Los 3 bloques de respuesta flotan y son golpeables
- [ ] Respuesta correcta: animación verde + score aumenta + sigue el juego
- [ ] Respuesta incorrecta: animación roja + vida se resta + muestra respuesta correcta 2s
- [ ] Con 0 vidas aparece GameOver con opción "Intentar de nuevo"
- [ ] Al completar 10 preguntas del nivel, aparece pantalla de nivel completado
- [ ] Score multiplier ×2 se activa con racha de 3 correctas (visual de fuego)
- [ ] Al terminar el juego, XP y monedas se integran al perfil del niño
- [ ] Las preguntas vienen de `CurriculumData` (lecciones 401–415)

### Técnicos
- [ ] `flutter analyze` sin errores ni warnings en código de producción
- [ ] 60 FPS en Chrome (`flutter run -d chrome`)
- [ ] 30 FPS mínimo en dispositivo Android de gama media (Moto G4)
- [ ] Tiempo de carga del nivel < 2 segundos
- [ ] No memory leaks al salir del juego y volver al home

### Pedagógicos
- [ ] Todas las preguntas son de Grado 4° (lecciones 401–415)
- [ ] Ningún ejercicio de tipo `dragDrop` se usa (solo `multipleChoice`)
- [ ] El feedback de respuesta incorrecta muestra la respuesta correcta por 2 segundos
- [ ] Los distractores son plausibles (no trivialmente incorrectos)

---

## 10. Extensión a otros grados (post-MVP)

El mismo motor de juego sirve para todos los grados cambiando el banco de preguntas:

| Versión | Grado | Lecciones fuente | Nombre del mundo |
|---------|-------|-----------------|-----------------|
| v1.0 | 4° | 401–415 | El Castillo de las Fracciones |
| v1.1 | 3° | 301–315 | La Selva de los Números |
| v1.2 | 2° | 201–215 | La Granja de las Tablas |
| v1.3 | 5° | 501–515 | La Montaña de los Enteros |
| v2.0 | 1° | 001–015 | El Pueblo de los Números |

La arquitectura de `GameQuestionsProvider` recibe el `grade` como parámetro, haciendo trivial la extensión.

---

## 11. Integración en SPEC_BACKLOG.md

Este feature corresponde a un nuevo ítem en el Bloque 12:

```
| 12.9 | Juego: "La Aventura del Cuarto Grado" (plataformas 2D) | eduplay-ft/lib/features/games/g4_adventure/ | ⏳ PENDIENTE |
```
