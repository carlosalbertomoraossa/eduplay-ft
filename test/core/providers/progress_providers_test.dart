import 'package:edplay_ft/core/providers/game_progress_provider.dart';
import 'package:edplay_ft/core/providers/lesson_progress_provider.dart';
import 'package:edplay_ft/features/lesson/presentation/widgets/exercise_visual_aid.dart';
import 'package:edplay_ft/features/subjects/presentation/widgets/unit_prep_zone.dart';
import 'package:edplay_ft/shared/widgets/lumi_lion_mascot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Persistencia en SharedPreferences (Lecciones y Juego G4)', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('LessonProgressNotifier guarda y restaura lecciones completadas', () async {
      final prefs = await SharedPreferences.getInstance();
      final notifier = LessonProgressNotifier(prefs);

      expect(notifier.state, isEmpty);
      notifier.completeLesson('lesson-001');
      notifier.completeLesson('lesson-016');

      expect(notifier.state, {'lesson-001', 'lesson-016'});

      // Nueva instancia lee desde SharedPreferences
      final restored = LessonProgressNotifier(prefs);
      expect(restored.state, {'lesson-001', 'lesson-016'});
    });

    test('GameProgressNotifier desbloquea niveles, guarda estrellas y mejor puntaje', () async {
      final prefs = await SharedPreferences.getInstance();
      final notifier = GameProgressNotifier(prefs);

      expect(notifier.state.unlockedLevel, 1);
      expect(notifier.state.starsFor(1), 0);

      notifier.recordLevelCompleted(
        level: 1,
        score: 450,
        accuracy: 0.95,
      );

      expect(notifier.state.unlockedLevel, 2);
      expect(notifier.state.starsFor(1), 3);
      expect(notifier.state.bestScoreFor(1), 450);

      // Nueva instancia restaura desde SharedPreferences
      final restored = GameProgressNotifier(prefs);
      expect(restored.state.unlockedLevel, 2);
      expect(restored.state.starsFor(1), 3);
      expect(restored.state.bestScoreFor(1), 450);
    });
  });

  group('ExerciseVisualAid — Gráfico + Tip en todos los niveles', () {
    testWidgets('muestra CustomPaint y Tip personalizado o generado automáticamente',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExerciseVisualAid(
              questionText: '¿Cuánto es 3/4 de la pizza?',
              hint: 'Divide en 4 partes y toma 3',
              options: ['1/4', '2/4', '3/4'],
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
      expect(find.textContaining('Tip:'), findsOneWidget);
      expect(find.textContaining('Divide en 4 partes y toma 3'), findsOneWidget);
    });

    testWidgets('Tablero Posicional interactivo permite sumar/restar fichas y alternar truco extra',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExerciseVisualAid(
              questionText: 'En el número 537, ¿cuánto vale el dígito 5?',
              options: ['5', '50', '500', '5.000'],
            ),
          ),
        ),
      );

      // Carga el número 537 en la tabla posicional y muestra la suma descompuesta
      expect(find.textContaining('Número: 537'), findsOneWidget);
      expect(find.textContaining('500'), findsWidgets);

      // Tocar el botón '+' de la primera columna (Centenas) sube 537 → 637
      await tester.tap(find.text('+').first);
      await tester.pumpAndSettle();
      expect(find.textContaining('Número: 637'), findsOneWidget);

      // Tocar '✨ Otro truco' muestra el súper tip interactivo
      await tester.tap(find.textContaining('Otro truco'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Súper Tip:'), findsOneWidget);
    });

    testWidgets('UnitPrepZone muestra muñeco animado, temario, mesa interactiva y tablita',
        (tester) async {
      bool started = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: UnitPrepZone(
                unitId: 'unit-201',
                onStartExercises: () => started = true,
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(LumiLionMascot), findsWidgets);
      expect(find.textContaining('Lumi el Leoncito Constructor'), findsOneWidget);
      expect(find.textContaining('Mesa Interactiva: ¡Arrastra y acomoda!'), findsOneWidget);
      expect(find.textContaining('Tablita Mágica'), findsOneWidget);

      // Acomodar piezas en la Mesa Interactiva actualiza el contador en vivo
      await tester.ensureVisible(find.text('Acomodar todo'));
      await tester.pump();
      await tester.tap(find.text('Acomodar todo'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.textContaining('¡Acomodaste'), findsOneWidget);

      // Pasar a la Zona de Ejercicios
      await tester.ensureVisible(
        find.text('¡Ya estoy listo! Ir a la Zona de Ejercicios'),
      );
      await tester.tap(find.text('¡Ya estoy listo! Ir a la Zona de Ejercicios'));
      await tester.pump();
      expect(started, isTrue);
    });

    testWidgets(
        'Temario súper interactivo permite voltear tarjetas mágicas, usar laboratorio en vivo y practicar en el mini-reto',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: UnitPrepZone(
                unitId: 'unit-401', // Fracciones en Grado 4°
                onStartExercises: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      // Paso 1 (1️⃣ ¿Qué es?): muestra el Súper Secreto de Lumi directamente
      expect(find.textContaining('¡Súper Secreto de Lumi'), findsOneWidget);

      // Pasar al Paso 2 (2️⃣ ¡Juega y Prueba!)
      await tester.ensureVisible(find.text('2️⃣ ¡Juega y Prueba!'));
      await tester.pump();
      await tester.tap(find.text('2️⃣ ¡Juega y Prueba!'));
      await tester.pump(const Duration(milliseconds: 250));

      // Verifica el Laboratorio en Vivo de fracciones (barra interactiva + equivalencias)
      expect(find.textContaining('¡Laboratorio en Vivo de'), findsOneWidget);
      expect(find.textContaining('Porcentaje:'), findsWidgets);

      // Probar los 3 juegos de la explicación: 1. Completar, 2. Armar y 3. Buscar
      await tester.ensureVisible(find.text('🪄 Completar con Lumi'));
      await tester.pump();
      await tester.tap(find.text('🪄 Completar con Lumi'));
      await tester.pump(const Duration(milliseconds: 250));
      expect(
        find.textContaining('¡Genial! Completaste toda la explicación jugando'),
        findsOneWidget,
      );

      // Cambiar al modo '🏗️ 2. Armar' y agregar una pieza al lienzo constructor
      await tester.ensureVisible(find.text('🏗️ 2. Armar'));
      await tester.pump();
      await tester.tap(find.text('🏗️ 2. Armar'));
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.textContaining('¡Arma un pedido del'), findsOneWidget);

      // Cambiar al modo '🔍 3. Buscar' e investigar fichas con la lupa
      await tester.ensureVisible(find.text('🔍 3. Buscar'));
      await tester.pump();
      await tester.tap(find.text('🔍 3. Buscar'));
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.textContaining('Misión Detective:'), findsOneWidget);

      // Pasar al Paso 3 (3️⃣ ¡Mini-Reto!)
      await tester.ensureVisible(find.text('3️⃣ ¡Mini-Reto!'));
      await tester.pump();
      await tester.tap(find.text('3️⃣ ¡Mini-Reto!'));
      await tester.pump(const Duration(milliseconds: 250));

      // Voltear la primera Tarjeta Mágica Giratoria
      expect(find.textContaining('Misterio #1:'), findsOneWidget);
      await tester.ensureVisible(find.textContaining('Misterio #1:'));
      await tester.pump();
      await tester.tap(find.textContaining('Misterio #1:'));
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.textContaining('✨ Respuesta:'), findsOneWidget);

      // Cambiar de pregunta en el Mini-Reto de Entrenamiento
      expect(find.textContaining('Mini-Reto de Entrenamiento (1/'), findsOneWidget);
      await tester.ensureVisible(find.text('🔄 Otra pregunta de este tema →'));
      await tester.pump();
      await tester.tap(find.text('🔄 Otra pregunta de este tema →'));
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.textContaining('Mini-Reto de Entrenamiento (2/'), findsOneWidget);
    });

    testWidgets(
        'Grado 1° (unit-001) define 5 dedos y 3 lados, muestra respuestas completas en Buscar y piezas únicas en la Mesa',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: UnitPrepZone(
                unitId: 'unit-001',
                onStartExercises: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      // Paso 1 define explícitamente dedos de una mano y lados de un triángulo
      expect(find.textContaining('5 dedos'), findsWidgets);
      expect(find.textContaining('3 lados'), findsWidgets);

      // Piezas de la Mesa Interactiva son 6 valores distintos sin repeticiones
      for (final label in ['+1', '+2', '+3', '+4', '+5', '+10']) {
        expect(find.text(label), findsOneWidget);
      }

      // Ir al Paso 2 -> 3. Buscar y validar textos completos e intrusos de 1°
      await tester.ensureVisible(find.text('2️⃣ ¡Juega y Prueba!'));
      await tester.pump();
      await tester.tap(find.text('2️⃣ ¡Juega y Prueba!'));
      await tester.pump(const Duration(milliseconds: 250));

      await tester.ensureVisible(find.text('🔍 3. Buscar'));
      await tester.pump();
      await tester.tap(find.text('🔍 3. Buscar'));
      await tester.pump(const Duration(milliseconds: 250));

      expect(
        find.textContaining('¿Cuántos dedos tiene una mano?\n👉 Respuesta: 5'),
        findsOneWidget,
      );
      expect(
        find.textContaining('¿Cuántos lados tiene un triángulo?\n👉 Respuesta: 3'),
        findsOneWidget,
      );
      expect(find.text('Una mano tiene 8 dedos'), findsOneWidget);
      expect(find.text('Un triángulo tiene 4 lados'), findsOneWidget);
      expect(find.text('1 Decena = 100 U'), findsNothing);
      expect(find.text('5 Centenas = 50'), findsNothing);
    });

    testWidgets(
        'Tips de 1° en ExerciseVisualAid coinciden con cada temática y evitan conceptos avanzados falsos',
        (tester) async {
      final grade1Questions = <String>[
        'Relaciona cada número con su nombre',
        'Relaciona cada suma con su resultado',
        '¿Cuántos lados tiene un triángulo?',
        '¿Qué forma plana tiene una arepa redonda o una moneda?',
        'El número después del 7 es ___',
        '¿Cuál número es MAYOR: 7 o 4?',
      ];

      for (final q in grade1Questions) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: ExerciseVisualAid(
                  questionText: q,
                  options: const ['A', 'B', 'C'],
                ),
              ),
            ),
          ),
        );
        await tester.pump();

        expect(find.textContaining('Multiplicar es'), findsNothing, reason: q);
        expect(find.textContaining('3,14'), findsNothing, reason: q);
        expect(
          find.textContaining('largo por el ancho'),
          findsNothing,
          reason: q,
        );
        expect(find.textContaining('bajo cero'), findsNothing, reason: q);
      }

      // Verificar tip y visual específicos para pregunta de triángulo de 1°
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ExerciseVisualAid(
                questionText: '¿Cuántos lados tiene un triángulo?',
                options: ['2', '3', '4'],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.textContaining('3 lados'), findsWidgets);
    });
  });
}
