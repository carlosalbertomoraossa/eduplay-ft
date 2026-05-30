---
spec-version: 1.0.0
type: implementation-plan
domain: learning / frontend
status: approved
owner: equipo-frontend
last-updated: 2026-05-26
related-specs:
  - specs/domains/learning/curriculum-men.md
  - specs/domains/learning/spec.md
  - specs/frontend/flutter-arch.md
---

# Plan de Implementación — Contenido Matemáticas Grados 2°–5° (Flutter)

## Objetivo

Completar el contenido jugable de Matemáticas en el frontend Flutter para los grados 2° a 5°,
alineado con los DBA MEN Colombia. Al terminar, los 75 lesson IDs definidos en
`CurriculumData` tendrán ejercicios reales y el flujo Home → Grado → Unidad → Lección
funcionará end-to-end para todos los grados.

## Estado de partida

| Componente | Estado actual |
|------------|--------------|
| `curriculum_data.dart` — Grado 1° (15 lecciones) | ✅ Completo con ejercicios |
| `curriculum_data.dart` — Grados 2°–5° (60 lecciones) | ⚠️ Stubs: solo título y XP, sin ejercicios |
| `units_screen.dart` | ⚠️ Hardcodeada con unidades de Grado 1°, no lee `selectedGradeProvider` |
| `home_screen.dart` — Selector de grado | ✅ Muestra los 5 grados, navega a units |
| `lessons_screen.dart` — Camino Duolingo | ✅ Genérico, lee cualquier `unitId` |
| `lesson_screen.dart` — Motor de lección | ✅ Genérico, lee cualquier `lessonId` |

## Reglas de implementación

1. **Solo datos, no lógica nueva** — todos los cambios son en `curriculum_data.dart`
   (nuevas entradas en `_allLessons`) y `units_screen.dart` (leer grado dinámico).
2. **Contexto colombiano obligatorio** — los ejercicios usan referentes del MEN:
   pesos COP, frutas tropicales, nombres colombianos, geografía local.
3. **Rangos numéricos por grado** — respetar estrictamente los rangos del DBA:
   - 2°: números ≤ 1.000, operaciones ≤ 100
   - 3°: números ≤ 100.000, multiplicación ≤ 10×10
   - 4°: números ≤ 1.000.000, fracciones, decimales
   - 5°: enteros negativos, porcentajes, proporciones
4. **Tipos de ejercicio disponibles** — `multipleChoice`, `fillBlank`, `dragDrop`
   (son los únicos widgets implementados; no usar `match`, `sort` ni `draw`).
5. **Sin commits parciales** — cada feature se commitea solo cuando compila y
   `flutter analyze` pasa sin errores.

---

## Feature 0 — `units-screen-dynamic`

**Bloqueante:** debe implementarse antes que cualquier otra feature, porque sin este fix
los grados 2°–5° navegan a una pantalla que siempre muestra las unidades de Grado 1°.

**Archivo:** `eduplay-ft/lib/features/subjects/presentation/screens/units_screen.dart`

### Cambios requeridos

- Importar `selected_grade_provider.dart`.
- Leer `ref.watch(selectedGradeProvider)` en el `build`.
- Reemplazar `_unitDefs` hardcodeada por `CurriculumData.getUnitIdsForGrade(grade)`.
- Calcular `order`, `title`, `lessonsTotal` desde `CurriculumData.unitTitles` y
  `CurriculumData.getLessonsForUnit(unitId).length`.
- Actualizar el título del `AppBar` con `CurriculumData.getGradeTitle(grade)`.
- Eliminar la clase `_UnitDef` y la constante `_unitDefs` (ya no se necesitan).
- Actualizar `_isUnlocked` para recibir la lista dinámica de `unitIds`.

### Criterio de aceptación

- Seleccionar Grado 2° en home y navegar a unidades muestra `unit-201`, `unit-202`, `unit-203`.
- Seleccionar Grado 1° muestra `unit-001`, `unit-002`, `unit-003`.
- `flutter analyze` sin errores ni warnings.

---

## Feature 1 — `g2-unit1-numeros-1000`

