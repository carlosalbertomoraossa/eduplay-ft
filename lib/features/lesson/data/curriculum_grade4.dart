// Currículo Grado 4° — 8 unidades (4 períodos académicos, 40 lecciones)
// Alineado con DBA MEN Colombia (Pensamientos NV, EM y AL)

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade4Lessons = {

    // ── UNIDAD 401: Fracciones ── DBA #3 Grado 4°
    // "Comprende fracciones equivalentes, propias e impropias."
    'lesson-401': Lesson(
      id: 'lesson-401', unitId: 'unit-401', orderNum: 1,
      title: '¿Qué es una fracción?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l401-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '¡Imagina una pizza! 🍕 Arriba van los pedazos que tomaste y abajo el total de pedazos iguales',
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

    'lesson-402': Lesson(
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

    'lesson-403': Lesson(
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

    'lesson-404': Lesson(
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

    'lesson-405': Lesson(
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
    'lesson-406': Lesson(
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

    'lesson-407': Lesson(
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

    'lesson-408': Lesson(
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

    'lesson-409': Lesson(
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

    'lesson-410': Lesson(
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
    'lesson-411': Lesson(
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

    'lesson-412': Lesson(
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

    'lesson-413': Lesson(
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

    'lesson-414': Lesson(
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

    'lesson-415': Lesson(
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

    // ── UNIDAD 404: Números hasta un millón ── DBA #1 Grado 4° (Período 1)
    // "Lee, escribe y compara números hasta 1.000.000. Redondea y estima."
    'lesson-416': Lesson(
      id: 'lesson-416', unitId: 'unit-404', orderNum: 1,
      title: 'Centenas de mil y el millón',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l416-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '10 decenas de mil forman 1 centena de mil (100.000)',
          content: {
            'question': '¿Cuántas unidades hay en 1 centena de mil?',
            'options': ['10.000', '100.000', '1.000.000', '1.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l416-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '10 centenas de mil forman 1 millón, que se escribe ___',
            'options': ['100.000', '1.000.000', '10.000', '999.999'],
            'correct_answer': '1.000.000',
          },
        ),
        Exercise(
          id: 'l416-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número sigue inmediatamente después de 999.999?',
            'options': ['999.998', '1.000.000', '100.000', '900.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l416-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada número con su lectura',
            'items': ['200.000', '550.000', '1.000.000'],
            'targets': ['Doscientos mil', 'Quinientos cincuenta mil', 'Un millón'],
            'correct_mapping': {
              '200.000': 'Doscientos mil',
              '550.000': 'Quinientos cincuenta mil',
              '1.000.000': 'Un millón',
            },
          },
        ),
        Exercise(
          id: 'l416-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '300.000 + 40.000 + 5.000 = ___',
            'options': ['345.000', '354.000', '304.500', '435.000'],
            'correct_answer': '345.000',
          },
        ),
      ],
    ),

    'lesson-417': Lesson(
      id: 'lesson-417', unitId: 'unit-404', orderNum: 2,
      title: 'Valor posicional hasta 6 cifras',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l417-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el número 648.320, ¿qué valor representa el dígito 6?',
            'options': ['6.000', '60.000', '600.000', '600'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l417-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En 752.419, el dígito que ocupa las decenas de mil es el ___',
            'options': ['7', '5', '2', '4'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l417-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es la descomposición correcta de 483.200?',
            'options': [
              '400.000 + 80.000 + 3.000 + 200',
              '40.000 + 8.000 + 300 + 20',
              '400.000 + 8.000 + 300 + 2',
              '480.000 + 32.000',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l417-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'En el número 539.184, relaciona cada dígito con su posición',
            'items': ['Dígito 5', 'Dígito 3', 'Dígito 9'],
            'targets': ['Centenas de mil (500.000)', 'Decenas de mil (30.000)', 'Unidades de mil (9.000)'],
            'correct_mapping': {
              'Dígito 5': 'Centenas de mil (500.000)',
              'Dígito 3': 'Decenas de mil (30.000)',
              'Dígito 9': 'Unidades de mil (9.000)',
            },
          },
        ),
        Exercise(
          id: 'l417-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '8 centenas de mil + 5 decenas de mil + 2 unidades de mil = ___',
            'options': ['852.000', '825.000', '582.000', '805.200'],
            'correct_answer': '852.000',
          },
        ),
      ],
    ),

    'lesson-418': Lesson(
      id: 'lesson-418', unitId: 'unit-404', orderNum: 3,
      title: 'Comparar poblaciones de Colombia',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l418-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Manizales tiene cerca de 450.000 habitantes y Pereira cerca de 480.000. ¿Cuál ciudad tiene más habitantes?',
            'options': ['Manizales', 'Pereira', 'Tienen igual', 'No se sabe'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l418-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Entre 609.500 y 690.500, el número mayor es ___',
            'options': ['609.500', '690.500', 'son iguales', '600.950'],
            'correct_answer': '690.500',
          },
        ),
        Exercise(
          id: 'l418-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué símbolo debe ir en el espacio: 325.800 ___ 325.080?',
            'options': ['> (mayor que)', '< (menor que)', '= (igual a)', '+'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l418-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena estas ciudades colombianas de menor a mayor población aproximada',
            'items': ['Popayán (330.000)', 'Santa Marta (550.000)', 'Bucaramanga (610.000)'],
            'targets': ['1° (menor)', '2° (intermedia)', '3° (mayor)'],
            'correct_mapping': {
              'Popayán (330.000)': '1° (menor)',
              'Santa Marta (550.000)': '2° (intermedia)',
              'Bucaramanga (610.000)': '3° (mayor)',
            },
          },
        ),
        Exercise(
          id: 'l418-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El mayor número de 6 cifras que existe es ___',
            'options': ['100.000', '900.000', '999.999', '1.000.000'],
            'correct_answer': '999.999',
          },
        ),
      ],
    ),

    'lesson-419': Lesson(
      id: 'lesson-419', unitId: 'unit-404', orderNum: 4,
      title: 'Redondeo y estimación',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l419-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Si la cifra siguiente es 5 o más, redondeamos hacia arriba',
          content: {
            'question': '¿A qué unidad de mil se redondea el número 4.820?',
            'options': ['4.000', '5.000', '4.500', '6.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l419-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El número 32.150 redondeado a la decena de mil más cercana es ___',
            'options': ['20.000', '30.000', '40.000', '35.000'],
            'correct_answer': '30.000',
          },
        ),
        Exercise(
          id: 'l419-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un televisor cuesta \$895.000. Redondeando a la centena de mil más cercana, cuesta aproximadamente…',
            'options': ['\$800.000', '\$900.000', '\$1.000.000', '\$700.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l419-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Redondea cada precio al millar más cercano',
            'items': ['\$1.900', '\$3.120', '\$7.850'],
            'targets': ['\$2.000', '\$3.000', '\$8.000'],
            'correct_mapping': {
              '\$1.900': '\$2.000',
              '\$3.120': '\$3.000',
              '\$7.850': '\$8.000',
            },
          },
        ),
        Exercise(
          id: 'l419-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si estimamos 198.000 + 302.000 redondeando a centenas de mil (200.000 + 300.000), obtenemos ___',
            'options': ['400.000', '500.000', '600.000', '450.000'],
            'correct_answer': '500.000',
          },
        ),
      ],
    ),

    'lesson-420': Lesson(
      id: 'lesson-420', unitId: 'unit-404', orderNum: 5,
      title: '¡Desafío del millón!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l420-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto le falta a 750.000 para llegar a 1.000.000?',
            'options': ['150.000', '200.000', '250.000', '350.000'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l420-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el número 904.630, el valor posicional del dígito 4 es ___',
            'options': ['400', '4.000', '40.000', '400.000'],
            'correct_answer': '4.000',
          },
        ),
        Exercise(
          id: 'l420-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una bicicleta cuesta \$489.000 y un casco \$98.000. Estimando al millar, ¿cuánto cuestan juntos aproximadamente (490.000 + 100.000)?',
            'options': ['\$500.000', '\$590.000', '\$650.000', '\$490.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l420-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada operación con su resultado exacto',
            'items': ['400.000 + 600.000', '850.000 - 250.000', '100.000 × 5'],
            'targets': ['1.000.000', '600.000', '500.000'],
            'correct_mapping': {
              '400.000 + 600.000': '1.000.000',
              '850.000 - 250.000': '600.000',
              '100.000 × 5': '500.000',
            },
          },
        ),
        Exercise(
          id: 'l420-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '568.900 redondeado a la centena de mil más cercana es ___',
            'options': ['500.000', '570.000', '600.000', '560.000'],
            'correct_answer': '600.000',
          },
        ),
        Exercise(
          id: 'l420-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estos números es MENOR que medio millón (500.000)?',
            'options': ['505.000', '499.900', '510.000', '600.000'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 405: Figuras y simetría ── DBA #6 Grado 4° (Período 2)
    // "Clasifica ángulos y triángulos. Reconoce simetría en figuras planas."
    'lesson-421': Lesson(
      id: 'lesson-421', unitId: 'unit-405', orderNum: 1,
      title: 'Medición de ángulos en grados',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l421-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Usamos el transportador para medir en grados (°)',
          content: {
            'question': '¿Cuántos grados mide exactamente un ángulo recto?',
            'options': ['45°', '90°', '180°', '360°'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l421-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un ángulo que mide 45° es menor que 90°, por eso es un ángulo ___',
            'options': ['agudo', 'recto', 'obtuso', 'llano'],
            'correct_answer': 'agudo',
          },
        ),
        Exercise(
          id: 'l421-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un ángulo llano (una línea recta abierta) mide el doble de un ángulo recto. ¿Cuántos grados mide?',
            'options': ['90°', '120°', '180°', '270°'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l421-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Clasifica cada medida de ángulo según su tipo',
            'items': ['35°', '90°', '130°'],
            'targets': ['Ángulo agudo', 'Ángulo recto', 'Ángulo obtuso'],
            'correct_mapping': {
              '35°': 'Ángulo agudo',
              '90°': 'Ángulo recto',
              '130°': 'Ángulo obtuso',
            },
          },
        ),
        Exercise(
          id: 'l421-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El instrumento escolar en forma de semicírculo para medir ángulos se llama ___',
            'options': ['transportador', 'balanza', 'termómetro', 'cronómetro'],
            'correct_answer': 'transportador',
          },
        ),
      ],
    ),

    'lesson-422': Lesson(
      id: 'lesson-422', unitId: 'unit-405', orderNum: 2,
      title: 'Clasificación de triángulos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l422-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cómo se llama el triángulo que tiene sus 3 lados de igual medida?',
            'options': ['Equilátero', 'Isósceles', 'Escaleno', 'Rectángulo'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l422-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un triángulo que tiene 2 lados iguales y 1 diferente se llama ___',
            'options': ['isósceles', 'equilátero', 'escaleno', 'cuadrado'],
            'correct_answer': 'isósceles',
          },
        ),
        Exercise(
          id: 'l422-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si los lados de un triángulo miden 4 cm, 5 cm y 7 cm (todos diferentes), ¿qué tipo de triángulo es?',
            'options': ['Equilátero', 'Isósceles', 'Escaleno', 'Circular'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l422-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada triángulo con la medida de sus lados',
            'items': ['Lados: 6 cm, 6 cm, 6 cm', 'Lados: 8 cm, 8 cm, 5 cm', 'Lados: 3 cm, 4 cm, 5 cm'],
            'targets': ['Equilátero', 'Isósceles', 'Escaleno'],
            'correct_mapping': {
              'Lados: 6 cm, 6 cm, 6 cm': 'Equilátero',
              'Lados: 8 cm, 8 cm, 5 cm': 'Isósceles',
              'Lados: 3 cm, 4 cm, 5 cm': 'Escaleno',
            },
          },
        ),
        Exercise(
          id: 'l422-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un triángulo que tiene un ángulo recto (90°) se llama triángulo ___',
            'options': ['rectángulo', 'obtusángulo', 'acutángulo', 'redondo'],
            'correct_answer': 'rectángulo',
          },
        ),
      ],
    ),

    'lesson-423': Lesson(
      id: 'lesson-423', unitId: 'unit-405', orderNum: 3,
      title: 'Cuadriláteros y paralelogramos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l423-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cómo se llaman todas las figuras planas cerradas que tienen exactamente 4 lados?',
            'options': ['Triángulos', 'Cuadriláteros', 'Pentágonos', 'Círculos'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l423-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una cometa tradicional con 4 lados iguales pero sin ángulos rectos tiene forma de ___',
            'options': ['rombo', 'círculo', 'triángulo', 'esfera'],
            'correct_answer': 'rombo',
          },
        ),
        Exercise(
          id: 'l423-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Dos líneas rectas que van en la misma dirección y NUNCA se cruzan (como los rieles del tren) son líneas…',
            'options': ['Paralelas', 'Perpendiculares', 'Curvas', 'Secantes'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l423-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada cuadrilátero con su descripción',
            'items': ['Cuadrado', 'Rombo', 'Trapecio'],
            'targets': ['4 lados iguales y 4 ángulos rectos', '4 lados iguales y ángulos no rectos', 'Solo 1 par de lados paralelos'],
            'correct_mapping': {
              'Cuadrado': '4 lados iguales y 4 ángulos rectos',
              'Rombo': '4 lados iguales y ángulos no rectos',
              'Trapecio': 'Solo 1 par de lados paralelos',
            },
          },
        ),
        Exercise(
          id: 'l423-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Dos líneas que se cruzan formando un ángulo recto (90°) se llaman líneas ___',
            'options': ['perpendiculares', 'paralelas', 'curvas', 'iguales'],
            'correct_answer': 'perpendiculares',
          },
        ),
      ],
    ),

    'lesson-424': Lesson(
      id: 'lesson-424', unitId: 'unit-405', orderNum: 4,
      title: 'Ejes de simetría',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l424-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué es un eje de simetría en una figura como una mariposa morpho?',
            'options': [
              'Una línea que divide la figura en dos mitades iguales como un espejo',
              'El borde externo de la figura',
              'Una esquina puntiaguda',
              'El color de las alas',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l424-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cuadrado se puede doblar en mitades iguales de ___ formas distintas (4 ejes de simetría)',
            'options': ['1', '2', '4', '0'],
            'correct_answer': '4',
          },
        ),
        Exercise(
          id: 'l424-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estas letras mayúsculas tiene simetría vertical (si la partes de arriba a abajo sus dos lados son iguales)?',
            'options': ['La letra A', 'La letra F', 'La letra P', 'La letra G'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l424-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada figura con su cantidad de ejes de simetría',
            'items': ['Triángulo escaleno (lados distintos)', 'Triángulo equilátero', 'Cuadrado'],
            'targets': ['0 ejes de simetría', '3 ejes de simetría', '4 ejes de simetría'],
            'correct_mapping': {
              'Triángulo escaleno (lados distintos)': '0 ejes de simetría',
              'Triángulo equilátero': '3 ejes de simetría',
              'Cuadrado': '4 ejes de simetría',
            },
          },
        ),
        Exercise(
          id: 'l424-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Cuando una figura se refleja al otro lado de un eje como en un espejo, la transformación se llama ___',
            'options': ['reflexión (simetría)', 'ampliación', 'división', 'rotación'],
            'correct_answer': 'reflexión (simetría)',
          },
        ),
      ],
    ),

    'lesson-425': Lesson(
      id: 'lesson-425', unitId: 'unit-405', orderNum: 5,
      title: '¡Desafío geométrico 4°!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l425-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'La suma de los 3 ángulos internos de cualquier triángulo siempre es…',
            'options': ['90°', '180°', '270°', '360°'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l425-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un ángulo mide 115°, como está entre 90° y 180°, es un ángulo ___',
            'options': ['obtuso', 'agudo', 'recto', 'llano'],
            'correct_answer': 'obtuso',
          },
        ),
        Exercise(
          id: 'l425-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un triángulo equilátero tiene perímetro de 27 cm. ¿Cuánto mide cada uno de sus 3 lados iguales?',
            'options': ['7 cm', '8 cm', '9 cm', '10 cm'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l425-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada concepto geométrico con su definición',
            'items': ['Triángulo isósceles', 'Rectas perpendiculares', 'Eje de simetría'],
            'targets': ['Tiene 2 lados iguales', 'Se cortan formando 90°', 'Divide en 2 mitades iguales'],
            'correct_mapping': {
              'Triángulo isósceles': 'Tiene 2 lados iguales',
              'Rectas perpendiculares': 'Se cortan formando 90°',
              'Eje de simetría': 'Divide en 2 mitades iguales',
            },
          },
        ),
        Exercise(
          id: 'l425-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un rectángulo (que no es cuadrado) tiene ___ ejes de simetría (uno vertical y uno horizontal)',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l425-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si en un triángulo rectángulo un ángulo mide 90° y otro mide 45°, ¿cuánto mide el tercer ángulo para completar 180°?',
            'options': ['30°', '45°', '60°', '90°'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 406: Área y perímetro ── DBA #5 Grado 4° (Período 3)
    // "Calcula área de rectángulos y cuadrados. Diferencia área de perímetro."
    'lesson-426': Lesson(
      id: 'lesson-426', unitId: 'unit-406', orderNum: 1,
      title: 'Diferencia entre área y perímetro',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l426-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'El perímetro es el borde; el área es la superficie de adentro',
          content: {
            'question': 'Si queremos poner baldosas en todo el piso del salón, ¿qué debemos medir?',
            'options': ['El área (superficie interior)', 'Solo una esquina', 'El peso del salón', 'La temperatura'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l426-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El contorno o borde alrededor de una figura es el perímetro, mientras que la superficie interior es el ___',
            'options': ['área', 'vértice', 'ángulo', 'litro'],
            'correct_answer': 'área',
          },
        ),
        Exercise(
          id: 'l426-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una figura formada por 12 cuadritos de 1 cm² cada uno tiene un área de…',
            'options': ['6 cm²', '12 cm²', '24 cm²', '4 cm²'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l426-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada situación con lo que se necesita calcular',
            'items': ['Poner cerca alrededor de una finca', 'Sembrar pasto en toda una cancha', 'Poner marco de madera a un cuadro'],
            'targets': ['Perímetro', 'Área', 'Perímetro del cuadro'],
            'correct_mapping': {
              'Poner cerca alrededor de una finca': 'Perímetro',
              'Sembrar pasto en toda una cancha': 'Área',
              'Poner marco de madera a un cuadro': 'Perímetro del cuadro',
            },
          },
        ),
        Exercise(
          id: 'l426-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El área se mide en unidades cuadradas como el metro cuadrado (___)',
            'options': ['m²', 'kg', 'cm', 'km'],
            'correct_answer': 'm²',
          },
        ),
      ],
    ),

    'lesson-427': Lesson(
      id: 'lesson-427', unitId: 'unit-406', orderNum: 2,
      title: 'Área del rectángulo y del cuadrado',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l427-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Área del rectángulo = largo × ancho (base × altura)',
          content: {
            'question': '¿Cuál es el área de un rectángulo que mide 8 cm de base y 5 cm de altura?',
            'options': ['13 cm²', '26 cm²', '40 cm²', '45 cm²'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l427-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cuadrado de lado 6 cm tiene un área de (6 × 6) = ___ cm²',
            'options': ['12', '24', '36', '42'],
            'correct_answer': '36',
          },
        ),
        Exercise(
          id: 'l427-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una huerta rectangular de café mide 10 m de largo por 7 m de ancho. ¿Cuál es su área?',
            'options': ['17 m²', '34 m²', '70 m²', '77 m²'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l427-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada figura con su área (base × altura)',
            'items': ['Cuadrado de lado 5 m', 'Rectángulo de 9 m × 4 m', 'Cuadrado de lado 10 m'],
            'targets': ['25 m²', '36 m²', '100 m²'],
            'correct_mapping': {
              'Cuadrado de lado 5 m': '25 m²',
              'Rectángulo de 9 m × 4 m': '36 m²',
              'Cuadrado de lado 10 m': '100 m²',
            },
          },
        ),
        Exercise(
          id: 'l427-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un rectángulo tiene área de 24 cm² y su base mide 6 cm, su altura mide (24 ÷ 6) = ___ cm',
            'options': ['3', '4', '6', '18'],
            'correct_answer': '4',
          },
        ),
      ],
    ),

    'lesson-428': Lesson(
      id: 'lesson-428', unitId: 'unit-406', orderNum: 3,
      title: 'Comparar área y perímetro',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l428-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Para un cuadrado de lado 5 cm, ¿cuánto valen su perímetro y su área?',
            'options': [
              'Perímetro = 20 cm y Área = 25 cm²',
              'Perímetro = 25 cm y Área = 20 cm²',
              'Perímetro = 10 cm y Área = 10 cm²',
              'Perímetro = 15 cm y Área = 25 cm²',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l428-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un rectángulo de 6 m × 2 m tiene área de 12 m² y perímetro de (6+2+6+2) = ___ m',
            'options': ['12', '14', '16', '18'],
            'correct_answer': '16',
          },
        ),
        Exercise(
          id: 'l428-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un rectángulo de 4×3 y otro de 6×2 tienen ambos área de 12 cm². ¿Tienen también el mismo perímetro?',
            'options': [
              'No: el de 4×3 tiene perímetro 14 cm y el de 6×2 tiene perímetro 16 cm',
              'Sí, siempre tienen el mismo perímetro',
              'Ninguno tiene perímetro',
              'Ambos tienen perímetro 12 cm',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l428-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Para un rectángulo de 7 cm de largo y 3 cm de ancho, relaciona',
            'items': ['Área (7 × 3)', 'Perímetro (7+3+7+3)', 'Suma de largo + ancho'],
            'targets': ['21 cm²', '20 cm', '10 cm'],
            'correct_mapping': {
              'Área (7 × 3)': '21 cm²',
              'Perímetro (7+3+7+3)': '20 cm',
              'Suma de largo + ancho': '10 cm',
            },
          },
        ),
        Exercise(
          id: 'l428-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si el área de un cuadrado es 49 m², cada lado mide ___ m (porque 7 × 7 = 49)',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '7',
          },
        ),
      ],
    ),

    'lesson-429': Lesson(
      id: 'lesson-429', unitId: 'unit-406', orderNum: 4,
      title: 'Área del triángulo y figuras compuestas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l429-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Si cortas un rectángulo por su diagonal, obtienes 2 triángulos iguales',
          content: {
            'question': 'Un triángulo es la mitad de un rectángulo de igual base y altura. Si el rectángulo tiene área 20 cm², ¿cuál es el área del triángulo?',
            'options': ['5 cm²', '10 cm²', '20 cm²', '40 cm²'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l429-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El área de un triángulo de base 8 cm y altura 6 cm es (8 × 6) ÷ 2 = ___ cm²',
            'options': ['14', '24', '48', '12'],
            'correct_answer': '24',
          },
        ),
        Exercise(
          id: 'l429-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una casa tiene una sala de 20 m² y una cocina de 12 m². ¿Cuál es el área total de las dos habitaciones?',
            'options': ['8 m²', '30 m²', '32 m²', '240 m²'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l429-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada figura con su área',
            'items': ['Triángulo de base 10 cm y altura 4 cm', 'Cuadrado de lado 4 cm', 'Dos cuadrados de 10 m² cada uno'],
            'targets': ['20 cm²', '16 cm²', '20 m²'],
            'correct_mapping': {
              'Triángulo de base 10 cm y altura 4 cm': '20 cm²',
              'Cuadrado de lado 4 cm': '16 cm²',
              'Dos cuadrados de 10 m² cada uno': '20 m²',
            },
          },
        ),
        Exercise(
          id: 'l429-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un jardín rectangular de 30 m² tiene una fuente de 6 m². El área que queda con césped es ___ m²',
            'options': ['18', '24', '36', '20'],
            'correct_answer': '24',
          },
        ),
      ],
    ),

    'lesson-430': Lesson(
      id: 'lesson-430', unitId: 'unit-406', orderNum: 5,
      title: '¡Desafío de área y perímetro!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l430-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una cancha de voleibol mide 18 m de largo por 9 m de ancho. ¿Cuál es su área (18 × 9)?',
            'options': ['54 m²', '162 m²', '180 m²', '27 m²'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l430-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un cuadrado tiene perímetro de 32 cm, cada lado mide 8 cm y su área es (8 × 8) = ___ cm²',
            'options': ['16', '32', '64', '48'],
            'correct_answer': '64',
          },
        ),
        Exercise(
          id: 'l430-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un piso de 15 m² se va a cubrir con baldosas. Si cada metro cuadrado cuesta \$20.000, ¿cuánto cuestan los 15 m²?',
            'options': ['\$150.000', '\$250.000', '\$300.000', '\$350.000'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l430-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada cálculo con su resultado',
            'items': ['Área de rectángulo 12 m × 5 m', 'Perímetro de rectángulo 12 m × 5 m', 'Área de cuadrado de lado 9 m'],
            'targets': ['60 m²', '34 m', '81 m²'],
            'correct_mapping': {
              'Área de rectángulo 12 m × 5 m': '60 m²',
              'Perímetro de rectángulo 12 m × 5 m': '34 m',
              'Área de cuadrado de lado 9 m': '81 m²',
            },
          },
        ),
        Exercise(
          id: 'l430-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un lote rectangular tiene área de 80 m² y mide 10 m de frente. Su fondo mide ___ m',
            'options': ['6', '8', '10', '70'],
            'correct_answer': '8',
          },
        ),
        Exercise(
          id: 'l430-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estas dos mesas tiene MAYOR área: una cuadrada de 6 m × 6 m o una rectangular de 8 m × 4 m?',
            'options': [
              'La cuadrada (36 m² > 32 m²)',
              'La rectangular (32 m² > 36 m²)',
              'Tienen igual área',
              'No se puede saber',
            ],
            'correct_index': 0,
          },
        ),
      ],
    ),

    // ── UNIDAD 407: Mapas y escalas ── DBA #7 Grado 4° (Período 4)
    // "Interpreta y usa escalas sencillas en mapas y planos."
    'lesson-431': Lesson(
      id: 'lesson-431', unitId: 'unit-407', orderNum: 1,
      title: 'Coordenadas en cuadrícula',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l431-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Primero leemos la columna (horizontal) y luego la fila (vertical)',
          content: {
            'question': 'En un mapa escolar con columnas A, B, C y filas 1, 2, 3, ¿qué significa la coordenada (B, 3)?',
            'options': ['Columna B y fila 3', 'Columna 3 y fila B', 'Solo la fila 3', 'Esquina fuera del mapa'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l431-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el par ordenado (4, 7) del plano cartesiano, el primer número (4) indica avanzar horizontalmente y el ___ indica subir verticalmente',
            'options': ['4', '7', '11', '0'],
            'correct_answer': '7',
          },
        ),
        Exercise(
          id: 'l431-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El punto donde se cruzan el eje horizontal y el eje vertical en el plano tiene coordenadas…',
            'options': ['(0, 0)', '(1, 1)', '(10, 10)', '(0, 1)'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l431-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada movimiento desde (0, 0) con su coordenada',
            'items': ['3 a la derecha y 2 arriba', '5 a la derecha y 1 arriba', '2 a la derecha y 6 arriba'],
            'targets': ['(3, 2)', '(5, 1)', '(2, 6)'],
            'correct_mapping': {
              '3 a la derecha y 2 arriba': '(3, 2)',
              '5 a la derecha y 1 arriba': '(5, 1)',
              '2 a la derecha y 6 arriba': '(2, 6)',
            },
          },
        ),
        Exercise(
          id: 'l431-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si estás en la casilla (2, 4) y avanzas 3 casillas hacia arriba, llegas a (2, ___)',
            'options': ['5', '6', '7', '1'],
            'correct_answer': '7',
          },
        ),
      ],
    ),

    'lesson-432': Lesson(
      id: 'lesson-432', unitId: 'unit-407', orderNum: 2,
      title: 'Puntos cardinales en mapas de Colombia',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l432-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la rosa de los vientos de un mapa de Colombia, ¿qué punto cardinal señala hacia arriba (donde está La Guajira y el mar Caribe)?',
            'options': ['El Norte', 'El Sur', 'El Oriente (Este)', 'El Occidente (Oeste)'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l432-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Leticia y la selva del Amazonas quedan en el extremo ___ de Colombia',
            'options': ['Sur', 'Norte', 'Occidente', 'Centro'],
            'correct_answer': 'Sur',
          },
        ),
        Exercise(
          id: 'l432-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El Sol sale cada mañana por la cordillera hacia los Llanos Orientales. ¿Qué punto cardinal es ese?',
            'options': ['Oriente (Este)', 'Occidente (Oeste)', 'Sur', 'Norte'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l432-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada región de Colombia con su ubicación en el mapa',
            'items': ['Península de La Guajira', 'Océano Pacífico (Chocó y Valle)', 'Amazonas (Leticia)'],
            'targets': ['Norte', 'Occidente (Oeste)', 'Sur'],
            'correct_mapping': {
              'Península de La Guajira': 'Norte',
              'Océano Pacífico (Chocó y Valle)': 'Occidente (Oeste)',
              'Amazonas (Leticia)': 'Sur',
            },
          },
        ),
        Exercise(
          id: 'l432-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El punto cardinal opuesto al Oriente (Este) es el ___',
            'options': ['Occidente (Oeste)', 'Norte', 'Sur', 'Centro'],
            'correct_answer': 'Occidente (Oeste)',
          },
        ),
      ],
    ),

    'lesson-433': Lesson(
      id: 'lesson-433', unitId: 'unit-407', orderNum: 3,
      title: '¿Qué es una escala (1:100)?',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l433-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '1:100 significa que 1 cm en el plano equivale a 100 cm (1 metro) en la vida real',
          content: {
            'question': 'En el plano de una casa con escala 1:100, cada 1 cm dibujado representa 1 metro real. Si la sala mide 5 cm en el plano, ¿cuánto mide en realidad?',
            'options': ['5 metros', '50 metros', '500 metros', '1 metro'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l433-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En un plano a escala 1 cm = 2 metros, un corredor que mide 6 cm en el papel tiene ___ metros reales',
            'options': ['8', '10', '12', '6'],
            'correct_answer': '12',
          },
        ),
        Exercise(
          id: 'l433-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Para qué sirve la escala en un mapa o plano?',
            'options': [
              'Para representar lugares grandes en una hoja manteniendo sus proporciones reales',
              'Para cambiar los colores del mapa',
              'Para borrar las montañas',
              'Para medir el peso del papel',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l433-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con escala 1 cm = 10 metros, relaciona la medida del dibujo con la real',
            'items': ['3 cm en el plano', '7 cm en el plano', '10 cm en el plano'],
            'targets': ['30 metros reales', '70 metros reales', '100 metros reales'],
            'correct_mapping': {
              '3 cm en el plano': '30 metros reales',
              '7 cm en el plano': '70 metros reales',
              '10 cm en el plano': '100 metros reales',
            },
          },
        ),
        Exercise(
          id: 'l433-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si una cancha mide 28 metros reales y la escala es 1 cm = 4 m, en el plano debemos dibujarla de (28 ÷ 4) = ___ cm',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '7',
          },
        ),
      ],
    ),

    'lesson-434': Lesson(
      id: 'lesson-434', unitId: 'unit-407', orderNum: 4,
      title: 'Distancias en mapas de Colombia',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l434-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En un mapa de Colombia donde 1 cm = 50 km, la distancia en línea recta entre dos ciudades es de 4 cm. ¿Cuántos kilómetros reales las separan?',
            'options': ['100 km', '150 km', '200 km', '250 km'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l434-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si en un mapa 1 cm equivale a 100 km, entonces 6 cm representan ___ km',
            'options': ['60', '600', '6.000', '106'],
            'correct_answer': '600',
          },
        ),
        Exercise(
          id: 'l434-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En un mapa turístico del Parque Tayrona, 1 cm = 500 metros. Si el sendero mide 6 cm en el mapa, ¿cuántos metros caminarás?',
            'options': ['1.500 m', '2.000 m', '3.000 m', '600 m'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l434-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con escala 1 cm = 25 km, relaciona cada distancia en el mapa con los kilómetros reales',
            'items': ['2 cm', '4 cm', '8 cm'],
            'targets': ['50 km', '100 km', '200 km'],
            'correct_mapping': {'2 cm': '50 km', '4 cm': '100 km', '8 cm': '200 km'},
          },
        ),
        Exercise(
          id: 'l434-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '1 kilómetro es igual a ___ metros',
            'options': ['100', '500', '1.000', '10.000'],
            'correct_answer': '1.000',
          },
        ),
      ],
    ),

    'lesson-435': Lesson(
      id: 'lesson-435', unitId: 'unit-407', orderNum: 5,
      title: '¡Desafío de mapas y escalas!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l435-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El plano de un salón está a escala 1:100 (1 cm = 1 m). Si el salón en el dibujo mide 8 cm de largo por 6 cm de ancho, ¿cuál es su área real?',
            'options': ['14 m²', '28 m²', '48 m²', '480 m²'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l435-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si estás en el punto (3, 5) de una cuadrícula y te mueves 4 unidades a la derecha, tu nueva posición es (___, 5)',
            'options': ['6', '7', '8', '9'],
            'correct_answer': '7',
          },
        ),
        Exercise(
          id: 'l435-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Dos pueblos están a 120 km de distancia real y en el mapa están separados por 4 cm. ¿Cuántos kilómetros representa 1 cm del mapa (120 ÷ 4)?',
            'options': ['20 km', '30 km', '40 km', '60 km'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l435-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada elemento de un mapa con su utilidad',
            'items': ['Rosa de los vientos', 'Escala (ej. 1:100)', 'Cuadrícula de coordenadas'],
            'targets': ['Indica Norte, Sur, Este y Oeste', 'Relaciona el tamaño del dibujo con el real', 'Ubica puntos con pares (columna, fila)'],
            'correct_mapping': {
              'Rosa de los vientos': 'Indica Norte, Sur, Este y Oeste',
              'Escala (ej. 1:100)': 'Relaciona el tamaño del dibujo con el real',
              'Cuadrícula de coordenadas': 'Ubica puntos con pares (columna, fila)',
            },
          },
        ),
        Exercise(
          id: 'l435-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Con escala 1 cm = 15 km, un río que mide 5 cm en el mapa tiene una longitud real de ___ km',
            'options': ['60', '70', '75', '85'],
            'correct_answer': '75',
          },
        ),
        Exercise(
          id: 'l435-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si viajas desde Bogotá hacia Barranquilla o Santa Marta, ¿hacia qué punto cardinal te diriges?',
            'options': ['Hacia el Norte', 'Hacia el Sur', 'Hacia la Antártida', 'No te mueves'],
            'correct_index': 0,
          },
        ),
      ],
    ),

    // ── UNIDAD 408: Probabilidad ── DBA #8 Grado 4° (Período 4)
    // "Calcula probabilidades simples en experimentos concretos (cara/sello, dados)."
    'lesson-436': Lesson(
      id: 'lesson-436', unitId: 'unit-408', orderNum: 1,
      title: 'Seguro, posible e imposible',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l436-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una bolsa hay SOLO 10 bolas rojas. Si sacas una bola sin mirar, ¿qué tan probable es que sea roja?',
            'options': ['Seguro (siempre ocurrirá)', 'Imposible', 'Poco probable', 'Nunca pasa'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l436-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Al lanzar un dado normal de 6 caras (con números del 1 al 6), sacar el número 9 es un evento ___',
            'options': ['imposible', 'seguro', 'muy probable', 'igual'],
            'correct_answer': 'imposible',
          },
        ),
        Exercise(
          id: 'l436-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Al lanzar una moneda de \$500 al aire, que caiga "cara" es un evento…',
            'options': ['Posible', 'Imposible', 'Obligatorio siempre', 'Inexistente'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l436-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con una bolsa que tiene 5 dulces de fresa y 5 de limón, clasifica cada evento',
            'items': ['Sacar un dulce de fresa o de limón', 'Sacar un dulce de fresa', 'Sacar un dulce de chocolate'],
            'targets': ['Seguro', 'Posible', 'Imposible'],
            'correct_mapping': {
              'Sacar un dulce de fresa o de limón': 'Seguro',
              'Sacar un dulce de fresa': 'Posible',
              'Sacar un dulce de chocolate': 'Imposible',
            },
          },
        ),
        Exercise(
          id: 'l436-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Que después del día viernes llegue el día sábado es un evento ___',
            'options': ['seguro', 'imposible', 'raro', 'dudoso'],
            'correct_answer': 'seguro',
          },
        ),
      ],
    ),

    'lesson-437': Lesson(
      id: 'lesson-437', unitId: 'unit-408', orderNum: 2,
      title: 'Más probable y menos probable',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l437-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una caja hay 8 canicas azules, 3 verdes y 1 amarilla. Si sacas una sin mirar, ¿qué color es MÁS PROBABLE sacar?',
            'options': ['Amarillo', 'Verde', 'Azul', 'Rojo'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l437-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la misma caja (8 azules, 3 verdes, 1 amarilla), el color MENOS probable (pero posible) de sacar es el ___',
            'options': ['amarillo', 'azul', 'verde', 'negro'],
            'correct_answer': 'amarillo',
          },
        ),
        Exercise(
          id: 'l437-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una ruleta está dividida en 6 partes iguales: 3 son rojas y 3 son blancas. ¿Cuál color tiene mayor probabilidad?',
            'options': ['El rojo', 'El blanco', 'Tienen igual probabilidad (50% y 50%)', 'Ninguno'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l437-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'En una canasta con 10 mangos, 4 manzanas y 1 pera, ordena su probabilidad',
            'items': ['Sacar un mango (10)', 'Sacar una manzana (4)', 'Sacar una pera (1)'],
            'targets': ['Más probable', 'Probabilidad media', 'Menos probable'],
            'correct_mapping': {
              'Sacar un mango (10)': 'Más probable',
              'Sacar una manzana (4)': 'Probabilidad media',
              'Sacar una pera (1)': 'Menos probable',
            },
          },
        ),
        Exercise(
          id: 'l437-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Al lanzar un dado del 1 al 6, sacar un número menor que 6 (1, 2, 3, 4 o 5) es ___ probable que sacar exactamente un 6',
            'options': ['más', 'menos', 'igual de', 'nada'],
            'correct_answer': 'más',
          },
        ),
      ],
    ),

    'lesson-438': Lesson(
      id: 'lesson-438', unitId: 'unit-408', orderNum: 3,
      title: 'Monedas, dados y ruletas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l438-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Al lanzar un dado común de 6 caras, ¿cuántos resultados posibles existen en total?',
            'options': ['2 resultados', '4 resultados', '6 resultados (1, 2, 3, 4, 5, 6)', '12 resultados'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l438-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En un dado del 1 al 6, los números pares son 2, 4 y 6, es decir hay ___ casos favorables de 6',
            'options': ['2', '3', '4', '6'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l438-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Al lanzar una moneda colombiana, ¿cuántos resultados posibles hay?',
            'options': ['1 (solo cara)', '2 (cara o sello)', '4', '6'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l438-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'En un dado del 1 al 6, relaciona cada evento con cuántos números lo cumplen',
            'items': ['Sacar el número 5', 'Sacar un número par (2, 4, 6)', 'Sacar un número mayor que 2 (3, 4, 5, 6)'],
            'targets': ['1 de 6', '3 de 6', '4 de 6'],
            'correct_mapping': {
              'Sacar el número 5': '1 de 6',
              'Sacar un número par (2, 4, 6)': '3 de 6',
              'Sacar un número mayor que 2 (3, 4, 5, 6)': '4 de 6',
            },
          },
        ),
        Exercise(
          id: 'l438-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si una ruleta tiene 8 secciones iguales numeradas del 1 al 8, hay ___ resultados posibles',
            'options': ['4', '6', '8', '10'],
            'correct_answer': '8',
          },
        ),
      ],
    ),

    'lesson-439': Lesson(
      id: 'lesson-439', unitId: 'unit-408', orderNum: 4,
      title: 'Probabilidad como fracción',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l439-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '¡Cuenta las opciones que te sirven (arriba) y el total de caras que pueden salir (abajo)! 🪙',
          content: {
            'question': '¿Cuál es la probabilidad en fracción de sacar "cara" al lanzar una moneda?',
            'options': ['1/2', '1/4', '1/6', '2/1'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l439-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Al lanzar un dado de 6 caras, la probabilidad de sacar el número 4 es ___',
            'options': ['1/6', '4/6', '1/4', '6/6'],
            'correct_answer': '1/6',
          },
        ),
        Exercise(
          id: 'l439-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una bolsa hay 3 fichas verdes y 2 fichas rojas (5 fichas en total). ¿Cuál es la probabilidad de sacar una ficha verde?',
            'options': ['2/5', '3/5', '3/2', '1/5'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l439-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'En una bolsa con 10 balotas (5 rojas, 3 azules y 2 amarillas), relaciona cada probabilidad',
            'items': ['Sacar roja', 'Sacar azul', 'Sacar amarilla'],
            'targets': ['5/10 (o 1/2)', '3/10', '2/10'],
            'correct_mapping': {
              'Sacar roja': '5/10 (o 1/2)',
              'Sacar azul': '3/10',
              'Sacar amarilla': '2/10',
            },
          },
        ),
        Exercise(
          id: 'l439-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En una rifa de 100 boletas, si compras 7 boletas tu probabilidad de ganar es ___',
            'options': ['7/100', '1/7', '7/10', '93/100'],
            'correct_answer': '7/100',
          },
        ),
      ],
    ),

    'lesson-440': Lesson(
      id: 'lesson-440', unitId: 'unit-408', orderNum: 5,
      title: '¡Desafío de probabilidad!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l440-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el salón 4°A hay 12 niñas y 8 niños (20 estudiantes en total). Si se elige un representante al azar, ¿cuál es la probabilidad de que sea niña?',
            'options': ['8/20', '12/20', '1/12', '12/8'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l440-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Al lanzar un dado de 6 caras, los números mayores que 4 son el 5 y el 6, por lo que la probabilidad es ___/6',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l440-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un evento imposible tiene probabilidad 0, mientras que un evento 100% seguro tiene probabilidad igual a…',
            'options': ['1 (el total sobre el total, ej. 6/6)', '0', '1/2', '1/10'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l440-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con una ruleta de 4 partes iguales (2 azules, 1 roja, 1 verde), relaciona',
            'items': ['Caer en azul', 'Caer en rojo', 'Caer en morado'],
            'targets': ['2/4 (1/2)', '1/4', '0/4 (imposible)'],
            'correct_mapping': {
              'Caer en azul': '2/4 (1/2)',
              'Caer en rojo': '1/4',
              'Caer en morado': '0/4 (imposible)',
            },
          },
        ),
        Exercise(
          id: 'l440-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si tienes 3 camisas y 2 pantalones, puedes armar (3 × 2) = ___ combinaciones distintas de ropa',
            'options': ['5', '6', '8', '9'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l440-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si sacas una letra al azar de la palabra COLOMBIA (8 letras, donde la O aparece 2 veces), ¿cuál es la probabilidad de sacar la letra O?',
            'options': ['1/8', '2/8 (o 1/4)', '3/8', '2/6'],
            'correct_index': 1,
          },
        ),
      ],
    ),
};
