// Currículo Grado 3° — 8 unidades (4 períodos académicos, 40 lecciones)
// Alineado con DBA MEN Colombia (Pensamientos NV, EM y AL)

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade3Lessons = {

    // ── UNIDAD 301: Números hasta 100.000 ── DBA #1 Grado 3°
    // "Lee, escribe y ordena números hasta 100.000. Representa en recta numérica."
    'lesson-301': Lesson(
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

    'lesson-302': Lesson(
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

    'lesson-303': Lesson(
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

    'lesson-304': Lesson(
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

    'lesson-305': Lesson(
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
    'lesson-306': Lesson(
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

    'lesson-307': Lesson(
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

    'lesson-308': Lesson(
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

    'lesson-309': Lesson(
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

    'lesson-310': Lesson(
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
    'lesson-311': Lesson(
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

    'lesson-312': Lesson(
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

    'lesson-313': Lesson(
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

    'lesson-314': Lesson(
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

    'lesson-315': Lesson(
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

    // ── UNIDAD 304: Perímetro y ángulos ── DBA #6 Grado 3° (Período 1)
    // "Calcula perímetro de figuras planas. Reconoce ángulos rectos, agudos y obtusos."
    'lesson-316': Lesson(
      id: 'lesson-316', unitId: 'unit-304', orderNum: 1,
      title: '¿Qué es el perímetro?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l316-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'El perímetro es la suma de todos los lados del borde',
          content: {
            'question': '¿Cómo se calcula el perímetro de cualquier figura plana de lados rectos?',
            'options': [
              'Sumando la medida de todos sus lados',
              'Restando el lado mayor menos el menor',
              'Contando solo un lado',
              'Dividiendo entre 2',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l316-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un triángulo cuyos lados miden 8 cm, 10 cm y 12 cm tiene un perímetro de ___ cm',
            'options': ['28', '30', '32', '20'],
            'correct_answer': '30',
          },
        ),
        Exercise(
          id: 'l316-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Para cercar con malla una huerta escolar rectangular de 6 m por 4 m, ¿qué debemos calcular?',
            'options': ['Su perímetro (20 m)', 'Su peso', 'Su temperatura', 'Su hora'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l316-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada polígono con su perímetro',
            'items': ['Triángulo de lados 5, 5 y 5 cm', 'Cuadrado de lado 6 cm', 'Triángulo de lados 7, 8 y 9 cm'],
            'targets': ['15 cm', '24 cm', '24 cm (7+8+9)'],
            'correct_mapping': {
              'Triángulo de lados 5, 5 y 5 cm': '15 cm',
              'Cuadrado de lado 6 cm': '24 cm',
              'Triángulo de lados 7, 8 y 9 cm': '24 cm (7+8+9)',
            },
          },
        ),
        Exercise(
          id: 'l316-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un pentágono tiene 5 lados iguales de 4 cm cada uno, su perímetro es ___ cm',
            'options': ['15', '20', '25', '9'],
            'correct_answer': '20',
          },
        ),
      ],
    ),

    'lesson-317': Lesson(
      id: 'lesson-317', unitId: 'unit-304', orderNum: 2,
      title: 'Perímetro de cuadrados y rectángulos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l317-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un cuadrado tiene 4 lados iguales de 9 cm. ¿Cuál operación rápida da su perímetro?',
            'options': ['4 × 9 = 36 cm', '4 + 9 = 13 cm', '9 - 4 = 5 cm', '9 × 2 = 18 cm'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l317-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una cancha de microfútbol mide 25 m de largo y 15 m de ancho. Su perímetro (25+15+25+15) es ___ m',
            'options': ['40', '65', '80', '90'],
            'correct_answer': '80',
          },
        ),
        Exercise(
          id: 'l317-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si el perímetro de un cuadrado es 28 cm, ¿cuánto mide cada uno de sus 4 lados?',
            'options': ['6 cm', '7 cm', '8 cm', '14 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l317-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada figura con su perímetro total',
            'items': ['Cuadrado de lado 8 m', 'Rectángulo de 10 m × 5 m', 'Cuadrado de lado 12 m'],
            'targets': ['32 m', '30 m', '48 m'],
            'correct_mapping': {
              'Cuadrado de lado 8 m': '32 m',
              'Rectángulo de 10 m × 5 m': '30 m',
              'Cuadrado de lado 12 m': '48 m',
            },
          },
        ),
        Exercise(
          id: 'l317-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un marco rectangular mide 12 cm de alto y 8 cm de ancho. Su perímetro es ___ cm',
            'options': ['20', '32', '40', '48'],
            'correct_answer': '40',
          },
        ),
      ],
    ),

    'lesson-318': Lesson(
      id: 'lesson-318', unitId: 'unit-304', orderNum: 3,
      title: 'Ángulo recto, agudo y obtuso',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l318-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Observa la esquina de una hoja de cuaderno o de una puerta',
          content: {
            'question': '¿Cómo se llama el ángulo que forma una esquina perfecta en forma de "L" (90 grados)?',
            'options': ['Ángulo recto', 'Ángulo agudo', 'Ángulo obtuso', 'Círculo'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l318-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un ángulo más cerrado (menor) que un ángulo recto se llama ángulo ___',
            'options': ['agudo', 'obtuso', 'recto', 'llano'],
            'correct_answer': 'agudo',
          },
        ),
        Exercise(
          id: 'l318-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos ángulos rectos tiene un rectángulo o un cuadrado en sus esquinas?',
            'options': ['2', '3', '4', '0'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l318-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada tipo de ángulo con su abertura',
            'items': ['Ángulo recto', 'Ángulo agudo', 'Ángulo obtuso'],
            'targets': ['Esquina en L (90°)', 'Más cerrado que L (<90°)', 'Más abierto que L (>90°)'],
            'correct_mapping': {
              'Ángulo recto': 'Esquina en L (90°)',
              'Ángulo agudo': 'Más cerrado que L (<90°)',
              'Ángulo obtuso': 'Más abierto que L (>90°)',
            },
          },
        ),
        Exercise(
          id: 'l318-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un ángulo más abierto (mayor) que un ángulo recto se llama ángulo ___',
            'options': ['obtuso', 'agudo', 'recto', 'pequeño'],
            'correct_answer': 'obtuso',
          },
        ),
      ],
    ),

    'lesson-319': Lesson(
      id: 'lesson-319', unitId: 'unit-304', orderNum: 4,
      title: 'Giros y direcciones',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l319-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Cuando el reloj marca las 3:00 en punto, ¿qué ángulo forman sus dos agujas?',
            'options': ['Un ángulo recto', 'Un ángulo cerrado de 0°', 'Una vuelta completa', 'Ninguno'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l319-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cuarto de vuelta (1/4 de giro) equivale a un ángulo ___',
            'options': ['recto', 'agudo', 'completo', 'nulo'],
            'correct_answer': 'recto',
          },
        ),
        Exercise(
          id: 'l319-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si miras hacia el Norte y das MEDIA vuelta (medio giro), ¿hacia dónde quedas mirando?',
            'options': ['Hacia el Sur (atrás)', 'Hacia el Norte', 'Hacia el techo', 'No cambias'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l319-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona las agujas del reloj con el ángulo que forman',
            'items': ['A las 3:00', 'A las 1:00', 'A las 5:00'],
            'targets': ['Ángulo recto', 'Ángulo agudo', 'Ángulo obtuso'],
            'correct_mapping': {
              'A las 3:00': 'Ángulo recto',
              'A las 1:00': 'Ángulo agudo',
              'A las 5:00': 'Ángulo obtuso',
            },
          },
        ),
        Exercise(
          id: 'l319-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si das 4 cuartos de vuelta seguidos, completas ___ vuelta entera',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '1',
          },
        ),
      ],
    ),

    'lesson-320': Lesson(
      id: 'lesson-320', unitId: 'unit-304', orderNum: 5,
      title: '¡Desafío de perímetro y ángulos!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l320-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un lote cuadrado en el Eje Cafetero mide 15 m por cada lado. ¿Cuál es su perímetro?',
            'options': ['30 m', '45 m', '60 m', '75 m'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l320-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un rectángulo tiene perímetro de 30 cm. Si sus dos lados largos miden 10 cm cada uno (20 cm en total), los dos lados cortos suman ___ cm',
            'options': ['5', '10', '15', '20'],
            'correct_answer': '10',
          },
        ),
        Exercise(
          id: 'l320-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Dos cuadrados separados tienen en total cuántos ángulos rectos?',
            'options': ['4', '6', '8', '10'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l320-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada problema con su resultado',
            'items': ['Perímetro de cuadrado de lado 7 cm', 'Perímetro de triángulo equilátero de lado 9 cm', 'Lado de un cuadrado de perímetro 36 cm'],
            'targets': ['28 cm', '27 cm', '9 cm'],
            'correct_mapping': {
              'Perímetro de cuadrado de lado 7 cm': '28 cm',
              'Perímetro de triángulo equilátero de lado 9 cm': '27 cm',
              'Lado de un cuadrado de perímetro 36 cm': '9 cm',
            },
          },
        ),
        Exercise(
          id: 'l320-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La punta de una flecha afilada forma un ángulo ___',
            'options': ['agudo', 'recto', 'obtuso', 'cuadrado'],
            'correct_answer': 'agudo',
          },
        ),
        Exercise(
          id: 'l320-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Mateo dio 2 vueltas completas trotando alrededor de un parque rectangular de 20 m × 10 m (perímetro 60 m). ¿Cuántos metros corrió?',
            'options': ['60 m', '90 m', '120 m', '100 m'],
            'correct_index': 2,
          },
        ),
      ],
    ),

    // ── UNIDAD 305: El tiempo y el calendario ── DBA #7 Grado 3° (Período 2)
    // "Usa el calendario y mide el tiempo en horas, minutos, días, semanas y meses."
    'lesson-321': Lesson(
      id: 'lesson-321', unitId: 'unit-305', orderNum: 1,
      title: 'Horas, minutos y segundos',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l321-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos minutos tiene 1 hora completa?',
            'options': ['30 minutos', '60 minutos', '100 minutos', '24 minutos'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l321-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '1 minuto tiene ___ segundos',
            'options': ['30', '60', '100', '10'],
            'correct_answer': '60',
          },
        ),
        Exercise(
          id: 'l321-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos minutos hay en un cuarto de hora (1/4 de hora)?',
            'options': ['10 minutos', '15 minutos', '20 minutos', '25 minutos'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l321-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada fracción de hora con sus minutos',
            'items': ['Media hora', 'Un cuarto de hora', 'Dos horas'],
            'targets': ['30 minutos', '15 minutos', '120 minutos'],
            'correct_mapping': {
              'Media hora': '30 minutos',
              'Un cuarto de hora': '15 minutos',
              'Dos horas': '120 minutos',
            },
          },
        ),
        Exercise(
          id: 'l321-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un día completo tiene ___ horas',
            'options': ['12', '24', '30', '60'],
            'correct_answer': '24',
          },
        ),
      ],
    ),

    'lesson-322': Lesson(
      id: 'lesson-322', unitId: 'unit-305', orderNum: 2,
      title: 'El calendario: semanas y meses',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l322-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos meses tiene un año?',
            'options': ['10 meses', '12 meses', '7 meses', '30 meses'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l322-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En 3 semanas completas hay (3 × 7) = ___ días',
            'options': ['14', '21', '28', '30'],
            'correct_answer': '21',
          },
        ),
        Exercise(
          id: 'l322-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El Día de la Independencia de Colombia se celebra el 20 de julio. ¿Qué número de mes es julio?',
            'options': ['Mes 5', 'Mes 6', 'Mes 7', 'Mes 8'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l322-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada período de tiempo con su equivalencia',
            'items': ['1 semana', '4 semanas', '1 año común'],
            'targets': ['7 días', '28 días', '365 días'],
            'correct_mapping': {
              '1 semana': '7 días',
              '4 semanas': '28 días',
              '1 año común': '365 días',
            },
          },
        ),
        Exercise(
          id: 'l322-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El único mes del año que tiene 28 días (o 29 en año bisiesto) es ___',
            'options': ['febrero', 'enero', 'marzo', 'diciembre'],
            'correct_answer': 'febrero',
          },
        ),
      ],
    ),

    'lesson-323': Lesson(
      id: 'lesson-323', unitId: 'unit-305', orderNum: 3,
      title: 'Duración de eventos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l323-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un partido de fútbol infantil empieza a las 2:15 p.m. y termina a las 3:00 p.m. ¿Cuántos minutos duró?',
            'options': ['30 minutos', '45 minutos', '60 minutos', '15 minutos'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l323-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un bus sale de Tunja a las 8:00 a.m. y llega a Bogotá a las 10:30 a.m., el viaje duró 2 horas y ___ minutos',
            'options': ['15', '30', '45', '50'],
            'correct_answer': '30',
          },
        ),
        Exercise(
          id: 'l323-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una película empieza a las 4:20 y dura 1 hora y 30 minutos. ¿A qué hora termina?',
            'options': ['5:20', '5:50', '6:00', '4:50'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l323-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona la hora de inicio y fin con el tiempo transcurrido',
            'items': ['De 9:00 a 9:25', 'De 10:10 a 10:50', 'De 1:00 a 3:00'],
            'targets': ['25 minutos', '40 minutos', '2 horas'],
            'correct_mapping': {
              'De 9:00 a 9:25': '25 minutos',
              'De 10:10 a 10:50': '40 minutos',
              'De 1:00 a 3:00': '2 horas',
            },
          },
        ),
        Exercise(
          id: 'l323-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si hoy es 12 de agosto y el paseo escolar es dentro de 10 días, el paseo será el ___ de agosto',
            'options': ['20', '22', '24', '18'],
            'correct_answer': '22',
          },
        ),
      ],
    ),

    'lesson-324': Lesson(
      id: 'lesson-324', unitId: 'unit-305', orderNum: 4,
      title: 'Problemas de tiempo cotidianos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l324-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Sofía lee un cuento durante 20 minutos cada día. ¿Cuántos minutos lee en 3 días?',
            'options': ['40 minutos', '50 minutos', '60 minutos (1 hora)', '80 minutos'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l324-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '1 hora y 25 minutos equivalen en total a (60 + 25) = ___ minutos',
            'options': ['75', '85', '95', '125'],
            'correct_answer': '85',
          },
        ),
        Exercise(
          id: 'l324-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Las vacaciones de mitad de año duran 3 semanas. ¿Cuántos días son 3 semanas?',
            'options': ['15 días', '21 días', '24 días', '30 días'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l324-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Convierte cada tiempo a minutos totales',
            'items': ['1 hora y 10 min', '1 hora y 40 min', '2 horas exactas'],
            'targets': ['70 minutos', '100 minutos', '120 minutos'],
            'correct_mapping': {
              '1 hora y 10 min': '70 minutos',
              '1 hora y 40 min': '100 minutos',
              '2 horas exactas': '120 minutos',
            },
          },
        ),
        Exercise(
          id: 'l324-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En medio año hay ___ meses',
            'options': ['4', '5', '6', '8'],
            'correct_answer': '6',
          },
        ),
      ],
    ),

    'lesson-325': Lesson(
      id: 'lesson-325', unitId: 'unit-305', orderNum: 5,
      title: '¡Desafío del calendario y el reloj!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l325-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un vuelo de Bogotá a Cartagena sale a las 9:15 a.m. y dura 1 hora y 30 minutos. ¿A qué hora aterriza?',
            'options': ['10:15 a.m.', '10:30 a.m.', '10:45 a.m.', '11:00 a.m.'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l325-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En 5 semanas completas hay (5 × 7) = ___ días',
            'options': ['30', '35', '40', '42'],
            'correct_answer': '35',
          },
        ),
        Exercise(
          id: 'l325-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos minutos hay en 3 horas completas?',
            'options': ['120 minutos', '150 minutos', '180 minutos', '300 minutos'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l325-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada cálculo de tiempo con su respuesta',
            'items': ['3 cuartos de hora', '2 días en horas', '2 años en meses'],
            'targets': ['45 minutos', '48 horas', '24 meses'],
            'correct_mapping': {
              '3 cuartos de hora': '45 minutos',
              '2 días en horas': '48 horas',
              '2 años en meses': '24 meses',
            },
          },
        ),
        Exercise(
          id: 'l325-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si el horno para hacer pandebonos se prende a las 3:10 y se apaga a las 3:35, estuvo prendido ___ minutos',
            'options': ['15', '20', '25', '35'],
            'correct_answer': '25',
          },
        ),
        Exercise(
          id: 'l325-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si el cumpleaños de Mateo es el 25 de mayo y hoy es 18 de mayo, ¿cuánto falta para su cumpleaños?',
            'options': ['5 días', '7 días (1 semana)', '10 días', '14 días'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 306: Problemas de multiplicación y división ── DBA #2 Grado 3° (Período 3)
    // "Resuelve problemas de multiplicación y división con números de hasta 2 cifras."
    'lesson-326': Lesson(
      id: 'lesson-326', unitId: 'unit-306', orderNum: 1,
      title: 'Multiplicar por 10 y por decenas',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l326-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Al multiplicar por 10 agregamos un cero al final',
          content: {
            'question': 'En la papelería hay 8 cajas con 10 colores cada una. ¿Cuántos colores hay en total?',
            'options': ['18', '80', '800', '40'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l326-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '20 × 4 = ___',
            'options': ['60', '80', '100', '24'],
            'correct_answer': '80',
          },
        ),
        Exercise(
          id: 'l326-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un bus intermunicipal lleva 30 pasajeros en cada viaje. ¿Cuántos pasajeros lleva en 3 viajes llenos?',
            'options': ['60', '90', '120', '33'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l326-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación por decenas con su producto',
            'items': ['10 × 6', '30 × 2', '40 × 2'],
            'targets': ['60', '60 (30×2)', '80'],
            'correct_mapping': {
              '10 × 6': '60',
              '30 × 2': '60 (30×2)',
              '40 × 2': '80',
            },
          },
        ),
        Exercise(
          id: 'l326-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '5 billetes de \$10.000 suman \$___',
            'options': ['20.000', '40.000', '50.000', '60.000'],
            'correct_answer': '50.000',
          },
        ),
      ],
    ),

    'lesson-327': Lesson(
      id: 'lesson-327', unitId: 'unit-306', orderNum: 2,
      title: 'Multiplicar 2 cifras por 1 cifra',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l327-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '12 × 3 = (10 × 3) + (2 × 3)',
          content: {
            'question': '¿Cuánto es 12 × 3?',
            'options': ['32', '35', '36', '39'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l327-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '21 × 4 = ___',
            'options': ['81', '84', '88', '64'],
            'correct_answer': '84',
          },
        ),
        Exercise(
          id: 'l327-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En el colegio hay 4 salones de tercero con 23 estudiantes cada uno. ¿Cuántos estudiantes hay en total?',
            'options': ['82', '92', '96', '88'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l327-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada multiplicación con su resultado',
            'items': ['14 × 2', '15 × 3', '25 × 2'],
            'targets': ['28', '45', '50'],
            'correct_mapping': {'14 × 2': '28', '15 × 3': '45', '25 × 2': '50'},
          },
        ),
        Exercise(
          id: 'l327-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '32 × 3 = ___',
            'options': ['66', '92', '96', '99'],
            'correct_answer': '96',
          },
        ),
      ],
    ),

    'lesson-328': Lesson(
      id: 'lesson-328', unitId: 'unit-306', orderNum: 3,
      title: 'División exacta de 2 cifras',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l328-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si repartimos 40 naranjas en 2 canastas iguales, ¿cuántas van en cada canasta?',
            'options': ['15', '20', '25', '10'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l328-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '60 ÷ 3 = ___',
            'options': ['15', '20', '30', '25'],
            'correct_answer': '20',
          },
        ),
        Exercise(
          id: 'l328-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un profesor reparte 48 hojas en partes iguales entre 4 equipos. ¿Cuántas hojas recibe cada equipo?',
            'options': ['10', '12', '14', '16'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l328-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división con su cociente',
            'items': ['36 ÷ 3', '44 ÷ 4', '50 ÷ 5'],
            'targets': ['12', '11', '10'],
            'correct_mapping': {'36 ÷ 3': '12', '44 ÷ 4': '11', '50 ÷ 5': '10'},
          },
        ),
        Exercise(
          id: 'l328-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '84 ÷ 4 = ___',
            'options': ['20', '21', '22', '24'],
            'correct_answer': '21',
          },
        ),
      ],
    ),

    'lesson-329': Lesson(
      id: 'lesson-329', unitId: 'unit-306', orderNum: 4,
      title: 'Problemas de dos pasos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l329-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Camila compró 3 paquetes de 12 galletas y regaló 6 galletas. ¿Cuántas galletas le quedaron?',
            'options': ['24', '30', '36', '42'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l329-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En 2 cajas hay 15 mangos en cada una (2×15=30). Si se reparten entre 5 niños (30÷5), cada niño recibe ___ mangos',
            'options': ['5', '6', '7', '10'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l329-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una boleta para el zoológico de Cali cuesta \$15.000. ¿Cuánto cuestan 3 boletas?',
            'options': ['\$35.000', '\$40.000', '\$45.000', '\$50.000'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l329-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada operación combinada con su resultado',
            'items': ['(10 × 3) + 5', '(20 × 2) - 10', '(12 × 2) ÷ 4'],
            'targets': ['35', '30', '6'],
            'correct_mapping': {
              '(10 × 3) + 5': '35',
              '(20 × 2) - 10': '30',
              '(12 × 2) ÷ 4': '6',
            },
          },
        ),
        Exercise(
          id: 'l329-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si ahorras \$2.000 diarios durante 14 días, ahorras \$___',
            'options': ['24.000', '28.000', '30.000', '16.000'],
            'correct_answer': '28.000',
          },
        ),
      ],
    ),

    'lesson-330': Lesson(
      id: 'lesson-330', unitId: 'unit-306', orderNum: 5,
      title: '¡Desafío de operaciones 3°!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l330-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una finca de Antioquia recogieron 4 canastos con 25 aguacates cada uno. ¿Cuántos aguacates recogieron?',
            'options': ['80', '90', '100', '125'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l330-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '96 ÷ 3 = ___',
            'options': ['31', '32', '33', '23'],
            'correct_answer': '32',
          },
        ),
        Exercise(
          id: 'l330-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si 18 × 5 = 90, ¿cuánto es 90 ÷ 5?',
            'options': ['15', '18', '20', '16'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l330-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada operación con su respuesta',
            'items': ['16 × 4', '75 ÷ 3', '24 × 3'],
            'targets': ['64', '25', '72'],
            'correct_mapping': {'16 × 4': '64', '75 ÷ 3': '25', '24 × 3': '72'},
          },
        ),
        Exercise(
          id: 'l330-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un álbum tiene 15 páginas con 6 láminas por página. En total caben ___ láminas',
            'options': ['75', '80', '90', '95'],
            'correct_answer': '90',
          },
        ),
        Exercise(
          id: 'l330-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Se empacan 68 bocadillos en cajas de 4 unidades. ¿Cuántas cajas se llenan?',
            'options': ['15 cajas', '16 cajas', '17 cajas', '18 cajas'],
            'correct_index': 2,
          },
        ),
      ],
    ),

    // ── UNIDAD 307: Fracciones simples ── DBA #5 Grado 3° (Período 4)
    // "Reconoce y representa fracciones simples (1/2, 1/3, 1/4) como partes del entero."
    'lesson-331': Lesson(
      id: 'lesson-331', unitId: 'unit-307', orderNum: 1,
      title: 'Partes iguales de un todo',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l331-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Para formar una fracción al partir una torta, ¿cómo deben ser todas las partes?',
            'options': ['De igual tamaño', 'Unas gigantes y otras pequeñas', 'De diferentes sabores', 'Sin cortar'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l331-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si partes una arepa en 2 partes iguales y te comes 1, te comiste ___ de la arepa',
            'options': ['1/2', '1/3', '1/4', '2/2'],
            'correct_answer': '1/2',
          },
        ),
        Exercise(
          id: 'l331-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la fracción 1/4, ¿qué indica el número 4 de abajo (denominador)?',
            'options': [
              'En cuántas partes iguales se dividió la unidad',
              'Cuántas tortas enteras hay',
              'Que sobraron 4 tortas',
              'La hora del día',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l331-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada división de una chocolatina con su fracción unitaria',
            'items': ['1 de 2 partes iguales', '1 de 3 partes iguales', '1 de 4 partes iguales'],
            'targets': ['1/2 (un medio)', '1/3 (un tercio)', '1/4 (un cuarto)'],
            'correct_mapping': {
              '1 de 2 partes iguales': '1/2 (un medio)',
              '1 de 3 partes iguales': '1/3 (un tercio)',
              '1 de 4 partes iguales': '1/4 (un cuarto)',
            },
          },
        ),
        Exercise(
          id: 'l331-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si juntas las 2 mitades de una naranja (1/2 + 1/2), tienes ___ naranja entera',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '1',
          },
        ),
      ],
    ),

    'lesson-332': Lesson(
      id: 'lesson-332', unitId: 'unit-307', orderNum: 2,
      title: 'Medios, tercios y cuartos',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l332-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'La bandera de Colombia tiene 3 franjas: la amarilla ocupa la mitad de la bandera. ¿Qué fracción es la mitad?',
            'options': ['1/4', '1/2', '1/3', '3/4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l332-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un queso campesino se parte en 4 pedazos iguales. Si usamos 3 pedazos, usamos ___ del queso',
            'options': ['1/4', '2/4', '3/4', '4/3'],
            'correct_answer': '3/4',
          },
        ),
        Exercise(
          id: 'l332-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un jardín se dividió en 3 partes iguales: 2 partes tienen rosas y 1 tiene claveles. ¿Qué fracción tiene rosas?',
            'options': ['1/3', '2/3', '3/2', '1/2'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l332-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada lectura con su escritura en fracción',
            'items': ['Dos tercios', 'Tres cuartos', 'Un medio'],
            'targets': ['2/3', '3/4', '1/2'],
            'correct_mapping': {'Dos tercios': '2/3', 'Tres cuartos': '3/4', 'Un medio': '1/2'},
          },
        ),
        Exercise(
          id: 'l332-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Para completar toda una pizza dividida en cuartos (4/4), si ya tienes 3/4 te falta ___',
            'options': ['1/4', '2/4', '1/2', '3/4'],
            'correct_answer': '1/4',
          },
        ),
      ],
    ),

    'lesson-333': Lesson(
      id: 'lesson-333', unitId: 'unit-307', orderNum: 3,
      title: 'Fracción de un grupo',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l333-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'La mitad (1/2) es dividir entre 2',
          content: {
            'question': 'En una canasta hay 10 mangos. ¿Cuántos mangos son la mitad (1/2) de la canasta?',
            'options': ['4 mangos', '5 mangos', '6 mangos', '2 mangos'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l333-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un tercio (1/3) de 9 lápices equivale a (9 ÷ 3) = ___ lápices',
            'options': ['2', '3', '4', '6'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l333-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Sofía tiene 8 monedas y guarda un cuarto (1/4) en su alcancía. ¿Cuántas monedas guardó (8 ÷ 4)?',
            'options': ['1 moneda', '2 monedas', '4 monedas', '6 monedas'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l333-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada fracción de 12 empanadas con su cantidad',
            'items': ['1/2 de 12', '1/3 de 12', '1/4 de 12'],
            'targets': ['6 empanadas', '4 empanadas', '3 empanadas'],
            'correct_mapping': {
              '1/2 de 12': '6 empanadas',
              '1/3 de 12': '4 empanadas',
              '1/4 de 12': '3 empanadas',
            },
          },
        ),
        Exercise(
          id: 'l333-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La mitad (1/2) de 16 estudiantes es ___ estudiantes',
            'options': ['6', '8', '10', '4'],
            'correct_answer': '8',
          },
        ),
      ],
    ),

    'lesson-334': Lesson(
      id: 'lesson-334', unitId: 'unit-307', orderNum: 4,
      title: 'Comparar fracciones simples',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l334-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Entre menos partes cortas la torta, cada pedazo es más grande',
          content: {
            'question': 'Si tienes dos tortas iguales, ¿qué porción es MÁS GRANDE: media torta (1/2) o un cuarto de torta (1/4)?',
            'options': ['1/4 de torta', '1/2 de torta', 'Son iguales', 'Ninguna'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l334-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Entre 1/4 y 3/4 de una chocolatina, es mayor ___',
            'options': ['1/4', '3/4', '0', 'son iguales'],
            'correct_answer': '3/4',
          },
        ),
        Exercise(
          id: 'l334-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál fracción representa una unidad completa (el entero completo)?',
            'options': ['1/3', '2/3', '3/3', '1/4'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l334-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena estas porciones de una misma pizza de la más pequeña a la más grande',
            'items': ['1/4 de pizza', '2/4 de pizza', '4/4 de pizza'],
            'targets': ['1° (más pequeña)', '2° (la mitad)', '3° (pizza completa)'],
            'correct_mapping': {
              '1/4 de pizza': '1° (más pequeña)',
              '2/4 de pizza': '2° (la mitad)',
              '4/4 de pizza': '3° (pizza completa)',
            },
          },
        ),
        Exercise(
          id: 'l334-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2 cuartos (2/4) de un pan ocupan exactamente el mismo espacio que ___ pan',
            'options': ['1/2', '1/3', '1/4', '3/4'],
            'correct_answer': '1/2',
          },
        ),
      ],
    ),

    'lesson-335': Lesson(
      id: 'lesson-335', unitId: 'unit-307', orderNum: 5,
      title: '¡Desafío de fracciones 3°!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l335-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una jarra de jugo de maracuyá alcanza para 4 vasos iguales. Si servimos 1 vaso, ¿qué fracción de la jarra queda todavía?',
            'options': ['1/4', '2/4', '3/4', '4/4'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l335-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cuarto (1/4) de 20 colores equivale a ___ colores',
            'options': ['4', '5', '6', '10'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l335-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una bandeja de 6 pandebonos, 2 tienen bocadillo por dentro. ¿Qué fracción simplificada o directa representa 2 de 6?',
            'options': ['2/6 (o 1/3)', '1/4', '5/6', '6/2'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l335-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada situación con su fracción',
            'items': ['Media hora de una hora', 'Un trimestre (3 meses de 12)', 'Un tercio de 15 naranjas'],
            'targets': ['1/2', '1/4 del año', '5 naranjas'],
            'correct_mapping': {
              'Media hora de una hora': '1/2',
              'Un trimestre (3 meses de 12)': '1/4 del año',
              'Un tercio de 15 naranjas': '5 naranjas',
            },
          },
        ),
        Exercise(
          id: 'l335-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si comes 1/3 de un bocadillo por la mañana y otro 1/3 por la tarde, comiste ___ en total',
            'options': ['1/3', '2/3', '3/3', '2/6'],
            'correct_answer': '2/3',
          },
        ),
        Exercise(
          id: 'l335-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estas fracciones es MAYOR que 1/3?',
            'options': ['1/4', '1/2', '1/6', '0/3'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 308: Gráficas e interpretación ── DBA #8 Grado 3° (Período 4)
    // "Interpreta y construye gráficas de barras con datos propios."
    'lesson-336': Lesson(
      id: 'lesson-336', unitId: 'unit-308', orderNum: 1,
      title: 'Recolectar y clasificar datos',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l336-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una encuesta sobre el plato típico favorito en 3°: Bandeja paisa=12, Ajiaco=9, Sancocho=11. ¿Cuántos niños respondieron la encuesta?',
            'options': ['30', '32', '34', '23'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l336-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El plato con mayor frecuencia en la encuesta (Bandeja paisa=12, Ajiaco=9, Sancocho=11) tuvo ___ votos',
            'options': ['9', '11', '12', '32'],
            'correct_answer': '12',
          },
        ),
        Exercise(
          id: 'l336-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué nombre reciben las opciones que se preguntan en una encuesta (por ejemplo: sabor favorito, deporte, edad)?',
            'options': ['Variables o categorías', 'Restas', 'Triángulos', 'Metros'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l336-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con los votos (Bandeja=12, Sancocho=11, Ajiaco=9), relaciona cada puesto',
            'items': ['Bandeja paisa', 'Sancocho', 'Ajiaco'],
            'targets': ['1° lugar (12)', '2° lugar (11)', '3° lugar (9)'],
            'correct_mapping': {
              'Bandeja paisa': '1° lugar (12)',
              'Sancocho': '2° lugar (11)',
              'Ajiaco': '3° lugar (9)',
            },
          },
        ),
        Exercise(
          id: 'l336-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La diferencia de votos entre Bandeja paisa (12) y Ajiaco (9) es ___',
            'options': ['2', '3', '4', '21'],
            'correct_answer': '3',
          },
        ),
      ],
    ),

    'lesson-337': Lesson(
      id: 'lesson-337', unitId: 'unit-308', orderNum: 2,
      title: 'Escalas en gráficas de barras',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l337-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una gráfica cuya escala va de 10 en 10 (0, 10, 20, 30, 40), si una barra llega exactamente a la mitad entre 20 y 30, ¿qué valor tiene?',
            'options': ['22', '25', '28', '35'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l337-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si cada división de la gráfica vale 4 unidades, una barra de 6 divisiones de alto representa (6 × 4) = ___',
            'options': ['18', '20', '24', '28'],
            'correct_answer': '24',
          },
        ),
        Exercise(
          id: 'l337-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Para graficar cantidades grandes como 100, 200, 300 y 400 visitantes, ¿qué escala conviene usar en el eje vertical?',
            'options': ['De 100 en 100', 'De 1 en 1', 'De 2 en 2', 'Sin números'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l337-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con escala de 10 en 10, relaciona la altura en rayitas con su valor',
            'items': ['3 rayitas', '5 rayitas', '8 rayitas'],
            'targets': ['30', '50', '80'],
            'correct_mapping': {'3 rayitas': '30', '5 rayitas': '50', '8 rayitas': '80'},
          },
        ),
        Exercise(
          id: 'l337-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si una barra llega a 60 y otra llega a 20, la primera barra es ___ veces más alta que la segunda',
            'options': ['2', '3', '4', '40'],
            'correct_answer': '3',
          },
        ),
      ],
    ),

    'lesson-338': Lesson(
      id: 'lesson-338', unitId: 'unit-308', orderNum: 3,
      title: 'Pictogramas con escala',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l338-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Multiplica el número de símbolos por el valor de cada símbolo',
          content: {
            'question': 'En un pictograma de reciclaje, cada ♻️ representa 5 botellas. Si el salón 3A tiene ♻️♻️♻️♻️♻️♻️ (6 símbolos), ¿cuántas botellas recicló?',
            'options': ['11 botellas', '25 botellas', '30 botellas', '35 botellas'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l338-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si cada 📖 vale 4 libros leídos y Sofía tiene 7 dibujos de 📖, leyó (7 × 4) = ___ libros',
            'options': ['21', '24', '28', '32'],
            'correct_answer': '28',
          },
        ),
        Exercise(
          id: 'l338-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si cada ⚽ vale 10 goles y un equipo hizo 45 goles, ¿cuántos balones se dibujan?',
            'options': ['4 balones completos y medio balón', '45 balones', '5 balones', '10 balones'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l338-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Si cada 🌺 = 6 flores, relaciona cada fila con su cantidad real',
            'items': ['🌺🌺', '🌺🌺🌺🌺', '🌺🌺🌺🌺🌺'],
            'targets': ['12 flores', '24 flores', '30 flores'],
            'correct_mapping': {
              '🌺🌺': '12 flores',
              '🌺🌺🌺🌺': '24 flores',
              '🌺🌺🌺🌺🌺': '30 flores',
            },
          },
        ),
        Exercise(
          id: 'l338-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Para representar 40 árboles cuando cada 🌳 vale 8 árboles, debemos dibujar (40 ÷ 8) = ___ árboles',
            'options': ['4', '5', '6', '8'],
            'correct_answer': '5',
          },
        ),
      ],
    ),

    'lesson-339': Lesson(
      id: 'lesson-339', unitId: 'unit-308', orderNum: 4,
      title: 'Comparar totales y diferencias',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l339-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Visitantes al Museo del Oro: Viernes=120, Sábado=250, Domingo=300. ¿Cuántos visitantes hubo en todo el fin de semana (Sábado + Domingo)?',
            'options': ['420', '500', '550', '670'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l339-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Con los mismos datos (Viernes=120, Domingo=300), el domingo entraron ___ personas más que el viernes',
            'options': ['150', '180', '200', '420'],
            'correct_answer': '180',
          },
        ),
        Exercise(
          id: 'l339-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la feria escolar: 3°A vendió \$45.000 y 3°B vendió \$38.000. ¿Cuánto más vendió 3°A que 3°B?',
            'options': ['\$5.000', '\$7.000', '\$8.000', '\$13.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l339-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con los puntos del torneo (Rojo=40, Azul=65, Verde=50), relaciona',
            'items': ['Suma de Rojo y Verde', 'Diferencia entre Azul y Rojo', 'Suma de los 3 equipos'],
            'targets': ['90 puntos', '25 puntos', '155 puntos'],
            'correct_mapping': {
              'Suma de Rojo y Verde': '90 puntos',
              'Diferencia entre Azul y Rojo': '25 puntos',
              'Suma de los 3 equipos': '155 puntos',
            },
          },
        ),
        Exercise(
          id: 'l339-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si la meta era recoger 100 kilos de papel y llevan 35 en 3°A y 45 en 3°B (80 en total), faltan ___ kilos',
            'options': ['15', '20', '25', '30'],
            'correct_answer': '20',
          },
        ),
      ],
    ),

    'lesson-340': Lesson(
      id: 'lesson-340', unitId: 'unit-308', orderNum: 5,
      title: '¡Desafío de gráficas 3°!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l340-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una gráfica de animales avistados en el Amazonas: Delfín rosado=15, Guacamaya=40, Mono tití=25. ¿Cuántos animales se avistaron en total?',
            'options': ['70', '75', '80', '85'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l340-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Se vieron ___ guacamayas (40) más que delfines rosados (15)',
            'options': ['20', '25', '30', '55'],
            'correct_answer': '25',
          },
        ),
        Exercise(
          id: 'l340-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si cada 🎟️ en un pictograma vale 8 entradas y el teatro vendió 72 entradas el sábado, ¿cuántos 🎟️ aparecen ese día?',
            'options': ['7', '8', '9', '10'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l340-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada concepto estadístico con su función',
            'items': ['Tabla de frecuencia', 'Escala del eje vertical', 'Barra más alta'],
            'targets': ['Muestra cuántas veces se repite cada dato', 'Indica de cuánto en cuánto suben los números', 'Representa la categoría ganadora'],
            'correct_mapping': {
              'Tabla de frecuencia': 'Muestra cuántas veces se repite cada dato',
              'Escala del eje vertical': 'Indica de cuánto en cuánto suben los números',
              'Barra más alta': 'Representa la categoría ganadora',
            },
          },
        ),
        Exercise(
          id: 'l340-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si el lunes llovieron 12 mm, el martes 18 mm y el miércoles 20 mm, en los 3 días cayeron ___ mm de lluvia',
            'options': ['40', '48', '50', '52'],
            'correct_answer': '50',
          },
        ),
        Exercise(
          id: 'l340-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la gráfica de frutas, "Mango" tiene el doble de votos que "Papaya". Si Papaya tiene 16 votos, ¿cuántos tiene Mango?',
            'options': ['24 votos', '30 votos', '32 votos', '8 votos'],
            'correct_index': 2,
          },
        ),
      ],
    ),
};
