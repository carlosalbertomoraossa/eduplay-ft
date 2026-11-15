// Currículo Grado 5° — 8 unidades (4 períodos académicos, 40 lecciones)
// Alineado con DBA MEN Colombia (Pensamientos NV, EM y AL)

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade5Lessons = {

    // ── UNIDAD 501: Números enteros ── DBA #1 Grado 5°
    // "Opera con números enteros negativos en contextos reales."
    'lesson-501': Lesson(
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

    'lesson-502': Lesson(
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

    'lesson-503': Lesson(
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

    'lesson-504': Lesson(
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

    'lesson-505': Lesson(
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
    'lesson-506': Lesson(
      id: 'lesson-506', unitId: 'unit-502', orderNum: 1,
      title: '¿Qué es un porcentaje?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l506-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '¡"Por ciento" suena a "por cien"! Significa cuántas partes tomas de cada 100 🎯',
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

    'lesson-507': Lesson(
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

    'lesson-508': Lesson(
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

    'lesson-509': Lesson(
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

    'lesson-510': Lesson(
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
    'lesson-511': Lesson(
      id: 'lesson-511', unitId: 'unit-503', orderNum: 1,
      title: '¿Qué es una razón?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l511-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '¡Es como una pareja! 🥭 Pon primero la cantidad de mangos y al lado lo que cuestan',
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

    'lesson-512': Lesson(
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

    'lesson-513': Lesson(
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

    'lesson-514': Lesson(
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

    'lesson-515': Lesson(
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

    // ── UNIDAD 504: Fracciones heterogéneas ── DBA #2 Grado 5° (Período 1)
    // "Realiza operaciones con fracciones heterogéneas (diferente denominador)."
    'lesson-516': Lesson(
      id: 'lesson-516', unitId: 'unit-504', orderNum: 1,
      title: 'Mínimo común múltiplo (MCM)',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l516-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Múltiplos de 2: 2, 4, 6, 8... Múltiplos de 3: 3, 6, 9...',
          content: {
            'question': '¿Cuál es el menor múltiplo común (MCM) entre 2 y 3?',
            'options': ['4', '5', '6', '9'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l516-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El mínimo común múltiplo (MCM) entre 3 y 4 es ___',
            'options': ['7', '8', '12', '16'],
            'correct_answer': '12',
          },
        ),
        Exercise(
          id: 'l516-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Para qué nos sirve hallar el MCM de los denominadores cuando sumamos dos fracciones como 1/2 + 1/3?',
            'options': [
              'Para encontrar un denominador común a las dos fracciones',
              'Para borrar los numeradores',
              'Para restar los denominadores',
              'No sirve en fracciones',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l516-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada pareja de números con su MCM',
            'items': ['MCM de 2 y 4', 'MCM de 2 y 5', 'MCM de 4 y 6'],
            'targets': ['4', '10', '12'],
            'correct_mapping': {
              'MCM de 2 y 4': '4',
              'MCM de 2 y 5': '10',
              'MCM de 4 y 6': '12',
            },
          },
        ),
        Exercise(
          id: 'l516-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Dos fracciones que tienen DIFERENTE denominador se llaman fracciones ___',
            'options': ['heterogéneas', 'homogéneas', 'enteras', 'negativas'],
            'correct_answer': 'heterogéneas',
          },
        ),
      ],
    ),

    'lesson-517': Lesson(
      id: 'lesson-517', unitId: 'unit-504', orderNum: 2,
      title: 'Convertir a común denominador',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l517-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Multiplica numerador y denominador de 1/2 por 2',
          content: {
            'question': 'Para sumar 1/2 + 1/4, primero convertimos 1/2 a cuartos. ¿A cuántos cuartos equivale 1/2?',
            'options': ['1/4', '2/4', '3/4', '4/4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l517-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si expresamos 1/2 y 1/3 con denominador 6, quedan convertidas en 3/6 y ___/6',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l517-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál fracción con denominador 10 es equivalente a 3/5 (multiplicando por 2 arriba y abajo)?',
            'options': ['3/10', '5/10', '6/10', '8/10'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l517-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Convierte cada fracción a doceavos (denominador 12)',
            'items': ['1/2', '1/3', '3/4'],
            'targets': ['6/12', '4/12', '9/12'],
            'correct_mapping': {'1/2': '6/12', '1/3': '4/12', '3/4': '9/12'},
          },
        ),
        Exercise(
          id: 'l517-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Al amplificar 2/3 multiplicando por 3 arriba y abajo, obtenemos ___/9',
            'options': ['4', '5', '6', '8'],
            'correct_answer': '6',
          },
        ),
      ],
    ),

    'lesson-518': Lesson(
      id: 'lesson-518', unitId: 'unit-504', orderNum: 3,
      title: 'Sumar fracciones heterogéneas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l518-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '1/2 = 2/4, así que 2/4 + 1/4 = 3/4',
          content: {
            'question': '¿Cuánto es 1/2 + 1/4?',
            'options': ['2/6', '3/4', '1/6', '2/4'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l518-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Como 1/2 = 3/6 y 1/3 = 2/6, entonces 1/2 + 1/3 = ___',
            'options': ['2/5', '5/6', '4/6', '1/6'],
            'correct_answer': '5/6',
          },
        ),
        Exercise(
          id: 'l518-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Para preparar una torta, María usó 1/3 de taza de azúcar morena y 1/6 de taza de azúcar blanca. ¿Cuánta azúcar usó en total (2/6 + 1/6)?',
            'options': ['3/6 (o 1/2 de taza)', '2/9', '1/9', '4/6'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l518-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma de fracciones heterogéneas con su resultado',
            'items': ['1/2 + 1/4', '1/3 + 1/6', '2/5 + 1/10'],
            'targets': ['3/4', '3/6 (1/2)', '5/10 (1/2)'],
            'correct_mapping': {
              '1/2 + 1/4': '3/4',
              '1/3 + 1/6': '3/6 (1/2)',
              '2/5 + 1/10': '5/10 (1/2)',
            },
          },
        ),
        Exercise(
          id: 'l518-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '1/4 + 3/8 = 2/8 + 3/8 = ___/8',
            'options': ['4', '5', '6', '7'],
            'correct_answer': '5',
          },
        ),
      ],
    ),

    'lesson-519': Lesson(
      id: 'lesson-519', unitId: 'unit-504', orderNum: 4,
      title: 'Restar y multiplicar fracciones',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l519-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '3/4 - 1/2 = 3/4 - 2/4',
          content: {
            'question': '¿Cuánto es 3/4 - 1/2?',
            'options': ['1/4', '2/2', '2/4', '1/2'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l519-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '5/6 - 1/3 = 5/6 - 2/6 = ___/6',
            'options': ['2', '3', '4', '1'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l519-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Para multiplicar dos fracciones (por ejemplo 1/2 × 3/4), multiplicamos numerador por numerador y denominador por denominador. ¿Cuánto da 1/2 × 3/4?',
            'options': ['3/8', '4/6', '3/6', '2/8'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l519-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada operación con su resultado',
            'items': ['1/2 - 1/4', '1/2 - 1/6', '2/3 × 1/5'],
            'targets': ['1/4', '2/6 (1/3)', '2/15'],
            'correct_mapping': {
              '1/2 - 1/4': '1/4',
              '1/2 - 1/6': '2/6 (1/3)',
              '2/3 × 1/5': '2/15',
            },
          },
        ),
        Exercise(
          id: 'l519-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'De 7/8 de litro de leche se gastó 1/2 litro (4/8). Quedan ___/8 de litro',
            'options': ['2', '3', '4', '5'],
            'correct_answer': '3',
          },
        ),
      ],
    ),

    'lesson-520': Lesson(
      id: 'lesson-520', unitId: 'unit-504', orderNum: 5,
      title: '¡Desafío de fracciones heterogéneas!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l520-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una finca del Tolima, 1/2 del terreno tiene arroz y 1/5 tiene maíz. ¿Qué fracción total está sembrada (5/10 + 2/10)?',
            'options': ['2/7', '7/10', '3/10', '6/10'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l520-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2/3 + 1/4 = 8/12 + 3/12 = ___/12',
            'options': ['9', '10', '11', '12'],
            'correct_answer': '11',
          },
        ),
        Exercise(
          id: 'l520-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuánto es 4/5 - 1/2 (8/10 - 5/10)?',
            'options': ['3/10', '3/3', '5/10', '2/10'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l520-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada operación con su resultado exacto',
            'items': ['1/3 + 1/4', '3/4 - 1/3', '1/2 × 1/3'],
            'targets': ['7/12', '5/12', '1/6'],
            'correct_mapping': {
              '1/3 + 1/4': '7/12',
              '3/4 - 1/3': '5/12',
              '1/2 × 1/3': '1/6',
            },
          },
        ),
        Exercise(
          id: 'l520-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si ya pintaste 5/6 de una pared, te falta pintar (6/6 - 5/6) = ___/6',
            'options': ['1', '2', '3', '5'],
            'correct_answer': '1',
          },
        ),
        Exercise(
          id: 'l520-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un ciclista recorrió 1/2 de la etapa en la primera hora y 1/3 en la segunda hora (en total 5/6). ¿Qué fracción de la etapa le falta por recorrer?',
            'options': ['1/6', '1/5', '2/5', '1/3'],
            'correct_index': 0,
          },
        ),
      ],
    ),

    // ── UNIDAD 505: Volumen ── DBA #5 Grado 5° (Período 2)
    // "Calcula el volumen de cuerpos rectangulares."
    'lesson-521': Lesson(
      id: 'lesson-521', unitId: 'unit-505', orderNum: 1,
      title: '¿Qué es el volumen?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l521-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué mide el VOLUMEN de un cuerpo geométrico 3D?',
            'options': [
              'La cantidad de espacio tridimensional que ocupa',
              'Solo el largo de una línea',
              'El color de sus caras',
              'Su temperatura en grados',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l521-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El volumen se mide en unidades cúbicas, como el centímetro cúbico (___)',
            'options': ['cm³', 'cm', 'cm²', 'kg'],
            'correct_answer': 'cm³',
          },
        ),
        Exercise(
          id: 'l521-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si armas una figura con 15 cubitos de 1 cm³ cada uno, ¿cuál es su volumen total?',
            'options': ['5 cm³', '10 cm³', '15 cm³', '30 cm³'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l521-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada unidad con lo que mide',
            'items': ['Centímetro (cm)', 'Centímetro cuadrado (cm²)', 'Centímetro cúbico (cm³)'],
            'targets': ['Longitud / Perímetro (1D)', 'Área / Superficie (2D)', 'Volumen / Espacio (3D)'],
            'correct_mapping': {
              'Centímetro (cm)': 'Longitud / Perímetro (1D)',
              'Centímetro cuadrado (cm²)': 'Área / Superficie (2D)',
              'Centímetro cúbico (cm³)': 'Volumen / Espacio (3D)',
            },
          },
        ),
        Exercise(
          id: 'l521-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una torre tiene 3 pisos y en cada piso hay 4 cubitos de 1 cm³. Su volumen es (3 × 4) = ___ cm³',
            'options': ['7', '10', '12', '16'],
            'correct_answer': '12',
          },
        ),
      ],
    ),

    'lesson-522': Lesson(
      id: 'lesson-522', unitId: 'unit-505', orderNum: 2,
      title: 'Volumen de un cubo',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l522-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Volumen del cubo = lado × lado × lado',
          content: {
            'question': '¿Cuál es el volumen de un cubo cuyas aristas miden 2 cm (2 × 2 × 2)?',
            'options': ['6 cm³', '8 cm³', '4 cm³', '12 cm³'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l522-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cubo de lado 3 cm tiene un volumen de (3 × 3 × 3) = ___ cm³',
            'options': ['9', '18', '27', '30'],
            'correct_answer': '27',
          },
        ),
        Exercise(
          id: 'l522-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un tanque de agua cúbico mide 10 m de largo, 10 m de ancho y 10 m de alto. ¿Cuál es su volumen?',
            'options': ['30 m³', '100 m³', '1.000 m³', '300 m³'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l522-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada cubo con su volumen (lado × lado × lado)',
            'items': ['Cubo de lado 1 cm', 'Cubo de lado 4 cm', 'Cubo de lado 5 cm'],
            'targets': ['1 cm³', '64 cm³', '125 cm³'],
            'correct_mapping': {
              'Cubo de lado 1 cm': '1 cm³',
              'Cubo de lado 4 cm': '64 cm³',
              'Cubo de lado 5 cm': '125 cm³',
            },
          },
        ),
        Exercise(
          id: 'l522-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un cubo tiene volumen de 8 m³, cada uno de sus lados mide ___ m (porque 2×2×2 = 8)',
            'options': ['2', '3', '4', '8'],
            'correct_answer': '2',
          },
        ),
      ],
    ),

    'lesson-523': Lesson(
      id: 'lesson-523', unitId: 'unit-505', orderNum: 3,
      title: 'Volumen de prismas rectangulares',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l523-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Fórmula: Volumen = largo × ancho × altura',
          content: {
            'question': 'Una caja de bocadillos mide 5 cm de largo, 4 cm de ancho y 3 cm de alto. ¿Cuál es su volumen (5 × 4 × 3)?',
            'options': ['12 cm³', '20 cm³', '60 cm³', '45 cm³'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l523-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un contenedor rectangular de 6 m de largo, 2 m de ancho y 3 m de alto tiene un volumen de (6 × 2 × 3) = ___ m³',
            'options': ['11', '18', '36', '24'],
            'correct_answer': '36',
          },
        ),
        Exercise(
          id: 'l523-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si el área de la base de una caja es 15 cm² y su altura es 4 cm, ¿cuál es su volumen (15 × 4)?',
            'options': ['19 cm³', '45 cm³', '60 cm³', '75 cm³'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l523-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona las dimensiones (largo × ancho × alto) con su volumen',
            'items': ['4 cm × 3 cm × 2 cm', '10 cm × 5 cm × 2 cm', '8 cm × 5 cm × 3 cm'],
            'targets': ['24 cm³', '100 cm³', '120 cm³'],
            'correct_mapping': {
              '4 cm × 3 cm × 2 cm': '24 cm³',
              '10 cm × 5 cm × 2 cm': '100 cm³',
              '8 cm × 5 cm × 3 cm': '120 cm³',
            },
          },
        ),
        Exercise(
          id: 'l523-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una piscina rectangular de 10 m de largo, 4 m de ancho y 2 m de profundidad tiene un volumen de ___ m³',
            'options': ['16', '40', '80', '100'],
            'correct_answer': '80',
          },
        ),
      ],
    ),

    'lesson-524': Lesson(
      id: 'lesson-524', unitId: 'unit-505', orderNum: 4,
      title: 'Volumen y capacidad (litros)',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l524-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '1 litro = 1.000 mililitros (1.000 cm³)',
          content: {
            'question': '¿Cuántos centímetros cúbicos (o mililitros) caben exactamente en 1 litro de leche?',
            'options': ['10 cm³', '100 cm³', '1.000 cm³', '10.000 cm³'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l524-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En una botella de 2 litros caben ___ mililitros (ml)',
            'options': ['200', '1.000', '2.000', '500'],
            'correct_answer': '2.000',
          },
        ),
        Exercise(
          id: 'l524-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una caja de jugo personal mide 5 cm × 4 cm × 10 cm. ¿Cuántos cm³ (mililitros) de jugo contiene?',
            'options': ['19 ml', '100 ml', '200 ml', '400 ml'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l524-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada capacidad en litros con su volumen en cm³ (ml)',
            'items': ['Medio litro (0,5 L)', '1 litro', '3 litros'],
            'targets': ['500 cm³', '1.000 cm³', '3.000 cm³'],
            'correct_mapping': {
              'Medio litro (0,5 L)': '500 cm³',
              '1 litro': '1.000 cm³',
              '3 litros': '3.000 cm³',
            },
          },
        ),
        Exercise(
          id: 'l524-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Con una jarra de 1.000 ml (1 litro) podemos llenar exactamente ___ vasos de 250 ml',
            'options': ['2', '3', '4', '5'],
            'correct_answer': '4',
          },
        ),
      ],
    ),

    'lesson-525': Lesson(
      id: 'lesson-525', unitId: 'unit-505', orderNum: 5,
      title: '¡Desafío de volumen!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l525-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un salón de clases mide 8 m de largo, 5 m de ancho y 3 m de alto. ¿Cuál es el volumen de aire dentro del salón?',
            'options': ['16 m³', '40 m³', '120 m³', '240 m³'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l525-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una caja tiene volumen de 60 cm³. Si su largo es 5 cm y su ancho es 4 cm (base = 20 cm²), su altura es (60 ÷ 20) = ___ cm',
            'options': ['2', '3', '4', '5'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l525-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos cubitos de 1 cm³ caben dentro de una caja cúbica de 4 cm de lado?',
            'options': ['12 cubitos', '16 cubitos', '64 cubitos', '48 cubitos'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l525-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada cuerpo con su volumen',
            'items': ['Cubo de lado 3 m', 'Prisma de 5 m × 3 m × 2 m', 'Prisma de 7 m × 2 m × 2 m'],
            'targets': ['27 m³', '30 m³', '28 m³'],
            'correct_mapping': {
              'Cubo de lado 3 m': '27 m³',
              'Prisma de 5 m × 3 m × 2 m': '30 m³',
              'Prisma de 7 m × 2 m × 2 m': '28 m³',
            },
          },
        ),
        Exercise(
          id: 'l525-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si juntamos dos cajas iguales de 45 cm³ cada una, el volumen total es ___ cm³',
            'options': ['80', '90', '100', '45'],
            'correct_answer': '90',
          },
        ),
        Exercise(
          id: 'l525-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un acuario rectangular mide 50 cm de largo, 20 cm de ancho y 30 cm de alto. ¿Cuál es su volumen en cm³ (y cuántos litros son)?',
            'options': [
              '30.000 cm³ (30 litros)',
              '3.000 cm³ (3 litros)',
              '100 cm³ (1 litro)',
              '15.000 cm³ (15 litros)',
            ],
            'correct_index': 0,
          },
        ),
      ],
    ),

    // ── UNIDAD 506: Circunferencia ── DBA #6 Grado 5° (Período 3)
    // "Identifica y traza circunferencias. Reconoce radio, diámetro y longitud de la circunferencia."
    'lesson-526': Lesson(
      id: 'lesson-526', unitId: 'unit-506', orderNum: 1,
      title: 'Centro, radio y diámetro',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l526-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cómo se llama el segmento que va desde el CENTRO de la circunferencia hasta cualquier punto de su borde?',
            'options': ['Radio', 'Diámetro', 'Vértice', 'Lado'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l526-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El segmento que cruza de lado a lado la circunferencia pasando por el centro se llama ___',
            'options': ['diámetro', 'radio', 'arco', 'esquina'],
            'correct_answer': 'diámetro',
          },
        ),
        Exercise(
          id: 'l526-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué diferencia hay entre la circunferencia y el círculo?',
            'options': [
              'La circunferencia es la línea del borde (como un aro) y el círculo incluye todo el interior (como una moneda)',
              'Son triángulos distintos',
              'La circunferencia es cuadrada',
              'No tienen centro',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l526-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada parte con su definición',
            'items': ['Centro', 'Radio', 'Diámetro'],
            'targets': ['Punto a igual distancia de todo el borde', 'Va del centro al borde', 'Une dos puntos del borde pasando por el centro'],
            'correct_mapping': {
              'Centro': 'Punto a igual distancia de todo el borde',
              'Radio': 'Va del centro al borde',
              'Diámetro': 'Une dos puntos del borde pasando por el centro',
            },
          },
        ),
        Exercise(
          id: 'l526-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El instrumento con dos brazos (una punta metálica y un lápiz) para trazar circunferencias perfectas se llama ___',
            'options': ['compás', 'transportador', 'balanza', 'escuadra'],
            'correct_answer': 'compás',
          },
        ),
      ],
    ),

    'lesson-527': Lesson(
      id: 'lesson-527', unitId: 'unit-506', orderNum: 2,
      title: 'Relación entre radio y diámetro',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l527-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'El diámetro mide exactamente 2 radios (D = 2 × r)',
          content: {
            'question': 'Si el radio de una rueda de bicicleta mide 30 cm, ¿cuánto mide su diámetro?',
            'options': ['15 cm', '30 cm', '60 cm', '90 cm'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l527-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una pizza circular tiene un diámetro de 28 cm. Su radio mide la mitad, es decir ___ cm',
            'options': ['12', '14', '16', '56'],
            'correct_answer': '14',
          },
        ),
        Exercise(
          id: 'l527-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si abres tu compás a 5 cm para dibujar una circunferencia, ¿de qué tamaño quedará el diámetro del círculo dibujado?',
            'options': ['5 cm', '10 cm', '15 cm', '25 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l527-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada radio con su diámetro correspondiente',
            'items': ['Radio = 4 cm', 'Radio = 9 cm', 'Radio = 15 cm'],
            'targets': ['Diámetro = 8 cm', 'Diámetro = 18 cm', 'Diámetro = 30 cm'],
            'correct_mapping': {
              'Radio = 4 cm': 'Diámetro = 8 cm',
              'Radio = 9 cm': 'Diámetro = 18 cm',
              'Radio = 15 cm': 'Diámetro = 30 cm',
            },
          },
        ),
        Exercise(
          id: 'l527-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El diámetro siempre es el ___ del radio',
            'options': ['doble', 'triple', 'cuarto', 'mismo'],
            'correct_answer': 'doble',
          },
        ),
      ],
    ),

    'lesson-528': Lesson(
      id: 'lesson-528', unitId: 'unit-506', orderNum: 3,
      title: 'El número Pi (π)',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l528-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'El diámetro cabe un poquito más de 3 veces (3,14) alrededor del borde',
          content: {
            'question': '¿Cuál es el valor aproximado del número Pi (π) que usamos en primaria?',
            'options': ['1,5', '2,0', '3,14', '10,0'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l528-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La longitud de cualquier circunferencia es aproximadamente ___ veces su diámetro',
            'options': ['3 (o 3,14)', '1', '10', '100'],
            'correct_answer': '3 (o 3,14)',
          },
        ),
        Exercise(
          id: 'l528-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si divides la longitud del borde de cualquier círculo entre su diámetro, siempre obtienes…',
            'options': ['El número Pi (π ≈ 3,14)', 'Cero', 'El número 100', 'Un número diferente cada vez'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l528-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Usando π ≈ 3 para estimar rápido (Longitud ≈ 3 × diámetro), relaciona',
            'items': ['Diámetro de 2 m', 'Diámetro de 4 m', 'Diámetro de 10 m'],
            'targets': ['Borde ≈ 6 m', 'Borde ≈ 12 m', 'Borde ≈ 30 m'],
            'correct_mapping': {
              'Diámetro de 2 m': 'Borde ≈ 6 m',
              'Diámetro de 4 m': 'Borde ≈ 12 m',
              'Diámetro de 10 m': 'Borde ≈ 30 m',
            },
          },
        ),
        Exercise(
          id: 'l528-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si el diámetro es 10 cm y usamos π = 3,14, la circunferencia exacta mide (3,14 × 10) = ___ cm',
            'options': ['3,14', '31,4', '314', '13,14'],
            'correct_answer': '31,4',
          },
        ),
      ],
    ),

    'lesson-529': Lesson(
      id: 'lesson-529', unitId: 'unit-506', orderNum: 4,
      title: 'Longitud de la circunferencia',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l529-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '¡Multiplica lo que mide el diámetro de lado a lado por 3,14 para dar toda la vuelta! 🎡',
          content: {
            'question': 'Una glorieta circular tiene 20 m de diámetro. Usando π = 3,14, ¿cuánto mide su borde (3,14 × 20)?',
            'options': ['31,4 m', '62,8 m', '94,2 m', '40 m'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l529-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un círculo tiene radio de 5 cm, su diámetro es 10 cm y su circunferencia (10 × 3,14) mide ___ cm',
            'options': ['15,7', '31,4', '50', '62,8'],
            'correct_answer': '31,4',
          },
        ),
        Exercise(
          id: 'l529-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Usando la aproximación π ≈ 3, ¿cuánta cinta se necesita para bordear un tambor circular de 30 cm de diámetro (3 × 30)?',
            'options': ['60 cm', '90 cm', '120 cm', '33 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l529-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con π = 3,14, relaciona cada diámetro con la longitud de su circunferencia',
            'items': ['Diámetro = 1 m', 'Diámetro = 2 m', 'Diámetro = 100 m'],
            'targets': ['3,14 m', '6,28 m', '314 m'],
            'correct_mapping': {
              'Diámetro = 1 m': '3,14 m',
              'Diámetro = 2 m': '6,28 m',
              'Diámetro = 100 m': '314 m',
            },
          },
        ),
        Exercise(
          id: 'l529-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El círculo central de una cancha de fútbol tiene radio de 9 m, por lo que su diámetro mide ___ m',
            'options': ['9', '18', '27', '36'],
            'correct_answer': '18',
          },
        ),
      ],
    ),

    'lesson-530': Lesson(
      id: 'lesson-530', unitId: 'unit-506', orderNum: 5,
      title: '¡Desafío circular!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l530-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una rueda de la fortuna tiene un radio de 15 metros. ¿Cuál es su altura desde el punto más bajo al más alto de la rueda (su diámetro)?',
            'options': ['15 m', '25 m', '30 m', '45 m'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l530-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si la circunferencia de un aro mide 30 cm (usando π ≈ 3), su diámetro mide (30 ÷ 3) = ___ cm',
            'options': ['5', '10', '15', '20'],
            'correct_answer': '10',
          },
        ),
        Exercise(
          id: 'l530-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si el diámetro de un plato típico de Ráquira es 24 cm, ¿cuánto mide su radio?',
            'options': ['8 cm', '12 cm', '14 cm', '48 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l530-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada fórmula o relación de la circunferencia',
            'items': ['Diámetro (D)', 'Radio (r)', 'Longitud de la circunferencia (C)'],
            'targets': ['2 × r', 'D ÷ 2', 'π × D'],
            'correct_mapping': {
              'Diámetro (D)': '2 × r',
              'Radio (r)': 'D ÷ 2',
              'Longitud de la circunferencia (C)': 'π × D',
            },
          },
        ),
        Exercise(
          id: 'l530-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un mantel circular tiene radio de 50 cm, es decir un diámetro de 100 cm (___ metro)',
            'options': ['1', '2', '5', '10'],
            'correct_answer': '1',
          },
        ),
        Exercise(
          id: 'l530-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una llanta de bicicleta tiene 50 cm de diámetro. Usando π = 3,14, ¿cuántos centímetros avanza en 1 vuelta completa (50 × 3,14)?',
            'options': ['100 cm', '157 cm', '314 cm', '200 cm'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 507: Estadística (Moda, mediana y promedio) ── DBA #7 Grado 5° (Período 4)
    // "Lee e interpreta tablas estadísticas. Calcula moda, mediana y promedio."
    'lesson-531': Lesson(
      id: 'lesson-531', unitId: 'unit-507', orderNum: 1,
      title: 'La moda (el dato más frecuente)',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l531-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'La moda es el valor que más se repite',
          content: {
            'question': 'Las edades de un grupo de niños son: 10, 11, 10, 9, 10, 11. ¿Cuál es la MODA de las edades?',
            'options': ['9 años', '10 años', '11 años', '12 años'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l531-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la lista de goles por partido: 2, 1, 3, 2, 0, 2, 4, la moda es ___ goles',
            'options': ['1', '2', '3', '4'],
            'correct_answer': '2',
          },
        ),
        Exercise(
          id: 'l531-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una tienda de calzado en Bucaramanga se vendieron tallas: 34, 35, 35, 36, 35, 37. ¿Qué talla es la moda?',
            'options': ['Talla 34', 'Talla 35', 'Talla 36', 'Talla 37'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l531-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada grupo de datos con su moda',
            'items': ['5, 8, 5, 3, 5', '12, 15, 15, 10, 15', '7, 9, 9, 4, 9'],
            'targets': ['Moda = 5', 'Moda = 15', 'Moda = 9'],
            'correct_mapping': {
              '5, 8, 5, 3, 5': 'Moda = 5',
              '12, 15, 15, 10, 15': 'Moda = 15',
              '7, 9, 9, 4, 9': 'Moda = 9',
            },
          },
        ),
        Exercise(
          id: 'l531-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En un diagrama de barras, la moda siempre corresponde a la barra más ___',
            'options': ['alta', 'baja', 'angosta', 'oscura'],
            'correct_answer': 'alta',
          },
        ),
      ],
    ),

    'lesson-532': Lesson(
      id: 'lesson-532', unitId: 'unit-507', orderNum: 2,
      title: 'La mediana (el dato central)',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l532-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Primero ordena los datos de menor a mayor y busca el del centro',
          content: {
            'question': 'En los datos ya ordenados: 3, 5, 8, 10, 12, ¿cuál es la MEDIANA (el valor justo en el centro)?',
            'options': ['5', '8', '10', '3'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l532-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si ordenamos las notas 4, 2, 5, 3, 1 → quedan 1, 2, 3, 4, 5. La mediana es ___',
            'options': ['2', '3', '4', '5'],
            'correct_answer': '3',
          },
        ),
        Exercise(
          id: 'l532-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Las temperaturas en 5 días en Bogotá fueron: 14°C, 18°C, 15°C, 20°C, 16°C. Al ordenarlas (14, 15, 16, 18, 20), ¿cuál es la mediana?',
            'options': ['15°C', '16°C', '18°C', '20°C'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l532-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada lista ordenada con su mediana (dato central)',
            'items': ['10, 20, 30, 40, 50', '2, 4, 7, 9, 11', '100, 150, 200'],
            'targets': ['30', '7', '150'],
            'correct_mapping': {
              '10, 20, 30, 40, 50': '30',
              '2, 4, 7, 9, 11': '7',
              '100, 150, 200': '150',
            },
          },
        ),
        Exercise(
          id: 'l532-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Para hallar la mediana, el primer paso obligatorio es ___ los datos de menor a mayor',
            'options': ['ordenar', 'multiplicar', 'borrar', 'restar'],
            'correct_answer': 'ordenar',
          },
        ),
      ],
    ),

    'lesson-533': Lesson(
      id: 'lesson-533', unitId: 'unit-507', orderNum: 3,
      title: 'El promedio o media aritmética',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l533-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Suma todos los datos y divide entre la cantidad de datos',
          content: {
            'question': 'Sofía sacó 4, 5 y 3 en tres tareas de matemáticas. ¿Cuál es su promedio ((4 + 5 + 3) ÷ 3)?',
            'options': ['3', '4', '5', '12'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l533-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'El promedio de 10, 20 y 30 es (60 ÷ 3) = ___',
            'options': ['15', '20', '25', '30'],
            'correct_answer': '20',
          },
        ),
        Exercise(
          id: 'l533-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En 4 partidos un equipo anotó 2, 4, 1 y 5 goles (suma = 12 goles). ¿Cuál fue el promedio de goles por partido (12 ÷ 4)?',
            'options': ['2 goles', '3 goles', '4 goles', '6 goles'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l533-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada grupo de números con su promedio (media)',
            'items': ['6 y 10 (suma 16 ÷ 2)', '5, 10 y 15 (suma 30 ÷ 3)', '10, 10, 10 y 18 (suma 48 ÷ 4)'],
            'targets': ['Promedio = 8', 'Promedio = 10', 'Promedio = 12'],
            'correct_mapping': {
              '6 y 10 (suma 16 ÷ 2)': 'Promedio = 8',
              '5, 10 y 15 (suma 30 ÷ 3)': 'Promedio = 10',
              '10, 10, 10 y 18 (suma 48 ÷ 4)': 'Promedio = 12',
            },
          },
        ),
        Exercise(
          id: 'l533-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Al promedio también se le conoce en estadística como ___ aritmética',
            'options': ['media', 'moda', 'mediana', 'escala'],
            'correct_answer': 'media',
          },
        ),
      ],
    ),

    'lesson-534': Lesson(
      id: 'lesson-534', unitId: 'unit-507', orderNum: 4,
      title: 'Análisis de tablas estadísticas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l534-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Ahorro diario de Mateo de lunes a viernes: \$1.000, \$2.000, \$2.000, \$3.000, \$2.000. ¿Cuánto es el promedio diario (10.000 ÷ 5)?',
            'options': ['\$1.500', '\$2.000', '\$2.500', '\$3.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l534-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En los datos: 4, 6, 6, 8, 11, el número que más se repite (la moda) es ___',
            'options': ['4', '6', '8', '11'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l534-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'La diferencia entre el dato mayor y el dato menor de una lista se llama RANGO. En las edades 7, 9, 10, 12, ¿cuál es el rango (12 - 7)?',
            'options': ['3', '5', '7', '19'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l534-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Para la lista ordenada: 2, 5, 5, 6, 12 (suma = 30), relaciona cada medida',
            'items': ['Moda (más repetido)', 'Mediana (dato del centro)', 'Promedio (30 ÷ 5)'],
            'targets': ['5', '5 (posición 3)', '6'],
            'correct_mapping': {
              'Moda (más repetido)': '5',
              'Mediana (dato del centro)': '5 (posición 3)',
              'Promedio (30 ÷ 5)': '6',
            },
          },
        ),
        Exercise(
          id: 'l534-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En los precios \$2.000, \$3.500 y \$5.000, el rango (mayor menos menor) es \$___',
            'options': ['1.500', '2.500', '3.000', '7.000'],
            'correct_answer': '3.000',
          },
        ),
      ],
    ),

    'lesson-535': Lesson(
      id: 'lesson-535', unitId: 'unit-507', orderNum: 5,
      title: '¡Desafío estadístico 5°!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l535-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En 5 pruebas de atletismo Valentina tardó: 12 s, 15 s, 14 s, 15 s y 14 s (suma = 70 s). ¿Cuál fue su tiempo promedio (70 ÷ 5)?',
            'options': ['13 s', '14 s', '15 s', '16 s'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l535-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si el promedio de 3 números es 10, la suma de esos 3 números es (10 × 3) = ___',
            'options': ['13', '20', '30', '40'],
            'correct_answer': '30',
          },
        ),
        Exercise(
          id: 'l535-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En los datos ordenados: 10, 12, 15, 20, 20, 20, 25 (7 datos), ¿cuál es la mediana (el 4° dato)?',
            'options': ['12', '15', '20', '25'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l535-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada concepto estadístico con cómo se halla',
            'items': ['Moda', 'Mediana', 'Media o Promedio'],
            'targets': ['Buscar el dato con mayor frecuencia', 'Ordenar y elegir el dato central', 'Sumar todos los datos y dividir por el total'],
            'correct_mapping': {
              'Moda': 'Buscar el dato con mayor frecuencia',
              'Mediana': 'Ordenar y elegir el dato central',
              'Media o Promedio': 'Sumar todos los datos y dividir por el total',
            },
          },
        ),
        Exercise(
          id: 'l535-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En una cosecha de café se recogieron 40 kg el lunes, 50 kg el martes y 60 kg el miércoles. El promedio diario fue ___ kg',
            'options': ['45', '50', '55', '150'],
            'correct_answer': '50',
          },
        ),
        Exercise(
          id: 'l535-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Juan necesita un promedio de 4,0 en 3 exámenes. Si en los dos primeros sacó 3,0 y 4,0 (suman 7,0), ¿cuánto debe sacar en el tercero para que los tres sumen 12,0?',
            'options': ['4,0', '4,5', '5,0', '3,5'],
            'correct_index': 2,
          },
        ),
      ],
    ),

    // ── UNIDAD 508: Álgebra inicial ── DBA #8 Grado 5° (Período 4)
    // "Comprende variables y expresiones algebraicas sencillas (n + 3 = 10)."
    'lesson-536': Lesson(
      id: 'lesson-536', unitId: 'unit-508', orderNum: 1,
      title: '¿Qué es una variable o incógnita?',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l536-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Usamos una letra como x o n para representar un número desconocido',
          content: {
            'question': 'En la igualdad n + 4 = 10, ¿qué representa la letra "n"?',
            'options': [
              'Un número desconocido (incógnita) que vale 6',
              'Una palabra sin valor numérico',
              'El número cero siempre',
              'Una figura geométrica',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l536-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si x + 5 = 12, entonces x vale ___',
            'options': ['5', '6', '7', '17'],
            'correct_answer': '7',
          },
        ),
        Exercise(
          id: 'l536-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si sabemos que a = 8, ¿cuánto vale la expresión a + 10?',
            'options': ['2', '18', '80', '10'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l536-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Si n = 5, relaciona cada expresión con su valor numérico',
            'items': ['n + 3', 'n - 2', '2 × n'],
            'targets': ['8', '3', '10'],
            'correct_mapping': {'n + 3': '8', 'n - 2': '3', '2 × n': '10'},
          },
        ),
        Exercise(
          id: 'l536-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En álgebra, cuando escribimos "3x" junto, significa 3 ___ por x',
            'options': ['multiplicado', 'sumado', 'restado', 'dividido'],
            'correct_answer': 'multiplicado',
          },
        ),
      ],
    ),

    'lesson-537': Lesson(
      id: 'lesson-537', unitId: 'unit-508', orderNum: 2,
      title: 'Expresiones en lenguaje algebraico',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l537-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si "x" es la edad de Sofía hoy, ¿cómo se escribe "la edad de Sofía dentro de 5 años"?',
            'options': ['x + 5', 'x - 5', '5 ÷ x', '5'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l537-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '"El doble de un número n" se escribe algebraicamente como ___',
            'options': ['2n', 'n + 2', 'n - 2', 'n ÷ 2'],
            'correct_answer': '2n',
          },
        ),
        Exercise(
          id: 'l537-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una empanada cuesta "p" pesos. ¿Qué expresión representa el precio de 4 empanadas?',
            'options': ['4p (4 × p)', 'p + 4', 'p - 4', '4 ÷ p'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l537-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada frase con su expresión algebraica',
            'items': ['Un número aumentado en 8', 'Un número disminuido en 3', 'El triple de un número'],
            'targets': ['x + 8', 'x - 3', '3x'],
            'correct_mapping': {
              'Un número aumentado en 8': 'x + 8',
              'Un número disminuido en 3': 'x - 3',
              'El triple de un número': '3x',
            },
          },
        ),
        Exercise(
          id: 'l537-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si x = 4, el valor de la expresión (3x + 2) es (3 × 4 + 2) = ___',
            'options': ['9', '12', '14', '18'],
            'correct_answer': '14',
          },
        ),
      ],
    ),

    'lesson-538': Lesson(
      id: 'lesson-538', unitId: 'unit-508', orderNum: 3,
      title: 'Ecuaciones de suma y resta',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l538-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Una ecuación es como una balanza en equilibrio: para despejar x usamos la operación inversa',
          content: {
            'question': '¿Cuál es el valor de x en la ecuación x + 15 = 40?',
            'options': ['20', '25', '35', '55'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l538-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la ecuación y - 9 = 11, el valor de y es (11 + 9) = ___',
            'options': ['2', '18', '20', '22'],
            'correct_answer': '20',
          },
        ),
        Exercise(
          id: 'l538-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Mateo tenía cierta cantidad de monedas "m", ganó 12 más y ahora tiene 30 (m + 12 = 30). ¿Cuántas monedas tenía al principio?',
            'options': ['16', '18', '20', '42'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l538-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Resuelve cada ecuación para encontrar el valor de la incógnita',
            'items': ['x + 8 = 20', 'x - 6 = 10', '25 - x = 15'],
            'targets': ['x = 12', 'x = 16', 'x = 10'],
            'correct_mapping': {
              'x + 8 = 20': 'x = 12',
              'x - 6 = 10': 'x = 16',
              '25 - x = 15': 'x = 10',
            },
          },
        ),
        Exercise(
          id: 'l538-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si n + 120 = 500, entonces n = ___',
            'options': ['320', '380', '420', '620'],
            'correct_answer': '380',
          },
        ),
      ],
    ),

    'lesson-539': Lesson(
      id: 'lesson-539', unitId: 'unit-508', orderNum: 4,
      title: 'Ecuaciones de multiplicación',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l539-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Si 3 multiplicado por x da 15, dividimos 15 entre 3',
          content: {
            'question': 'En la ecuación 3x = 15, ¿cuánto vale x?',
            'options': ['3', '5', '12', '45'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l539-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 4n = 36, entonces n = (36 ÷ 4) = ___',
            'options': ['7', '8', '9', '10'],
            'correct_answer': '9',
          },
        ),
        Exercise(
          id: 'l539-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '5 cuadernos iguales cuestan \$20.000 (5c = 20.000). ¿Cuánto cuesta cada cuaderno "c"?',
            'options': ['\$3.000', '\$4.000', '\$5.000', '\$15.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l539-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada ecuación con el valor de su variable',
            'items': ['2x = 14', '5x = 40', '6x = 54'],
            'targets': ['x = 7', 'x = 8', 'x = 9'],
            'correct_mapping': {
              '2x = 14': 'x = 7',
              '5x = 40': 'x = 8',
              '6x = 54': 'x = 9',
            },
          },
        ),
        Exercise(
          id: 'l539-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la ecuación 2x + 1 = 11, como 2x = 10, entonces x vale ___',
            'options': ['4', '5', '6', '10'],
            'correct_answer': '5',
          },
        ),
      ],
    ),

    'lesson-540': Lesson(
      id: 'lesson-540', unitId: 'unit-508', orderNum: 5,
      title: '¡Desafío algebraico!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.hard,
      exercises: [
        Exercise(
          id: 'l540-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'El perímetro de un cuadrado de lado "L" es 4L. Si 4L = 48 cm, ¿cuánto mide el lado L?',
            'options': ['10 cm', '12 cm', '14 cm', '16 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l540-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la ecuación 3x + 4 = 19, primero restamos 4 (3x = 15) y luego dividimos entre 3: x = ___',
            'options': ['4', '5', '6', '7'],
            'correct_answer': '5',
          },
        ),
        Exercise(
          id: 'l540-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si el doble de la edad de Camila más 3 años es igual a 21 años (2c + 3 = 21), ¿cuántos años tiene Camila?',
            'options': ['8 años', '9 años', '10 años', '12 años'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l540-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada ecuación con su solución correcta',
            'items': ['x + 25 = 60', '7x = 63', '2x - 4 = 16'],
            'targets': ['x = 35', 'x = 9', 'x = 10'],
            'correct_mapping': {
              'x + 25 = 60': 'x = 35',
              '7x = 63': 'x = 9',
              '2x - 4 = 16': 'x = 10',
            },
          },
        ),
        Exercise(
          id: 'l540-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si a = 6 y b = 4, el valor de (2a + 3b) es (12 + 12) = ___',
            'options': ['20', '22', '24', '26'],
            'correct_answer': '24',
          },
        ),
        Exercise(
          id: 'l540-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué ecuación representa el problema: "Pensé un número x, lo multipliqué por 5 y obtuve 45"?',
            'options': ['5x = 45', 'x + 5 = 45', 'x - 5 = 45', '45x = 5'],
            'correct_index': 0,
          },
        ),
      ],
    ),
};