**DBA:** #1 Grado 2° — "Lee, escribe y ordena números hasta 1.000. Reconoce el valor posicional."
**Unidad:** `unit-201` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-201 | Las centenas | intro | 5 | easy |
| lesson-202 | Leer y escribir hasta 1.000 | standard | 5 | easy |
| lesson-203 | Valor posicional | standard | 5 | medium |
| lesson-204 | Ordenar números hasta 1.000 | standard | 5 | medium |
| lesson-205 | ¡Desafío numérico! | boss | 6 | medium |

### Ejercicios representativos

```
lesson-201 ej.1 (multipleChoice): ¿Cuántas decenas tiene 1 centena?
  opciones: 5 / 10 / 100 / 20 → correcta: 10

lesson-203 ej.2 (fillBlank): En el número 537, el dígito de las centenas es ___
  opciones: 3 / 5 / 7 / 1 → correcta: 5

lesson-204 ej.3 (dragDrop): Ordena de menor a mayor: 850, 508, 805, 580
  mapping correcto: 508 → 1°, 580 → 2°, 805 → 3°, 850 → 4°
```

**Contextos colombianos:** páginas de un libro, precios en tienda de barrio,
número de estudiantes en un colegio.

---

## Feature 2 — `g2-unit2-suma-resta-100`

**DBA:** #2 Grado 2° — "Resuelve y formula problemas de adición y sustracción hasta 100."
**Unidad:** `unit-202` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-206 | Sumar decenas | intro | 5 | easy |
| lesson-207 | Sumar con llevada | standard | 5 | medium |
| lesson-208 | Restar decenas | standard | 5 | easy |
| lesson-209 | Restar con préstamo | standard | 5 | medium |
| lesson-210 | ¡Campeón de operaciones! | boss | 6 | medium |

### Ejercicios representativos

```
lesson-206 ej.1 (multipleChoice): ¿Cuánto es 30 + 40?
  opciones: 60 / 70 / 80 / 50 → correcta: 70

lesson-207 ej.2 (fillBlank): 47 + 36 = ___
  opciones: 72 / 83 / 73 / 84 → correcta: 83

lesson-210 ej.1 (multipleChoice): Camila tenía $65 y gastó $28 en la tienda.
  ¿Cuánto le queda?  opciones: 37 / 47 / 33 / 43 → correcta: 37
```

**Contextos colombianos:** monedas y billetes COP, mercado de frutas, lonchera escolar.

---

## Feature 3 — `g2-unit3-tablas-2-3-5`

**DBA:** #3 Grado 2° — "Comprende la multiplicación como adición repetida. Tablas del 2, 3 y 5."
**Unidad:** `unit-203` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-211 | Grupos iguales | intro | 5 | easy |
| lesson-212 | Tabla del 2 | standard | 5 | easy |
| lesson-213 | Tabla del 3 | standard | 5 | medium |
| lesson-214 | Tabla del 5 | standard | 5 | medium |
| lesson-215 | ¡Desafío de tablas! | boss | 6 | medium |

### Ejercicios representativos

```
lesson-211 ej.1 (multipleChoice): Hay 3 canastas con 4 mangos cada una. ¿Cuántos mangos en total?
  opciones: 7 / 12 / 8 / 10 → correcta: 12

lesson-212 ej.2 (fillBlank): 2 × 7 = ___
  opciones: 12 / 14 / 16 / 9 → correcta: 14

lesson-215 ej.3 (dragDrop): Relaciona cada multiplicación con su resultado
  items: 3×6 / 5×4 / 2×9  targets: 18 / 20 / 18 → mapping correcto
```

**Contextos colombianos:** bandejas de arepas, paquetes de chicles, filas de sillas en el aula.

---

## Feature 4 — `g3-unit1-numeros-100000`

