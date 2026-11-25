// Spec: .sdd/implemented/features/g4-adventure/technical-specs.md §4

import '../../../lesson/data/curriculum_data.dart';
import '../../../lesson/domain/entities/lesson.dart';
import '../domain/entities/game_question.dart';

// Exercise IDs de tipo multipleChoice de Grados 4° y 5°.
// 8 niveles × 10 preguntas = 80 ejercicios mapeados del currículo.
// Niveles 1–6: ejercicios únicos por unidad temática.
// Niveles 7–8: repaso mixto y boss con ejercicios de todas las unidades.
const Map<int, List<String>> _levelExerciseIds = {
  1: ['l401-e1', 'l401-e2', 'l402-e1', 'l402-e3', 'l403-e1',
      'l403-e3', 'l404-e1', 'l404-e3', 'l405-e1', 'l405-e4'],
  2: ['l405-e6', 'l406-e1', 'l406-e3', 'l407-e1', 'l407-e3',
      'l408-e1', 'l408-e3', 'l409-e1', 'l409-e3', 'l410-e1'],
  3: ['l410-e3', 'l410-e5', 'l411-e1', 'l411-e2', 'l412-e1',
      'l412-e3', 'l413-e1', 'l413-e3', 'l414-e1', 'l414-e3'],
  4: ['l415-e1', 'l415-e4', 'l415-e6', 'l501-e1', 'l501-e2',
      'l502-e1', 'l502-e3', 'l503-e1', 'l503-e3', 'l504-e1'],
  5: ['l504-e5', 'l505-e1', 'l505-e3', 'l505-e6', 'l506-e1',
      'l506-e2', 'l507-e1', 'l507-e3', 'l508-e1', 'l508-e3'],
  6: ['l509-e1', 'l509-e3', 'l510-e1', 'l510-e4', 'l510-e6',
      'l511-e1', 'l511-e2', 'l512-e1', 'l512-e3', 'l513-e1'],
  7: ['l513-e3', 'l514-e1', 'l514-e3', 'l515-e1', 'l515-e3',
      'l515-e6', 'l501-e1', 'l410-e5', 'l406-e1', 'l401-e1'],
  8: ['l415-e6', 'l505-e6', 'l510-e6', 'l515-e6', 'l410-e5',
      'l510-e4', 'l514-e3', 'l415-e4', 'l505-e3', 'l405-e6'],
};

