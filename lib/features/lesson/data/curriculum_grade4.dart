// Currículo Grado 4° — Fracciones, Multiplicación/División, Decimales
// 15 lecciones alineadas con DBA MEN Colombia

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade4Lessons = {

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
};
