// Currículo Grado 2° — Números hasta 1.000, Suma y Resta, Tablas ×2 ×3 ×5
// 15 lecciones alineadas con DBA MEN Colombia

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade2Lessons = {
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
};
