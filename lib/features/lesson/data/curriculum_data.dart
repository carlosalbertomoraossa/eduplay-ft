// Currículo de Matemáticas MVP — contenido de las 15 lecciones
// Spec: /specs/domains/learning/spec.md
// Alineado con DBA versión 2 — MEN 2016, Estándares Básicos de Competencias

import '../domain/entities/lesson.dart';

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

  // ─── Contenido completo de las 15 lecciones ────────────────────────────────

  static final Map<String, Lesson> _allLessons = {
    // ── UNIDAD 1: Números del 1 al 100 ── DBA #1 Grado 1°
    // "Cuenta, lee y escribe números hasta 100 en contextos de juego"
    'lesson-001': const Lesson(
      id: 'lesson-001', unitId: 'unit-001', orderNum: 1,
      title: 'Números del 1 al 10',
      type: LessonType.standard, estimatedMinutes: 5,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l1-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Cuenta los dedos de una mano',
          content: {
            'question': '¿Cuántos dedos tiene una mano?',
            'options': ['3', '4', '5', '6'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l1-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número después del 7 es ___',
            'options': ['6', '8', '9', '10'],
            'correct_answer': '8',
          },
        ),
        Exercise(
          id: 'l1-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          hint: 'Cuenta los lados de un triángulo',
          content: {
            'question': '¿Cuántos lados tiene un triángulo?',
            'options': ['2', '3', '4', '5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l1-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su nombre',
            'items': ['1', '2', '3'],
            'targets': ['uno', 'dos', 'tres'],
            'correct_mapping': {'1': 'uno', '2': 'dos', '3': 'tres'},
          },
        ),
        Exercise(
          id: 'l1-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número antes del 5 es ___',
            'options': ['3', '4', '6', '7'],
            'correct_answer': '4',
          },
        ),
      ],
    ),

    'lesson-002': const Lesson(
      id: 'lesson-002', unitId: 'unit-001', orderNum: 2,
      title: 'Contar hasta 20',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l2-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número sigue después del 15?',
            'options': ['14', '16', '17', '13'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l2-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '10 + 6 = ___',
            'options': ['14', '16', '15', '17'],
            'correct_answer': '16',
          },
        ),
        Exercise(
          id: 'l2-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su nombre',
            'items': ['4', '5', '6'],
            'targets': ['cuatro', 'cinco', 'seis'],
            'correct_mapping': {'4': 'cuatro', '5': 'cinco', '6': 'seis'},
          },
        ),
        Exercise(
          id: 'l2-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 11 + 4?',
            'options': ['14', '15', '16', '13'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l2-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número antes del 20 es ___',
            'options': ['18', '19', '17', '21'],
            'correct_answer': '19',
          },
        ),
      ],
    ),

    'lesson-003': const Lesson(
      id: 'lesson-003', unitId: 'unit-001', orderNum: 3,
      title: 'Antes y después',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l3-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número va ANTES del 9?',
            'options': ['8', '10', '7', '11'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l3-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número DESPUÉS del 14 es ___',
            'options': ['13', '15', '16', '12'],
            'correct_answer': '15',
          },
        ),
        Exercise(
          id: 'l3-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su nombre',
            'items': ['7', '8', '9'],
            'targets': ['siete', 'ocho', 'nueve'],
            'correct_mapping': {'7': 'siete', '8': 'ocho', '9': 'nueve'},
          },
        ),
        Exercise(
          id: 'l3-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número va DESPUÉS del 12?',
            'options': ['11', '13', '14', '10'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l3-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número ANTES del 7 es ___',
            'options': ['5', '6', '8', '9'],
            'correct_answer': '6',
          },
        ),
      ],
    ),

    'lesson-004': const Lesson(
      id: 'lesson-004', unitId: 'unit-001', orderNum: 4,
      title: 'Comparar números',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l4-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál número es MAYOR: 7 o 4?',
            'options': ['4', '7', '6', '3'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l4-e2', orderNum: 2, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿cuál número es más pequeño que 10?',
          content: {
            'sentence': '___ es menor que 10',
            'options': ['12', '9', '11', '15'],
            'correct_answer': '9',
          },
        ),
        Exercise(
          id: 'l4-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su nombre',
            'items': ['10', '11', '12'],
            'targets': ['diez', 'once', 'doce'],
            'correct_mapping': {'10': 'diez', '11': 'once', '12': 'doce'},
          },
        ),
        Exercise(
          id: 'l4-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál número es MENOR: 17 o 13?',
            'options': ['17', '13', '15', '14'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l4-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '___ es mayor que 15',
            'options': ['14', '16', '13', '12'],
            'correct_answer': '16',
          },
        ),
      ],
    ),

    'lesson-005': const Lesson(
      id: 'lesson-005', unitId: 'unit-001', orderNum: 5,
      title: '¡Desafío de números!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l5-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 8 + 7?',
            'options': ['13', '14', '15', '16'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l5-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '20 - 5 = ___',
            'options': ['13', '14', '15', '16'],
            'correct_answer': '15',
          },
        ),
        Exercise(
          id: 'l5-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su nombre',
            'items': ['13', '14', '15'],
            'targets': ['trece', 'catorce', 'quince'],
            'correct_mapping': {'13': 'trece', '14': 'catorce', '15': 'quince'},
          },
        ),
        Exercise(
          id: 'l5-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es el número más grande?',
            'options': ['12', '18', '15', '9'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l5-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El doble de 6 es ___',
            'options': ['10', '12', '11', '14'],
            'correct_answer': '12',
          },
        ),
      ],
    ),

    // ── UNIDAD 2: Suma hasta 20 ── DBA #2 Grado 1°
    // "Reconoce la adición como acción de agregar y la representa"
    'lesson-006': const Lesson(
      id: 'lesson-006', unitId: 'unit-002', orderNum: 1,
      title: '¿Qué es sumar?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l6-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Sumar es juntar o agregar más cosas',
          content: {
            'question': 'Tienes 2 mangos 🥭 y te dan 1 más. ¿Cuántos mangos tienes?',
            'options': ['2', '3', '4', '1'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l6-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el parque hay 3 niños jugando y llegan 2 más. ¿Cuántos niños hay?',
            'options': ['4', '5', '6', '3'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l6-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2 + 1 = ___',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l6-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3 + 2 = ___',
            'options': ['3', '4', '5', '6'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l6-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma con su resultado',
            'items': ['2+1', '3+1', '4+1'],
            'targets': ['3', '4', '5'],
            'correct_mapping': {'2+1': '3', '3+1': '4', '4+1': '5'},
          },
        ),
      ],
    ),

    'lesson-007': const Lesson(
      id: 'lesson-007', unitId: 'unit-002', orderNum: 2,
      title: 'Sumar hasta 5',
      type: LessonType.standard, estimatedMinutes: 5,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l7-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 1 + 3?',
            'options': ['3', '4', '5', '2'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l7-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2 + 3 = ___',
            'options': ['3', '4', '5', '6'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l7-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          hint: 'Cero no cambia el número',
          content: {
            'question': '¿Cuánto es 0 + 4?',
            'options': ['0', '3', '4', '5'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l7-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma con su resultado',
            'items': ['1+1', '2+2', '3+2'],
            'targets': ['2', '4', '5'],
            'correct_mapping': {'1+1': '2', '2+2': '4', '3+2': '5'},
          },
        ),
        Exercise(
          id: 'l7-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número más 2 da 5?',
          content: {
            'sentence': '___ + 2 = 5',
            'options': ['2', '3', '4', '5'],
            'correct_answer': '3',
          },
        ),
      ],
    ),

    'lesson-008': const Lesson(
      id: 'lesson-008', unitId: 'unit-002', orderNum: 3,
      title: 'Sumar hasta 10',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l8-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 5 + 3?',
            'options': ['7', '8', '9', '6'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l8-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '6 + 4 = ___',
            'options': ['8', '9', '10', '11'],
            'correct_answer': '10',
          },
        ),
        Exercise(
          id: 'l8-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 7 + 2?',
            'options': ['8', '9', '10', '11'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l8-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma con su resultado',
            'items': ['4+4', '3+6', '5+5'],
            'targets': ['8', '9', '10'],
            'correct_mapping': {'4+4': '8', '3+6': '9', '5+5': '10'},
          },
        ),
        Exercise(
          id: 'l8-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número más 3 da 10?',
          content: {
            'sentence': '___ + 3 = 10',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '7',
          },
        ),
      ],
    ),

    'lesson-009': const Lesson(
      id: 'lesson-009', unitId: 'unit-002', orderNum: 4,
      title: 'Sumar hasta 20',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l9-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 8 + 6?',
            'options': ['13', '14', '15', '12'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l9-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '9 + 7 = ___',
            'options': ['14', '15', '16', '17'],
            'correct_answer': '16',
          },
        ),
        Exercise(
          id: 'l9-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 12 + 5?',
            'options': ['16', '17', '18', '15'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l9-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma con su resultado',
            'items': ['7+8', '8+8', '9+9'],
            'targets': ['15', '16', '18'],
            'correct_mapping': {'7+8': '15', '8+8': '16', '9+9': '18'},
          },
        ),
        Exercise(
          id: 'l9-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número más 10 da 17?',
          content: {
            'sentence': '10 + ___ = 17',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '7',
          },
        ),
      ],
    ),

    'lesson-010': const Lesson(
      id: 'lesson-010', unitId: 'unit-002', orderNum: 5,
      title: '¡Campeón de la suma!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l10-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Ana tiene 9 lápices y su mamá le regaló 8 más. ¿Cuántos lápices tiene ahora?',
            'options': ['16', '17', '18', '15'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l10-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '7 + 8 = ___',
            'options': ['13', '14', '15', '16'],
            'correct_answer': '15',
          },
        ),
        Exercise(
          id: 'l10-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 11 + 9?',
            'options': ['19', '20', '21', '18'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l10-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma con su resultado',
            'items': ['6+7', '8+9', '9+9'],
            'targets': ['13', '17', '18'],
            'correct_mapping': {'6+7': '13', '8+9': '17', '9+9': '18'},
          },
        ),
        Exercise(
          id: 'l10-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número más 9 da 20?',
          content: {
            'sentence': '___ + 9 = 20',
            'options': ['9', '10', '11', '12'],
            'correct_answer': '11',
          },
        ),
        Exercise(
          id: 'l10-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una canasta hay 8 naranjas 🍊 y 7 manzanas 🍎. ¿Cuántas frutas hay en total?',
            'options': ['14', '15', '16', '13'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 3: Resta hasta 20 ── DBA #3 Grado 1°
    // "Reconoce la sustracción como acción de quitar y la representa"
    'lesson-011': const Lesson(
      id: 'lesson-011', unitId: 'unit-003', orderNum: 1,
      title: '¿Qué es restar?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l11-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Restar es quitar o sacar cosas',
          content: {
            'question': 'Había 5 galletas 🍪 y te comiste 2. ¿Cuántas quedan?',
            'options': ['2', '3', '4', '5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l11-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Tenías 4 estrellas ⭐ y perdiste 1. ¿Cuántas te quedan?',
            'options': ['2', '3', '4', '5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l11-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': '5 - 2 = ___',
            'options': ['2', '3', '4', '5'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l11-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3 - 1 = ___',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l11-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada resta con su resultado',
            'items': ['5-3', '5-2', '5-1'],
            'targets': ['2', '3', '4'],
            'correct_mapping': {'5-3': '2', '5-2': '3', '5-1': '4'},
          },
        ),
      ],
    ),

    'lesson-012': const Lesson(
      id: 'lesson-012', unitId: 'unit-003', orderNum: 2,
      title: 'Restar hasta 5',
      type: LessonType.standard, estimatedMinutes: 5,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l12-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 5 - 3?',
            'options': ['1', '2', '3', '4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l12-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '4 - 2 = ___',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l12-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 3 - 1?',
            'options': ['1', '2', '3', '4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l12-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada resta con su resultado',
            'items': ['4-3', '4-2', '4-1'],
            'targets': ['1', '2', '3'],
            'correct_mapping': {'4-3': '1', '4-2': '2', '4-1': '3'},
          },
        ),
        Exercise(
          id: 'l12-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número menos 1 da 3?',
          content: {
            'sentence': '___ - 1 = 3',
            'options': ['3', '4', '5', '6'],
            'correct_answer': '4',
          },
        ),
      ],
    ),

    'lesson-013': const Lesson(
      id: 'lesson-013', unitId: 'unit-003', orderNum: 3,
      title: 'Restar hasta 10',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l13-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 9 - 4?',
            'options': ['4', '5', '6', '7'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l13-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '10 - 3 = ___',
            'options': ['5', '6', '7', '8'],
            'correct_answer': '7',
          },
        ),
        Exercise(
          id: 'l13-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 8 - 5?',
            'options': ['2', '3', '4', '5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l13-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada resta con su resultado',
            'items': ['8-6', '9-5', '10-3'],
            'targets': ['2', '4', '7'],
            'correct_mapping': {'8-6': '2', '9-5': '4', '10-3': '7'},
          },
        ),
        Exercise(
          id: 'l13-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número le quito para que queden 4?',
          content: {
            'sentence': '10 - ___ = 4',
            'options': ['4', '5', '6', '7'],
            'correct_answer': '6',
          },
        ),
      ],
    ),

    'lesson-014': const Lesson(
      id: 'lesson-014', unitId: 'unit-003', orderNum: 4,
      title: 'Restar hasta 20',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l14-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 15 - 7?',
            'options': ['7', '8', '9', '6'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l14-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '18 - 9 = ___',
            'options': ['7', '8', '9', '10'],
            'correct_answer': '9',
          },
        ),
        Exercise(
          id: 'l14-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 14 - 6?',
            'options': ['6', '7', '8', '9'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l14-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada resta con su resultado',
            'items': ['15-8', '16-7', '20-6'],
            'targets': ['7', '9', '14'],
            'correct_mapping': {'15-8': '7', '16-7': '9', '20-6': '14'},
          },
        ),
        Exercise(
          id: 'l14-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número le quito a 20 para que queden 11?',
          content: {
            'sentence': '20 - ___ = 11',
            'options': ['8', '9', '10', '11'],
            'correct_answer': '9',
          },
        ),
      ],
    ),

    'lesson-015': const Lesson(
      id: 'lesson-015', unitId: 'unit-003', orderNum: 5,
      title: '¡Campeón de la resta!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l15-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Luisa tenía 17 fichas y perdió 8. ¿Cuántas fichas le quedan?',
            'options': ['8', '9', '10', '11'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l15-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '16 - 7 = ___',
            'options': ['7', '8', '9', '10'],
            'correct_answer': '9',
          },
        ),
        Exercise(
          id: 'l15-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 20 - 12?',
            'options': ['7', '8', '9', '10'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l15-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada resta con su resultado',
            'items': ['15-7', '18-9', '20-5'],
            'targets': ['8', '9', '15'],
            'correct_mapping': {'15-7': '8', '18-9': '9', '20-5': '15'},
          },
        ),
        Exercise(
          id: 'l15-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número le quito a 20 para que queden 7?',
          content: {
            'sentence': '20 - ___ = 7',
            'options': ['12', '13', '14', '15'],
            'correct_answer': '13',
          },
        ),
        Exercise(
          id: 'l15-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En un libro había 19 hojas y se arrancaron 6. ¿Cuántas hojas quedan?',
            'options': ['12', '13', '14', '15'],
            'correct_index': 1,
          },
        ),
      ],
    ),
    // ── UNIDAD 201: Números hasta 1.000 ── DBA #1 Grado 2°
    // "Lee, escribe y ordena números hasta 1.000. Reconoce el valor posicional."
    'lesson-201': const Lesson(
      id: 'lesson-201', unitId: 'unit-201', orderNum: 1,
      title: 'Las centenas',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l201-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Una centena es un grupo de 10 decenas',
          content: {
            'question': '¿Cuántas decenas tiene 1 centena?',
            'options': ['5', '10', '100', '20'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l201-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántas unidades tiene 1 centena?',
            'options': ['10', '50', '100', '200'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l201-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': '10 decenas = ___ centena',
            'options': ['1', '2', '10', '100'],
            'correct_answer': '1',
          },
        ),
        Exercise(
          id: 'l201-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su nombre',
            'items': ['100', '200', '300'],
            'targets': ['cien', 'doscientos', 'trescientos'],
            'correct_mapping': {'100': 'cien', '200': 'doscientos', '300': 'trescientos'},
          },
        ),
        Exercise(
          id: 'l201-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número 200 tiene ___ centenas',
            'options': ['1', '2', '3', '20'],
            'correct_answer': '2',
          },
        ),
      ],
    ),

    'lesson-202': const Lesson(
      id: 'lesson-202', unitId: 'unit-201', orderNum: 2,
      title: 'Leer y escribir hasta 1.000',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l202-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cómo se escribe en número "trescientos cuarenta y siete"?',
            'options': ['374', '347', '437', '473'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l202-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '500 + 60 + 8 = ___',
            'options': ['568', '586', '658', '865'],
            'correct_answer': '568',
          },
        ),
        Exercise(
          id: 'l202-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El libro de ciencias del colegio tiene doscientas treinta y cinco páginas. ¿Cuál es ese número?',
            'options': ['253', '235', '325', '352'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l202-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '900 + 40 + 7 = ___',
            'options': ['947', '974', '497', '794'],
            'correct_answer': '947',
          },
        ),
        Exercise(
          id: 'l202-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su nombre',
            'items': ['400', '750', '999'],
            'targets': ['cuatrocientos', 'setecientos cincuenta', 'novecientos noventa y nueve'],
            'correct_mapping': {
              '400': 'cuatrocientos',
              '750': 'setecientos cincuenta',
              '999': 'novecientos noventa y nueve',
            },
          },
        ),
      ],
    ),

    'lesson-203': const Lesson(
      id: 'lesson-203', unitId: 'unit-201', orderNum: 3,
      title: 'Valor posicional',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l203-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'El 5 está en el lugar de las centenas',
          content: {
            'question': 'En el número 537, ¿cuánto vale el dígito 5?',
            'options': ['5', '50', '500', '5.000'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l203-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el número 537, el dígito de las centenas es ___',
            'options': ['3', '5', '7', '1'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l203-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el número 829, ¿cuánto vale el dígito 2?',
            'options': ['2', '20', '200', '2.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l203-e4', orderNum: 4, type: ExerciseType.fillBlank,
          hint: 'Piensa: 700 + ___ + 4 = 764',
          content: {
            'sentence': '700 + ___ + 4 = 764',
            'options': ['6', '60', '600', '64'],
            'correct_answer': '60',
          },
        ),
        Exercise(
          id: 'l203-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ubica cada dígito del número 385 en su lugar',
            'items': ['3', '8', '5'],
            'targets': ['centenas', 'decenas', 'unidades'],
            'correct_mapping': {'3': 'centenas', '8': 'decenas', '5': 'unidades'},
          },
        ),
      ],
    ),

    'lesson-204': const Lesson(
      id: 'lesson-204', unitId: 'unit-201', orderNum: 4,
      title: 'Ordenar números hasta 1.000',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l204-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál número es mayor: 750 o 705?',
            'options': ['705', '750', '507', '570'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l204-e2', orderNum: 2, type: ExerciseType.fillBlank,
          hint: 'Piensa en un número entre 500 y 600',
          content: {
            'sentence': '___ es menor que 600 y mayor que 500',
            'options': ['601', '499', '550', '700'],
            'correct_answer': '550',
          },
        ),
        Exercise(
          id: 'l204-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de menor a mayor: 850, 508, 805, 580',
            'items': ['850', '508', '805', '580'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {'508': '1°', '580': '2°', '805': '3°', '850': '4°'},
          },
        ),
        Exercise(
          id: 'l204-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el colegio San Jorge hay 324 estudiantes y en el colegio La Esperanza hay 342. ¿Cuál tiene más estudiantes?',
            'options': ['San Jorge', 'La Esperanza', 'Los dos igual', 'No se sabe'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l204-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número que va entre 498 y 500 es ___',
            'options': ['497', '499', '501', '502'],
            'correct_answer': '499',
          },
        ),
      ],
    ),

    'lesson-205': const Lesson(
      id: 'lesson-205', unitId: 'unit-201', orderNum: 5,
      title: '¡Desafío numérico!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l205-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 4 centenas + 3 decenas + 7 unidades?',
            'options': ['347', '437', '374', '473'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l205-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el número 961, el dígito de las decenas es ___',
            'options': ['1', '6', '9', '61'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l205-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estos números es el mayor?',
            'options': ['789', '798', '897', '879'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l205-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con el valor que representa el dígito 3',
            'items': ['300', '30', '3'],
            'targets': ['centenas', 'decenas', 'unidades'],
            'correct_mapping': {'300': 'centenas', '30': 'decenas', '3': 'unidades'},
          },
        ),
        Exercise(
          id: 'l205-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un bus escolar recorre 100 km el lunes, 200 km el martes y 300 km el miércoles. En total recorrió ___ km',
            'options': ['500', '600', '400', '700'],
            'correct_answer': '600',
          },
        ),
        Exercise(
          id: 'l205-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la tienda de don Carlos hay 518 fichas y en la tienda de doña Rosa hay 581. ¿Cuál tienda tiene más?',
            'options': ['Don Carlos', 'Doña Rosa', 'Las dos igual', 'No se puede saber'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 202: Suma y resta hasta 100 ── DBA #2 Grado 2°
    // "Resuelve y formula problemas de adición y sustracción hasta 100."
    'lesson-206': const Lesson(
      id: 'lesson-206', unitId: 'unit-202', orderNum: 1,
      title: 'Sumar decenas',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l206-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Suma las decenas: 3 + 4 = 7, entonces 30 + 40 = 70',
          content: {
            'question': '¿Cuánto es 30 + 40?',
            'options': ['60', '70', '80', '50'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l206-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '20 + 60 = ___',
            'options': ['70', '80', '90', '60'],
            'correct_answer': '80',
          },
        ),
        Exercise(
          id: 'l206-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el mercado había 40 mangos 🥭 y llegaron 50 más. ¿Cuántos hay en total?',
            'options': ['80', '90', '100', '70'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l206-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma con su resultado',
            'items': ['10+20', '30+30', '50+40'],
            'targets': ['30', '60', '90'],
            'correct_mapping': {'10+20': '30', '30+30': '60', '50+40': '90'},
          },
        ),
        Exercise(
          id: 'l206-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número más 30 da 80?',
          content: {
            'sentence': '___ + 30 = 80',
            'options': ['40', '50', '60', '70'],
            'correct_answer': '50',
          },
        ),
      ],
    ),

    'lesson-207': const Lesson(
      id: 'lesson-207', unitId: 'unit-202', orderNum: 2,
      title: 'Sumar con llevada',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l207-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Suma las unidades primero: 8 + 7 = 15, llevas 1',
          content: {
            'question': '¿Cuánto es 38 + 47?',
            'options': ['75', '85', '84', '76'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l207-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '47 + 36 = ___',
            'options': ['72', '83', '73', '84'],
            'correct_answer': '83',
          },
        ),
        Exercise(
          id: 'l207-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Luisa tiene \$57 en su alcancía y su mamá le da \$28 más. ¿Cuánto tiene ahora?',
            'options': ['75', '85', '84', '86'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l207-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '65 + 29 = ___',
            'options': ['84', '94', '93', '95'],
            'correct_answer': '94',
          },
        ),
        Exercise(
          id: 'l207-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma con su resultado',
            'items': ['46+35', '57+26', '38+44'],
            'targets': ['81', '83', '82'],
            'correct_mapping': {'46+35': '81', '57+26': '83', '38+44': '82'},
          },
        ),
      ],
    ),

    'lesson-208': const Lesson(
      id: 'lesson-208', unitId: 'unit-202', orderNum: 3,
      title: 'Restar decenas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l208-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Resta las decenas: 7 - 3 = 4, entonces 70 - 30 = 40',
          content: {
            'question': '¿Cuánto es 70 - 30?',
            'options': ['30', '40', '50', '60'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l208-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '90 - 40 = ___',
            'options': ['40', '50', '60', '30'],
            'correct_answer': '50',
          },
        ),
        Exercise(
          id: 'l208-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la lonchera había 80 uvas 🍇 y te comiste 20. ¿Cuántas quedan?',
            'options': ['50', '60', '70', '80'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l208-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada resta con su resultado',
            'items': ['80-40', '90-30', '70-20'],
            'targets': ['40', '60', '50'],
            'correct_mapping': {'80-40': '40', '90-30': '60', '70-20': '50'},
          },
        ),
        Exercise(
          id: 'l208-e5', orderNum: 5, type: ExerciseType.fillBlank,
          hint: 'Piensa: ¿qué número le quito a 100 para que queden 60?',
          content: {
            'sentence': '100 - ___ = 60',
            'options': ['30', '40', '50', '60'],
            'correct_answer': '40',
          },
        ),
      ],
    ),

    'lesson-209': const Lesson(
      id: 'lesson-209', unitId: 'unit-202', orderNum: 4,
      title: 'Restar con préstamo',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l209-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'No puedes restar 5 de 3, pides prestado a las decenas',
          content: {
            'question': '¿Cuánto es 73 - 45?',
            'options': ['27', '28', '38', '37'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l209-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '82 - 37 = ___',
            'options': ['44', '45', '55', '35'],
            'correct_answer': '45',
          },
        ),
        Exercise(
          id: 'l209-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la tienda había 91 paquetes de papas y se vendieron 56. ¿Cuántos quedan?',
            'options': ['25', '35', '36', '45'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l209-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '64 - 28 = ___',
            'options': ['34', '36', '46', '38'],
            'correct_answer': '36',
          },
        ),
        Exercise(
          id: 'l209-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada resta con su resultado',
            'items': ['81-45', '73-28', '92-57'],
            'targets': ['36', '45', '35'],
            'correct_mapping': {'81-45': '36', '73-28': '45', '92-57': '35'},
          },
        ),
      ],
    ),

    'lesson-210': const Lesson(
      id: 'lesson-210', unitId: 'unit-202', orderNum: 5,
      title: '¡Campeón de operaciones!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l210-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Camila tenía \$65 y gastó \$28 en la tienda. ¿Cuánto le queda?',
            'options': ['37', '47', '33', '43'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l210-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '58 + 37 = ___',
            'options': ['85', '95', '94', '96'],
            'correct_answer': '95',
          },
        ),
        Exercise(
          id: 'l210-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el mercado de Bogotá había 83 cajitas de fresas 🍓 y se vendieron 46. ¿Cuántas quedan?',
            'options': ['37', '47', '36', '38'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l210-e4', orderNum: 4, type: ExerciseType.fillBlank,
          hint: 'Piensa: 91 menos 47 es igual a ___',
          content: {
            'sentence': '___ + 47 = 91',
            'options': ['44', '45', '54', '46'],
            'correct_answer': '44',
          },
        ),
        Exercise(
          id: 'l210-e5', orderNum: 5, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 76 + 48?',
            'options': ['114', '124', '123', '134'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l210-e6', orderNum: 6, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada operación con su resultado',
            'items': ['67+26', '84-38', '53+39'],
            'targets': ['93', '46', '92'],
            'correct_mapping': {'67+26': '93', '84-38': '46', '53+39': '92'},
          },
        ),
      ],
    ),

    // ── UNIDAD 203: Tablas × 2, × 3, × 5 ── DBA #3 Grado 2°
    // "Comprende la multiplicación como adición repetida. Tablas del 2, 3 y 5."
    'lesson-211': const Lesson(
      id: 'lesson-211', unitId: 'unit-203', orderNum: 1,
      title: 'Grupos iguales',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l211-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Multiplica: 3 × 4 es sumar 4 tres veces',
          content: {
            'question': 'Hay 3 canastas con 4 mangos 🥭 cada una. ¿Cuántos mangos hay en total?',
            'options': ['7', '12', '8', '10'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l211-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Hay 2 bandejas con 5 arepas cada una. ¿Cuántas arepas hay?',
            'options': ['7', '10', '8', '12'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l211-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': '4 grupos de 3 = ___',
            'options': ['7', '9', '12', '10'],
            'correct_answer': '12',
          },
        ),
        Exercise(
          id: 'l211-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada agrupación con su total',
            'items': ['2 grupos de 4', '3 grupos de 3', '5 grupos de 2'],
            'targets': ['8', '9', '10'],
            'correct_mapping': {
              '2 grupos de 4': '8',
              '3 grupos de 3': '9',
              '5 grupos de 2': '10',
            },
          },
        ),
        Exercise(
          id: 'l211-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3 filas de 6 sillas = ___ sillas',
            'options': ['15', '16', '18', '21'],
            'correct_answer': '18',
          },
        ),
      ],
    ),

    'lesson-212': const Lesson(
      id: 'lesson-212', unitId: 'unit-203', orderNum: 2,
      title: 'Tabla del 2',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l212-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 2 × 4?',
            'options': ['6', '8', '10', '4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l212-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2 × 7 = ___',
            'options': ['12', '14', '16', '9'],
            'correct_answer': '14',
          },
        ),
        Exercise(
          id: 'l212-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Santiago tiene 3 paquetes de chicles con 2 chicles cada uno. ¿Cuántos chicles tiene?',
            'options': ['5', '6', '7', '8'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l212-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2 × 9 = ___',
            'options': ['16', '18', '20', '14'],
            'correct_answer': '18',
          },
        ),
        Exercise(
          id: 'l212-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['2×3', '2×6', '2×8'],
            'targets': ['6', '12', '16'],
            'correct_mapping': {'2×3': '6', '2×6': '12', '2×8': '16'},
          },
        ),
      ],
    ),

    'lesson-213': const Lesson(
      id: 'lesson-213', unitId: 'unit-203', orderNum: 3,
      title: 'Tabla del 3',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l213-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 3 × 5?',
            'options': ['12', '15', '18', '9'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l213-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3 × 7 = ___',
            'options': ['18', '21', '24', '14'],
            'correct_answer': '21',
          },
        ),
        Exercise(
          id: 'l213-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En cada fila del salón hay 3 sillas. Si hay 8 filas, ¿cuántas sillas hay?',
            'options': ['22', '24', '21', '27'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l213-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3 × 9 = ___',
            'options': ['24', '27', '30', '21'],
            'correct_answer': '27',
          },
        ),
        Exercise(
          id: 'l213-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['3×4', '3×6', '3×8'],
            'targets': ['12', '18', '24'],
            'correct_mapping': {'3×4': '12', '3×6': '18', '3×8': '24'},
          },
        ),
      ],
    ),

    'lesson-214': const Lesson(
      id: 'lesson-214', unitId: 'unit-203', orderNum: 4,
      title: 'Tabla del 5',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l214-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 5 × 4?',
            'options': ['15', '20', '25', '10'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l214-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '5 × 6 = ___',
            'options': ['25', '30', '35', '20'],
            'correct_answer': '30',
          },
        ),
        Exercise(
          id: 'l214-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Hay 7 paquetes de chicles con 5 chicles cada uno. ¿Cuántos chicles hay en total?',
            'options': ['30', '35', '40', '25'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l214-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '5 × 9 = ___',
            'options': ['40', '45', '50', '35'],
            'correct_answer': '45',
          },
        ),
        Exercise(
          id: 'l214-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['5×3', '5×7', '5×8'],
            'targets': ['15', '35', '40'],
            'correct_mapping': {'5×3': '15', '5×7': '35', '5×8': '40'},
          },
        ),
      ],
    ),

    'lesson-215': const Lesson(
      id: 'lesson-215', unitId: 'unit-203', orderNum: 5,
      title: '¡Desafío de tablas!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l215-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 2 × 8?',
            'options': ['14', '16', '18', '12'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l215-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3 × 6 = ___',
            'options': ['15', '18', '21', '12'],
            'correct_answer': '18',
          },
        ),
        Exercise(
          id: 'l215-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 5 × 7?',
            'options': ['30', '35', '40', '25'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l215-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['2×8', '3×7', '5×6'],
            'targets': ['16', '21', '30'],
            'correct_mapping': {'2×8': '16', '3×7': '21', '5×6': '30'},
          },
        ),
        Exercise(
          id: 'l215-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Hay 4 bandejas de arepas con 5 arepas cada una. ¿Cuántas arepas hay en total? ___',
            'options': ['15', '20', '25', '10'],
            'correct_answer': '20',
          },
        ),
        Exercise(
          id: 'l215-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál multiplicación da 24?',
            'options': ['2×9', '3×8', '5×5', '2×10'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 301: Números hasta 100.000 ── DBA #1 Grado 3°
    // "Lee, escribe y ordena números hasta 100.000. Representa en recta numérica."
    'lesson-301': const Lesson(
      id: 'lesson-301', unitId: 'unit-301', orderNum: 1,
      title: 'Los miles',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l301-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Un millar es igual a 1.000 unidades',
          content: {
            'question': '¿Cuántas unidades hay en 1.000?',
            'options': ['100', '1.000', '10.000', '500'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l301-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos miles tiene el número 5.000?',
            'options': ['3', '4', '5', '6'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l301-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3.000 = ___ miles',
            'options': ['2', '3', '4', '30'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l301-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su nombre',
            'items': ['1.000', '4.000', '7.000'],
            'targets': ['un mil', 'cuatro mil', 'siete mil'],
            'correct_mapping': {
              '1.000': 'un mil',
              '4.000': 'cuatro mil',
              '7.000': 'siete mil',
            },
          },
        ),
        Exercise(
          id: 'l301-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El Estadio El Campín tiene 38.000 sillas. ¿Cuántos miles son 38.000? ___',
            'options': ['3', '8', '38', '380'],
            'correct_answer': '38',
          },
        ),
      ],
    ),

    'lesson-302': const Lesson(
      id: 'lesson-302', unitId: 'unit-301', orderNum: 2,
      title: 'Decenas de mil',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l302-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '10 grupos de mil = una decena de mil',
          content: {
            'question': '¿Cuántas unidades hay en 10.000?',
            'options': ['1.000', '10.000', '100.000', '500'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l302-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '20.000 + 5.000 = ___',
            'options': ['15.000', '25.000', '52.000', '250.000'],
            'correct_answer': '25.000',
          },
        ),
        Exercise(
          id: 'l302-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '3 decenas de mil son iguales a…',
            'options': ['3.000', '30.000', '300.000', '3.000.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l302-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '85.000 - 10.000 = ___',
            'options': ['75.000', '80.000', '84.000', '95.000'],
            'correct_answer': '75.000',
          },
        ),
        Exercise(
          id: 'l302-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de menor a mayor',
            'items': ['45.000', '12.000', '78.000', '30.000'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {
              '12.000': '1°',
              '30.000': '2°',
              '45.000': '3°',
              '78.000': '4°',
            },
          },
        ),
      ],
    ),

    'lesson-303': const Lesson(
      id: 'lesson-303', unitId: 'unit-301', orderNum: 3,
      title: 'Comparar números grandes',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l303-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál número es mayor: 34.500 o 34.050?',
            'options': ['34.050', '34.500', '34.005', '34.550'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l303-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '___ es mayor que 45.000 y menor que 46.000',
            'options': ['44.999', '45.500', '46.001', '43.000'],
            'correct_answer': '45.500',
          },
        ),
        Exercise(
          id: 'l303-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'La distancia de Bogotá a Medellín es 415 km y a Cali es 462 km. ¿Cuál ciudad está más lejos de Bogotá?',
            'options': ['Medellín', 'Cali', 'Las dos igual', 'No se puede saber'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l303-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número que va entre 79.999 y 80.001 es ___',
            'options': ['79.998', '80.000', '80.002', '79.001'],
            'correct_answer': '80.000',
          },
        ),
        Exercise(
          id: 'l303-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de mayor a menor',
            'items': ['63.200', '36.200', '62.300', '32.600'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {
              '63.200': '1°',
              '62.300': '2°',
              '36.200': '3°',
              '32.600': '4°',
            },
          },
        ),
      ],
    ),

    'lesson-304': const Lesson(
      id: 'lesson-304', unitId: 'unit-301', orderNum: 4,
      title: 'La recta numérica',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l304-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'El punto del medio entre dos números es su promedio',
          content: {
            'question': '¿Qué número va exactamente en la mitad entre 10.000 y 20.000?',
            'options': ['12.000', '15.000', '18.000', '11.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l304-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Entre 40.000 y 60.000 el punto del medio en la recta es ___',
            'options': ['45.000', '50.000', '55.000', '48.000'],
            'correct_answer': '50.000',
          },
        ),
        Exercise(
          id: 'l304-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ubica estos números de menor a mayor en la recta numérica',
            'items': ['50.000', '10.000', '90.000', '70.000'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {
              '10.000': '1°',
              '50.000': '2°',
              '70.000': '3°',
              '90.000': '4°',
            },
          },
        ),
        Exercise(
          id: 'l304-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número está más cerca de 50.000 en la recta numérica?',
            'options': ['46.000', '53.000', '49.000', '58.000'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l304-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la recta numérica, ___ está entre 70.000 y 80.000',
            'options': ['69.000', '75.000', '80.500', '90.000'],
            'correct_answer': '75.000',
          },
        ),
      ],
    ),

    'lesson-305': const Lesson(
      id: 'lesson-305', unitId: 'unit-301', orderNum: 5,
      title: '¡Desafío de números grandes!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l305-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 30.000 + 7.000 + 400 + 50 + 6?',
            'options': ['37.456', '37.465', '37.564', '37.645'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l305-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el número 82.547, el dígito de los miles es ___',
            'options': ['2', '5', '7', '8'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l305-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es el mayor de estos números?',
            'options': ['54.320', '54.230', '54.032', '54.302'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l305-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el número 65.824, el dígito de las decenas de mil es ___',
            'options': ['2', '5', '6', '8'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l305-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de menor a mayor',
            'items': ['27.500', '72.500', '25.700', '70.250'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {
              '25.700': '1°',
              '27.500': '2°',
              '70.250': '3°',
              '72.500': '4°',
            },
          },
        ),
        Exercise(
          id: 'l305-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El Estadio Atanasio Girardot tiene cupo para 45.000 personas y el Estadio El Campín para 38.000. ¿Cuántas personas más caben en el Atanasio?',
            'options': ['5.000', '7.000', '9.000', '17.000'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 302: Tablas del 1 al 10 ── DBA #3 Grado 3°
    // "Comprende y aplica las tablas de multiplicar del 1 al 10."
    'lesson-306': const Lesson(
      id: 'lesson-306', unitId: 'unit-302', orderNum: 1,
      title: 'Tablas del 4 y del 6',
      type: LessonType.intro, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l306-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 4 × 7?',
            'options': ['24', '28', '32', '21'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l306-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '6 × 5 = ___',
            'options': ['24', '30', '36', '20'],
            'correct_answer': '30',
          },
        ),
        Exercise(
          id: 'l306-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 4 × 9?',
            'options': ['32', '36', '40', '28'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l306-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '6 × 8 = ___',
            'options': ['42', '48', '54', '40'],
            'correct_answer': '48',
          },
        ),
        Exercise(
          id: 'l306-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['4×6', '6×7', '4×8'],
            'targets': ['24', '42', '32'],
            'correct_mapping': {'4×6': '24', '6×7': '42', '4×8': '32'},
          },
        ),
      ],
    ),

    'lesson-307': const Lesson(
      id: 'lesson-307', unitId: 'unit-302', orderNum: 2,
      title: 'Tablas del 7 y del 8',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l307-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 7 × 6?',
            'options': ['36', '42', '49', '35'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l307-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '8 × 7 = ___',
            'options': ['48', '56', '63', '49'],
            'correct_answer': '56',
          },
        ),
        Exercise(
          id: 'l307-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 7 × 9?',
            'options': ['54', '63', '72', '56'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l307-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '8 × 9 = ___',
            'options': ['63', '72', '81', '64'],
            'correct_answer': '72',
          },
        ),
        Exercise(
          id: 'l307-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['7×7', '8×6', '7×8'],
            'targets': ['49', '48', '56'],
            'correct_mapping': {'7×7': '49', '8×6': '48', '7×8': '56'},
          },
        ),
      ],
    ),

    'lesson-308': const Lesson(
      id: 'lesson-308', unitId: 'unit-302', orderNum: 3,
      title: 'Tabla del 9',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l308-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 9 × 4?',
            'options': ['27', '36', '45', '30'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l308-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '9 × 7 = ___',
            'options': ['54', '63', '72', '56'],
            'correct_answer': '63',
          },
        ),
        Exercise(
          id: 'l308-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 9 × 8?',
            'options': ['63', '72', '81', '64'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l308-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '9 × 9 = ___',
            'options': ['72', '81', '90', '63'],
            'correct_answer': '81',
          },
        ),
        Exercise(
          id: 'l308-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['9×3', '9×6', '9×5'],
            'targets': ['27', '54', '45'],
            'correct_mapping': {'9×3': '27', '9×6': '54', '9×5': '45'},
          },
        ),
      ],
    ),

    'lesson-309': const Lesson(
      id: 'lesson-309', unitId: 'unit-302', orderNum: 4,
      title: 'Propiedad conmutativa',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l309-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Recuerda: 3 × 8 = 24, y el orden no cambia el resultado',
          content: {
            'question': '¿Cuánto es 8 × 3?',
            'options': ['20', '24', '28', '18'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l309-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 6 × 8 = 48, entonces 8 × 6 = ___',
            'options': ['46', '48', '56', '42'],
            'correct_answer': '48',
          },
        ),
        Exercise(
          id: 'l309-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Es lo mismo multiplicar 7 × 4 que 4 × 7?',
            'options': ['Sí, siempre', 'No, cambia el resultado', 'A veces', 'Depende del número'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l309-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 9 × 5 = 45, entonces 5 × 9 = ___',
            'options': ['40', '45', '50', '54'],
            'correct_answer': '45',
          },
        ),
        Exercise(
          id: 'l309-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su igual conmutativo',
            'items': ['6×7', '8×3', '9×4'],
            'targets': ['7×6', '3×8', '4×9'],
            'correct_mapping': {'6×7': '7×6', '8×3': '3×8', '9×4': '4×9'},
          },
        ),
      ],
    ),

    'lesson-310': const Lesson(
      id: 'lesson-310', unitId: 'unit-302', orderNum: 5,
      title: '¡Campeón de tablas!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l310-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 7 × 8?',
            'options': ['54', '56', '63', '49'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l310-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '9 × 6 = ___',
            'options': ['48', '54', '63', '45'],
            'correct_answer': '54',
          },
        ),
        Exercise(
          id: 'l310-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['7×9', '8×6', '9×9'],
            'targets': ['63', '48', '81'],
            'correct_mapping': {'7×9': '63', '8×6': '48', '9×9': '81'},
          },
        ),
        Exercise(
          id: 'l310-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 6 × 6?',
            'options': ['30', '36', '42', '32'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l310-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 4 × 8 = 32, entonces 8 × ___ = 32',
            'options': ['3', '4', '6', '8'],
            'correct_answer': '4',
          },
        ),
        Exercise(
          id: 'l310-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un agricultor tiene 7 surcos con 9 plantas de yuca cada uno. ¿Cuántas plantas hay en total?',
            'options': ['54', '63', '72', '56'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 303: División básica ── DBA #4 Grado 3°
    // "Comprende la división como reparto equitativo y como medida."
    'lesson-311': const Lesson(
      id: 'lesson-311', unitId: 'unit-303', orderNum: 1,
      title: '¿Qué es dividir?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l311-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Dividir es repartir en grupos iguales',
          content: {
            'question': '12 mangos 🥭 repartidos en 3 canastas iguales. ¿Cuántos mangos hay por canasta?',
            'options': ['3', '4', '5', '6'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l311-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': '10 obleas repartidas entre 2 amigos. ¿Cuántas le tocan a cada uno?',
            'options': ['4', '5', '6', '8'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l311-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': '15 ÷ 3 = ___',
            'options': ['4', '5', '6', '7'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l311-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '8 ÷ 2 = ___',
            'options': ['3', '4', '5', '6'],
            'correct_answer': '4',
          },
        ),
        Exercise(
          id: 'l311-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división con su resultado',
            'items': ['6÷2', '12÷3', '10÷2'],
            'targets': ['3', '4', '5'],
            'correct_mapping': {'6÷2': '3', '12÷3': '4', '10÷2': '5'},
          },
        ),
      ],
    ),

    'lesson-312': const Lesson(
      id: 'lesson-312', unitId: 'unit-303', orderNum: 2,
      title: 'Dividir entre 2 y 3',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l312-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 18 ÷ 2?',
            'options': ['7', '9', '8', '6'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l312-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '24 ÷ 3 = ___',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '8',
          },
        ),
        Exercise(
          id: 'l312-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 27 ÷ 3?',
            'options': ['7', '9', '8', '6'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l312-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '16 ÷ 2 = ___',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '8',
          },
        ),
        Exercise(
          id: 'l312-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división con su resultado',
            'items': ['14÷2', '24÷3', '18÷3'],
            'targets': ['7', '8', '6'],
            'correct_mapping': {'14÷2': '7', '24÷3': '8', '18÷3': '6'},
          },
        ),
      ],
    ),

    'lesson-313': const Lesson(
      id: 'lesson-313', unitId: 'unit-303', orderNum: 3,
      title: 'Dividir entre 4 y 5',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l313-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 28 ÷ 4?',
            'options': ['6', '7', '8', '5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l313-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '20 ÷ 4 = ___',
            'options': ['4', '5', '6', '8'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l313-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 35 ÷ 5?',
            'options': ['6', '7', '8', '5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l313-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '40 ÷ 5 = ___',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '8',
          },
        ),
        Exercise(
          id: 'l313-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división con su resultado',
            'items': ['32÷4', '45÷5', '40÷4'],
            'targets': ['8', '9', '10'],
            'correct_mapping': {'32÷4': '8', '45÷5': '9', '40÷4': '10'},
          },
        ),
      ],
    ),

    'lesson-314': const Lesson(
      id: 'lesson-314', unitId: 'unit-303', orderNum: 4,
      title: 'Dividir entre 6, 7 y 8',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l314-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 42 ÷ 6?',
            'options': ['5', '7', '8', '6'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l314-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '56 ÷ 7 = ___',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '8',
          },
        ),
        Exercise(
          id: 'l314-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 48 ÷ 8?',
            'options': ['5', '6', '7', '4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l314-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '63 ÷ 7 = ___',
            'options': ['7', '8', '9', '6'],
            'correct_answer': '9',
          },
        ),
        Exercise(
          id: 'l314-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división con su resultado',
            'items': ['54÷6', '49÷7', '64÷8'],
            'targets': ['9', '7', '8'],
            'correct_mapping': {'54÷6': '9', '49÷7': '7', '64÷8': '8'},
          },
        ),
      ],
    ),

    'lesson-315': const Lesson(
      id: 'lesson-315', unitId: 'unit-303', orderNum: 5,
      title: '¡Desafío de división!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l315-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '48 obleas repartidas en 6 grupos iguales. ¿Cuántas obleas hay por grupo?',
            'options': ['6', '8', '9', '7'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l315-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '72 ÷ 8 = ___',
            'options': ['7', '8', '9', '6'],
            'correct_answer': '9',
          },
        ),
        Exercise(
          id: 'l315-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 63 ÷ 9?',
            'options': ['6', '7', '8', '5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l315-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división con su resultado',
            'items': ['42÷7', '56÷8', '45÷9'],
            'targets': ['6', '7', '5'],
            'correct_mapping': {'42÷7': '6', '56÷8': '7', '45÷9': '5'},
          },
        ),
        Exercise(
          id: 'l315-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En un campo de yuca hay 81 plantas en 9 filas iguales. ¿Cuántas plantas hay por fila? ___',
            'options': ['7', '8', '9', '6'],
            'correct_answer': '9',
          },
        ),
        Exercise(
          id: 'l315-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 36 ÷ 4?',
            'options': ['8', '9', '6', '7'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 401: Fracciones ── DBA #3 Grado 4°
    // "Comprende fracciones equivalentes, propias e impropias."
    'lesson-401': const Lesson(
      id: 'lesson-401', unitId: 'unit-401', orderNum: 1,
      title: '¿Qué es una fracción?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l401-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'El numerador es las partes que tomaste, el denominador las partes totales',
          content: {
            'question': 'Si divides una pizza en 4 partes iguales y comes 1, ¿qué fracción comiste?',
            'options': ['1/2', '1/4', '1/3', '2/4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l401-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué fracción representa la mitad de un bocadillo de guayaba?',
            'options': ['1/4', '1/2', '1/3', '2/3'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l401-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un sancocho se repartió en 3 partes iguales y comiste 1. Comiste ___ del sancocho',
            'options': ['1/2', '1/3', '1/4', '2/3'],
            'correct_answer': '1/3',
          },
        ),
        Exercise(
          id: 'l401-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada fracción con su nombre',
            'items': ['1/2', '1/3', '1/4'],
            'targets': ['un medio', 'un tercio', 'un cuarto'],
            'correct_mapping': {'1/2': 'un medio', '1/3': 'un tercio', '1/4': 'un cuarto'},
          },
        ),
        Exercise(
          id: 'l401-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si una figura se divide en 5 partes iguales y sombreo 3, la fracción sombreada es ___',
            'options': ['2/5', '3/5', '3/4', '5/3'],
            'correct_answer': '3/5',
          },
        ),
      ],
    ),

    'lesson-402': const Lesson(
      id: 'lesson-402', unitId: 'unit-401', orderNum: 2,
      title: 'Mitad y cuarto',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l402-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es la mitad de 12?',
            'options': ['4', '6', '8', '3'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l402-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La cuarta parte de 20 es ___',
            'options': ['4', '5', '8', '10'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l402-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El río Magdalena recorre 1/2 del largo de Colombia. Si el país mide 1.800 km de norte a sur, ¿cuántos km recorre el río?',
            'options': ['600', '900', '1.200', '450'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l402-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '1/4 de 24 es ___',
            'options': ['4', '6', '8', '12'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l402-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada fracción con el valor que representa de 12',
            'items': ['1/2 de 12', '1/3 de 12', '1/4 de 12'],
            'targets': ['6', '4', '3'],
            'correct_mapping': {'1/2 de 12': '6', '1/3 de 12': '4', '1/4 de 12': '3'},
          },
        ),
      ],
    ),

    'lesson-403': const Lesson(
      id: 'lesson-403', unitId: 'unit-401', orderNum: 3,
      title: 'Tercios y quintos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l403-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 1/3 de 15?',
            'options': ['3', '5', '6', '9'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l403-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2/5 de 25 es ___',
            'options': ['5', '10', '15', '20'],
            'correct_answer': '10',
          },
        ),
        Exercise(
          id: 'l403-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Se cortó un sancocho en 5 porciones iguales y se repartieron 3. ¿Qué fracción se repartió?',
            'options': ['2/5', '3/5', '1/5', '4/5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l403-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2/3 de 18 es ___',
            'options': ['6', '9', '12', '15'],
            'correct_answer': '12',
          },
        ),
        Exercise(
          id: 'l403-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada fracción con el valor que representa de 30',
            'items': ['1/3 de 30', '2/5 de 30', '1/5 de 30'],
            'targets': ['10', '12', '6'],
            'correct_mapping': {'1/3 de 30': '10', '2/5 de 30': '12', '1/5 de 30': '6'},
          },
        ),
      ],
    ),

    'lesson-404': const Lesson(
      id: 'lesson-404', unitId: 'unit-401', orderNum: 4,
      title: 'Fracciones equivalentes',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l404-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál fracción es equivalente a 1/2?',
            'options': ['1/3', '2/4', '1/4', '2/6'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l404-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '1/2 es equivalente a ___/4',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l404-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estas fracciones NO es equivalente a 2/4?',
            'options': ['1/2', '3/6', '4/8', '2/3'],
            'correct_index': 3,
          },
        ),
        Exercise(
          id: 'l404-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3/6 = ___/2',
            'options': ['1', '2', '3', '6'],
            'correct_answer': '1',
          },
        ),
        Exercise(
          id: 'l404-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona fracciones equivalentes',
            'items': ['1/2', '2/3', '3/4'],
            'targets': ['2/4', '4/6', '6/8'],
            'correct_mapping': {'1/2': '2/4', '2/3': '4/6', '3/4': '6/8'},
          },
        ),
      ],
    ),

    'lesson-405': const Lesson(
      id: 'lesson-405', unitId: 'unit-401', orderNum: 5,
      title: '¡Desafío de fracciones!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l405-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es mayor: 3/4 o 2/3?',
            'options': ['2/3', '3/4', 'Las dos iguales', 'No se puede saber'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l405-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '1/2 + 1/4 = ___/4',
            'options': ['2', '3', '4', '6'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l405-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada fracción con su equivalente simplificado',
            'items': ['4/8', '6/9', '9/12'],
            'targets': ['1/2', '2/3', '3/4'],
            'correct_mapping': {'4/8': '1/2', '6/9': '2/3', '9/12': '3/4'},
          },
        ),
        Exercise(
          id: 'l405-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un bocadillo de guayaba se dividió en 8 partes. Carlos comió 4 partes. En fracción simplificada, ¿qué fracción comió?',
            'options': ['1/4', '1/2', '2/3', '3/4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l405-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2/6 simplificada es ___/3',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '1',
          },
        ),
        Exercise(
          id: 'l405-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una receta de sancocho se usan 3/4 de taza de arroz. ¿Cuál fracción es equivalente?',
            'options': ['4/6', '6/8', '5/6', '2/3'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 402: Multiplicación y división ── DBA #2 Grado 4°
    // "Resuelve problemas de multiplicación y división con hasta 3 cifras."
    'lesson-406': const Lesson(
      id: 'lesson-406', unitId: 'unit-402', orderNum: 1,
      title: 'Multiplicar por decenas',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l406-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Multiplica el número y luego agrega el cero de la decena',
          content: {
            'question': '¿Cuánto es 30 × 6?',
            'options': ['180', '160', '200', '120'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l406-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '40 × 7 = ___',
            'options': ['240', '280', '320', '200'],
            'correct_answer': '280',
          },
        ),
        Exercise(
          id: 'l406-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 50 × 8?',
            'options': ['350', '400', '450', '300'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l406-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '20 × 9 = ___',
            'options': ['160', '180', '200', '140'],
            'correct_answer': '180',
          },
        ),
        Exercise(
          id: 'l406-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['30×5', '40×6', '70×3'],
            'targets': ['150', '240', '210'],
            'correct_mapping': {'30×5': '150', '40×6': '240', '70×3': '210'},
          },
        ),
      ],
    ),

    'lesson-407': const Lesson(
      id: 'lesson-407', unitId: 'unit-402', orderNum: 2,
      title: 'Multiplicar 2×2 cifras',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l407-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 23 × 14?',
            'options': ['312', '322', '332', '342'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l407-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '24 × 15 = ___',
            'options': ['340', '360', '380', '320'],
            'correct_answer': '360',
          },
        ),
        Exercise(
          id: 'l407-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 32 × 21?',
            'options': ['662', '672', '682', '652'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l407-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '45 × 12 = ___',
            'options': ['520', '540', '560', '580'],
            'correct_answer': '540',
          },
        ),
        Exercise(
          id: 'l407-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['13×11', '22×14', '31×12'],
            'targets': ['143', '308', '372'],
            'correct_mapping': {'13×11': '143', '22×14': '308', '31×12': '372'},
          },
        ),
      ],
    ),

    'lesson-408': const Lesson(
      id: 'lesson-408', unitId: 'unit-402', orderNum: 3,
      title: 'Dividir con residuo',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l408-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '5 × 3 = 15, y 17 - 15 = 2 de residuo',
          content: {
            'question': '¿Cuánto es 17 ÷ 5 (con residuo)?',
            'options': ['3 r2', '3 r3', '4 r1', '2 r7'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l408-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '23 ÷ 4 = 5 r ___',
            'options': ['2', '3', '4', '1'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l408-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 29 ÷ 6 (con residuo)?',
            'options': ['4 r5', '5 r4', '4 r4', '5 r3'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l408-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '37 ÷ 8 = 4 r ___',
            'options': ['4', '5', '6', '3'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l408-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división con su resultado (con residuo)',
            'items': ['13÷4', '25÷7', '34÷9'],
            'targets': ['3 r1', '3 r4', '3 r7'],
            'correct_mapping': {'13÷4': '3 r1', '25÷7': '3 r4', '34÷9': '3 r7'},
          },
        ),
      ],
    ),

    'lesson-409': const Lesson(
      id: 'lesson-409', unitId: 'unit-402', orderNum: 4,
      title: 'División de 2 cifras',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l409-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 84 ÷ 12?',
            'options': ['5', '6', '7', '8'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l409-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '96 ÷ 16 = ___',
            'options': ['4', '5', '6', '7'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l409-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 78 ÷ 13?',
            'options': ['4', '5', '6', '7'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l409-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '110 ÷ 22 = ___',
            'options': ['4', '5', '6', '7'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l409-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división con su resultado',
            'items': ['80÷16', '91÷13', '72÷12'],
            'targets': ['5', '7', '6'],
            'correct_mapping': {'80÷16': '5', '91÷13': '7', '72÷12': '6'},
          },
        ),
      ],
    ),

    'lesson-410': const Lesson(
      id: 'lesson-410', unitId: 'unit-402', orderNum: 5,
      title: '¡Campeón de operaciones!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l410-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 42 × 23?',
            'options': ['946', '966', '986', '956'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l410-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '144 ÷ 12 = ___',
            'options': ['10', '11', '12', '13'],
            'correct_answer': '12',
          },
        ),
        Exercise(
          id: 'l410-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un camión transporta 35 cajas por viaje. ¿Cuántas cajas transporta en 14 viajes?',
            'options': ['440', '490', '520', '470'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l410-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '26 ÷ 7 = 3 r ___',
            'options': ['4', '5', '6', '3'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l410-e5', orderNum: 5, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 52 × 19?',
            'options': ['978', '988', '998', '968'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l410-e6', orderNum: 6, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada operación con su resultado',
            'items': ['25×12', '96÷16', '38×15'],
            'targets': ['300', '6', '570'],
            'correct_mapping': {'25×12': '300', '96÷16': '6', '38×15': '570'},
          },
        ),
      ],
    ),

    // ── UNIDAD 403: Decimales y dinero ── DBA #4 Grado 4°
    // "Reconoce y usa decimales en contextos de medida y dinero (pesos colombianos)."
    'lesson-411': const Lesson(
      id: 'lesson-411', unitId: 'unit-403', orderNum: 1,
      title: '¿Qué son los decimales?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l411-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Las décimas están justo después del punto decimal',
          content: {
            'question': '¿Qué número decimal representa "tres décimas"?',
            'options': ['3.0', '0.3', '0.03', '30.0'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l411-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número decimal es "cinco centésimas"?',
            'options': ['5.0', '0.5', '0.05', '50.0'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l411-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': '0.7 se lee "siete ___"',
            'options': ['décimas', 'centésimas', 'unidades', 'décimas de mil'],
            'correct_answer': 'décimas',
          },
        ),
        Exercise(
          id: 'l411-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada decimal con su nombre',
            'items': ['0.1', '0.01', '0.5'],
            'targets': ['una décima', 'una centésima', 'cinco décimas'],
            'correct_mapping': {
              '0.1': 'una décima',
              '0.01': 'una centésima',
              '0.5': 'cinco décimas',
            },
          },
        ),
        Exercise(
          id: 'l411-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número 3.7 tiene ___ décimas',
            'options': ['3', '7', '37', '0'],
            'correct_answer': '7',
          },
        ),
      ],
    ),

    'lesson-412': const Lesson(
      id: 'lesson-412', unitId: 'unit-403', orderNum: 2,
      title: 'Décimas y centésimas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l412-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es el valor del 5 en el número 3.52?',
            'options': ['5 enteros', '5 décimas', '5 centésimas', '50'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l412-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el número 7.48, el dígito de las centésimas es ___',
            'options': ['4', '7', '8', '48'],
            'correct_answer': '8',
          },
        ),
        Exercise(
          id: 'l412-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál número es mayor: 2.5 o 2.50?',
            'options': ['2.5', '2.50', 'Son iguales', 'No se puede saber'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l412-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '4.6 = 4 + ___ décimas',
            'options': ['4', '6', '46', '60'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l412-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada decimal con su forma expandida',
            'items': ['0.3', '0.07', '1.5'],
            'targets': ['3 décimas', '7 centésimas', '1 entero y 5 décimas'],
            'correct_mapping': {
              '0.3': '3 décimas',
              '0.07': '7 centésimas',
              '1.5': '1 entero y 5 décimas',
            },
          },
        ),
      ],
    ),

    'lesson-413': const Lesson(
      id: 'lesson-413', unitId: 'unit-403', orderNum: 3,
      title: 'Sumar decimales',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l413-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Suma décima con décima: 3 + 4 = 7 décimas',
          content: {
            'question': '¿Cuánto es 1.3 + 2.4?',
            'options': ['3.5', '3.6', '3.7', '3.8'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l413-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2.5 + 1.8 = ___',
            'options': ['4.1', '4.2', '4.3', '4.4'],
            'correct_answer': '4.3',
          },
        ),
        Exercise(
          id: 'l413-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 0.75 + 0.25?',
            'options': ['0.9', '1.0', '1.1', '0.8'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l413-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3.6 + 2.7 = ___',
            'options': ['6.1', '6.2', '6.3', '6.4'],
            'correct_answer': '6.3',
          },
        ),
        Exercise(
          id: 'l413-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma con su resultado',
            'items': ['1.2+2.3', '0.5+0.8', '3.4+1.9'],
            'targets': ['3.5', '1.3', '5.3'],
            'correct_mapping': {'1.2+2.3': '3.5', '0.5+0.8': '1.3', '3.4+1.9': '5.3'},
          },
        ),
      ],
    ),

    'lesson-414': const Lesson(
      id: 'lesson-414', unitId: 'unit-403', orderNum: 4,
      title: 'Precios en pesos colombianos',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l414-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una libra de arroz cuesta \$2.500 y una de fríjol \$3.200. ¿Cuánto es el total?',
            'options': ['\$5.600', '\$5.700', '\$5.800', '\$5.500'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l414-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Compraste un cuaderno por \$3.500 y un lápiz por \$800. ¿Cuánto gastaste en total? ___',
            'options': ['\$3.800', '\$4.200', '\$4.300', '\$4.500'],
            'correct_answer': '\$4.300',
          },
        ),
        Exercise(
          id: 'l414-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Tenías \$10.000 y gastaste \$6.750. ¿Cuánto te queda?',
            'options': ['\$3.150', '\$3.250', '\$3.350', '\$3.450'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l414-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una botella de jugo cuesta \$1.200 y un pan \$750. El cambio de un billete de \$5.000 es ___',
            'options': ['\$2.850', '\$3.050', '\$3.150', '\$3.250'],
            'correct_answer': '\$3.050',
          },
        ),
        Exercise(
          id: 'l414-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada compra con su cambio de \$20.000',
            'items': ['Gasta \$8.500', 'Gasta \$12.300', 'Gasta \$15.750'],
            'targets': ['\$11.500', '\$7.700', '\$4.250'],
            'correct_mapping': {
              'Gasta \$8.500': '\$11.500',
              'Gasta \$12.300': '\$7.700',
              'Gasta \$15.750': '\$4.250',
            },
          },
        ),
      ],
    ),

    'lesson-415': const Lesson(
      id: 'lesson-415', unitId: 'unit-403', orderNum: 5,
      title: '¡Desafío de decimales!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l415-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 4.75 + 3.25?',
            'options': ['7.5', '8.0', '8.5', '7.0'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l415-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '9.3 - 4.8 = ___',
            'options': ['4.3', '4.5', '4.6', '4.4'],
            'correct_answer': '4.5',
          },
        ),
        Exercise(
          id: 'l415-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de menor a mayor',
            'items': ['1.70', '0.35', '2.03', '1.07'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {
              '0.35': '1°',
              '1.07': '2°',
              '1.70': '3°',
              '2.03': '4°',
            },
          },
        ),
        Exercise(
          id: 'l415-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una libra de queso cuesta \$5.800 y una de mantequilla \$4.600. ¿Cuánto más cara es la libra de queso?',
            'options': ['\$1.000', '\$1.200', '\$1.400', '\$900'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l415-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2.08 + 3.72 = ___',
            'options': ['5.70', '5.80', '5.90', '5.60'],
            'correct_answer': '5.80',
          },
        ),
        Exercise(
          id: 'l415-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estos números es el mayor?',
            'options': ['3.09', '3.9', '3.19', '3.91'],
            'correct_index': 3,
          },
        ),
      ],
    ),

    // ── UNIDAD 501: Números enteros ── DBA #1 Grado 5°
    // "Opera con números enteros negativos en contextos reales."
    'lesson-501': const Lesson(
      id: 'lesson-501', unitId: 'unit-501', orderNum: 1,
      title: 'Números negativos',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l501-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Cuando bajamos de 0, los números se vuelven negativos',
          content: {
            'question': 'La temperatura en el páramo era 2°C y bajó 5°C. ¿Cuál es la temperatura ahora?',
            'options': ['-3°C', '3°C', '-7°C', '7°C'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l501-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En Cartagena el nivel del mar es 0 m. Un submarino está 15 m bajo el agua. ¿Qué número representa esa profundidad?',
            'options': ['15', '0', '-15', '-5'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l501-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si la temperatura bajó de 3°C a -2°C, bajó ___ grados',
            'options': ['1', '5', '6', '7'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l501-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de menor a mayor en la recta numérica',
            'items': ['-3', '0', '2', '-1'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {'-3': '1°', '-1': '2°', '0': '3°', '2': '4°'},
          },
        ),
        Exercise(
          id: 'l501-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El opuesto de +4 es ___',
            'options': ['-4', '4', '0', '-8'],
            'correct_answer': '-4',
          },
        ),
      ],
    ),

    'lesson-502': const Lesson(
      id: 'lesson-502', unitId: 'unit-501', orderNum: 2,
      title: 'La recta numérica entera',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l502-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número está entre -3 y -1 en la recta numérica?',
            'options': ['-4', '-2', '0', '1'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l502-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la recta numérica, el número que está 3 posiciones a la derecha de -5 es ___',
            'options': ['-8', '-3', '-2', '-1'],
            'correct_answer': '-2',
          },
        ),
        Exercise(
          id: 'l502-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número es menor: -6 o -2?',
            'options': ['-2', '-6', 'Son iguales', 'No se puede saber'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l502-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número que está a igual distancia de -4 y +4 en la recta numérica es ___',
            'options': ['-1', '0', '1', '2'],
            'correct_answer': '0',
          },
        ),
        Exercise(
          id: 'l502-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de menor a mayor',
            'items': ['-5', '3', '-1', '0'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {'-5': '1°', '-1': '2°', '0': '3°', '3': '4°'},
          },
        ),
      ],
    ),

    'lesson-503': const Lesson(
      id: 'lesson-503', unitId: 'unit-501', orderNum: 3,
      title: 'Comparar enteros',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l503-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es mayor: -4 o -9?',
            'options': ['-9', '-4', 'Son iguales', '0'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l503-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '___ es mayor que -5',
            'options': ['-8', '-6', '-5', '-3'],
            'correct_answer': '-3',
          },
        ),
        Exercise(
          id: 'l503-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿En cuál lista los números están ordenados de menor a mayor?',
            'options': ['-3, -1, 0, 2', '2, 0, -1, -3', '-1, -3, 0, 2', '-3, 0, -1, 2'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l503-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El entero ___ está a igual distancia de 0 que +7 pero en el lado negativo',
            'options': ['7', '-7', '0', '-6'],
            'correct_answer': '-7',
          },
        ),
        Exercise(
          id: 'l503-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de mayor a menor',
            'items': ['-2', '5', '-8', '1'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {'5': '1°', '1': '2°', '-2': '3°', '-8': '4°'},
          },
        ),
      ],
    ),

    'lesson-504': const Lesson(
      id: 'lesson-504', unitId: 'unit-501', orderNum: 4,
      title: 'Sumar y restar enteros',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l504-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Empieza en -3 y avanza 7 hacia la derecha',
          content: {
            'question': '¿Cuánto es (-3) + 7?',
            'options': ['-4', '-10', '4', '10'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l504-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '5 + (-8) = ___',
            'options': ['-3', '3', '-13', '13'],
            'correct_answer': '-3',
          },
        ),
        Exercise(
          id: 'l504-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada operación con su resultado',
            'items': ['(-3)+5', '4+(-7)', '(-2)+(-4)'],
            'targets': ['2', '-3', '-6'],
            'correct_mapping': {'(-3)+5': '2', '4+(-7)': '-3', '(-2)+(-4)': '-6'},
          },
        ),
        Exercise(
          id: 'l504-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': '(-6) - (-2) = ___',
            'options': ['-8', '-4', '4', '8'],
            'correct_answer': '-4',
          },
        ),
        Exercise(
          id: 'l504-e5', orderNum: 5, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En Bogotá la temperatura es 14°C. En el páramo de Sumapaz es -2°C. ¿Cuántos grados más hace en Bogotá?',
            'options': ['12', '14', '16', '18'],
            'correct_index': 2,
          },
        ),
      ],
    ),

    'lesson-505': const Lesson(
      id: 'lesson-505', unitId: 'unit-501', orderNum: 5,
      title: '¡Desafío de enteros!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l505-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es (-4) + (-5)?',
            'options': ['-1', '1', '-9', '9'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l505-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3 - 8 = ___',
            'options': ['-5', '5', '-11', '11'],
            'correct_answer': '-5',
          },
        ),
        Exercise(
          id: 'l505-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es el resultado de (-7) + 12 + (-3)?',
            'options': ['-2', '2', '-18', '18'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l505-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un submarino está a -30 m y sube 18 m. Ahora está a ___ m',
            'options': ['-48', '-18', '-12', '12'],
            'correct_answer': '-12',
          },
        ),
        Exercise(
          id: 'l505-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de menor a mayor',
            'items': ['-10', '3', '-4', '0'],
            'targets': ['1°', '2°', '3°', '4°'],
            'correct_mapping': {'-10': '1°', '-4': '2°', '0': '3°', '3': '4°'},
          },
        ),
        Exercise(
          id: 'l505-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'La deuda de Camilo en la tienda escolar es -\$800. Si paga \$500, ¿cuánto le queda por pagar?',
            'options': ['-\$1.300', '-\$300', '\$300', '\$1.300'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 502: Porcentajes ── DBA #3 Grado 5°
    // "Resuelve problemas con porcentajes (descuentos, propinas, IVA)."
    'lesson-506': const Lesson(
      id: 'lesson-506', unitId: 'unit-502', orderNum: 1,
      title: '¿Qué es un porcentaje?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l506-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'La palabra "por ciento" viene del latín "per centum"',
          content: {
            'question': '¿Qué significa "por ciento"?',
            'options': ['Por cada 10', 'Por cada 50', 'Por cada 100', 'Por cada 1.000'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l506-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cómo se escribe "cincuenta por ciento"?',
            'options': ['50%', '0.50', '5%', '500%'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l506-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': '100% representa ___',
            'options': ['la mitad', 'la cuarta parte', 'el todo completo', 'el doble'],
            'correct_answer': 'el todo completo',
          },
        ),
        Exercise(
          id: 'l506-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada porcentaje con su fracción',
            'items': ['50%', '25%', '10%'],
            'targets': ['1/2', '1/4', '1/10'],
            'correct_mapping': {'50%': '1/2', '25%': '1/4', '10%': '1/10'},
          },
        ),
        Exercise(
          id: 'l506-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si en un salón de 20 estudiantes el 50% son niñas, hay ___ niñas',
            'options': ['5', '8', '10', '15'],
            'correct_answer': '10',
          },
        ),
      ],
    ),

    'lesson-507': const Lesson(
      id: 'lesson-507', unitId: 'unit-502', orderNum: 2,
      title: 'El 50%, 25% y 10%',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l507-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es el 50% de 80?',
            'options': ['20', '40', '50', '60'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l507-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El 25% de 60 es ___',
            'options': ['12', '15', '20', '25'],
            'correct_answer': '15',
          },
        ),
        Exercise(
          id: 'l507-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es el 10% de 350?',
            'options': ['35', '50', '70', '100'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l507-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El 50% de \$12.000 es ___',
            'options': ['\$4.000', '\$5.000', '\$6.000', '\$8.000'],
            'correct_answer': '\$6.000',
          },
        ),
        Exercise(
          id: 'l507-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada porcentaje con su valor de 200',
            'items': ['10% de 200', '25% de 200', '50% de 200'],
            'targets': ['20', '50', '100'],
            'correct_mapping': {'10% de 200': '20', '25% de 200': '50', '50% de 200': '100'},
          },
        ),
      ],
    ),

    'lesson-508': const Lesson(
      id: 'lesson-508', unitId: 'unit-502', orderNum: 3,
      title: 'Calcular el porcentaje',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l508-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '20% = 20/100 = 1/5. Divide entre 5',
          content: {
            'question': '¿Cuánto es el 20% de 500?',
            'options': ['50', '100', '150', '200'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l508-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El 30% de 90 es ___',
            'options': ['18', '27', '30', '36'],
            'correct_answer': '27',
          },
        ),
        Exercise(
          id: 'l508-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es el 15% de 200?',
            'options': ['20', '25', '30', '40'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l508-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El 40% de \$5.000 es ___',
            'options': ['\$1.500', '\$2.000', '\$2.500', '\$3.000'],
            'correct_answer': '\$2.000',
          },
        ),
        Exercise(
          id: 'l508-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada porcentaje con su valor',
            'items': ['20% de 150', '30% de 200', '40% de 300'],
            'targets': ['30', '60', '120'],
            'correct_mapping': {'20% de 150': '30', '30% de 200': '60', '40% de 300': '120'},
          },
        ),
      ],
    ),

    'lesson-509': const Lesson(
      id: 'lesson-509', unitId: 'unit-502', orderNum: 4,
      title: 'Descuentos y ofertas',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l509-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Calcula el 25% y réstalo del precio original',
          content: {
            'question': 'Un cuaderno cuesta \$4.000 y tiene 25% de descuento. ¿Cuánto pagas?',
            'options': ['\$1.000', '\$2.000', '\$3.000', '\$3.500'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l509-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una camisa cuesta \$30.000 con 10% de descuento. El descuento es ___',
            'options': ['\$2.000', '\$3.000', '\$4.000', '\$5.000'],
            'correct_answer': '\$3.000',
          },
        ),
        Exercise(
          id: 'l509-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una chaqueta cuesta \$80.000 y tiene 50% de descuento. ¿Cuánto pagas?',
            'options': ['\$20.000', '\$30.000', '\$40.000', '\$50.000'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l509-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un libro cuesta \$15.000 con 20% de descuento. Pagas ___',
            'options': ['\$10.000', '\$11.000', '\$12.000', '\$13.000'],
            'correct_answer': '\$12.000',
          },
        ),
        Exercise(
          id: 'l509-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada artículo con su precio con descuento',
            'items': ['\$20.000 - 10%', '\$40.000 - 25%', '\$50.000 - 20%'],
            'targets': ['\$18.000', '\$30.000', '\$40.000'],
            'correct_mapping': {
              '\$20.000 - 10%': '\$18.000',
              '\$40.000 - 25%': '\$30.000',
              '\$50.000 - 20%': '\$40.000',
            },
          },
        ),
      ],
    ),

    'lesson-510': const Lesson(
      id: 'lesson-510', unitId: 'unit-502', orderNum: 5,
      title: '¡Desafío de porcentajes!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l510-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es el 35% de 200?',
            'options': ['60', '65', '70', '75'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l510-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un restaurante cobra 10% de propina sobre \$25.000. La propina es ___',
            'options': ['\$2.000', '\$2.500', '\$3.000', '\$3.500'],
            'correct_answer': '\$2.500',
          },
        ),
        Exercise(
          id: 'l510-e3', orderNum: 3, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada porcentaje con su valor',
            'items': ['10% de 400', '25% de 80', '50% de 60'],
            'targets': ['40', '20', '30'],
            'correct_mapping': {'10% de 400': '40', '25% de 80': '20', '50% de 60': '30'},
          },
        ),
        Exercise(
          id: 'l510-e4', orderNum: 4, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En San Victorino hay 30% de descuento en ropa. Una camiseta cuesta \$25.000. ¿Cuánto pagas?',
            'options': ['\$17.000', '\$17.500', '\$18.000', '\$19.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l510-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El IVA es del 19%. Si un artículo cuesta \$10.000, el IVA son ___',
            'options': ['\$1.000', '\$1.500', '\$1.900', '\$2.000'],
            'correct_answer': '\$1.900',
          },
        ),
        Exercise(
          id: 'l510-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué porcentaje de 80 es 20?',
            'options': ['15%', '20%', '25%', '30%'],
            'correct_index': 2,
          },
        ),
      ],
    ),

    // ── UNIDAD 503: Razones y proporciones ── DBA #4 Grado 5°
    // "Comprende razones y proporciones. Resuelve regla de tres simple."
    'lesson-511': const Lesson(
      id: 'lesson-511', unitId: 'unit-503', orderNum: 1,
      title: '¿Qué es una razón?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l511-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Una razón compara dos cantidades directamente',
          content: {
            'question': 'Si por cada 2 mangos pagas \$1.000, ¿cuál es la razón mango:precio?',
            'options': ['1:500', '2:1.000', '1:1.000', '2:500'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l511-e2', orderNum: 2, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una receta, por cada 3 tazas de harina se usa 1 de azúcar. ¿Cuál es la razón harina:azúcar?',
            'options': ['1:3', '3:1', '1:1', '3:3'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l511-e3', orderNum: 3, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si hay 4 niñas por cada 3 niños en un salón, la razón niñas:niños es ___:3',
            'options': ['1', '2', '4', '6'],
            'correct_answer': '4',
          },
        ),
        Exercise(
          id: 'l511-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada situación con su razón',
            'items': ['2 mangos/\$500', '3 libras/\$6.000', '5 km/1 hora'],
            'targets': ['2:500', '3:6.000', '5:1'],
            'correct_mapping': {
              '2 mangos/\$500': '2:500',
              '3 libras/\$6.000': '3:6.000',
              '5 km/1 hora': '5:1',
            },
          },
        ),
        Exercise(
          id: 'l511-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si la razón de mangos a naranjas es 2:3 y hay 6 mangos, hay ___ naranjas',
            'options': ['3', '6', '9', '12'],
            'correct_answer': '9',
          },
        ),
      ],
    ),

    'lesson-512': const Lesson(
      id: 'lesson-512', unitId: 'unit-503', orderNum: 2,
      title: 'Proporciones directas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l512-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si 2 libras de arroz cuestan \$4.000, ¿cuánto cuestan 4 libras?',
            'options': ['\$6.000', '\$8.000', '\$10.000', '\$12.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l512-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 5 personas comen 10 arepas, 10 personas comen ___ arepas',
            'options': ['15', '20', '25', '30'],
            'correct_answer': '20',
          },
        ),
        Exercise(
          id: 'l512-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un carro recorre 60 km en 1 hora. ¿Cuántos km recorre en 3 horas?',
            'options': ['120', '150', '180', '210'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l512-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 4 bolígrafos cuestan \$3.600, 7 bolígrafos cuestan ___',
            'options': ['\$5.600', '\$6.200', '\$6.300', '\$7.200'],
            'correct_answer': '\$6.300',
          },
        ),
        Exercise(
          id: 'l512-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada proporción con el valor faltante',
            'items': ['2:\$800 = 5:?', '3:\$900 = 6:?', '4:\$1.200 = 8:?'],
            'targets': ['\$2.000', '\$1.800', '\$2.400'],
            'correct_mapping': {
              '2:\$800 = 5:?': '\$2.000',
              '3:\$900 = 6:?': '\$1.800',
              '4:\$1.200 = 8:?': '\$2.400',
            },
          },
        ),
      ],
    ),

    'lesson-513': const Lesson(
      id: 'lesson-513', unitId: 'unit-503', orderNum: 3,
      title: 'Regla de tres simple',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l513-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Usa la regla de tres: 3 → \$6.000, entonces 5 → ?',
          content: {
            'question': 'Si 3 libras de arroz cuestan \$6.000, ¿cuánto cuestan 5 libras?',
            'options': ['\$8.000', '\$10.000', '\$12.000', '\$9.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l513-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 4 cuadernos cuestan \$12.000, 6 cuadernos cuestan ___',
            'options': ['\$14.000', '\$16.000', '\$18.000', '\$20.000'],
            'correct_answer': '\$18.000',
          },
        ),
        Exercise(
          id: 'l513-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un albañil cobra \$80.000 por 2 días de trabajo. ¿Cuánto cobra por 5 días?',
            'options': ['\$160.000', '\$180.000', '\$200.000', '\$220.000'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l513-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si en 3 minutos se llenan 9 vasos de agua, en 5 minutos se llenan ___ vasos',
            'options': ['12', '15', '18', '20'],
            'correct_answer': '15',
          },
        ),
        Exercise(
          id: 'l513-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Aplica la regla de tres para encontrar el valor faltante',
            'items': ['5 mangos → \$2.500; 8 →?', '3 km → 6 min; 7 km →?', '2 l → \$1.800; 5 l →?'],
            'targets': ['\$4.000', '14 min', '\$4.500'],
            'correct_mapping': {
              '5 mangos → \$2.500; 8 →?': '\$4.000',
              '3 km → 6 min; 7 km →?': '14 min',
              '2 l → \$1.800; 5 l →?': '\$4.500',
            },
          },
        ),
      ],
    ),

    'lesson-514': const Lesson(
      id: 'lesson-514', unitId: 'unit-503', orderNum: 4,
      title: 'Aplicaciones reales',
      type: LessonType.standard, estimatedMinutes: 7,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l514-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un mapa de Colombia tiene escala 1:500.000. Si la distancia en el mapa es 4 cm, ¿cuántos km son en realidad?',
            'options': ['10', '15', '20', '25'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l514-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una receta para 4 personas necesita 2 tazas de arroz. Para 10 personas se necesitan ___ tazas',
            'options': ['4', '5', '6', '8'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l514-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una fábrica produce 120 arepas en 4 horas. ¿Cuántas produce en 7 horas?',
            'options': ['180', '210', '240', '270'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l514-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si por cada \$10.000 ahorras el 15%, en \$40.000 ahorras ___',
            'options': ['\$4.000', '\$5.000', '\$6.000', '\$8.000'],
            'correct_answer': '\$6.000',
          },
        ),
        Exercise(
          id: 'l514-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Resuelve cada proporción directa',
            'items': ['2 kg → \$6.000; 7 kg →?', '3 buses → 90 pasaj.; 5 →?', '4 l → \$3.200; 9 l →?'],
            'targets': ['\$21.000', '150 pasaj.', '\$7.200'],
            'correct_mapping': {
              '2 kg → \$6.000; 7 kg →?': '\$21.000',
              '3 buses → 90 pasaj.; 5 →?': '150 pasaj.',
              '4 l → \$3.200; 9 l →?': '\$7.200',
            },
          },
        ),
      ],
    ),

    'lesson-515': const Lesson(
      id: 'lesson-515', unitId: 'unit-503', orderNum: 5,
      title: '¡Desafío final!',
      type: LessonType.boss, estimatedMinutes: 10,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l515-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si 6 cuadernos cuestan \$18.000, ¿cuánto cuestan 10 cuadernos?',
            'options': ['\$25.000', '\$30.000', '\$35.000', '\$40.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l515-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un carro recorre 240 km con 20 litros de gasolina. Con 35 litros recorre ___ km',
            'options': ['360', '380', '400', '420'],
            'correct_answer': '420',
          },
        ),
        Exercise(
          id: 'l515-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'La razón de niños a adultos en un parque es 3:2. Si hay 18 niños, ¿cuántos adultos hay?',
            'options': ['9', '12', '15', '18'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l515-e4', orderNum: 4, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El 35% de \$60.000 es ___',
            'options': ['\$18.000', '\$20.000', '\$21.000', '\$24.000'],
            'correct_answer': '\$21.000',
          },
        ),
        Exercise(
          id: 'l515-e5', orderNum: 5, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada proporción con el valor faltante',
            'items': ['2:5 = 8:?', '3:7 = 9:?', '4:6 = 12:?'],
            'targets': ['20', '21', '18'],
            'correct_mapping': {'2:5 = 8:?': '20', '3:7 = 9:?': '21', '4:6 = 12:?': '18'},
          },
        ),
        Exercise(
          id: 'l515-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una tienda tiene 25% de descuento en todo. Un pantalón cuesta \$80.000. ¿Cuánto pagas?',
            'options': ['\$55.000', '\$60.000', '\$65.000', '\$70.000'],
            'correct_index': 1,
          },
        ),
      ],
    ),
  };
}
