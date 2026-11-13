// Currículo de Matemáticas Completo — 39 unidades (195 lecciones, 4 períodos por grado)
// Spec: ../.sdd/implemented/features/domain-learning/curriculum-men.md
// Alineado con DBA versión 2 — MEN 2016, Estándares Básicos de Competencias (NV, EM, AL)
// Contenido distribuido en curriculum_grade1.dart … curriculum_grade5.dart

import '../domain/entities/lesson.dart';
import 'curriculum_grade1.dart';
import 'curriculum_grade2.dart';
import 'curriculum_grade3.dart';
import 'curriculum_grade4.dart';
import 'curriculum_grade5.dart';

class LessonSummary {
  final String id;
  final int order;
  final String title;
  final int xpReward;

  const LessonSummary({
    required this.id,
    required this.order,
    required this.title,
    required this.xpReward,
  });
}

class CurriculumData {
  // ── Unidades por grado (ordenadas por Período 1, 2, 3 y 4) ──────
  static const Map<int, List<String>> _gradeUnits = {
    1: [
      'unit-001', 'unit-004', // Período 1
      'unit-002', 'unit-005', // Período 2
      'unit-003', 'unit-006', // Período 3
      'unit-007', 'unit-008', // Período 4
    ],
    2: [
      'unit-201', 'unit-204', // Período 1
      'unit-202', 'unit-205', // Período 2
      'unit-203', 'unit-206', // Período 3
      'unit-207',             // Período 4
    ],
    3: [
      'unit-301', 'unit-304', // Período 1
      'unit-302', 'unit-305', // Período 2
      'unit-303', 'unit-306', // Período 3
      'unit-307', 'unit-308', // Período 4
    ],
    4: [
      'unit-404', 'unit-402', // Período 1
      'unit-401', 'unit-405', // Período 2
      'unit-403', 'unit-406', // Período 3
      'unit-407', 'unit-408', // Período 4
    ],
    5: [
      'unit-501', 'unit-504', // Período 1
      'unit-502', 'unit-505', // Período 2
      'unit-503', 'unit-506', // Período 3
      'unit-507', 'unit-508', // Período 4
    ],
  };

  // ── Período académico (1 a 4) de cada unidad ────────────────────
  static const Map<String, int> unitPeriods = {
    // Grado 1°
    'unit-001': 1, 'unit-004': 1,
    'unit-002': 2, 'unit-005': 2,
    'unit-003': 3, 'unit-006': 3,
    'unit-007': 4, 'unit-008': 4,
    // Grado 2°
    'unit-201': 1, 'unit-204': 1,
    'unit-202': 2, 'unit-205': 2,
    'unit-203': 3, 'unit-206': 3,
    'unit-207': 4,
    // Grado 3°
    'unit-301': 1, 'unit-304': 1,
    'unit-302': 2, 'unit-305': 2,
    'unit-303': 3, 'unit-306': 3,
    'unit-307': 4, 'unit-308': 4,
    // Grado 4°
    'unit-404': 1, 'unit-402': 1,
    'unit-401': 2, 'unit-405': 2,
    'unit-403': 3, 'unit-406': 3,
    'unit-407': 4, 'unit-408': 4,
    // Grado 5°
    'unit-501': 1, 'unit-504': 1,
    'unit-502': 2, 'unit-505': 2,
    'unit-503': 3, 'unit-506': 3,
    'unit-507': 4, 'unit-508': 4,
  };

  static int getUnitPeriod(String unitId) => unitPeriods[unitId] ?? 1;

  static List<String> getUnitIdsForGrade(int grade) =>
      _gradeUnits[grade] ?? const [];

  static Set<String> getLessonIdsForGrade(int grade) {
    final units = getUnitIdsForGrade(grade);
    final ids = <String>{};
    for (final unitId in units) {
      ids.addAll(getLessonIdsForUnit(unitId));
    }
    return ids;
  }

  static String getGradeTitle(int grade) => 'Matemáticas $grade°';

