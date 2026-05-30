// Spec: specs/games/g4-adventure-platformer.md §4

import '../../../lesson/data/curriculum_data.dart';
import '../../../lesson/domain/entities/lesson.dart';
import '../domain/entities/game_question.dart';

// Exercise IDs de tipo multipleChoice de Grado 4°, agrupados por nivel (1–8).
// Progresión: fracciones (1–2) → multiplicación/división (3–4) →
//             decimales (5–6) → mixto avanzado (7–8 boss).
const Map<int, List<String>> _levelExerciseIds = {
  1: ['l401-e1', 'l401-e2', 'l402-e1', 'l402-e3', 'l403-e1',
      'l403-e3', 'l404-e1', 'l404-e3', 'l405-e1', 'l405-e4'],
  2: ['l402-e1', 'l402-e3', 'l403-e1', 'l403-e3', 'l404-e1',
      'l404-e3', 'l405-e1', 'l405-e4', 'l405-e6', 'l406-e1'],
  3: ['l405-e6', 'l406-e1', 'l406-e3', 'l407-e1', 'l407-e3',
      'l408-e1', 'l408-e3', 'l409-e1', 'l409-e3', 'l410-e1'],
  4: ['l407-e1', 'l407-e3', 'l408-e1', 'l408-e3', 'l409-e1',
      'l409-e3', 'l410-e1', 'l410-e3', 'l410-e5', 'l411-e1'],
  5: ['l409-e3', 'l410-e1', 'l410-e3', 'l410-e5', 'l411-e1',
      'l411-e2', 'l412-e1', 'l412-e3', 'l413-e1', 'l413-e3'],
  6: ['l411-e1', 'l411-e2', 'l412-e1', 'l412-e3', 'l413-e1',
      'l413-e3', 'l414-e1', 'l414-e3', 'l415-e1', 'l415-e4'],
  7: ['l412-e3', 'l413-e1', 'l413-e3', 'l414-e1', 'l414-e3',
      'l415-e1', 'l415-e4', 'l415-e6', 'l401-e1', 'l402-e1'],
  8: ['l415-e1', 'l415-e4', 'l415-e6', 'l413-e1', 'l414-e3',
      'l410-e5', 'l408-e1', 'l406-e3', 'l404-e1', 'l401-e1'],
};

Difficulty _difficultyForLevel(int level) {
  if (level <= 2) return Difficulty.easy;
  if (level <= 5) return Difficulty.medium;
  return Difficulty.hard;
}

int _xpForLevel(int level) {
  if (level <= 2) return 10;
  if (level <= 5) return 15;
  return 20;
}

class GameQuestionsProvider {
  // Devuelve las preguntas del juego para el nivel indicado (1–8).
  // Mapea ejercicios multipleChoice de CurriculumData a GameQuestion,
  // adaptando las 4 opciones del currículo a las 3 que necesita el juego.
  static List<GameQuestion> getQuestionsForLevel(int level) {
    final ids = _levelExerciseIds[level];
    if (ids == null) return [];

    final difficulty = _difficultyForLevel(level);
    final xpReward = _xpForLevel(level);

    final questions = <GameQuestion>[];
    for (final exerciseId in ids) {
      final q = _buildQuestion(exerciseId, difficulty, xpReward);
      if (q != null) questions.add(q);
    }
    return questions;
  }

  static GameQuestion? _buildQuestion(
    String exerciseId,
    Difficulty difficulty,
    int xpReward,
  ) {
    // exerciseId format: 'l401-e1' → lessonId prefix before last '-eN'
    final dashIndex = exerciseId.lastIndexOf('-');
    if (dashIndex < 0) return null;
    final lessonId = exerciseId.substring(0, dashIndex);

    final lesson = CurriculumData.getLesson(lessonId);
    if (lesson == null) return null;

    Exercise? exercise;
    for (final e in lesson.exercises) {
      if (e.id == exerciseId) {
        exercise = e;
        break;
      }
    }
    if (exercise == null) return null;
    if (exercise.type != ExerciseType.multipleChoice) return null;

    final rawOptions = List<String>.from(
      exercise.content['options'] as List<dynamic>,
    );
    final rawCorrectIndex = exercise.content['correct_index'] as int;
    final question = exercise.content['question'] as String;

    // El juego usa exactamente 3 opciones.
    // correct_index 0-2 → tomar primeras 3; correct_index 3 → tomar últimas 3
    // y remapear el índice correcto a 2.
    final List<String> options;
    final int correctIndex;
    if (rawCorrectIndex <= 2) {
      options = rawOptions.sublist(0, 3);
      correctIndex = rawCorrectIndex;
    } else {
      options = rawOptions.sublist(1, 4);
      correctIndex = 2;
    }

    return GameQuestion(
      id: exerciseId,
      question: question,
      options: options,
      correctIndex: correctIndex,
      xpReward: xpReward,
      difficulty: difficulty,
    );
  }
}
