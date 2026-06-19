// Currículo de Matemáticas MVP — contenido de las 75 lecciones
// Spec: /specs/domains/learning/spec.md
// Alineado con DBA versión 2 — MEN 2016, Estándares Básicos de Competencias
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
  // ── Unidades por grado ──────────────────────────────────────────
  static const Map<int, List<String>> _gradeUnits = {
    1: ['unit-001', 'unit-002', 'unit-003'],
    2: ['unit-201', 'unit-202', 'unit-203'],
    3: ['unit-301', 'unit-302', 'unit-303'],
    4: ['unit-401', 'unit-402', 'unit-403'],
    5: ['unit-501', 'unit-502', 'unit-503'],
  };

  static List<String> getUnitIdsForGrade(int grade) =>
      _gradeUnits[grade] ?? const [];

  static String getGradeTitle(int grade) => 'Matemáticas $grade°';

  static const Map<String, String> unitTitles = {
    // Grado 1
    'unit-001': 'Unidad 1: Números',
    'unit-002': 'Unidad 2: Suma',
    'unit-003': 'Unidad 3: Resta',
    // Grado 2
    'unit-201': 'Unidad 1: Números hasta 1.000',
    'unit-202': 'Unidad 2: Suma y resta hasta 100',
    'unit-203': 'Unidad 3: Tablas × 2, × 3, × 5',
    // Grado 3
    'unit-301': 'Unidad 1: Números hasta 100.000',
    'unit-302': 'Unidad 2: Tablas del 1 al 10',
    'unit-303': 'Unidad 3: División básica',
    // Grado 4
    'unit-401': 'Unidad 1: Fracciones',
    'unit-402': 'Unidad 2: Multiplicación y división',
    'unit-403': 'Unidad 3: Decimales y dinero',
    // Grado 5
    'unit-501': 'Unidad 1: Números enteros',
    'unit-502': 'Unidad 2: Porcentajes',
    'unit-503': 'Unidad 3: Razones y proporciones',
  };

  static const Map<String, String> unitDescriptions = {
    'unit-001': 'Números del 1 al 100 · DBA #1',
    'unit-002': 'Suma hasta 20 · DBA #2',
    'unit-003': 'Resta hasta 20 · DBA #3',
    'unit-201': 'Centenas, decenas y unidades · DBA #1',
    'unit-202': 'Operaciones con reagrupación · DBA #2',
    'unit-203': 'Multiplicación como suma repetida · DBA #3',
    'unit-301': 'Miles y decenas de mil · DBA #1',
    'unit-302': 'Tablas completas y propiedad conmutativa · DBA #3',
    'unit-303': 'Reparto equitativo y cociente · DBA #4',
    'unit-401': 'Medios, tercios, cuartos y equivalencias · DBA #3',
    'unit-402': 'Algoritmo estándar con 2 cifras · DBA #2',
    'unit-403': 'Décimas, centésimas y pesos COP · DBA #4',
    'unit-501': 'Negativos, recta numérica y operaciones · DBA #1',
    'unit-502': 'Porcentaje como fracción de 100 · DBA #3',
    'unit-503': 'Razón, proporción y regla de tres · DBA #4',
  };

  static const Map<String, List<LessonSummary>> _unitSummaries = {
    // ── Grado 1 ──
    'unit-001': [
      LessonSummary(id: 'lesson-001', order: 1, title: 'Números del 1 al 10', xpReward: 30),
      LessonSummary(id: 'lesson-002', order: 2, title: 'Contar hasta 20', xpReward: 30),
      LessonSummary(id: 'lesson-003', order: 3, title: 'Antes y después', xpReward: 40),
      LessonSummary(id: 'lesson-004', order: 4, title: 'Comparar números', xpReward: 40),
      LessonSummary(id: 'lesson-005', order: 5, title: '¡Desafío de números!', xpReward: 60),
    ],
    'unit-002': [
      LessonSummary(id: 'lesson-006', order: 1, title: '¿Qué es sumar?', xpReward: 25),
      LessonSummary(id: 'lesson-007', order: 2, title: 'Sumar hasta 5', xpReward: 30),
      LessonSummary(id: 'lesson-008', order: 3, title: 'Sumar hasta 10', xpReward: 30),
      LessonSummary(id: 'lesson-009', order: 4, title: 'Sumar hasta 20', xpReward: 40),
      LessonSummary(id: 'lesson-010', order: 5, title: '¡Campeón de la suma!', xpReward: 60),
    ],
    'unit-003': [
      LessonSummary(id: 'lesson-011', order: 1, title: '¿Qué es restar?', xpReward: 25),
      LessonSummary(id: 'lesson-012', order: 2, title: 'Restar hasta 5', xpReward: 30),
      LessonSummary(id: 'lesson-013', order: 3, title: 'Restar hasta 10', xpReward: 30),
      LessonSummary(id: 'lesson-014', order: 4, title: 'Restar hasta 20', xpReward: 40),
      LessonSummary(id: 'lesson-015', order: 5, title: '¡Campeón de la resta!', xpReward: 60),
    ],
    // ── Grado 2 ──
    'unit-201': [
      LessonSummary(id: 'lesson-201', order: 1, title: 'Las centenas', xpReward: 30),
      LessonSummary(id: 'lesson-202', order: 2, title: 'Leer y escribir hasta 1.000', xpReward: 30),
      LessonSummary(id: 'lesson-203', order: 3, title: 'Valor posicional', xpReward: 40),
      LessonSummary(id: 'lesson-204', order: 4, title: 'Ordenar números hasta 1.000', xpReward: 40),
      LessonSummary(id: 'lesson-205', order: 5, title: '¡Desafío numérico!', xpReward: 60),
    ],
    'unit-202': [
      LessonSummary(id: 'lesson-206', order: 1, title: 'Sumar decenas', xpReward: 25),
      LessonSummary(id: 'lesson-207', order: 2, title: 'Sumar con llevada', xpReward: 30),
      LessonSummary(id: 'lesson-208', order: 3, title: 'Restar decenas', xpReward: 30),
      LessonSummary(id: 'lesson-209', order: 4, title: 'Restar con préstamo', xpReward: 40),
      LessonSummary(id: 'lesson-210', order: 5, title: '¡Campeón de operaciones!', xpReward: 60),
    ],
    'unit-203': [
      LessonSummary(id: 'lesson-211', order: 1, title: 'Grupos iguales', xpReward: 25),
      LessonSummary(id: 'lesson-212', order: 2, title: 'Tabla del 2', xpReward: 30),
      LessonSummary(id: 'lesson-213', order: 3, title: 'Tabla del 3', xpReward: 30),
      LessonSummary(id: 'lesson-214', order: 4, title: 'Tabla del 5', xpReward: 40),
      LessonSummary(id: 'lesson-215', order: 5, title: '¡Desafío de tablas!', xpReward: 60),
    ],
    // ── Grado 3 ──
    'unit-301': [
      LessonSummary(id: 'lesson-301', order: 1, title: 'Los miles', xpReward: 30),
      LessonSummary(id: 'lesson-302', order: 2, title: 'Decenas de mil', xpReward: 30),
      LessonSummary(id: 'lesson-303', order: 3, title: 'Comparar números grandes', xpReward: 40),
      LessonSummary(id: 'lesson-304', order: 4, title: 'La recta numérica', xpReward: 40),
      LessonSummary(id: 'lesson-305', order: 5, title: '¡Desafío de números grandes!', xpReward: 60),
    ],
    'unit-302': [
      LessonSummary(id: 'lesson-306', order: 1, title: 'Tablas del 4 y del 6', xpReward: 30),
      LessonSummary(id: 'lesson-307', order: 2, title: 'Tablas del 7 y del 8', xpReward: 30),
      LessonSummary(id: 'lesson-308', order: 3, title: 'Tabla del 9', xpReward: 40),
      LessonSummary(id: 'lesson-309', order: 4, title: 'Propiedad conmutativa', xpReward: 40),
      LessonSummary(id: 'lesson-310', order: 5, title: '¡Campeón de tablas!', xpReward: 60),
    ],
    'unit-303': [
      LessonSummary(id: 'lesson-311', order: 1, title: '¿Qué es dividir?', xpReward: 25),
      LessonSummary(id: 'lesson-312', order: 2, title: 'Dividir entre 2 y 3', xpReward: 30),
      LessonSummary(id: 'lesson-313', order: 3, title: 'Dividir entre 4 y 5', xpReward: 30),
      LessonSummary(id: 'lesson-314', order: 4, title: 'Dividir entre 6, 7 y 8', xpReward: 40),
      LessonSummary(id: 'lesson-315', order: 5, title: '¡Desafío de división!', xpReward: 60),
    ],
    // ── Grado 4 ──
    'unit-401': [
      LessonSummary(id: 'lesson-401', order: 1, title: '¿Qué es una fracción?', xpReward: 25),
      LessonSummary(id: 'lesson-402', order: 2, title: 'Mitad y cuarto', xpReward: 30),
      LessonSummary(id: 'lesson-403', order: 3, title: 'Tercios y quintos', xpReward: 30),
      LessonSummary(id: 'lesson-404', order: 4, title: 'Fracciones equivalentes', xpReward: 40),
      LessonSummary(id: 'lesson-405', order: 5, title: '¡Desafío de fracciones!', xpReward: 60),
    ],
    'unit-402': [
      LessonSummary(id: 'lesson-406', order: 1, title: 'Multiplicar por decenas', xpReward: 30),
      LessonSummary(id: 'lesson-407', order: 2, title: 'Multiplicar 2×2 cifras', xpReward: 30),
      LessonSummary(id: 'lesson-408', order: 3, title: 'Dividir con residuo', xpReward: 40),
      LessonSummary(id: 'lesson-409', order: 4, title: 'División de 2 cifras', xpReward: 40),
      LessonSummary(id: 'lesson-410', order: 5, title: '¡Campeón de operaciones!', xpReward: 60),
    ],
    'unit-403': [
      LessonSummary(id: 'lesson-411', order: 1, title: '¿Qué son los decimales?', xpReward: 25),
      LessonSummary(id: 'lesson-412', order: 2, title: 'Décimas y centésimas', xpReward: 30),
      LessonSummary(id: 'lesson-413', order: 3, title: 'Sumar decimales', xpReward: 30),
      LessonSummary(id: 'lesson-414', order: 4, title: 'Precios en pesos colombianos', xpReward: 40),
      LessonSummary(id: 'lesson-415', order: 5, title: '¡Desafío de decimales!', xpReward: 60),
    ],
    // ── Grado 5 ──
    'unit-501': [
      LessonSummary(id: 'lesson-501', order: 1, title: 'Números negativos', xpReward: 25),
      LessonSummary(id: 'lesson-502', order: 2, title: 'La recta numérica entera', xpReward: 30),
      LessonSummary(id: 'lesson-503', order: 3, title: 'Comparar enteros', xpReward: 30),
      LessonSummary(id: 'lesson-504', order: 4, title: 'Sumar y restar enteros', xpReward: 40),
      LessonSummary(id: 'lesson-505', order: 5, title: '¡Desafío de enteros!', xpReward: 60),
    ],
    'unit-502': [
      LessonSummary(id: 'lesson-506', order: 1, title: '¿Qué es un porcentaje?', xpReward: 25),
      LessonSummary(id: 'lesson-507', order: 2, title: 'El 50%, 25% y 10%', xpReward: 30),
      LessonSummary(id: 'lesson-508', order: 3, title: 'Calcular el porcentaje', xpReward: 30),
      LessonSummary(id: 'lesson-509', order: 4, title: 'Descuentos y ofertas', xpReward: 40),
      LessonSummary(id: 'lesson-510', order: 5, title: '¡Desafío de porcentajes!', xpReward: 60),
    ],
    'unit-503': [
      LessonSummary(id: 'lesson-511', order: 1, title: '¿Qué es una razón?', xpReward: 25),
      LessonSummary(id: 'lesson-512', order: 2, title: 'Proporciones directas', xpReward: 30),
      LessonSummary(id: 'lesson-513', order: 3, title: 'Regla de tres simple', xpReward: 30),
      LessonSummary(id: 'lesson-514', order: 4, title: 'Aplicaciones reales', xpReward: 40),
      LessonSummary(id: 'lesson-515', order: 5, title: '¡Desafío final!', xpReward: 60),
    ],
  };

  static List<LessonSummary> getLessonsForUnit(String unitId) =>
      _unitSummaries[unitId] ?? const [];

  static Set<String> getLessonIdsForUnit(String unitId) =>
      getLessonsForUnit(unitId).map((l) => l.id).toSet();

  static Lesson? getLesson(String id) => _allLessons[id];

  static List<String> get allLessonIds => _allLessons.keys.toList();


  // ─── Contenido de las 75 lecciones ─────────────────────────────────────────
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