  static const Map<String, String> unitTitles = {
    // Grado 1 (8 unidades)
    'unit-001': 'Unidad 1: Números hasta 100',
    'unit-004': 'Unidad 2: Ubicación espacial',
    'unit-002': 'Unidad 3: Suma hasta 20',
    'unit-005': 'Unidad 4: Medición y comparación',
    'unit-003': 'Unidad 5: Resta hasta 20',
    'unit-006': 'Unidad 6: Figuras planas',
    'unit-007': 'Unidad 7: El tiempo y el reloj',
    'unit-008': 'Unidad 8: Datos y pictogramas',
    // Grado 2 (7 unidades)
    'unit-201': 'Unidad 1: Números hasta 1.000',
    'unit-204': 'Unidad 2: Medición con regla',
    'unit-202': 'Unidad 3: Suma y resta hasta 100',
    'unit-205': 'Unidad 4: Cuerpos geométricos',
    'unit-203': 'Unidad 5: Tablas × 2, × 3, × 5',
    'unit-206': 'Unidad 6: Patrones y secuencias',
    'unit-207': 'Unidad 7: Datos y gráficas',
    // Grado 3 (8 unidades)
    'unit-301': 'Unidad 1: Números hasta 100.000',
    'unit-304': 'Unidad 2: Perímetro y ángulos',
    'unit-302': 'Unidad 3: Tablas del 1 al 10',
    'unit-305': 'Unidad 4: El tiempo y el calendario',
    'unit-303': 'Unidad 5: División básica',
    'unit-306': 'Unidad 6: Multiplicación y división 2 cifras',
    'unit-307': 'Unidad 7: Fracciones simples',
    'unit-308': 'Unidad 8: Gráficas e interpretación',
    // Grado 4 (8 unidades)
    'unit-404': 'Unidad 1: Números hasta un millón',
    'unit-402': 'Unidad 2: Multiplicación y división',
    'unit-401': 'Unidad 3: Fracciones',
    'unit-405': 'Unidad 4: Figuras y simetría',
    'unit-403': 'Unidad 5: Decimales y dinero',
    'unit-406': 'Unidad 6: Área y perímetro',
    'unit-407': 'Unidad 7: Mapas y escalas',
    'unit-408': 'Unidad 8: Probabilidad',
    // Grado 5 (8 unidades)
    'unit-501': 'Unidad 1: Números enteros',
    'unit-504': 'Unidad 2: Fracciones heterogéneas',
    'unit-502': 'Unidad 3: Porcentajes',
    'unit-505': 'Unidad 4: Volumen',
    'unit-503': 'Unidad 5: Razones y proporciones',
    'unit-506': 'Unidad 6: Circunferencia',
    'unit-507': 'Unidad 7: Estadística (Moda y promedio)',
    'unit-508': 'Unidad 8: Álgebra inicial',
  };

  static const Map<String, String> unitDescriptions = {
    // Grado 1
    'unit-001': 'Números del 1 al 100 · DBA #1 (NV)',
    'unit-004': 'Arriba/abajo, izquierda/derecha · DBA #7 (EM)',
    'unit-002': 'Suma hasta 20 · DBA #2 (NV)',
    'unit-005': 'Largo/corto, pesado/liviano · DBA #4 (EM)',
    'unit-003': 'Resta hasta 20 · DBA #3 (NV)',
    'unit-006': 'Círculo, cuadrado, triángulo · DBA #5 (EM)',
    'unit-007': 'Hora en punto y media hora · DBA #6 (EM)',
    'unit-008': 'Pictogramas y barras sencillas · DBA #8 (AL)',
    // Grado 2
    'unit-201': 'Centenas, decenas y unidades · DBA #1 (NV)',
    'unit-204': 'Centímetros, metro y regla · DBA #5 (EM)',
    'unit-202': 'Operaciones con reagrupación · DBA #2 (NV)',
    'unit-205': 'Cubo, esfera, cilindro y cono · DBA #4 (EM)',
    'unit-203': 'Multiplicación como suma repetida · DBA #3 (NV)',
    'unit-206': 'Patrones numéricos y geométricos · DBA #6 (NV)',
    'unit-207': 'Tablas de frecuencia y barras · DBA #7 (AL)',
    // Grado 3
    'unit-301': 'Miles y decenas de mil · DBA #1 (NV)',
    'unit-304': 'Perímetro y ángulos rectos/agudos · DBA #6 (EM)',
    'unit-302': 'Tablas completas y conmutativa · DBA #3 (NV)',
    'unit-305': 'Horas, minutos y calendario · DBA #7 (EM)',
    'unit-303': 'Reparto equitativo y cociente · DBA #4 (NV)',
    'unit-306': 'Problemas de 2 cifras · DBA #2 (NV)',
    'unit-307': 'Medios, tercios y cuartos · DBA #5 (NV)',
    'unit-308': 'Gráficas con escala y análisis · DBA #8 (AL)',
    // Grado 4
    'unit-404': 'Centenas de mil, millón y redondeo · DBA #1 (NV)',
    'unit-402': 'Algoritmo estándar con 2 cifras · DBA #2 (NV)',
    'unit-401': 'Medios, tercios, cuartos y equivalencias · DBA #3 (NV)',
    'unit-405': 'Ángulos en grados, triángulos y simetría · DBA #6 (EM)',
    'unit-403': 'Décimas, centésimas y pesos COP · DBA #4 (NV)',
    'unit-406': 'Superficie en m² y cm² vs. perímetro · DBA #5 (EM)',
    'unit-407': 'Coordenadas, puntos cardinales y escala · DBA #7 (EM)',
    'unit-408': 'Eventos seguros, posibles y fracciones · DBA #8 (AL)',
    // Grado 5
    'unit-501': 'Negativos, recta numérica y operaciones · DBA #1 (NV)',
    'unit-504': 'MCM y distinto denominador · DBA #2 (NV)',
    'unit-502': 'Porcentaje como fracción de 100 · DBA #3 (NV)',
    'unit-505': 'Unidades cúbicas (cm³, m³) y litros · DBA #5 (EM)',
    'unit-503': 'Razón, proporción y regla de tres · DBA #4 (NV)',
    'unit-506': 'Radio, diámetro y número Pi (π) · DBA #6 (EM)',
    'unit-507': 'Moda, mediana y media aritmética · DBA #7 (AL)',
    'unit-508': 'Variables y ecuaciones sencillas · DBA #8 (NV)',
  };

