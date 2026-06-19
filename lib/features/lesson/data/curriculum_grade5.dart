// Currículo Grado 5° — Enteros, Porcentajes, Razones y Proporciones
// 15 lecciones alineadas con DBA MEN Colombia

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade5Lessons = {

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
