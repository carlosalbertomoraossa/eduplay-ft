import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:edplay_ft/features/lesson/presentation/widgets/exercise_visual_aid.dart';

void main() {
  group('ExerciseVisualAid - fracción de cantidad vs fracción de figura', () {
    testWidgets('para "¿Cuánto es la mitad de 12?" muestra grupos iguales con Total: 12 y tip de reparto',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ExerciseVisualAid(
                questionText: '¿Cuánto es la mitad de 12?',
                options: ['4', '6', '8'],
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Repartir en Partes Iguales'), findsOneWidget);
      expect(find.textContaining('Total: 12'), findsOneWidget);
      expect(find.textContaining('Grupo 1'), findsOneWidget);
      expect(find.textContaining('Grupo 2'), findsOneWidget);
      expect(find.textContaining('12 ÷ 2'), findsOneWidget);
      // No debe hablar de pizza ni de "número de abajo"
      expect(find.textContaining('Fábrica de Fracciones'), findsNothing);
    });

    testWidgets('para preguntas con opciones en fracción mantiene la Fábrica de Fracciones',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ExerciseVisualAid(
                questionText: '¿Qué fracción representa la mitad de un bocadillo de guayaba?',
                options: ['1/2', '1/3', '1/4'],
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Fábrica de Fracciones'), findsOneWidget);
    });
  });
}
