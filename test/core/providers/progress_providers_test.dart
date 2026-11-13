import 'package:edplay_ft/core/providers/game_progress_provider.dart';
import 'package:edplay_ft/core/providers/lesson_progress_provider.dart';
import 'package:edplay_ft/features/lesson/presentation/widgets/exercise_visual_aid.dart';
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
  });
}