  static const Map<String, List<LessonSummary>> _unitSummaries = {
    // ── Grado 1 (8 unidades) ──
    'unit-001': [
      LessonSummary(id: 'lesson-001', order: 1, title: 'Números del 1 al 10', xpReward: 30),
      LessonSummary(id: 'lesson-002', order: 2, title: 'Contar hasta 20', xpReward: 30),
      LessonSummary(id: 'lesson-003', order: 3, title: 'Antes y después', xpReward: 40),
      LessonSummary(id: 'lesson-004', order: 4, title: 'Comparar números', xpReward: 40),
      LessonSummary(id: 'lesson-005', order: 5, title: '¡Desafío de números!', xpReward: 60),
    ],
    'unit-004': [
      LessonSummary(id: 'lesson-016', order: 1, title: 'Arriba y abajo', xpReward: 25),
      LessonSummary(id: 'lesson-017', order: 2, title: 'Izquierda y derecha', xpReward: 30),
      LessonSummary(id: 'lesson-018', order: 3, title: 'Cerca, lejos, delante y detrás', xpReward: 30),
      LessonSummary(id: 'lesson-019', order: 4, title: 'Dentro, fuera y en el borde', xpReward: 40),
      LessonSummary(id: 'lesson-020', order: 5, title: '¡Desafío espacial!', xpReward: 60),
    ],
    'unit-002': [
      LessonSummary(id: 'lesson-006', order: 1, title: '¿Qué es sumar?', xpReward: 25),
      LessonSummary(id: 'lesson-007', order: 2, title: 'Sumar hasta 5', xpReward: 30),
      LessonSummary(id: 'lesson-008', order: 3, title: 'Sumar hasta 10', xpReward: 30),
      LessonSummary(id: 'lesson-009', order: 4, title: 'Sumar hasta 20', xpReward: 40),
      LessonSummary(id: 'lesson-010', order: 5, title: '¡Campeón de la suma!', xpReward: 60),
    ],
    'unit-005': [
      LessonSummary(id: 'lesson-021', order: 1, title: 'Largo, corto, alto y bajo', xpReward: 25),
      LessonSummary(id: 'lesson-022', order: 2, title: 'Pesado y liviano', xpReward: 30),
      LessonSummary(id: 'lesson-023', order: 3, title: 'Lleno, vacío y capacidad', xpReward: 30),
      LessonSummary(id: 'lesson-024', order: 4, title: 'Medir con palmas y pasos', xpReward: 40),
      LessonSummary(id: 'lesson-025', order: 5, title: '¡Desafío de medidas!', xpReward: 60),
    ],
    'unit-003': [
      LessonSummary(id: 'lesson-011', order: 1, title: '¿Qué es restar?', xpReward: 25),
      LessonSummary(id: 'lesson-012', order: 2, title: 'Restar hasta 5', xpReward: 30),
      LessonSummary(id: 'lesson-013', order: 3, title: 'Restar hasta 10', xpReward: 30),
      LessonSummary(id: 'lesson-014', order: 4, title: 'Restar hasta 20', xpReward: 40),
      LessonSummary(id: 'lesson-015', order: 5, title: '¡Campeón de la resta!', xpReward: 60),
    ],
    'unit-006': [
      LessonSummary(id: 'lesson-026', order: 1, title: 'El círculo y el cuadrado', xpReward: 25),
      LessonSummary(id: 'lesson-027', order: 2, title: 'El triángulo y el rectángulo', xpReward: 30),
      LessonSummary(id: 'lesson-028', order: 3, title: 'Contando lados y esquinas', xpReward: 30),
      LessonSummary(id: 'lesson-029', order: 4, title: 'Figuras en mi entorno', xpReward: 40),
      LessonSummary(id: 'lesson-030', order: 5, title: '¡Desafío geométrico!', xpReward: 60),
    ],
    'unit-007': [
      LessonSummary(id: 'lesson-031', order: 1, title: 'Mañana, tarde y noche', xpReward: 25),
      LessonSummary(id: 'lesson-032', order: 2, title: 'Los días de la semana', xpReward: 30),
      LessonSummary(id: 'lesson-033', order: 3, title: 'La hora en punto', xpReward: 30),
      LessonSummary(id: 'lesson-034', order: 4, title: 'La media hora', xpReward: 40),
      LessonSummary(id: 'lesson-035', order: 5, title: '¡Desafío del tiempo!', xpReward: 60),
    ],
    'unit-008': [
      LessonSummary(id: 'lesson-036', order: 1, title: 'Contar y organizar datos', xpReward: 25),
      LessonSummary(id: 'lesson-037', order: 2, title: 'Leer pictogramas', xpReward: 30),
      LessonSummary(id: 'lesson-038', order: 3, title: 'Comparar cantidades en tablas', xpReward: 30),
      LessonSummary(id: 'lesson-039', order: 4, title: 'Diagramas de barras sencillos', xpReward: 40),
      LessonSummary(id: 'lesson-040', order: 5, title: '¡Desafío de datos!', xpReward: 60),
    ],
    // ── Grado 2 (7 unidades) ──
    'unit-201': [
      LessonSummary(id: 'lesson-201', order: 1, title: 'Las centenas', xpReward: 30),
      LessonSummary(id: 'lesson-202', order: 2, title: 'Leer y escribir hasta 1.000', xpReward: 30),
      LessonSummary(id: 'lesson-203', order: 3, title: 'Valor posicional', xpReward: 40),
      LessonSummary(id: 'lesson-204', order: 4, title: 'Ordenar números hasta 1.000', xpReward: 40),
      LessonSummary(id: 'lesson-205', order: 5, title: '¡Desafío numérico!', xpReward: 60),
    ],
    'unit-204': [
      LessonSummary(id: 'lesson-216', order: 1, title: 'El centímetro y la regla', xpReward: 25),
      LessonSummary(id: 'lesson-217', order: 2, title: 'El metro y los centímetros', xpReward: 30),
      LessonSummary(id: 'lesson-218', order: 3, title: 'Comparar y sumar longitudes', xpReward: 30),
      LessonSummary(id: 'lesson-219', order: 4, title: 'Perímetro simple con regla', xpReward: 40),
      LessonSummary(id: 'lesson-220', order: 5, title: '¡Desafío de medición!', xpReward: 60),
    ],
    'unit-202': [
      LessonSummary(id: 'lesson-206', order: 1, title: 'Sumar decenas', xpReward: 25),
      LessonSummary(id: 'lesson-207', order: 2, title: 'Sumar con llevada', xpReward: 30),
      LessonSummary(id: 'lesson-208', order: 3, title: 'Restar decenas', xpReward: 30),
      LessonSummary(id: 'lesson-209', order: 4, title: 'Restar con préstamo', xpReward: 40),
      LessonSummary(id: 'lesson-210', order: 5, title: '¡Campeón de operaciones!', xpReward: 60),
    ],
    'unit-205': [
      LessonSummary(id: 'lesson-221', order: 1, title: 'El cubo y el prisma', xpReward: 25),
      LessonSummary(id: 'lesson-222', order: 2, title: 'Esfera, cilindro y cono', xpReward: 30),
      LessonSummary(id: 'lesson-223', order: 3, title: 'Caras, vértices y aristas', xpReward: 30),
      LessonSummary(id: 'lesson-224', order: 4, title: 'Objetos 3D en nuestro entorno', xpReward: 40),
      LessonSummary(id: 'lesson-225', order: 5, title: '¡Desafío de cuerpos 3D!', xpReward: 60),
    ],
    'unit-203': [
      LessonSummary(id: 'lesson-211', order: 1, title: 'Grupos iguales', xpReward: 25),
      LessonSummary(id: 'lesson-212', order: 2, title: 'Tabla del 2', xpReward: 30),
      LessonSummary(id: 'lesson-213', order: 3, title: 'Tabla del 3', xpReward: 30),
      LessonSummary(id: 'lesson-214', order: 4, title: 'Tabla del 5', xpReward: 40),
      LessonSummary(id: 'lesson-215', order: 5, title: '¡Desafío de tablas!', xpReward: 60),
    ],
    'unit-206': [
      LessonSummary(id: 'lesson-226', order: 1, title: 'Secuencias de 2 en 2 y 5 en 5', xpReward: 25),
      LessonSummary(id: 'lesson-227', order: 2, title: 'Secuencias ascendentes y descendentes', xpReward: 30),
      LessonSummary(id: 'lesson-228', order: 3, title: 'Patrones geométricos y de colores', xpReward: 30),
      LessonSummary(id: 'lesson-229', order: 4, title: 'Encontrar el número oculto', xpReward: 40),
      LessonSummary(id: 'lesson-230', order: 5, title: '¡Desafío de patrones!', xpReward: 60),
    ],
    'unit-207': [
      LessonSummary(id: 'lesson-231', order: 1, title: 'Tablas de conteo', xpReward: 25),
      LessonSummary(id: 'lesson-232', order: 2, title: 'Tablas de frecuencia', xpReward: 30),
      LessonSummary(id: 'lesson-233', order: 3, title: 'Gráficas de barras', xpReward: 30),
      LessonSummary(id: 'lesson-234', order: 4, title: 'Interpretar encuestas escolares', xpReward: 40),
      LessonSummary(id: 'lesson-235', order: 5, title: '¡Desafío estadístico!', xpReward: 60),
    ],
    // ── Grado 3 (8 unidades) ──
    'unit-301': [
      LessonSummary(id: 'lesson-301', order: 1, title: 'Los miles', xpReward: 30),
      LessonSummary(id: 'lesson-302', order: 2, title: 'Decenas de mil', xpReward: 30),
      LessonSummary(id: 'lesson-303', order: 3, title: 'Comparar números grandes', xpReward: 40),
      LessonSummary(id: 'lesson-304', order: 4, title: 'La recta numérica', xpReward: 40),
      LessonSummary(id: 'lesson-305', order: 5, title: '¡Desafío de números grandes!', xpReward: 60),
    ],
    'unit-304': [
      LessonSummary(id: 'lesson-316', order: 1, title: '¿Qué es el perímetro?', xpReward: 25),
      LessonSummary(id: 'lesson-317', order: 2, title: 'Perímetro de cuadrados y rectángulos', xpReward: 30),
      LessonSummary(id: 'lesson-318', order: 3, title: 'Ángulo recto, agudo y obtuso', xpReward: 30),
      LessonSummary(id: 'lesson-319', order: 4, title: 'Giros y direcciones', xpReward: 40),
      LessonSummary(id: 'lesson-320', order: 5, title: '¡Desafío de perímetro y ángulos!', xpReward: 60),
    ],
    'unit-302': [
      LessonSummary(id: 'lesson-306', order: 1, title: 'Tablas del 4 y del 6', xpReward: 30),
      LessonSummary(id: 'lesson-307', order: 2, title: 'Tablas del 7 y del 8', xpReward: 30),
      LessonSummary(id: 'lesson-308', order: 3, title: 'Tabla del 9', xpReward: 40),
      LessonSummary(id: 'lesson-309', order: 4, title: 'Propiedad conmutativa', xpReward: 40),
      LessonSummary(id: 'lesson-310', order: 5, title: '¡Campeón de tablas!', xpReward: 60),
    ],
    'unit-305': [
      LessonSummary(id: 'lesson-321', order: 1, title: 'Horas, minutos y segundos', xpReward: 25),
      LessonSummary(id: 'lesson-322', order: 2, title: 'El calendario: semanas y meses', xpReward: 30),
      LessonSummary(id: 'lesson-323', order: 3, title: 'Duración de eventos', xpReward: 30),
      LessonSummary(id: 'lesson-324', order: 4, title: 'Problemas de tiempo cotidianos', xpReward: 40),
      LessonSummary(id: 'lesson-325', order: 5, title: '¡Desafío del calendario y el reloj!', xpReward: 60),
    ],
    'unit-303': [
      LessonSummary(id: 'lesson-311', order: 1, title: '¿Qué es dividir?', xpReward: 25),
      LessonSummary(id: 'lesson-312', order: 2, title: 'Dividir entre 2 y 3', xpReward: 30),
      LessonSummary(id: 'lesson-313', order: 3, title: 'Dividir entre 4 y 5', xpReward: 30),
      LessonSummary(id: 'lesson-314', order: 4, title: 'Dividir entre 6, 7 y 8', xpReward: 40),
      LessonSummary(id: 'lesson-315', order: 5, title: '¡Desafío de división!', xpReward: 60),
    ],
    'unit-306': [
      LessonSummary(id: 'lesson-326', order: 1, title: 'Multiplicar por 10 y por decenas', xpReward: 25),
      LessonSummary(id: 'lesson-327', order: 2, title: 'Multiplicar 2 cifras por 1 cifra', xpReward: 30),
      LessonSummary(id: 'lesson-328', order: 3, title: 'División exacta de 2 cifras', xpReward: 30),
      LessonSummary(id: 'lesson-329', order: 4, title: 'Problemas de dos pasos', xpReward: 40),
      LessonSummary(id: 'lesson-330', order: 5, title: '¡Desafío de operaciones 3°!', xpReward: 60),
    ],
    'unit-307': [
      LessonSummary(id: 'lesson-331', order: 1, title: 'Partes iguales de un todo', xpReward: 25),
      LessonSummary(id: 'lesson-332', order: 2, title: 'Medios, tercios y cuartos', xpReward: 30),
      LessonSummary(id: 'lesson-333', order: 3, title: 'Fracción de un grupo', xpReward: 30),
      LessonSummary(id: 'lesson-334', order: 4, title: 'Comparar fracciones simples', xpReward: 40),
      LessonSummary(id: 'lesson-335', order: 5, title: '¡Desafío de fracciones 3°!', xpReward: 60),
    ],
    'unit-308': [
      LessonSummary(id: 'lesson-336', order: 1, title: 'Recolectar y clasificar datos', xpReward: 25),
      LessonSummary(id: 'lesson-337', order: 2, title: 'Escalas en gráficas de barras', xpReward: 30),
      LessonSummary(id: 'lesson-338', order: 3, title: 'Pictogramas con escala', xpReward: 30),
      LessonSummary(id: 'lesson-339', order: 4, title: 'Comparar totales y diferencias', xpReward: 40),
      LessonSummary(id: 'lesson-340', order: 5, title: '¡Desafío de gráficas 3°!', xpReward: 60),
    ],
    // ── Grado 4 (8 unidades) ──
    'unit-404': [
      LessonSummary(id: 'lesson-416', order: 1, title: 'Centenas de mil y el millón', xpReward: 25),
      LessonSummary(id: 'lesson-417', order: 2, title: 'Valor posicional hasta 6 cifras', xpReward: 30),
      LessonSummary(id: 'lesson-418', order: 3, title: 'Comparar poblaciones de Colombia', xpReward: 30),
      LessonSummary(id: 'lesson-419', order: 4, title: 'Redondeo y estimación', xpReward: 40),
      LessonSummary(id: 'lesson-420', order: 5, title: '¡Desafío del millón!', xpReward: 60),
    ],
    'unit-402': [
      LessonSummary(id: 'lesson-406', order: 1, title: 'Multiplicar por decenas', xpReward: 30),
      LessonSummary(id: 'lesson-407', order: 2, title: 'Multiplicar 2×2 cifras', xpReward: 30),
      LessonSummary(id: 'lesson-408', order: 3, title: 'Dividir con residuo', xpReward: 40),
      LessonSummary(id: 'lesson-409', order: 4, title: 'División de 2 cifras', xpReward: 40),
      LessonSummary(id: 'lesson-410', order: 5, title: '¡Campeón de operaciones!', xpReward: 60),
    ],
    'unit-401': [
      LessonSummary(id: 'lesson-401', order: 1, title: '¿Qué es una fracción?', xpReward: 25),
      LessonSummary(id: 'lesson-402', order: 2, title: 'Mitad y cuarto', xpReward: 30),
      LessonSummary(id: 'lesson-403', order: 3, title: 'Tercios y quintos', xpReward: 30),
      LessonSummary(id: 'lesson-404', order: 4, title: 'Fracciones equivalentes', xpReward: 40),
      LessonSummary(id: 'lesson-405', order: 5, title: '¡Desafío de fracciones!', xpReward: 60),
    ],
    'unit-405': [
      LessonSummary(id: 'lesson-421', order: 1, title: 'Medición de ángulos en grados', xpReward: 25),
      LessonSummary(id: 'lesson-422', order: 2, title: 'Clasificación de triángulos', xpReward: 30),
      LessonSummary(id: 'lesson-423', order: 3, title: 'Cuadriláteros y paralelogramos', xpReward: 30),
      LessonSummary(id: 'lesson-424', order: 4, title: 'Ejes de simetría', xpReward: 40),
      LessonSummary(id: 'lesson-425', order: 5, title: '¡Desafío geométrico 4°!', xpReward: 60),
    ],
    'unit-403': [
      LessonSummary(id: 'lesson-411', order: 1, title: '¿Qué son los decimales?', xpReward: 25),
      LessonSummary(id: 'lesson-412', order: 2, title: 'Décimas y centésimas', xpReward: 30),
      LessonSummary(id: 'lesson-413', order: 3, title: 'Sumar decimales', xpReward: 30),
      LessonSummary(id: 'lesson-414', order: 4, title: 'Precios en pesos colombianos', xpReward: 40),
      LessonSummary(id: 'lesson-415', order: 5, title: '¡Desafío de decimales!', xpReward: 60),
    ],
    'unit-406': [
      LessonSummary(id: 'lesson-426', order: 1, title: 'Diferencia entre área y perímetro', xpReward: 25),
      LessonSummary(id: 'lesson-427', order: 2, title: 'Área del rectángulo y del cuadrado', xpReward: 30),
      LessonSummary(id: 'lesson-428', order: 3, title: 'Comparar área y perímetro', xpReward: 30),
      LessonSummary(id: 'lesson-429', order: 4, title: 'Área del triángulo y figuras compuestas', xpReward: 40),
      LessonSummary(id: 'lesson-430', order: 5, title: '¡Desafío de área y perímetro!', xpReward: 60),
    ],
    'unit-407': [
      LessonSummary(id: 'lesson-431', order: 1, title: 'Coordenadas en cuadrícula', xpReward: 25),
      LessonSummary(id: 'lesson-432', order: 2, title: 'Puntos cardinales en mapas de Colombia', xpReward: 30),
      LessonSummary(id: 'lesson-433', order: 3, title: '¿Qué es una escala (1:100)?', xpReward: 30),
      LessonSummary(id: 'lesson-434', order: 4, title: 'Distancias en mapas de Colombia', xpReward: 40),
      LessonSummary(id: 'lesson-435', order: 5, title: '¡Desafío de mapas y escalas!', xpReward: 60),
    ],
    'unit-408': [
      LessonSummary(id: 'lesson-436', order: 1, title: 'Seguro, posible e imposible', xpReward: 25),
      LessonSummary(id: 'lesson-437', order: 2, title: 'Más probable y menos probable', xpReward: 30),
      LessonSummary(id: 'lesson-438', order: 3, title: 'Monedas, dados y ruletas', xpReward: 30),
      LessonSummary(id: 'lesson-439', order: 4, title: 'Probabilidad como fracción', xpReward: 40),
      LessonSummary(id: 'lesson-440', order: 5, title: '¡Desafío de probabilidad!', xpReward: 60),
    ],
    // ── Grado 5 (8 unidades) ──
    'unit-501': [
      LessonSummary(id: 'lesson-501', order: 1, title: 'Números negativos', xpReward: 25),
      LessonSummary(id: 'lesson-502', order: 2, title: 'La recta numérica entera', xpReward: 30),
      LessonSummary(id: 'lesson-503', order: 3, title: 'Comparar enteros', xpReward: 30),
      LessonSummary(id: 'lesson-504', order: 4, title: 'Sumar y restar enteros', xpReward: 40),
      LessonSummary(id: 'lesson-505', order: 5, title: '¡Desafío de enteros!', xpReward: 60),
    ],
    'unit-504': [
      LessonSummary(id: 'lesson-516', order: 1, title: 'Mínimo común múltiplo (MCM)', xpReward: 25),
      LessonSummary(id: 'lesson-517', order: 2, title: 'Convertir a común denominador', xpReward: 30),
      LessonSummary(id: 'lesson-518', order: 3, title: 'Sumar fracciones heterogéneas', xpReward: 30),
      LessonSummary(id: 'lesson-519', order: 4, title: 'Restar y multiplicar fracciones', xpReward: 40),
      LessonSummary(id: 'lesson-520', order: 5, title: '¡Desafío de fracciones heterogéneas!', xpReward: 60),
    ],
    'unit-502': [
      LessonSummary(id: 'lesson-506', order: 1, title: '¿Qué es un porcentaje?', xpReward: 25),
      LessonSummary(id: 'lesson-507', order: 2, title: 'El 50%, 25% y 10%', xpReward: 30),
      LessonSummary(id: 'lesson-508', order: 3, title: 'Calcular el porcentaje', xpReward: 30),
      LessonSummary(id: 'lesson-509', order: 4, title: 'Descuentos y ofertas', xpReward: 40),
      LessonSummary(id: 'lesson-510', order: 5, title: '¡Desafío de porcentajes!', xpReward: 60),
    ],
    'unit-505': [
      LessonSummary(id: 'lesson-521', order: 1, title: '¿Qué es el volumen?', xpReward: 25),
      LessonSummary(id: 'lesson-522', order: 2, title: 'Volumen de un cubo', xpReward: 30),
      LessonSummary(id: 'lesson-523', order: 3, title: 'Volumen de prismas rectangulares', xpReward: 30),
      LessonSummary(id: 'lesson-524', order: 4, title: 'Volumen y capacidad (litros)', xpReward: 40),
      LessonSummary(id: 'lesson-525', order: 5, title: '¡Desafío de volumen!', xpReward: 60),
    ],
    'unit-503': [
      LessonSummary(id: 'lesson-511', order: 1, title: '¿Qué es una razón?', xpReward: 25),
      LessonSummary(id: 'lesson-512', order: 2, title: 'Proporciones directas', xpReward: 30),
      LessonSummary(id: 'lesson-513', order: 3, title: 'Regla de tres simple', xpReward: 30),
      LessonSummary(id: 'lesson-514', order: 4, title: 'Aplicaciones reales', xpReward: 40),
      LessonSummary(id: 'lesson-515', order: 5, title: '¡Desafío final!', xpReward: 60),
    ],
    'unit-506': [
      LessonSummary(id: 'lesson-526', order: 1, title: 'Centro, radio y diámetro', xpReward: 25),
      LessonSummary(id: 'lesson-527', order: 2, title: 'Relación entre radio y diámetro', xpReward: 30),
      LessonSummary(id: 'lesson-528', order: 3, title: 'El número Pi (π)', xpReward: 30),
      LessonSummary(id: 'lesson-529', order: 4, title: 'Longitud de la circunferencia', xpReward: 40),
      LessonSummary(id: 'lesson-530', order: 5, title: '¡Desafío circular!', xpReward: 60),
    ],
    'unit-507': [
      LessonSummary(id: 'lesson-531', order: 1, title: 'La moda (el dato más frecuente)', xpReward: 25),
      LessonSummary(id: 'lesson-532', order: 2, title: 'La mediana (el dato central)', xpReward: 30),
      LessonSummary(id: 'lesson-533', order: 3, title: 'El promedio o media aritmética', xpReward: 30),
      LessonSummary(id: 'lesson-534', order: 4, title: 'Análisis de tablas estadísticas', xpReward: 40),
      LessonSummary(id: 'lesson-535', order: 5, title: '¡Desafío estadístico 5°!', xpReward: 60),
    ],
    'unit-508': [
      LessonSummary(id: 'lesson-536', order: 1, title: '¿Qué es una variable o incógnita?', xpReward: 25),
      LessonSummary(id: 'lesson-537', order: 2, title: 'Expresiones en lenguaje algebraico', xpReward: 30),
      LessonSummary(id: 'lesson-538', order: 3, title: 'Ecuaciones de suma y resta', xpReward: 30),
      LessonSummary(id: 'lesson-539', order: 4, title: 'Ecuaciones de multiplicación', xpReward: 40),
      LessonSummary(id: 'lesson-540', order: 5, title: '¡Desafío algebraico!', xpReward: 60),
    ],
  };

  static List<LessonSummary> getLessonsForUnit(String unitId) =>
      _unitSummaries[unitId] ?? const [];

  static Set<String> getLessonIdsForUnit(String unitId) =>
      getLessonsForUnit(unitId).map((l) => l.id).toSet();

  static Lesson? getLesson(String id) => _allLessons[id];

  static List<String> get allLessonIds => _allLessons.keys.toList();


  // ─── Contenido de las 195 lecciones ────────────────────────────────────────
  // Cada grado importa su contenido desde su archivo dedicado
  // (curriculum_grade1.dart … curriculum_grade5.dart)

  static final Map<String, Lesson> _allLessons = {
    ...grade1Lessons,
    ...grade2Lessons,
    ...grade3Lessons,
    ...grade4Lessons,
    ...grade5Lessons,
  };
}
