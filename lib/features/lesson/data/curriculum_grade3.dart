// Currículo Grado 3° — Números hasta 100.000, Tablas 1–10, División
// 15 lecciones alineadas con DBA MEN Colombia

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade3Lessons = {

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
};
