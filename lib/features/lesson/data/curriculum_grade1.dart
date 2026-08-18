// Currículo Grado 1° — Números del 1 al 100, Suma, Resta
// 15 lecciones alineadas con DBA MEN Colombia

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade1Lessons = {
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
};