**DBA:** #1 Grado 3° — "Lee, escribe y ordena números hasta 100.000. Representa en recta numérica."
**Unidad:** `unit-301` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-301 | Los miles | intro | 5 | easy |
| lesson-302 | Decenas de mil | standard | 5 | medium |
| lesson-303 | Comparar números grandes | standard | 5 | medium |
| lesson-304 | La recta numérica | standard | 5 | medium |
| lesson-305 | ¡Desafío de números grandes! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-301 ej.1 (multipleChoice): ¿Cuántas unidades hay en 1.000?
  opciones: 100 / 1.000 / 10.000 / 500 → correcta: 1.000

lesson-303 ej.2 (fillBlank): ___ es mayor que 45.000 y menor que 46.000
  opciones: 44.999 / 45.500 / 46.001 / 43.000 → correcta: 45.500

lesson-304 ej.3 (dragDrop): Ubica en la recta: 10.000 / 50.000 / 70.000 / 90.000
```

**Contextos colombianos:** aforo de estadios, habitantes de municipios colombianos,
distancias en carreteras.

---

## Feature 5 — `g3-unit2-tablas-completas`

**DBA:** #3 Grado 3° — "Comprende y aplica las tablas de multiplicar del 1 al 10."
**Unidad:** `unit-302` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-306 | Tablas del 4 y del 6 | intro | 5 | easy |
| lesson-307 | Tablas del 7 y del 8 | standard | 5 | medium |
| lesson-308 | Tabla del 9 | standard | 5 | medium |
| lesson-309 | Propiedad conmutativa | standard | 5 | medium |
| lesson-310 | ¡Campeón de tablas! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-306 ej.1 (multipleChoice): ¿Cuánto es 4 × 7?
  opciones: 24 / 28 / 32 / 21 → correcta: 28

lesson-309 ej.2 (fillBlank): Si 6 × 8 = 48, entonces 8 × 6 = ___
  opciones: 46 / 48 / 56 / 42 → correcta: 48

lesson-310 ej.3 (dragDrop): Relaciona: 7×9 / 8×6 / 9×9  targets: 63 / 48 / 81
```

---

## Feature 6 — `g3-unit3-division-basica`

**DBA:** #4 Grado 3° — "Comprende la división como reparto equitativo y como medida."
**Unidad:** `unit-303` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-311 | ¿Qué es dividir? | intro | 5 | easy |
| lesson-312 | Dividir entre 2 y 3 | standard | 5 | easy |
| lesson-313 | Dividir entre 4 y 5 | standard | 5 | medium |
| lesson-314 | Dividir entre 6, 7 y 8 | standard | 5 | medium |
| lesson-315 | ¡Desafío de división! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-311 ej.1 (multipleChoice): 12 mangos repartidos en 3 canastas iguales. ¿Cuántos por canasta?
  opciones: 3 / 4 / 5 / 6 → correcta: 4

lesson-313 ej.2 (fillBlank): 20 ÷ 4 = ___
  opciones: 4 / 5 / 6 / 8 → correcta: 5

lesson-315 ej.3 (dragDrop): Relaciona: 42÷7 / 36÷6 / 56÷8  targets: 6 / 6 / 7
```

**Contextos colombianos:** repartir obleas, distribuir tareas en grupo, contar filas en un campo.

---

## Feature 7 — `g4-unit1-fracciones`

**DBA:** #3 Grado 4° — "Comprende fracciones equivalentes, propias e impropias."
**Unidad:** `unit-401` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-401 | ¿Qué es una fracción? | intro | 5 | easy |
| lesson-402 | Mitad y cuarto | standard | 5 | easy |
| lesson-403 | Tercios y quintos | standard | 5 | medium |
| lesson-404 | Fracciones equivalentes | standard | 5 | medium |
| lesson-405 | ¡Desafío de fracciones! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-401 ej.1 (multipleChoice): Si divides una pizza en 4 partes iguales y comes 1, ¿qué fracción comiste?
  opciones: 1/2 / 1/4 / 1/3 / 2/4 → correcta: 1/4

lesson-404 ej.2 (fillBlank): 1/2 es equivalente a ___/4
  opciones: 1 / 2 / 3 / 4 → correcta: 2

lesson-405 ej.3 (dragDrop): Relaciona fracciones equivalentes: 1/2 / 2/3 / 3/4  targets: 2/4 / 4/6 / 6/8
```

