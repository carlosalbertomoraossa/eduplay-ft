import 'package:flutter_test/flutter_test.dart';

import 'package:edplay_ft/features/games/g4_adventure/data/game_questions_provider.dart';
import 'package:edplay_ft/features/games/g4_adventure/domain/entities/game_question.dart';

void main() {
  group('GameQuestionsProvider', () {
    test('getQuestionsForLevel(1) devuelve 10 preguntas', () {
      final questions = GameQuestionsProvider.getQuestionsForLevel(1);
      expect(questions.length, 10);
    });

    test('getQuestionsForLevel(2) devuelve 10 preguntas', () {
      final questions = GameQuestionsProvider.getQuestionsForLevel(2);
      expect(questions.length, 10);
    });

    test('getQuestionsForLevel(3) devuelve 10 preguntas', () {
      final questions = GameQuestionsProvider.getQuestionsForLevel(3);
      expect(questions.length, 10);
    });

    test('getQuestionsForLevel(8) devuelve 10 preguntas', () {
      final questions = GameQuestionsProvider.getQuestionsForLevel(8);
      expect(questions.length, 10);
    });

    test('getQuestionsForLevel con nivel inválido devuelve lista vacía', () {
      final questions = GameQuestionsProvider.getQuestionsForLevel(99);
      expect(questions, isEmpty);
    });

    test('cada pregunta tiene exactamente 3 opciones', () {
      for (var level = 1; level <= 8; level++) {
        final questions = GameQuestionsProvider.getQuestionsForLevel(level);
        for (final q in questions) {
          expect(q.options.length, 3,
              reason: 'Nivel $level, pregunta ${q.id}');
        }
      }
    });

    test('correctIndex está entre 0 y 2 en todas las preguntas', () {
      for (var level = 1; level <= 8; level++) {
        final questions = GameQuestionsProvider.getQuestionsForLevel(level);
        for (final q in questions) {
          expect(q.correctIndex >= 0 && q.correctIndex <= 2, isTrue,
              reason: 'Nivel $level, pregunta ${q.id}');
        }
      }
    });

    test('isCorrectAnswer funciona correctamente', () {
      final questions = GameQuestionsProvider.getQuestionsForLevel(1);
      for (final q in questions) {
        expect(q.isCorrectAnswer(q.correctIndex), isTrue,
            reason: 'Pregunta ${q.id}');
        // Una opción incorrecta distinta
        final wrongIndex = (q.correctIndex + 1) % 3;
        expect(q.isCorrectAnswer(wrongIndex), isFalse,
            reason: 'Pregunta ${q.id}');
      }
    });

    test('los niveles 1-2 tienen difficulty easy', () {
      for (var level = 1; level <= 2; level++) {
        final questions = GameQuestionsProvider.getQuestionsForLevel(level);
        for (final q in questions) {
          expect(q.difficulty.name, 'easy',
              reason: 'Nivel $level, pregunta ${q.id}');
        }
      }
    });

    test('los niveles 3-5 tienen difficulty medium', () {
      for (var level = 3; level <= 5; level++) {
        final questions = GameQuestionsProvider.getQuestionsForLevel(level);
        for (final q in questions) {
          expect(q.difficulty.name, 'medium',
              reason: 'Nivel $level, pregunta ${q.id}');
        }
      }
    });

    test('los niveles 6-8 tienen difficulty hard', () {
      for (var level = 6; level <= 8; level++) {
        final questions = GameQuestionsProvider.getQuestionsForLevel(level);
        for (final q in questions) {
          expect(q.difficulty.name, 'hard',
              reason: 'Nivel $level, pregunta ${q.id}');
        }
      }
    });

    test('ninguna pregunta está vacía', () {
      for (var level = 1; level <= 8; level++) {
        final questions = GameQuestionsProvider.getQuestionsForLevel(level);
        for (final q in questions) {
          expect(q.question, isNotEmpty,
              reason: 'Nivel $level, pregunta ${q.id}');
          expect(q.options.every((o) => o.isNotEmpty), isTrue,
              reason: 'Nivel $level, pregunta ${q.id}');
        }
      }
    });
  });
}
