// Currículo Grado 1° — 8 unidades (4 períodos académicos, 40 lecciones)
// Alineado con DBA MEN Colombia (Pensamientos NV, EM y AL)

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade1Lessons = {
    // ── UNIDAD 1: Números del 1 al 100 ── DBA #1 Grado 1°
    // "Cuenta, lee y escribe números hasta 100 en contextos de juego"
    'lesson-001': Lesson(
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

    'lesson-002': Lesson(
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

    'lesson-003': Lesson(
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

    'lesson-004': Lesson(
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

    'lesson-005': Lesson(
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
    'lesson-006': Lesson(
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

    'lesson-007': Lesson(
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

    'lesson-008': Lesson(
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

    'lesson-009': Lesson(
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

    'lesson-010': Lesson(
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
    'lesson-011': Lesson(
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

    'lesson-012': Lesson(
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

    'lesson-013': Lesson(
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

    'lesson-014': Lesson(
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

    'lesson-015': Lesson(
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

    // ── UNIDAD 4 (unit-004): Ubicación espacial ── DBA #7 Grado 1° (Período 1)
    // "Ubica objetos y personas en el espacio usando referencias (arriba/abajo, izquierda/derecha, cerca/lejos)."
    'lesson-016': Lesson(
      id: 'lesson-016', unitId: 'unit-004', orderNum: 1,
      title: 'Arriba y abajo',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l16-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Mira hacia el cielo cuando sales al patio',
          content: {
            'question': 'Cuando estás en el parque, ¿dónde están las nubes y el sol?',
            'options': ['Abajo', 'Arriba', 'Debajo del suelo', 'Adentro'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l16-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El pasto donde caminamos está ___ de nuestros pies',
            'options': ['arriba', 'abajo', 'encima', 'lejos'],
            'correct_answer': 'abajo',
          },
        ),
        Exercise(
          id: 'l16-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un pajarito está en la copa de un árbol de mango y un perro está en las raíces. ¿Quién está ARRIBA?',
            'options': ['El perro', 'El pajarito', 'Los dos igual', 'Ninguno'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l16-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada objeto con su posición normal',
            'items': ['Estrellas', 'Zapatos', 'Sombrero'],
            'targets': ['En el cielo (arriba)', 'En los pies (abajo)', 'En la cabeza (encima)'],
            'correct_mapping': {
              'Estrellas': 'En el cielo (arriba)',
              'Zapatos': 'En los pies (abajo)',
              'Sombrero': 'En la cabeza (encima)',
            },
          },
        ),
        Exercise(
          id: 'l16-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El cuaderno está ___ de la mesa del salón',
            'options': ['encima', 'adentro', 'lejos', 'detrás'],
            'correct_answer': 'encima',
          },
        ),
      ],
    ),

    'lesson-017': Lesson(
      id: 'lesson-017', unitId: 'unit-004', orderNum: 2,
      title: 'Izquierda y derecha',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l17-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la palabra SOL, ¿qué letra está a la IZQUIERDA de la O?',
            'options': ['L', 'S', 'O', 'Ninguna'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l17-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la fila 1 - 2 - 3, el número 3 está a la ___ del 2',
            'options': ['izquierda', 'derecha', 'arriba', 'abajo'],
            'correct_answer': 'derecha',
          },
        ),
        Exercise(
          id: 'l17-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la fila 🍎 🍌 🍍, ¿qué fruta está a la izquierda del banano?',
            'options': ['La piña 🍍', 'La manzana 🍎', 'El banano 🍌', 'Ninguna'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l17-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'En la fila A - B - C, ubica cada letra respecto a la B',
            'items': ['Letra A', 'Letra B', 'Letra C'],
            'targets': ['Izquierda', 'Centro', 'Derecha'],
            'correct_mapping': {'Letra A': 'Izquierda', 'Letra B': 'Centro', 'Letra C': 'Derecha'},
          },
        ),
        Exercise(
          id: 'l17-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Nuestro corazón late del lado ___ del pecho',
            'options': ['izquierdo', 'derecho', 'trasero', 'inferior'],
            'correct_answer': 'izquierdo',
          },
        ),
      ],
    ),

    'lesson-018': Lesson(
      id: 'lesson-018', unitId: 'unit-004', orderNum: 3,
      title: 'Cerca, lejos, delante y detrás',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l18-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si estás sentado en tu pupitre, ¿qué está más CERCA de ti?',
            'options': ['Tu lápiz', 'La montaña de Monserrate', 'La Luna', 'Otra ciudad'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l18-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la fila del descanso, el primer niño va ___ del segundo',
            'options': ['detrás', 'delante', 'debajo', 'adentro'],
            'correct_answer': 'delante',
          },
        ),
        Exercise(
          id: 'l18-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Cuando llevas tu maleta en la espalda, la maleta va…',
            'options': ['Delante de ti', 'Detrás de ti', 'Debajo de tus pies', 'Lejos de ti'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l18-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada palabra con su opuesto espacial',
            'items': ['Cerca', 'Delante', 'Arriba'],
            'targets': ['Lejos', 'Detrás', 'Abajo'],
            'correct_mapping': {'Cerca': 'Lejos', 'Delante': 'Detrás', 'Arriba': 'Abajo'},
          },
        ),
        Exercise(
          id: 'l18-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El Sol está muy ___ de la Tierra',
            'options': ['cerca', 'lejos', 'adentro', 'debajo'],
            'correct_answer': 'lejos',
          },
        ),
      ],
    ),

    'lesson-019': Lesson(
      id: 'lesson-019', unitId: 'unit-004', orderNum: 4,
      title: 'Dentro, fuera y en el borde',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l19-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Dónde guardas tus colores cuando terminas la tarea?',
            'options': ['Dentro de la cartuchera', 'Debajo del zapato', 'En el techo', 'Lejos del salón'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l19-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Los peces nadan ___ del agua del río',
            'options': ['fuera', 'dentro', 'encima', 'lejos'],
            'correct_answer': 'dentro',
          },
        ),
        Exercise(
          id: 'l19-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En un partido de fútbol, si el balón cruza la línea lateral, el balón está…',
            'options': ['Dentro de la cancha', 'Fuera de la cancha', 'Debajo del pasto', 'En el arco'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l19-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ubica cada elemento respecto a una canasta de frutas',
            'items': ['Semillas de la papaya', 'Mangos guardados', 'Mesa que sostiene la canasta'],
            'targets': ['Dentro de la fruta', 'Dentro de la canasta', 'Debajo de la canasta'],
            'correct_mapping': {
              'Semillas de la papaya': 'Dentro de la fruta',
              'Mangos guardados': 'Dentro de la canasta',
              'Mesa que sostiene la canasta': 'Debajo de la canasta',
            },
          },
        ),
        Exercise(
          id: 'l19-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Lo contrario de DENTRO es ___',
            'options': ['arriba', 'fuera', 'cerca', 'delante'],
            'correct_answer': 'fuera',
          },
        ),
      ],
    ),

    'lesson-020': Lesson(
      id: 'lesson-020', unitId: 'unit-004', orderNum: 5,
      title: '¡Desafío espacial!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l20-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la fila Sofía - Mateo - Valentina, ¿quién está ENTRE Sofía y Valentina?',
            'options': ['Sofía', 'Mateo', 'Valentina', 'Nadie'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l20-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si das un paso hacia adelante y luego uno hacia atrás, quedas en el ___ lugar',
            'options': ['mismo', 'último', 'techo', 'lejos'],
            'correct_answer': 'mismo',
          },
        ),
        Exercise(
          id: 'l20-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la secuencia 🐶 🐱 🐰, ¿qué animal está a la DERECHA del gato 🐱?',
            'options': ['El perro 🐶', 'El conejo 🐰', 'El gato 🐱', 'Ninguno'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l20-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada pista con la posición correcta',
            'items': ['Donde vuela el cóndor', 'Donde crecen las raíces', 'Donde llevas el morral'],
            'targets': ['Arriba', 'Debajo de la tierra', 'Detrás (en la espalda)'],
            'correct_mapping': {
              'Donde vuela el cóndor': 'Arriba',
              'Donde crecen las raíces': 'Debajo de la tierra',
              'Donde llevas el morral': 'Detrás (en la espalda)',
            },
          },
        ),
        Exercise(
          id: 'l20-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la fila 10 - 20 - 30, el 10 está a la ___ del 20',
            'options': ['izquierda', 'derecha', 'arriba', 'dentro'],
            'correct_answer': 'izquierda',
          },
        ),
        Exercise(
          id: 'l20-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El jugo de lulo está servido en el vaso. ¿Dónde está el jugo?',
            'options': ['Fuera del vaso', 'Dentro del vaso', 'Debajo de la mesa', 'Detrás de la silla'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 5 (unit-005): Medición y comparación ── DBA #4 Grado 1° (Período 2)
    // "Identifica y compara atributos medibles (largo, corto, pesado, liviano, lleno, vacío)."
    'lesson-021': Lesson(
      id: 'lesson-021', unitId: 'unit-005', orderNum: 1,
      title: 'Largo, corto, alto y bajo',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l21-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estos objetos es MÁS LARGO?',
            'options': ['Un borrador', 'Un bus de TransMilenio', 'Un lápiz', 'Una moneda'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l21-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una palma de cera del Quindío es más ___ que una flor',
            'options': ['baja', 'alta', 'corta', 'pequeña'],
            'correct_answer': 'alta',
          },
        ),
        Exercise(
          id: 'l21-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Entre un gusano y una serpiente boa, ¿cuál es más corto?',
            'options': ['La serpiente boa', 'El gusano', 'Miden igual', 'Ninguno'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l21-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena del más corto al más largo',
            'items': ['Hormiga', 'Lápiz', 'Cancha de fútbol'],
            'targets': ['1° (más corto)', '2° (mediano)', '3° (más largo)'],
            'correct_mapping': {
              'Hormiga': '1° (más corto)',
              'Lápiz': '2° (mediano)',
              'Cancha de fútbol': '3° (más largo)',
            },
          },
        ),
        Exercise(
          id: 'l21-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Lo opuesto de LARGO es ___',
            'options': ['corto', 'pesado', 'lleno', 'alto'],
            'correct_answer': 'corto',
          },
        ),
      ],
    ),

    'lesson-022': Lesson(
      id: 'lesson-022', unitId: 'unit-005', orderNum: 2,
      title: 'Pesado y liviano',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l22-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estos es MÁS PESADO?',
            'options': ['Una pluma de ave', 'Una sandía grande', 'Una hoja seca', 'Un algodón'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l22-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un globo inflado es más ___ que una piedra',
            'options': ['pesado', 'liviano', 'largo', 'bajo'],
            'correct_answer': 'liviano',
          },
        ),
        Exercise(
          id: 'l22-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una balanza de brazos, el lado que tiene el objeto más pesado se mueve hacia…',
            'options': ['Abajo', 'Arriba', 'La izquierda', 'No se mueve'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l22-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Clasifica del más liviano al más pesado',
            'items': ['Mariposa', 'Perro', 'Vaca'],
            'targets': ['Más liviano', 'Peso medio', 'Más pesado'],
            'correct_mapping': {
              'Mariposa': 'Más liviano',
              'Perro': 'Peso medio',
              'Vaca': 'Más pesado',
            },
          },
        ),
        Exercise(
          id: 'l22-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un bulto de papa de Boyacá es ___ que una sola papa',
            'options': ['más pesado', 'más liviano', 'más corto', 'vacío'],
            'correct_answer': 'más pesado',
          },
        ),
      ],
    ),

    'lesson-023': Lesson(
      id: 'lesson-023', unitId: 'unit-005', orderNum: 3,
      title: 'Lleno, vacío y capacidad',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l23-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿En cuál recipiente cabe MÁS agua?',
            'options': ['Una cuchara', 'Un vaso pequeño', 'Un balde grande', 'Una tapita'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l23-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Cuando te tomas toda el agua de tu termo, el termo queda ___',
            'options': ['lleno', 'vacío', 'pesado', 'largo'],
            'correct_answer': 'vacío',
          },
        ),
        Exercise(
          id: 'l23-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si una jarra llena alcanza para 4 vasos iguales, ¿en cuál cabe más líquido?',
            'options': ['En 1 vaso', 'En la jarra', 'En una cuchara', 'Caben igual'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l23-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena de menor a mayor capacidad',
            'items': ['Pocillo de tinto', 'Jarra de limonada', 'Piscina'],
            'targets': ['1° (cabe menos)', '2° (mediano)', '3° (cabe más)'],
            'correct_mapping': {
              'Pocillo de tinto': '1° (cabe menos)',
              'Jarra de limonada': '2° (mediano)',
              'Piscina': '3° (cabe más)',
            },
          },
        ),
        Exercise(
          id: 'l23-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Lo contrario de LLENO es ___',
            'options': ['vacío', 'alto', 'corto', 'pesado'],
            'correct_answer': 'vacío',
          },
        ),
      ],
    ),

    'lesson-024': Lesson(
      id: 'lesson-024', unitId: 'unit-005', orderNum: 4,
      title: 'Medir con palmas y pasos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l24-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El escritorio de Sofía mide 6 cuartas (palmas) y su cuaderno mide 2 cuartas. ¿Cuál es más largo?',
            'options': ['El cuaderno', 'El escritorio', 'Miden igual', 'El lápiz'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l24-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si el salón mide 10 pasos de largo y el baño mide 4 pasos, el salón tiene ___ pasos más que el baño',
            'options': ['4', '5', '6', '14'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l24-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Para medir el largo de la cancha del colegio sin regla, ¿qué es mejor usar?',
            'options': ['Pasos al caminar', 'Un grano de arroz', 'Una moneda', 'Una uña'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l24-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona qué parte del cuerpo sirve mejor para medir cada objeto',
            'items': ['Borrador pequeño', 'Ancho del pupitre', 'Largo del patio'],
            'targets': ['Un dedo', 'Palmas (cuartas)', 'Pasos largos'],
            'correct_mapping': {
              'Borrador pequeño': 'Un dedo',
              'Ancho del pupitre': 'Palmas (cuartas)',
              'Largo del patio': 'Pasos largos',
            },
          },
        ),
        Exercise(
          id: 'l24-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una mesa mide 8 lápices de largo y una silla mide 5 lápices. Juntas miden ___ lápices',
            'options': ['11', '12', '13', '3'],
            'correct_answer': '13',
          },
        ),
      ],
    ),

    'lesson-025': Lesson(
      id: 'lesson-025', unitId: 'unit-005', orderNum: 5,
      title: '¡Desafío de medidas!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l25-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué atributo comparamos cuando decimos que una patilla pesa más que un limón?',
            'options': ['La longitud', 'El peso (masa)', 'El color', 'La hora'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l25-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un termo se llena con 5 vasos de jugo y ya pusimos 3 vasos, faltan ___ vasos para llenarlo',
            'options': ['1', '2', '3', '8'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l25-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'La cuerda roja mide 9 palmas y la azul mide 14 palmas. ¿Cuántas palmas más larga es la cuerda azul?',
            'options': ['4', '5', '6', '23'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l25-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada pregunta con lo que estamos midiendo',
            'items': ['¿Qué tan alto es el árbol?', '¿Cuánto pesa el costal?', '¿Cuánta agua cabe en la olla?'],
            'targets': ['Longitud / Altura', 'Peso / Masa', 'Capacidad'],
            'correct_mapping': {
              '¿Qué tan alto es el árbol?': 'Longitud / Altura',
              '¿Cuánto pesa el costal?': 'Peso / Masa',
              '¿Cuánta agua cabe en la olla?': 'Capacidad',
            },
          },
        ),
        Exercise(
          id: 'l25-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una pluma es ___ y un ladrillo es pesado',
            'options': ['liviana', 'larga', 'llena', 'alta'],
            'correct_answer': 'liviana',
          },
        ),
        Exercise(
          id: 'l25-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Mateo mide 12 palmas de estatura y su hermanito mide 8 palmas. ¿Quién es más alto?',
            'options': ['Su hermanito', 'Mateo', 'Miden igual', 'No se sabe'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 6 (unit-006): Figuras planas ── DBA #5 Grado 1° (Período 3)
    // "Describe y compara figuras planas: cuadrado, rectángulo, triángulo, círculo."
    'lesson-026': Lesson(
      id: 'lesson-026', unitId: 'unit-006', orderNum: 1,
      title: 'El círculo y el cuadrado',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l26-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué forma plana tiene una arepa redonda o una moneda?',
            'options': ['Cuadrado', 'Círculo', 'Triángulo', 'Rectángulo'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l26-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cuadrado tiene ___ lados exactamente iguales',
            'options': ['2', '3', '4', '0'],
            'correct_answer': '4',
          },
        ),
        Exercise(
          id: 'l26-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántas esquinas (vértices) tiene un círculo?',
            'options': ['0 (ninguna)', '3', '4', '2'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l26-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada figura con su característica',
            'items': ['Círculo', 'Cuadrado', 'Esquina de un cuadrado'],
            'targets': ['Curvo y sin esquinas', '4 lados iguales', 'Vértice'],
            'correct_mapping': {
              'Círculo': 'Curvo y sin esquinas',
              'Cuadrado': '4 lados iguales',
              'Esquina de un cuadrado': 'Vértice',
            },
          },
        ),
        Exercise(
          id: 'l26-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Las ruedas de una bicicleta tienen forma de ___',
            'options': ['círculo', 'cuadrado', 'triángulo', 'rectángulo'],
            'correct_answer': 'círculo',
          },
        ),
      ],
    ),

    'lesson-027': Lesson(
      id: 'lesson-027', unitId: 'unit-006', orderNum: 2,
      title: 'El triángulo y el rectángulo',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l27-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos lados y cuántas esquinas tiene un triángulo?',
            'options': ['2 lados y 2 esquinas', '3 lados y 3 esquinas', '4 lados y 4 esquinas', '0 lados'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l27-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La puerta del salón y el tablero tienen forma de ___',
            'options': ['círculo', 'triángulo', 'rectángulo', 'esfera'],
            'correct_answer': 'rectángulo',
          },
        ),
        Exercise(
          id: 'l27-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿En qué se parecen un cuadrado y un rectángulo?',
            'options': ['Ambos tienen 3 lados', 'Ambos tienen 4 lados y 4 esquinas', 'No tienen lados', 'Son redondos'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l27-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada objeto con su forma geométrica',
            'items': ['Bandera de Colombia', 'Porción triangular de pizza', 'Anillo o aro'],
            'targets': ['Rectángulo', 'Triángulo', 'Círculo'],
            'correct_mapping': {
              'Bandera de Colombia': 'Rectángulo',
              'Porción triangular de pizza': 'Triángulo',
              'Anillo o aro': 'Círculo',
            },
          },
        ),
        Exercise(
          id: 'l27-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La figura plana que tiene exactamente 3 lados se llama ___',
            'options': ['triángulo', 'cuadrado', 'rectángulo', 'círculo'],
            'correct_answer': 'triángulo',
          },
        ),
      ],
    ),

    'lesson-028': Lesson(
      id: 'lesson-028', unitId: 'unit-006', orderNum: 3,
      title: 'Contando lados y esquinas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l28-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si dibujas 1 cuadrado y 1 triángulo separados, ¿cuántos lados dibujaste en total?',
            'options': ['6', '7', '8', '5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l28-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Dos triángulos separados tienen en total ___ esquinas',
            'options': ['3', '5', '6', '8'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l28-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál figura tiene MÁS lados: un triángulo o un rectángulo?',
            'options': ['El triángulo', 'El rectángulo', 'El círculo', 'Tienen igual'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l28-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada figura con su número de lados',
            'items': ['Círculo', 'Triángulo', 'Cuadrado'],
            'targets': ['0 lados rectos', '3 lados rectos', '4 lados rectos'],
            'correct_mapping': {
              'Círculo': '0 lados rectos',
              'Triángulo': '3 lados rectos',
              'Cuadrado': '4 lados rectos',
            },
          },
        ),
        Exercise(
          id: 'l28-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cuadrado y un rectángulo juntos suman ___ lados',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '8',
          },
        ),
      ],
    ),

    'lesson-029': Lesson(
      id: 'lesson-029', unitId: 'unit-006', orderNum: 4,
      title: 'Figuras en mi entorno',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l29-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Cuando dibujas una casita sencilla, usas un cuadrado abajo y ¿qué figura para el techo?',
            'options': ['Un triángulo', 'Un círculo', 'Una línea', 'Un balón'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l29-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si doblas una servilleta cuadrada por su diagonal (de esquina a esquina), formas un ___',
            'options': ['círculo', 'triángulo', 'cubo', 'balón'],
            'correct_answer': 'triángulo',
          },
        ),
        Exercise(
          id: 'l29-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un billete de \$2.000 pesos colombianos tiene forma de…',
            'options': ['Círculo', 'Triángulo', 'Rectángulo', 'Estrella'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l29-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada parte del dibujo de un tren con su figura',
            'items': ['Ruedas del tren', 'Vagón alargado', 'Techo en punta'],
            'targets': ['Círculos', 'Rectángulo', 'Triángulo'],
            'correct_mapping': {
              'Ruedas del tren': 'Círculos',
              'Vagón alargado': 'Rectángulo',
              'Techo en punta': 'Triángulo',
            },
          },
        ),
        Exercise(
          id: 'l29-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si juntamos 2 cuadrados iguales lado con lado, formamos un ___',
            'options': ['rectángulo', 'círculo', 'triángulo', 'punto'],
            'correct_answer': 'rectángulo',
          },
        ),
      ],
    ),

    'lesson-030': Lesson(
      id: 'lesson-030', unitId: 'unit-006', orderNum: 5,
      title: '¡Desafío geométrico!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l30-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Soy una figura plana de 4 lados iguales y 4 esquinas. ¿Quién soy?',
            'options': ['El triángulo', 'El cuadrado', 'El círculo', 'El cono'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l30-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '3 triángulos separados tienen en total ___ lados',
            'options': ['6', '8', '9', '12'],
            'correct_answer': '9',
          },
        ),
        Exercise(
          id: 'l30-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estas figuras NO tiene lados rectos?',
            'options': ['Cuadrado', 'Rectángulo', 'Círculo', 'Triángulo'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l30-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona la adivinanza con la figura correcta',
            'items': ['Tengo 3 puntas como una montaña', 'Soy redondo como el Sol', 'Tengo 2 lados largos y 2 cortos'],
            'targets': ['Triángulo', 'Círculo', 'Rectángulo'],
            'correct_mapping': {
              'Tengo 3 puntas como una montaña': 'Triángulo',
              'Soy redondo como el Sol': 'Círculo',
              'Tengo 2 lados largos y 2 cortos': 'Rectángulo',
            },
          },
        ),
        Exercise(
          id: 'l30-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un rectángulo tiene ___ esquinas (vértices)',
            'options': ['2', '3', '4', '5'],
            'correct_answer': '4',
          },
        ),
        Exercise(
          id: 'l30-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si dibujas una casa con 1 cuadrado (pared), 1 triángulo (techo) y 1 rectángulo (puerta), ¿cuántas figuras dibujaste?',
            'options': ['2', '3', '4', '5'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 7 (unit-007): El tiempo y el reloj ── DBA #6 Grado 1° (Período 4)
    // "Lee la hora en punto y media hora en relojes análogos y digitales."
    'lesson-031': Lesson(
      id: 'lesson-031', unitId: 'unit-007', orderNum: 1,
      title: 'Mañana, tarde y noche',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l31-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿En qué momento del día desayunamos arepa con chocolate y vamos al colegio?',
            'options': ['En la mañana', 'A medianoche', 'Al dormir', 'En la madrugada oscura'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l31-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Vemos la Luna y las estrellas en el cielo durante la ___',
            'options': ['mañana', 'tarde', 'noche', 'clase'],
            'correct_answer': 'noche',
          },
        ),
        Exercise(
          id: 'l31-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué ocurrió AYER si hoy es martes?',
            'options': ['Lunes', 'Miércoles', 'Viernes', 'Domingo'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l31-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena las actividades del día desde que despiertas',
            'items': ['Desayunar', 'Almorzar', 'Ponerse la pijama y dormir'],
            'targets': ['1° Mañana', '2° Mediodía / Tarde', '3° Noche'],
            'correct_mapping': {
              'Desayunar': '1° Mañana',
              'Almorzar': '2° Mediodía / Tarde',
              'Ponerse la pijama y dormir': '3° Noche',
            },
          },
        ),
        Exercise(
          id: 'l31-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Después de la mañana sigue la ___',
            'options': ['tarde', 'ayer', 'mañana', 'semana'],
            'correct_answer': 'tarde',
          },
        ),
      ],
    ),

    'lesson-032': Lesson(
      id: 'lesson-032', unitId: 'unit-007', orderNum: 2,
      title: 'Los días de la semana',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l32-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos días tiene una semana completa?',
            'options': ['5', '6', '7', '10'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l32-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El día que sigue después del miércoles es el ___',
            'options': ['martes', 'jueves', 'viernes', 'lunes'],
            'correct_answer': 'jueves',
          },
        ),
        Exercise(
          id: 'l32-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuáles son los 2 días del fin de semana en que descansamos del colegio?',
            'options': ['Lunes y martes', 'Sábado y domingo', 'Miércoles y jueves', 'Martes y viernes'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l32-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena estos tres días de la semana',
            'items': ['Lunes', 'Martes', 'Miércoles'],
            'targets': ['1° día escolar', '2° día escolar', '3° día escolar'],
            'correct_mapping': {
              'Lunes': '1° día escolar',
              'Martes': '2° día escolar',
              'Miércoles': '3° día escolar',
            },
          },
        ),
        Exercise(
          id: 'l32-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'De lunes a viernes vamos al colegio durante ___ días',
            'options': ['3', '4', '5', '7'],
            'correct_answer': '5',
          },
        ),
      ],
    ),

    'lesson-033': Lesson(
      id: 'lesson-033', unitId: 'unit-007', orderNum: 3,
      title: 'La hora en punto',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l33-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'La aguja corta marca la hora y la larga los minutos',
          content: {
            'question': 'En un reloj de agujas, cuando la aguja larga apunta al 12 y la corta al 3, ¿qué hora es?',
            'options': ['Las 12 en punto', 'Las 3 en punto', 'Las 6 en punto', 'Las 9 en punto'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l33-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En un reloj digital, las 8 en punto se escribe ___',
            'options': ['8:00', '8:30', '12:08', '0:08'],
            'correct_answer': '8:00',
          },
        ),
        Exercise(
          id: 'l33-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Para marcar una hora "en punto", ¿a qué número debe apuntar siempre el minutero (aguja larga)?',
            'options': ['Al 6', 'Al 12', 'Al 1', 'Al 3'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l33-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada reloj digital con su lectura',
            'items': ['7:00', '10:00', '12:00'],
            'targets': ['Siete en punto', 'Diez en punto', 'Doce en punto'],
            'correct_mapping': {
              '7:00': 'Siete en punto',
              '10:00': 'Diez en punto',
              '12:00': 'Doce en punto',
            },
          },
        ),
        Exercise(
          id: 'l33-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si entras a clase a las 7:00 y pasa 1 hora, son las ___ en punto',
            'options': ['6', '8', '9', '10'],
            'correct_answer': '8',
          },
        ),
      ],
    ),

    'lesson-034': Lesson(
      id: 'lesson-034', unitId: 'unit-007', orderNum: 4,
      title: 'La media hora',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l34-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Cuando pasa media hora (y media), ¿a qué número apunta la aguja larga del reloj?',
            'options': ['Al 12', 'Al 6', 'Al 3', 'Al 9'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l34-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En un reloj digital, las "cuatro y media" se muestra como ___',
            'options': ['4:00', '4:30', '4:06', '6:04'],
            'correct_answer': '4:30',
          },
        ),
        Exercise(
          id: 'l34-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El recreo empieza a las 9:30. ¿Cómo se lee esa hora?',
            'options': ['Nueve en punto', 'Nueve y media', 'Diez y media', 'Tres y nueve'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l34-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada hora digital con su nombre',
            'items': ['2:30', '5:00', '11:30'],
            'targets': ['Dos y media', 'Cinco en punto', 'Once y media'],
            'correct_mapping': {
              '2:30': 'Dos y media',
              '5:00': 'Cinco en punto',
              '11:30': 'Once y media',
            },
          },
        ),
        Exercise(
          id: 'l34-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Media hora tiene ___ minutos',
            'options': ['10', '30', '60', '15'],
            'correct_answer': '30',
          },
        ),
      ],
    ),

    'lesson-035': Lesson(
      id: 'lesson-035', unitId: 'unit-007', orderNum: 5,
      title: '¡Desafío del tiempo!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l35-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si hoy es viernes, ¿qué día será MAÑANA?',
            'options': ['Jueves', 'Sábado', 'Domingo', 'Lunes'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l35-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Cuando el reloj marca 6:30, decimos que son las seis y ___',
            'options': ['punto', 'media', 'cuarto', 'diez'],
            'correct_answer': 'media',
          },
        ),
        Exercise(
          id: 'l35-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'La clase de educación física empieza a las 10:00 y termina a las 11:00. ¿Cuántas horas dura?',
            'options': ['1 hora', '2 horas', '5 horas', '10 horas'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l35-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada pista con la respuesta correcta',
            'items': ['Aguja larga en el 12', 'Aguja larga en el 6', 'Días de la semana'],
            'targets': ['Hora en punto (:00)', 'Media hora (:30)', '7 días'],
            'correct_mapping': {
              'Aguja larga en el 12': 'Hora en punto (:00)',
              'Aguja larga en el 6': 'Media hora (:30)',
              'Días de la semana': '7 días',
            },
          },
        ),
        Exercise(
          id: 'l35-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si almuerzas a las 12:00 y la merienda es 3 horas después, meriendas a las ___:00',
            'options': ['2', '3', '4', '5'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l35-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué reloj marca las "nueve en punto"?',
            'options': ['9:30', '9:00', '12:09', '6:09'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 8 (unit-008): Datos y pictogramas ── DBA #8 Grado 1° (Período 4)
    // "Interpreta y representa datos en pictogramas y diagramas de barras sencillos."
    'lesson-036': Lesson(
      id: 'lesson-036', unitId: 'unit-008', orderNum: 1,
      title: 'Contar y organizar datos',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l36-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la mesa hay: 🥭🥭🥭🥭 y 🍌🍌. ¿Cuántos mangos hay?',
            'options': ['2', '3', '4', '6'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l36-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si en el salón 5 niños prefieren fútbol y 3 prefieren patinaje, en total votaron ___ niños',
            'options': ['6', '7', '8', '2'],
            'correct_answer': '8',
          },
        ),
        Exercise(
          id: 'l36-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Observa los animales: 🐶🐶🐶 🐱🐱🐱🐱🐱. ¿De cuál animal hay MÁS?',
            'options': ['Perros 🐶', 'Gatos 🐱', 'Hay igual', 'Ninguno'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l36-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Cuenta los emojis y relaciónalos con su cantidad',
            'items': ['⭐⭐', '🍎🍎🍎🍎', '🎈🎈🎈'],
            'targets': ['2', '4', '3'],
            'correct_mapping': {'⭐⭐': '2', '🍎🍎🍎🍎': '4', '🎈🎈🎈': '3'},
          },
        ),
        Exercise(
          id: 'l36-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la lista ⚽⚽⚽⚽⚽ hay ___ balones',
            'options': ['4', '5', '6', '3'],
            'correct_answer': '5',
          },
        ),
      ],
    ),

    'lesson-037': Lesson(
      id: 'lesson-037', unitId: 'unit-008', orderNum: 2,
      title: 'Leer pictogramas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l37-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Cada dibujo representa 1 voto',
          content: {
            'question': 'En un pictograma de frutas favoritas: Mango = 🥭🥭🥭🥭🥭, Guayaba = 🍐🍐🍐. ¿Cuál es la fruta favorita?',
            'options': ['La guayaba', 'El mango', 'El banano', 'Empataron'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l37-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si cada 🍦 vale 1 niño y hay 🍦🍦🍦🍦🍦🍦 en vainilla, entonces ___ niños eligieron vainilla',
            'options': ['5', '6', '7', '4'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l37-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el pictograma de mascotas: Perro = 7, Gato = 4, Loro = 2. ¿Cuál mascota tiene MENOS votos?',
            'options': ['El perro', 'El gato', 'El loro', 'Todos igual'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l37-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada fila del pictograma con su total',
            'items': ['Arepas: 🫓🫓🫓🫓', 'Empanadas: 🥟🥟🥟🥟🥟🥟', 'Buñuelos: 🧆🧆'],
            'targets': ['4 votos', '6 votos', '2 votos'],
            'correct_mapping': {
              'Arepas: 🫓🫓🫓🫓': '4 votos',
              'Empanadas: 🥟🥟🥟🥟🥟🥟': '6 votos',
              'Buñuelos: 🧆🧆': '2 votos',
            },
          },
        ),
        Exercise(
          id: 'l37-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 6 niños votaron por empanada y 4 por arepa, la empanada ganó por ___ votos más',
            'options': ['1', '2', '3', '10'],
            'correct_answer': '2',
          },
        ),
      ],
    ),

    'lesson-038': Lesson(
      id: 'lesson-038', unitId: 'unit-008', orderNum: 3,
      title: 'Comparar cantidades en tablas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l38-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Tabla de cuentos leídos: Sofía = 5, Mateo = 8, Juan = 6. ¿Quién leyó MÁS cuentos?',
            'options': ['Sofía', 'Mateo', 'Juan', 'Todos igual'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l38-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la misma tabla (Sofía=5, Mateo=8, Juan=6), Mateo leyó ___ cuentos más que Sofía',
            'options': ['2', '3', '4', '13'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l38-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si Sofía leyó 5 cuentos y Juan leyó 6, ¿cuántos leyeron entre los dos?',
            'options': ['10', '11', '12', '1'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l38-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Según los goles: Azul=9, Rojo=4, Verde=7, ubica cada equipo',
            'items': ['Equipo Azul (9)', 'Equipo Verde (7)', 'Equipo Rojo (4)'],
            'targets': ['1° lugar (más goles)', '2° lugar', '3° lugar (menos goles)'],
            'correct_mapping': {
              'Equipo Azul (9)': '1° lugar (más goles)',
              'Equipo Verde (7)': '2° lugar',
              'Equipo Rojo (4)': '3° lugar (menos goles)',
            },
          },
        ),
        Exercise(
          id: 'l38-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si el equipo Azul hizo 9 goles y el Rojo hizo 4, la diferencia es de ___ goles',
            'options': ['4', '5', '6', '13'],
            'correct_answer': '5',
          },
        ),
      ],
    ),

    'lesson-039': Lesson(
      id: 'lesson-039', unitId: 'unit-008', orderNum: 4,
      title: 'Diagramas de barras sencillos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l39-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En un diagrama de barras de colores favoritos, la barra más ALTA representa…',
            'options': ['El color con menos votos', 'El color con más votos', 'Que nadie votó', 'Cero votos'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l39-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si la barra del color Amarillo llega al 6 y la del Azul llega al 10, el Azul tiene ___ votos más',
            'options': ['3', '4', '5', '16'],
            'correct_answer': '4',
          },
        ),
        Exercise(
          id: 'l39-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si dos barras tienen exactamente la misma altura en la gráfica, ¿qué significa?',
            'options': ['Que tienen la misma cantidad', 'Que una ganó', 'Que está mal dibujada', 'Que valen cero'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l39-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona la altura de la barra con su significado',
            'items': ['Barra más alta', 'Barra más baja', 'Barras iguales'],
            'targets': ['Mayor cantidad', 'Menor cantidad', 'Empate'],
            'correct_mapping': {
              'Barra más alta': 'Mayor cantidad',
              'Barra más baja': 'Menor cantidad',
              'Barras iguales': 'Empate',
            },
          },
        ),
        Exercise(
          id: 'l39-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si las barras de jugos muestran: Lulo=5, Mora=7 y Mango=3, en total encuestaron a ___ niños',
            'options': ['12', '14', '15', '10'],
            'correct_answer': '15',
          },
        ),
      ],
    ),

    'lesson-040': Lesson(
      id: 'lesson-040', unitId: 'unit-008', orderNum: 5,
      title: '¡Desafío de datos!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l40-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la huerta escolar recogieron: 8 tomates, 5 zanahorias y 6 lechugas. ¿De cuál verdura recogieron más?',
            'options': ['Zanahorias', 'Tomates', 'Lechugas', 'Papas'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l40-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Con 8 tomates y 5 zanahorias, recogieron ___ verduras entre esos dos tipos',
            'options': ['12', '13', '14', '3'],
            'correct_answer': '13',
          },
        ),
        Exercise(
          id: 'l40-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En un pictograma donde cada 📚 vale 1 libro: Camila tiene 📚📚📚📚 y Andrés tiene 📚📚📚📚📚📚📚. ¿Cuántos libros más tiene Andrés?',
            'options': ['2', '3', '4', '11'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l40-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada pregunta sobre los datos (Perros=8, Gatos=5, Aves=3) con su respuesta',
            'items': ['¿Cuál es la mascota más común?', '¿Cuántos perros más que aves hay?', '¿Cuántas mascotas hay en total?'],
            'targets': ['Perros (8)', '5 de diferencia', '16 mascotas'],
            'correct_mapping': {
              '¿Cuál es la mascota más común?': 'Perros (8)',
              '¿Cuántos perros más que aves hay?': '5 de diferencia',
              '¿Cuántas mascotas hay en total?': '16 mascotas',
            },
          },
        ),
        Exercise(
          id: 'l40-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En una gráfica de barras, el dato con MENOS votos tiene la barra más ___',
            'options': ['baja', 'alta', 'ancha', 'larga'],
            'correct_answer': 'baja',
          },
        ),
        Exercise(
          id: 'l40-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El lunes llovió, el martes hizo sol, el miércoles hizo sol y el jueves hizo sol. ¿Cuántos días hizo sol?',
            'options': ['1', '2', '3', '4'],
            'correct_index': 2,
          },
        ),
      ],
    ),
};