**Contextos colombianos:** partir bocadillo de guayaba, repartir sancocho, secciones de un mapa.

---

## Feature 8 — `g4-unit2-mult-division`

**DBA:** #2 Grado 4° — "Resuelve problemas de multiplicación y división con hasta 3 cifras."
**Unidad:** `unit-402` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-406 | Multiplicar por decenas | intro | 5 | easy |
| lesson-407 | Multiplicar 2×2 cifras | standard | 5 | medium |
| lesson-408 | Dividir con residuo | standard | 5 | medium |
| lesson-409 | División de 2 cifras | standard | 5 | hard |
| lesson-410 | ¡Campeón de operaciones! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-406 ej.1 (multipleChoice): ¿Cuánto es 30 × 6?
  opciones: 180 / 160 / 200 / 120 → correcta: 180

lesson-407 ej.2 (fillBlank): 24 × 15 = ___
  opciones: 340 / 360 / 380 / 320 → correcta: 360

lesson-408 ej.3 (multipleChoice): ¿Cuánto es 17 ÷ 5? (con residuo)
  opciones: 3 r2 / 3 r3 / 4 r1 / 2 r7 → correcta: 3 r2
```

---

## Feature 9 — `g4-unit3-decimales-dinero`

**DBA:** #4 Grado 4° — "Reconoce y usa decimales en contextos de medida y dinero (pesos colombianos)."
**Unidad:** `unit-403` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-411 | ¿Qué son los decimales? | intro | 5 | easy |
| lesson-412 | Décimas y centésimas | standard | 5 | medium |
| lesson-413 | Sumar decimales | standard | 5 | medium |
| lesson-414 | Precios en pesos colombianos | standard | 5 | medium |
| lesson-415 | ¡Desafío de decimales! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-411 ej.1 (multipleChoice): ¿Qué número decimal representa "tres décimas"?
  opciones: 3.0 / 0.3 / 0.03 / 30.0 → correcta: 0.3

lesson-414 ej.2 (fillBlank): Una libra de arroz cuesta $2.500 y una de fríjol $3.200.
  ¿Cuánto es el total? ___
  opciones: $5.600 / $5.700 / $5.800 / $5.500 → correcta: $5.700

lesson-415 ej.3 (dragDrop): Ordena de menor a mayor: 1.5 / 1.05 / 1.50 / 0.15
```

**Contextos colombianos:** pesos COP, precios de tienda, medidas de recetas de cocina colombiana.

---

## Feature 10 — `g5-unit1-enteros`

**DBA:** #1 Grado 5° — "Opera con números enteros negativos en contextos reales."
**Unidad:** `unit-501` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-501 | Números negativos | intro | 5 | easy |
| lesson-502 | La recta numérica entera | standard | 5 | easy |
| lesson-503 | Comparar enteros | standard | 5 | medium |
| lesson-504 | Sumar y restar enteros | standard | 5 | medium |
| lesson-505 | ¡Desafío de enteros! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-501 ej.1 (multipleChoice): La temperatura en el páramo era 2°C y bajó 5°C. ¿Cuál es la temperatura?
  opciones: -3°C / 3°C / -7°C / 7°C → correcta: -3°C

lesson-503 ej.2 (fillBlank): ___ es mayor que -5
  opciones: -8 / -6 / -5 / -3 → correcta: -3