const Map<int, String> _levelTopicLabels = {
  1: 'Nivel 1 · Fracciones Básicas',
  2: 'Nivel 2 · Fracciones y Operaciones',
  3: 'Nivel 3 · Multiplicación y División',
  4: 'Nivel 4 · Decimales y Enteros',
  5: 'Nivel 5 · Porcentajes y Descuentos',
  6: 'Nivel 6 · Razones y Proporciones',
  7: 'Nivel 7 · Repaso Mixto',
  8: 'Nivel 8 · ¡Boss Final!',
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
  /// Devuelve las preguntas del juego para el nivel indicado (1–8) en modo
  /// clásico (Grado 4°/5° — retrocompatible con tests existentes).
  static List<GameQuestion> getQuestionsForLevel(int level) {
    final ids = _levelExerciseIds[level];
    if (ids == null) return [];

    final difficulty = _difficultyForLevel(level);
    final xpReward = _xpForLevel(level);
    final topicLabel = _levelTopicLabels[level] ?? 'Nivel $level';

    final questions = <GameQuestion>[];
    for (final exerciseId in ids) {
      final q = _buildQuestion(
        exerciseId,
        difficulty,
        xpReward,
        topicLabel: topicLabel,
      );
      if (q != null) questions.add(q);
    }
    return questions;
  }

  /// Devuelve 10 preguntas del currículo MEN Colombia para cualquier [grade] (1..5)
  /// y capítulo [level] (1..8), mapeando 2 capítulos por cada uno de los 4 períodos.
  static List<GameQuestion> getQuestionsForGradeAndLevel({
    required int grade,
    required int level,
  }) {
    if (level < 1 || level > 8) return [];
    final clampedGrade = grade.clamp(1, 5);
    final unitIds = CurriculumData.getUnitIdsForGrade(clampedGrade);
    if (unitIds.isEmpty) return getQuestionsForLevel(level);

    final period = periodForLevel(level);
    final difficulty = _difficultyForLevel(level);
    final xpReward = _xpForLevel(level);
    final topicLabel =
        'G$clampedGrade° · P$period · ${topicForGradeAndLevel(grade: clampedGrade, level: level)}';

    // Prioridad 1: ejercicios de la unidad exacta del capítulo
    final primaryPool = <Exercise>[];
    final periodPool = <Exercise>[];
    final gradePool = <Exercise>[];

    final targetUnitId = level <= unitIds.length ? unitIds[level - 1] : null;

    for (final unitId in unitIds) {
      final unitPeriod = CurriculumData.getUnitPeriod(unitId);
      final summaries = CurriculumData.getLessonsForUnit(unitId);
      for (final summary in summaries) {
        final lesson = CurriculumData.getLesson(summary.id);
        if (lesson == null) continue;
        for (final ex in lesson.exercises) {
          if (ex.type != ExerciseType.multipleChoice) continue;
          if (unitId == targetUnitId) {
            primaryPool.add(ex);
          } else if (unitPeriod == period) {
            periodPool.add(ex);
          } else {
            gradePool.add(ex);
          }
        }
      }
    }

    // Nivel 8 (Gran Enciclopedia / Boss): mezcla retos de todo el grado si es posible
    final orderedCandidates = <Exercise>[
      if (level == 8) ...[
        ...primaryPool.take(4),
        ...periodPool.take(3),
        ...gradePool,
        ...primaryPool.skip(4),
      ] else ...[
        ...primaryPool,
        ...periodPool,
        ...gradePool,
      ],
    ];

    final seenIds = <String>{};
    final result = <GameQuestion>[];
    for (final ex in orderedCandidates) {
      if (!seenIds.add(ex.id)) continue;
      final q = _fromExercise(
        ex,
        difficulty,
        xpReward,
        topicLabel: topicLabel,
      );
      if (q != null) result.add(q);
      if (result.length >= 10) break;
    }

    return result.isNotEmpty ? result : getQuestionsForLevel(level);
  }

  /// Período escolar colombiano (1..4) al que corresponde cada capítulo (1..8).
  static int periodForLevel(int level) => ((level - 1) ~/ 2).clamp(0, 3) + 1;

  /// Tema corto DBA del currículo MEN para el grado y capítulo dado.
  static String topicForGradeAndLevel({
    required int grade,
    required int level,
  }) {
    final unitIds = CurriculumData.getUnitIdsForGrade(grade.clamp(1, 5));
    if (level >= 1 && level <= unitIds.length) {
      final rawTitle = CurriculumData.unitTitles[unitIds[level - 1]] ?? '';
      final colonIdx = rawTitle.indexOf(':');
      if (colonIdx != -1 && colonIdx + 1 < rawTitle.length) {
        return rawTitle.substring(colonIdx + 1).trim();
      }
      if (rawTitle.isNotEmpty) return rawTitle;
    }
    return level == 8 ? '¡Gran Reto Final!' : 'Repaso del Período';
  }

  static GameQuestion? _buildQuestion(
    String exerciseId,
    Difficulty difficulty,
    int xpReward, {
    required String topicLabel,
  }) {
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
    return _fromExercise(
      exercise,
      difficulty,
      xpReward,
      topicLabel: topicLabel,
    );
  }

  static GameQuestion? _fromExercise(
    Exercise exercise,
    Difficulty difficulty,
    int xpReward, {
    required String topicLabel,
  }) {
    if (exercise.type != ExerciseType.multipleChoice) return null;

    final rawOptions = List<String>.from(
      exercise.content['options'] as List<dynamic>,
    );
    if (rawOptions.length < 3) return null;
    final rawCorrectIndex = exercise.content['correct_index'] as int;
    final question = exercise.content['question'] as String;

    // El juego usa exactamente 3 opciones.
    final List<String> options;
    final int correctIndex;
    if (rawCorrectIndex <= 2) {
      options = rawOptions.sublist(0, 3);
      correctIndex = rawCorrectIndex;
    } else {
      options = rawOptions.sublist(rawOptions.length - 3, rawOptions.length);
      correctIndex = 2;
    }

    return GameQuestion(
      id: exercise.id,
      question: question,
      options: options,
      correctIndex: correctIndex,
      xpReward: xpReward,
      difficulty: difficulty,
      hint: exercise.hint,
      topicLabel: topicLabel,
    );
  }
}
