import 'package:flutter_test/flutter_test.dart';

import 'package:edplay_ft/features/games/g4_adventure/data/game_questions_provider.dart';

void main() {
  group('GameQuestionsProvider multi-grado (1°–5° × 8 capítulos)', () {
    test('todos los grados 1..5 y niveles 1..8 devuelven 10 preguntas válidas', () {
      for (var grade = 1; grade <= 5; grade++) {
        for (var level = 1; level <= 8; level++) {
          final questions = GameQuestionsProvider.getQuestionsForGradeAndLevel(
            grade: grade,
            level: level,
          );
          expect(
            questions.length,
            10,
            reason: 'Grado $grade nivel $level debe tener 10 preguntas',
          );
          for (final q in questions) {
            expect(q.options.length, 3);
            expect(q.correctIndex, inInclusiveRange(0, 2));
            expect(q.question.trim(), isNotEmpty);
            expect(q.topicLabel, contains('G$grade°'));
          }
        }
      }
    });

    test('periodForLevel mapea 2 capítulos por cada uno de los 4 períodos MEN', () {
      expect(GameQuestionsProvider.periodForLevel(1), 1);
      expect(GameQuestionsProvider.periodForLevel(2), 1);
      expect(GameQuestionsProvider.periodForLevel(3), 2);
      expect(GameQuestionsProvider.periodForLevel(4), 2);
      expect(GameQuestionsProvider.periodForLevel(5), 3);
      expect(GameQuestionsProvider.periodForLevel(6), 3);
      expect(GameQuestionsProvider.periodForLevel(7), 4);
      expect(GameQuestionsProvider.periodForLevel(8), 4);
    });
  });
}
