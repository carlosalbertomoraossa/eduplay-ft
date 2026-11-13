// Currículo Grado 2° — 7 unidades (4 períodos académicos, 35 lecciones)
// Alineado con DBA MEN Colombia (Pensamientos NV, EM y AL)

import '../domain/entities/lesson.dart';

const Map<String, Lesson> grade2Lessons = {
    // ── UNIDAD 201: Números hasta 1.000 ── DBA #1 Grado 2°
    // "Lee, escribe y ordena números hasta 1.000. Reconoce el valor posicional."
    'lesson-201': Lesson(
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

    'lesson-202': Lesson(
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

    'lesson-203': Lesson(
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

    'lesson-204': Lesson(
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

    'lesson-205': Lesson(
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
    'lesson-206': Lesson(
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

    'lesson-207': Lesson(
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

    'lesson-208': Lesson(
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

    'lesson-209': Lesson(
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

    'lesson-210': Lesson(
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
    'lesson-211': Lesson(
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

    'lesson-212': Lesson(
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

    'lesson-213': Lesson(
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

    'lesson-214': Lesson(
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

    'lesson-215': Lesson(
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

    // ── UNIDAD 204: Medición con regla ── DBA #5 Grado 2° (Período 1)
    // "Mide longitudes con regla usando centímetros y metros."
    'lesson-216': Lesson(
      id: 'lesson-216', unitId: 'unit-204', orderNum: 1,
      title: 'El centímetro y la regla',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l216-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Siempre empezamos a medir desde el número 0 de la regla',
          content: {
            'question': 'Cuando mides un lápiz con una regla, ¿en qué número debes colocar la punta inicial del lápiz?',
            'options': ['En el 1', 'En el 0', 'En el 10', 'En la mitad'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l216-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La abreviatura de centímetro es ___',
            'options': ['cm', 'kg', 'lt', 'hr'],
            'correct_answer': 'cm',
          },
        ),
        Exercise(
          id: 'l216-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si un borrador empieza en el 0 de la regla y termina en el 5, ¿cuánto mide?',
            'options': ['4 cm', '5 cm', '6 cm', '50 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l216-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada objeto escolar con su medida aproximada en centímetros',
            'items': ['Borrador pequeño', 'Lápiz nuevo', 'Regla escolar'],
            'targets': ['4 cm', '15 cm', '30 cm'],
            'correct_mapping': {
              'Borrador pequeño': '4 cm',
              'Lápiz nuevo': '15 cm',
              'Regla escolar': '30 cm',
            },
          },
        ),
        Exercise(
          id: 'l216-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si un crayón va del número 2 al número 9 en la regla, mide ___ cm',
            'options': ['7', '9', '11', '6'],
            'correct_answer': '7',
          },
        ),
      ],
    ),

    'lesson-217': Lesson(
      id: 'lesson-217', unitId: 'unit-204', orderNum: 2,
      title: 'El metro y los centímetros',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l217-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: '"Centi" significa cien',
          content: {
            'question': '¿Cuántos centímetros hay en 1 metro completo?',
            'options': ['10 cm', '50 cm', '100 cm', '1.000 cm'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l217-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': '2 metros son iguales a ___ centímetros',
            'options': ['20', '100', '200', '500'],
            'correct_answer': '200',
          },
        ),
        Exercise(
          id: 'l217-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué unidad es mejor para medir el largo del salón de clases?',
            'options': ['El metro (m)', 'El milímetro', 'Una moneda', 'Un grano de café'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l217-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada equivalencia entre metros y centímetros',
            'items': ['1 metro', '3 metros', 'Medio metro'],
            'targets': ['100 cm', '300 cm', '50 cm'],
            'correct_mapping': {
              '1 metro': '100 cm',
              '3 metros': '300 cm',
              'Medio metro': '50 cm',
            },
          },
        ),
        Exercise(
          id: 'l217-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Sofía mide 1 metro y 25 centímetros, es decir ___ cm en total',
            'options': ['105', '125', '250', '152'],
            'correct_answer': '125',
          },
        ),
      ],
    ),

    'lesson-218': Lesson(
      id: 'lesson-218', unitId: 'unit-204', orderNum: 3,
      title: 'Comparar y sumar longitudes',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l218-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una cinta amarilla mide 45 cm y una cinta azul mide 30 cm. ¿Cuánto miden las dos juntas?',
            'options': ['65 cm', '75 cm', '85 cm', '15 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l218-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cuaderno mide 28 cm de alto y una libreta mide 18 cm. El cuaderno mide ___ cm más',
            'options': ['8', '10', '12', '46'],
            'correct_answer': '10',
          },
        ),
        Exercise(
          id: 'l218-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál medida es MAYOR: 1 metro o 85 centímetros?',
            'options': ['85 centímetros', '1 metro (100 cm)', 'Son iguales', 'No se puede comparar'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l218-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Ordena estas medidas de la más corta a la más larga',
            'items': ['25 cm', '90 cm', '2 metros (200 cm)'],
            'targets': ['1° (más corta)', '2° (mediana)', '3° (más larga)'],
            'correct_mapping': {
              '25 cm': '1° (más corta)',
              '90 cm': '2° (mediana)',
              '2 metros (200 cm)': '3° (más larga)',
            },
          },
        ),
        Exercise(
          id: 'l218-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si tienes una cuerda de 100 cm y cortas un pedazo de 40 cm, quedan ___ cm',
            'options': ['50', '60', '70', '140'],
            'correct_answer': '60',
          },
        ),
      ],
    ),

    'lesson-219': Lesson(
      id: 'lesson-219', unitId: 'unit-204', orderNum: 4,
      title: 'Perímetro simple con regla',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l219-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Suma todos los lados del contorno',
          content: {
            'question': 'Un triángulo tiene 3 lados que miden 5 cm cada uno. ¿Cuánto mide todo su borde (perímetro)?',
            'options': ['10 cm', '15 cm', '20 cm', '8 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l219-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cuadrado donde cada uno de sus 4 lados mide 10 cm tiene un contorno total de ___ cm',
            'options': ['20', '30', '40', '50'],
            'correct_answer': '40',
          },
        ),
        Exercise(
          id: 'l219-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un portarretratos rectangular mide 20 cm de largo y 10 cm de ancho. ¿Cuánto suman sus 4 lados (20+10+20+10)?',
            'options': ['30 cm', '50 cm', '60 cm', '40 cm'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l219-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada figura con la suma de todos sus lados',
            'items': ['Cuadrado de lado 3 cm', 'Triángulo de lados 4, 4 y 4 cm', 'Cuadrado de lado 5 cm'],
            'targets': ['12 cm', '12 cm (3 lados de 4)', '20 cm'],
            'correct_mapping': {
              'Cuadrado de lado 3 cm': '12 cm',
              'Triángulo de lados 4, 4 y 4 cm': '12 cm (3 lados de 4)',
              'Cuadrado de lado 5 cm': '20 cm',
            },
          },
        ),
        Exercise(
          id: 'l219-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La suma de los lados de un triángulo de 6 cm, 8 cm y 10 cm es ___ cm',
            'options': ['20', '22', '24', '18'],
            'correct_answer': '24',
          },
        ),
      ],
    ),

    'lesson-220': Lesson(
      id: 'lesson-220', unitId: 'unit-204', orderNum: 5,
      title: '¡Desafío de medición!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l220-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos centímetros le faltan a una tabla de 70 cm para medir 1 metro (100 cm)?',
            'options': ['20 cm', '30 cm', '40 cm', '170 cm'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l220-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si pones dos reglas de 30 cm una tras otra en fila, alcanzan ___ cm',
            'options': ['30', '50', '60', '90'],
            'correct_answer': '60',
          },
        ),
        Exercise(
          id: 'l220-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una caña de azúcar mide 150 cm. ¿A cuánto equivale eso en metros y centímetros?',
            'options': ['1 metro y 5 cm', '1 metro y 50 cm', '15 metros', '50 centímetros'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l220-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada suma de longitudes con su resultado',
            'items': ['45 cm + 55 cm', '20 cm + 35 cm', '80 cm - 25 cm'],
            'targets': ['100 cm (1 metro)', '55 cm', '55 cm restantes'],
            'correct_mapping': {
              '45 cm + 55 cm': '100 cm (1 metro)',
              '20 cm + 35 cm': '55 cm',
              '80 cm - 25 cm': '55 cm restantes',
            },
          },
        ),
        Exercise(
          id: 'l220-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un mantel cuadrado tiene 4 lados de 20 cm cada uno. Su borde completo mide ___ cm',
            'options': ['40', '60', '80', '100'],
            'correct_answer': '80',
          },
        ),
        Exercise(
          id: 'l220-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un marcador empieza en el 3 cm de la regla y termina en el 15 cm. ¿Cuánto mide el marcador?',
            'options': ['12 cm', '15 cm', '18 cm', '11 cm'],
            'correct_index': 0,
          },
        ),
      ],
    ),

    // ── UNIDAD 205: Cuerpos geométricos ── DBA #4 Grado 2° (Período 2)
    // "Reconoce y describe cuerpos geométricos (cubo, esfera, cilindro, cono)."
    'lesson-221': Lesson(
      id: 'lesson-221', unitId: 'unit-205', orderNum: 1,
      title: 'El cubo y el prisma',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l221-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué cuerpo geométrico 3D tiene la forma de un dado para jugar parqués?',
            'options': ['Esfera', 'Cubo', 'Cono', 'Cilindro'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l221-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un dado tiene números del 1 al 6 porque un cubo tiene ___ caras cuadradas',
            'options': ['4', '6', '8', '12'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l221-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Una caja de zapatos o un ladrillo tienen caras rectangulares. Ese cuerpo se llama…',
            'options': ['Prisma rectangular', 'Esfera', 'Cono', 'Círculo'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l221-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada objeto con el cuerpo geométrico al que se parece',
            'items': ['Dado de parqués', 'Caja de leche o zapatos', 'Balón de fútbol'],
            'targets': ['Cubo', 'Prisma rectangular', 'Esfera'],
            'correct_mapping': {
              'Dado de parqués': 'Cubo',
              'Caja de leche o zapatos': 'Prisma rectangular',
              'Balón de fútbol': 'Esfera',
            },
          },
        ),
        Exercise(
          id: 'l221-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Todas las 6 caras de un cubo tienen forma de ___',
            'options': ['cuadrado', 'triángulo', 'círculo', 'cono'],
            'correct_answer': 'cuadrado',
          },
        ),
      ],
    ),

    'lesson-222': Lesson(
      id: 'lesson-222', unitId: 'unit-205', orderNum: 2,
      title: 'Esfera, cilindro y cono',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l222-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué cuerpo geométrico tiene forma de cucurucho de helado o gorro de fiesta?',
            'options': ['Cubo', 'Cilindro', 'Cono', 'Prisma'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l222-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un tarro de galletas redondo y una lata tienen forma de ___',
            'options': ['cilindro', 'cubo', 'esfera', 'pirámide'],
            'correct_answer': 'cilindro',
          },
        ),
        Exercise(
          id: 'l222-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál de estos cuerpos puede RODAR fácilmente en cualquier dirección y no tiene caras planas?',
            'options': ['El cubo', 'La esfera', 'El ladrillo', 'La pirámide'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l222-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada cuerpo redondo con sus bases planas',
            'items': ['Esfera', 'Cono', 'Cilindro'],
            'targets': ['0 bases planas', '1 base circular', '2 bases circulares'],
            'correct_mapping': {
              'Esfera': '0 bases planas',
              'Cono': '1 base circular',
              'Cilindro': '2 bases circulares',
            },
          },
        ),
        Exercise(
          id: 'l222-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una naranja redonda y una canica tienen forma de ___',
            'options': ['esfera', 'cubo', 'cono', 'cilindro'],
            'correct_answer': 'esfera',
          },
        ),
      ],
    ),

    'lesson-223': Lesson(
      id: 'lesson-223', unitId: 'unit-205', orderNum: 3,
      title: 'Caras, vértices y aristas',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l223-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          hint: 'Cuenta las 4 esquinas de arriba y las 4 esquinas de abajo',
          content: {
            'question': '¿Cuántos vértices (esquinas) tiene un cubo en total?',
            'options': ['4', '6', '8', '12'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l223-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Las superficies planas de un cuerpo geométrico se llaman ___',
            'options': ['caras', 'puntas', 'ruedas', 'curvas'],
            'correct_answer': 'caras',
          },
        ),
        Exercise(
          id: 'l223-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Las líneas donde se unen dos caras de una caja se llaman aristas. ¿Cuántas aristas tiene un cubo?',
            'options': ['6', '8', '12', '10'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l223-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada elemento de un cubo con su cantidad',
            'items': ['Caras cuadradas', 'Vértices (esquinas)', 'Aristas (bordes)'],
            'targets': ['6', '8', '12'],
            'correct_mapping': {
              'Caras cuadradas': '6',
              'Vértices (esquinas)': '8',
              'Aristas (bordes)': '12',
            },
          },
        ),
        Exercise(
          id: 'l223-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un cono tiene ___ punta o cúspide arriba',
            'options': ['1', '2', '4', '0'],
            'correct_answer': '1',
          },
        ),
      ],
    ),

    'lesson-224': Lesson(
      id: 'lesson-224', unitId: 'unit-205', orderNum: 4,
      title: 'Objetos 3D en nuestro entorno',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l224-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si apoyas la base de un cilindro sobre arena húmeda, ¿qué huella plana deja?',
            'options': ['Un cuadrado', 'Un círculo', 'Un triángulo', 'Una estrella'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l224-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si apoyas una cara de un cubo sobre plastilina, deja la huella de un ___',
            'options': ['cuadrado', 'círculo', 'triángulo', 'óvalo'],
            'correct_answer': 'cuadrado',
          },
        ),
        Exercise(
          id: 'l224-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuáles de estos cuerpos pueden TANTO deslizarse (sobre su base plana) COMO rodar (de lado)?',
            'options': ['El cilindro y el cono', 'Solo el cubo', 'Solo la esfera', 'El ladrillo'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l224-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada producto colombiano con su forma 3D',
            'items': ['Bocadillo veleño en bloque', 'Tambor de cumbia', 'Almojábana o buñuelo redondo'],
            'targets': ['Prisma rectangular', 'Cilindro', 'Esfera'],
            'correct_mapping': {
              'Bocadillo veleño en bloque': 'Prisma rectangular',
              'Tambor de cumbia': 'Cilindro',
              'Almojábana o buñuelo redondo': 'Esfera',
            },
          },
        ),
        Exercise(
          id: 'l224-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Una pirámide tiene caras laterales con forma de ___',
            'options': ['triángulo', 'círculo', 'cilindro', 'esfera'],
            'correct_answer': 'triángulo',
          },
        ),
      ],
    ),

    'lesson-225': Lesson(
      id: 'lesson-225', unitId: 'unit-205', orderNum: 5,
      title: '¡Desafío de cuerpos 3D!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l225-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Tengo 6 caras cuadradas iguales, 8 vértices y 12 aristas. ¿Qué cuerpo soy?',
            'options': ['El cilindro', 'El cubo', 'La esfera', 'El cono'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l225-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Dos dados (cubos) tienen en total ___ caras cuadradas',
            'options': ['6', '10', '12', '16'],
            'correct_answer': '12',
          },
        ),
        Exercise(
          id: 'l225-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué diferencia hay entre un círculo y una esfera?',
            'options': [
              'El círculo es plano (2D) y la esfera tiene volumen como un balón (3D)',
              'El círculo tiene esquinas y la esfera no',
              'Son exactamente lo mismo',
              'La esfera es cuadrada',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l225-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada pista con el cuerpo geométrico correcto',
            'items': ['Rueda en todas direcciones sin caras planas', 'Tiene 2 bases circulares como un tubo', 'Tiene 1 base circular y 1 punta'],
            'targets': ['Esfera', 'Cilindro', 'Cono'],
            'correct_mapping': {
              'Rueda en todas direcciones sin caras planas': 'Esfera',
              'Tiene 2 bases circulares como un tubo': 'Cilindro',
              'Tiene 1 base circular y 1 punta': 'Cono',
            },
          },
        ),
        Exercise(
          id: 'l225-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Un prisma rectangular tiene ___ caras en total, igual que el cubo',
            'options': ['4', '5', '6', '8'],
            'correct_answer': '6',
          },
        ),
        Exercise(
          id: 'l225-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si desarmas una caja con forma de cubo, ¿cuántos cuadrados planos necesitas para volverla a armar?',
            'options': ['4 cuadrados', '6 cuadrados', '8 cuadrados', '3 cuadrados'],
            'correct_index': 1,
          },
        ),
      ],
    ),

    // ── UNIDAD 206: Patrones y secuencias ── DBA #6 Grado 2° (Período 3)
    // "Identifica patrones numéricos y geométricos, y los continúa."
    'lesson-226': Lesson(
      id: 'lesson-226', unitId: 'unit-206', orderNum: 1,
      title: 'Secuencias de 2 en 2 y 5 en 5',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l226-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número sigue en la secuencia: 2, 4, 6, 8, ___?',
            'options': ['9', '10', '11', '12'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l226-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la secuencia de 5 en 5: 5, 10, 15, 20, ___',
            'options': ['22', '25', '30', '21'],
            'correct_answer': '25',
          },
        ),
        Exercise(
          id: 'l226-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es la regla del patrón: 10, 20, 30, 40, 50?',
            'options': ['Sumar 5 cada vez', 'Sumar 10 cada vez', 'Restar 10 cada vez', 'Sumar 2 cada vez'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l226-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada secuencia con el número que la completa',
            'items': ['12, 14, 16, ___', '25, 30, 35, ___', '50, 60, 70, ___'],
            'targets': ['18', '40', '80'],
            'correct_mapping': {
              '12, 14, 16, ___': '18',
              '25, 30, 35, ___': '40',
              '50, 60, 70, ___': '80',
            },
          },
        ),
        Exercise(
          id: 'l226-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si cuentas de 3 en 3: 3, 6, 9, 12, el siguiente número es ___',
            'options': ['13', '14', '15', '16'],
            'correct_answer': '15',
          },
        ),
      ],
    ),

    'lesson-227': Lesson(
      id: 'lesson-227', unitId: 'unit-206', orderNum: 2,
      title: 'Secuencias ascendentes y descendentes',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l227-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Observa la cuenta regresiva: 50, 45, 40, 35, ___. ¿Qué número sigue?',
            'options': ['40', '30', '25', '34'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l227-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el patrón descendente 100, 90, 80, 70, ___, el siguiente número es ___',
            'options': ['50', '60', '65', '75'],
            'correct_answer': '60',
          },
        ),
        Exercise(
          id: 'l227-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Cuando los números de una secuencia van creciendo cada vez más, la secuencia es…',
            'options': ['Ascendente (sube)', 'Descendente (baja)', 'Quieta', 'Vacía'],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l227-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada secuencia con su regla',
            'items': ['100, 200, 300, 400', '20, 18, 16, 14', '15, 25, 35, 45'],
            'targets': ['Sumar 100', 'Restar 2', 'Sumar 10'],
            'correct_mapping': {
              '100, 200, 300, 400': 'Sumar 100',
              '20, 18, 16, 14': 'Restar 2',
              '15, 25, 35, 45': 'Sumar 10',
            },
          },
        ),
        Exercise(
          id: 'l227-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la secuencia 40, 36, 32, 28, estamos restando ___ cada vez',
            'options': ['2', '4', '5', '6'],
            'correct_answer': '4',
          },
        ),
      ],
    ),

    'lesson-228': Lesson(
      id: 'lesson-228', unitId: 'unit-206', orderNum: 3,
      title: 'Patrones geométricos y de colores',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l228-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la manilla artesanal: 🟡🔵🔴 🟡🔵🔴 🟡🔵___. ¿Qué color sigue?',
            'options': ['Amarillo 🟡', 'Azul 🔵', 'Rojo 🔴', 'Verde 🟢'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l228-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el patrón: Cuadrado, Triángulo, Cuadrado, Triángulo, Cuadrado, sigue ___',
            'options': ['Triángulo', 'Círculo', 'Cuadrado', 'Cubo'],
            'correct_answer': 'Triángulo',
          },
        ),
        Exercise(
          id: 'l228-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si una figura crece así: Paso 1 = 2 cuadros, Paso 2 = 4 cuadros, Paso 3 = 6 cuadros. ¿Cuántos cuadros tendrá el Paso 4?',
            'options': ['7 cuadros', '8 cuadros', '10 cuadros', '9 cuadros'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l228-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Completa cada patrón visual con la figura que sigue',
            'items': ['⭐🌙 ⭐🌙 ⭐___', '🔺🔺🔵 🔺🔺___', '🟢🟡 🟢🟡 ___'],
            'targets': ['🌙', '🔵', '🟢'],
            'correct_mapping': {
              '⭐🌙 ⭐🌙 ⭐___': '🌙',
              '🔺🔺🔵 🔺🔺___': '🔵',
              '🟢🟡 🟢🟡 ___': '🟢',
            },
          },
        ),
        Exercise(
          id: 'l228-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En una torre de bloques donde cada piso tiene 3 bloques más que el anterior (3, 6, 9, ___), el cuarto piso tiene ___ bloques',
            'options': ['10', '11', '12', '15'],
            'correct_answer': '12',
          },
        ),
      ],
    ),

    'lesson-229': Lesson(
      id: 'lesson-229', unitId: 'unit-206', orderNum: 4,
      title: 'Encontrar el número oculto',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l229-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Qué número falta en la mitad de la secuencia: 100, 150, ___, 250, 300?',
            'options': ['175', '200', '220', '180'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l229-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la serie 7, 14, ___, 28, 35, el número que falta es ___',
            'options': ['18', '20', '21', '24'],
            'correct_answer': '21',
          },
        ),
        Exercise(
          id: 'l229-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Valentina ahorra cada semana \$200 más: \$200, \$400, \$600, ___. ¿Cuánto tendrá en la semana 4?',
            'options': ['\$700', '\$800', '\$900', '\$1.000'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l229-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Encuentra el número faltante en cada secuencia',
            'items': ['4, 8, ___, 16', '50, ___, 30, 20', '300, 400, ___, 600'],
            'targets': ['12', '40', '500'],
            'correct_mapping': {
              '4, 8, ___, 16': '12',
              '50, ___, 30, 20': '40',
              '300, 400, ___, 600': '500',
            },
          },
        ),
        Exercise(
          id: 'l229-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En el patrón 90, 85, 80, ___, 70, falta el número ___',
            'options': ['72', '75', '78', '65'],
            'correct_answer': '75',
          },
        ),
      ],
    ),

    'lesson-230': Lesson(
      id: 'lesson-230', unitId: 'unit-206', orderNum: 5,
      title: '¡Desafío de patrones!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l230-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuál es el siguiente número en el patrón: 120, 140, 160, 180, ___?',
            'options': ['190', '200', '210', '220'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l230-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si cada caja trae 5 mangos, en 1, 2, 3, 4 y 5 cajas habrá: 5, 10, 15, 20 y ___ mangos',
            'options': ['22', '24', '25', '30'],
            'correct_answer': '25',
          },
        ),
        Exercise(
          id: 'l230-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la secuencia 1, 2, 4, 8, 16 (cada número es el doble del anterior), ¿cuál es el doble de 8?',
            'options': ['12', '14', '16', '10'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l230-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada patrón con su descripción',
            'items': ['5, 10, 15, 20', '80, 70, 60, 50', '3, 6, 9, 12'],
            'targets': ['Aumenta de 5 en 5', 'Disminuye de 10 en 10', 'Aumenta de 3 en 3'],
            'correct_mapping': {
              '5, 10, 15, 20': 'Aumenta de 5 en 5',
              '80, 70, 60, 50': 'Disminuye de 10 en 10',
              '3, 6, 9, 12': 'Aumenta de 3 en 3',
            },
          },
        ),
        Exercise(
          id: 'l230-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En la secuencia 900, 800, 700, ___, 500, falta el número ___',
            'options': ['550', '600', '650', '750'],
            'correct_answer': '600',
          },
        ),
        Exercise(
          id: 'l230-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Un bus pasa por el paradero a las 7:00, 7:15, 7:30 y 7:45. ¿Cada cuántos minutos pasa el bus?',
            'options': ['Cada 5 minutos', 'Cada 10 minutos', 'Cada 15 minutos', 'Cada 30 minutos'],
            'correct_index': 2,
          },
        ),
      ],
    ),

    // ── UNIDAD 207: Datos y gráficas ── DBA #7 Grado 2° (Período 4)
    // "Organiza datos en tablas y los representa en diagramas de barras."
    'lesson-231': Lesson(
      id: 'lesson-231', unitId: 'unit-207', orderNum: 1,
      title: 'Tablas de conteo',
      type: LessonType.intro, estimatedMinutes: 5,
      xpReward: 25, coinReward: 8, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l231-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una tabla de conteo, cada grupito de 5 marcas (|||| tachadas) vale 5. Si "Fútbol" tiene 3 grupitos de 5, ¿cuántos niños eligieron fútbol?',
            'options': ['8', '10', '15', '20'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l231-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si "Ciclismo" tiene 2 grupos de 5 marcas y 2 marcas sueltas (5 + 5 + 2), el total es ___',
            'options': ['9', '10', '12', '14'],
            'correct_answer': '12',
          },
        ),
        Exercise(
          id: 'l231-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Para qué sirven las marcas de conteo en una encuesta escolar?',
            'options': [
              'Para registrar cada respuesta sin perder la cuenta',
              'Para borrar el tablero',
              'Para medir longitudes',
              'Para dibujar círculos',
            ],
            'correct_index': 0,
          },
        ),
        Exercise(
          id: 'l231-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Relaciona cada conteo con su número total',
            'items': ['1 grupo de 5 + 3 palitos', '2 grupos de 5', '3 grupos de 5 + 4 palitos'],
            'targets': ['8', '10', '19'],
            'correct_mapping': {
              '1 grupo de 5 + 3 palitos': '8',
              '2 grupos de 5': '10',
              '3 grupos de 5 + 4 palitos': '19',
            },
          },
        ),
        Exercise(
          id: 'l231-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': '4 grupos de 5 marcas en una tabla de conteo representan ___ votos',
            'options': ['15', '20', '25', '9'],
            'correct_answer': '20',
          },
        ),
      ],
    ),

    'lesson-232': Lesson(
      id: 'lesson-232', unitId: 'unit-207', orderNum: 2,
      title: 'Tablas de frecuencia',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.easy,
      exercises: [
        Exercise(
          id: 'l232-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En una tabla de frecuencia de sabores de helado: Mora=12, Arequipe=18, Coco=9. ¿Cuál es la frecuencia de Arequipe?',
            'options': ['9', '12', '18', '39'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l232-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'En esa misma tabla (Mora=12, Arequipe=18, Coco=9), el total de helados vendidos fue ___',
            'options': ['30', '35', '39', '40'],
            'correct_answer': '39',
          },
        ),
        Exercise(
          id: 'l232-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Cuántos niños más prefieren Arequipe (18) que Coco (9)?',
            'options': ['6', '8', '9', '27'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l232-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Según la tabla (Buses=15, Bicicletas=22, Carros=18), relaciona cada pregunta',
            'items': ['Transporte más usado', 'Transporte menos usado', 'Diferencia entre Bicicletas y Buses'],
            'targets': ['Bicicletas (22)', 'Buses (15)', '7 de diferencia'],
            'correct_mapping': {
              'Transporte más usado': 'Bicicletas (22)',
              'Transporte menos usado': 'Buses (15)',
              'Diferencia entre Bicicletas y Buses': '7 de diferencia',
            },
          },
        ),
        Exercise(
          id: 'l232-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'La cantidad de veces que se repite un dato en una tabla se llama ___',
            'options': ['frecuencia', 'perímetro', 'vértice', 'centena'],
            'correct_answer': 'frecuencia',
          },
        ),
      ],
    ),

    'lesson-233': Lesson(
      id: 'lesson-233', unitId: 'unit-207', orderNum: 3,
      title: 'Gráficas de barras',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 30, coinReward: 10, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l233-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En un diagrama de barras sobre deportes en grado 2°: Fútbol=14, Baloncesto=8, Patinaje=12. ¿Cuál barra es la segunda más alta?',
            'options': ['Fútbol', 'Patinaje', 'Baloncesto', 'Todas igual'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l233-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si Fútbol=14 y Baloncesto=8, entre esos dos deportes suman ___ estudiantes',
            'options': ['20', '22', '24', '6'],
            'correct_answer': '22',
          },
        ),
        Exercise(
          id: 'l233-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Si los números del eje vertical van de 2 en 2 (0, 2, 4, 6, 8, 10) y una barra sube 4 escalones desde el 0, ¿qué valor representa?',
            'options': ['4', '6', '8', '10'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l233-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con escala de 5 en 5, relaciona cuántos cuadritos de alto tiene cada barra',
            'items': ['1 cuadrito de alto', '3 cuadritos de alto', '5 cuadritos de alto'],
            'targets': ['5 votos', '15 votos', '25 votos'],
            'correct_mapping': {
              '1 cuadrito de alto': '5 votos',
              '3 cuadritos de alto': '15 votos',
              '5 cuadritos de alto': '25 votos',
            },
          },
        ),
        Exercise(
          id: 'l233-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si en el salón hay 34 niños (14 en fútbol, 8 en baloncesto y 12 en patinaje), faltan por votar ___ niños',
            'options': ['0', '2', '4', '6'],
            'correct_answer': '0',
          },
        ),
      ],
    ),

    'lesson-234': Lesson(
      id: 'lesson-234', unitId: 'unit-207', orderNum: 4,
      title: 'Interpretar encuestas escolares',
      type: LessonType.standard, estimatedMinutes: 6,
      xpReward: 40, coinReward: 12, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l234-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la biblioteca escolar prestaron: Lunes=20 libros, Martes=15, Miércoles=25. ¿Qué día prestaron más libros?',
            'options': ['Lunes', 'Martes', 'Miércoles', 'Jueves'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l234-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Entre Lunes (20), Martes (15) y Miércoles (25) se prestaron ___ libros en total',
            'options': ['50', '55', '60', '65'],
            'correct_answer': '60',
          },
        ),
        Exercise(
          id: 'l234-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En la tienda escolar vendieron 30 empanadas y 18 pasteles. ¿Cuántas empanadas más que pasteles se vendieron?',
            'options': ['10', '12', '14', '48'],
            'correct_index': 1,
          },
        ),
        Exercise(
          id: 'l234-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Según las lluvias del mes (Semana 1=3 días, Semana 2=6 días, Semana 3=2 días), relaciona',
            'items': ['Semana más lluviosa', 'Semana más seca', 'Total de días con lluvia'],
            'targets': ['Semana 2 (6 días)', 'Semana 3 (2 días)', '11 días'],
            'correct_mapping': {
              'Semana más lluviosa': 'Semana 2 (6 días)',
              'Semana más seca': 'Semana 3 (2 días)',
              'Total de días con lluvia': '11 días',
            },
          },
        ),
        Exercise(
          id: 'l234-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si 25 niños trajeron lonchera y 15 compraron en la cafetería, en el curso hay ___ niños',
            'options': ['30', '35', '40', '45'],
            'correct_answer': '40',
          },
        ),
      ],
    ),

    'lesson-235': Lesson(
      id: 'lesson-235', unitId: 'unit-207', orderNum: 5,
      title: '¡Desafío estadístico!',
      type: LessonType.boss, estimatedMinutes: 8,
      xpReward: 60, coinReward: 20, difficulty: Difficulty.medium,
      exercises: [
        Exercise(
          id: 'l235-e1', orderNum: 1, type: ExerciseType.multipleChoice,
          content: {
            'question': 'En un pictograma cada 🌳 vale 2 árboles sembrados. Si el grado 2° tiene 🌳🌳🌳🌳🌳, ¿cuántos árboles sembraron?',
            'options': ['5 árboles', '8 árboles', '10 árboles', '12 árboles'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l235-e2', orderNum: 2, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si cada ⭐ vale 5 puntos y Camila ganó ⭐⭐⭐⭐, entonces tiene ___ puntos',
            'options': ['9', '15', '20', '25'],
            'correct_answer': '20',
          },
        ),
        Exercise(
          id: 'l235-e3', orderNum: 3, type: ExerciseType.multipleChoice,
          content: {
            'question': 'Tabla de mascotas en el barrio: Perros=35, Gatos=20, Pájaros=15. ¿Cuántas mascotas hay en total?',
            'options': ['60', '65', '70', '75'],
            'correct_index': 2,
          },
        ),
        Exercise(
          id: 'l235-e4', orderNum: 4, type: ExerciseType.dragDrop,
          content: {
            'instruction': 'Con los datos (Perros=35, Gatos=20, Pájaros=15), relaciona cada operación',
            'items': ['Perros menos Gatos', 'Gatos más Pájaros', 'Perros menos Pájaros'],
            'targets': ['15', '35', '20'],
            'correct_mapping': {
              'Perros menos Gatos': '15',
              'Gatos más Pájaros': '35',
              'Perros menos Pájaros': '20',
            },
          },
        ),
        Exercise(
          id: 'l235-e5', orderNum: 5, type: ExerciseType.fillBlank,
          content: {
            'sentence': 'Si una barra llega a 45 y otra llega a 30, la diferencia entre las dos barras es ___',
            'options': ['10', '15', '20', '75'],
            'correct_answer': '15',
          },
        ),
        Exercise(
          id: 'l235-e6', orderNum: 6, type: ExerciseType.multipleChoice,
          content: {
            'question': '¿Por qué es útil pasar una tabla de datos a un diagrama de barras?',
            'options': [
              'Porque permite comparar de un vistazo cuál dato es mayor o menor',
              'Porque cambia los números de la encuesta',
              'Porque borra los datos pequeños',
              'No sirve para nada',
            ],
            'correct_index': 0,
          },
        ),
      ],
    ),
};