lesson-504 ej.3 (dragDrop): Relaciona: (-3)+5 / 4+(-7) / (-2)+(-4)  targets: 2 / -3 / -6
```

**Contextos colombianos:** temperatura en páramos, nivel del mar en puertos colombianos,
deuda vs ahorro en la tienda escolar.

---

## Feature 11 — `g5-unit2-porcentajes`

**DBA:** #3 Grado 5° — "Resuelve problemas con porcentajes (descuentos, propinas, IVA)."
**Unidad:** `unit-502` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-506 | ¿Qué es un porcentaje? | intro | 5 | easy |
| lesson-507 | El 50%, 25% y 10% | standard | 5 | easy |
| lesson-508 | Calcular el porcentaje | standard | 5 | medium |
| lesson-509 | Descuentos y ofertas | standard | 5 | medium |
| lesson-510 | ¡Desafío de porcentajes! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-507 ej.1 (multipleChoice): ¿Cuánto es el 50% de 80?
  opciones: 20 / 40 / 50 / 60 → correcta: 40

lesson-509 ej.2 (fillBlank): Un cuaderno cuesta $4.000 y tiene 25% de descuento. ¿Cuánto pagas?
  opciones: $1.000 / $2.000 / $3.000 / $3.500 → correcta: $3.000

lesson-510 ej.3 (dragDrop): Relaciona: 10% de 200 / 25% de 80 / 50% de 60  targets: 20 / 20 / 30
```

**Contextos colombianos:** descuentos en San Victorino, propinas en restaurantes, IVA en productos.

---

## Feature 12 — `g5-unit3-razones-proporciones`

**DBA:** #4 Grado 5° — "Comprende razones y proporciones. Resuelve regla de tres simple."
**Unidad:** `unit-503` | **Pensamiento:** Numérico y variacional

### Lecciones a implementar

| ID | Título | Tipo | Ejercicios | Dificultad |
|----|--------|------|------------|------------|
| lesson-511 | ¿Qué es una razón? | intro | 5 | easy |
| lesson-512 | Proporciones directas | standard | 5 | medium |
| lesson-513 | Regla de tres simple | standard | 5 | medium |
| lesson-514 | Aplicaciones reales | standard | 5 | hard |
| lesson-515 | ¡Desafío final! | boss | 6 | hard |

### Ejercicios representativos

```
lesson-511 ej.1 (multipleChoice): Si por cada 2 mangos pagas $1.000, ¿cuál es la razón mango/precio?
  opciones: 1:500 / 2:1.000 / 1:1.000 / 2:500 → correcta: 2:1.000

lesson-513 ej.2 (fillBlank): Si 3 libras de arroz cuestan $6.000, ¿cuánto cuestan 5 libras?
  opciones: $8.000 / $10.000 / $12.000 / $9.000 → correcta: $10.000

lesson-515 ej.3 (dragDrop): Relaciona proporción directa con su valor faltante
```

**Contextos colombianos:** recetas de cocina escaladas, distancias en mapas de Colombia,
precios en plaza de mercado.

---

## Feature 13 — `smoke-test-all-grades`

**Tipo:** Verificación y documentación

### Checklist

- [ ] `flutter analyze` — cero errores, cero warnings en código de producción
- [ ] Verificar que `CurriculumData.getLesson(id)` no retorna `null` para ninguno de los 75 lesson IDs
- [ ] Navegar manualmente: Home → Grado 2° → Unidad 1 → Lección 1 → completar → resultado
- [ ] Navegar manualmente: Home → Grado 5° → Unidad 3 → Lección 5 → completar → resultado
- [ ] Actualizar `SPEC_BACKLOG.md`: marcar 13.2, 13.3, 13.4 como `✅ IMPLEMENTADO`
- [ ] Actualizar `eduplay-ft/STATUS.md` con las 60 lecciones nuevas

---

## Orden de implementación recomendado

```
Feature 0  →  Feature 1  →  Feature 2  →  Feature 3
                                                    ↓
Feature 6  ←  Feature 5  ←  Feature 4  ←  (Grado 2° completo)
    ↓
Feature 7  →  Feature 8  →  Feature 9
                                    ↓
Feature 12 ←  Feature 11 ←  Feature 10 ← (Grado 4° completo)
    ↓
Feature 13 (smoke test)
```

## Resumen de métricas

| Métrica | Valor |
|---------|-------|
| Features totales | 13 |
| Lecciones a implementar | 60 |
| Ejercicios estimados | ~306 |
| Archivos modificados | 2 (`units_screen.dart`, `curriculum_data.dart`) |
| Archivos nuevos | 0 |
| Grados cubiertos al terminar | 1°–5° completos |
| DBA cubiertos al terminar | 12 (3 por grado × 4 grados nuevos) |
