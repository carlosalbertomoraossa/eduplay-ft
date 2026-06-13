// Spec: specs/games/g4-adventure-platformer.md §4

import '../../../lesson/data/curriculum_data.dart';
import '../../../lesson/domain/entities/lesson.dart';
import '../domain/entities/game_question.dart';

// Exercise IDs de tipo multipleChoice de Grado 4°.
// MVP: solo nivel 1 — Fracciones Básicas (lecciones 401–405).
const Map<int, List<String>> _levelExerciseIds = {
  1: ['l401-e1', 'l401-e2', 'l402-e1', 'l402-e3', 'l403-e1',
      'l403-e3', 'l404-e1', 'l404-e3', 'l405-e1', 'l405-e4'],
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
  // Devuelve las preguntas del juego para el nivel indicado (actualmente solo 1).
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
    // exerciseId format: 'l401-e1' → lección 'lesson-401'
    final match = RegExp(r'^l(\d+)-').firstMatch(exerciseId);
    if (match == null) return null;
    final lessonId = 'lesson-${match.group(1)}';

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
