import 'package:edplay_ft/features/lesson/data/curriculum_data.dart';
import 'package:edplay_ft/features/lesson/domain/entities/lesson.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurriculumData — 4 Períodos Académicos (Grados 1° a 5°)', () {
    test('contiene exactamente 39 unidades y 195 lecciones en total', () {
      final expectedUnitsPerGrade = {
        1: 8,
        2: 7,
        3: 8,
        4: 8,
        5: 8,
      };

      var totalUnits = 0;
      var totalLessons = 0;

      for (final entry in expectedUnitsPerGrade.entries) {
        final grade = entry.key;
        final expectedUnits = entry.value;
        final units = CurriculumData.getUnitIdsForGrade(grade);

        expect(
          units.length,
          expectedUnits,
          reason: 'Grado $grade° debe tener $expectedUnits unidades',
        );
        totalUnits += units.length;

        final gradeLessonIds = CurriculumData.getLessonIdsForGrade(grade);
        expect(
          gradeLessonIds.length,
          expectedUnits * 5,
          reason: 'Grado $grade° debe tener ${expectedUnits * 5} lecciones',
        );
        totalLessons += gradeLessonIds.length;
      }

      expect(totalUnits, 39);
      expect(totalLessons, 195);
      expect(CurriculumData.allLessonIds.length, 195);
    });

    test('cada grado cubre los 4 períodos académicos en orden (1..4)', () {
      for (var grade = 1; grade <= 5; grade++) {
        final units = CurriculumData.getUnitIdsForGrade(grade);
        final periods = units.map(CurriculumData.getUnitPeriod).toList();

        // Debe contener los períodos 1, 2, 3 y 4
        expect(periods.toSet(), {1, 2, 3, 4},
            reason: 'Grado $grade° debe cubrir los 4 períodos');

        // Deben estar ordenados de forma no decreciente
        for (var i = 1; i < periods.length; i++) {
          expect(
            periods[i],
            greaterThanOrEqualTo(periods[i - 1]),
            reason:
                'Unidades de Grado $grade° deben estar ordenadas por período',
          );
        }
      }
    });

    test('todas las 39 unidades tienen título, descripción y 5 lecciones válidas', () {
      for (var grade = 1; grade <= 5; grade++) {
        final units = CurriculumData.getUnitIdsForGrade(grade);
        for (final unitId in units) {
          expect(CurriculumData.unitTitles[unitId], isNotEmpty,
              reason: 'Falta título para $unitId');
          expect(CurriculumData.unitDescriptions[unitId], isNotEmpty,
              reason: 'Falta descripción para $unitId');

          final summaries = CurriculumData.getLessonsForUnit(unitId);
          expect(summaries.length, 5,
              reason: 'Unidad $unitId debe tener 5 lecciones');

          for (final summary in summaries) {
            final lesson = CurriculumData.getLesson(summary.id);
            expect(lesson, isNotNull,
                reason: 'Lección ${summary.id} ($unitId) debe existir en _allLessons');
            expect(lesson!.exercises.length, greaterThanOrEqualTo(3),
                reason: 'Lección ${lesson.id} debe tener al menos 3 ejercicios');

            for (final ex in lesson.exercises) {
              expect(
                ex.type,
                isIn([
                  ExerciseType.multipleChoice,
                  ExerciseType.fillBlank,
                  ExerciseType.dragDrop,
                ]),
                reason: 'Ejercicio ${ex.id} usa un tipo soportado',
              );

              if (ex.type == ExerciseType.multipleChoice) {
                final options = ex.content['options'] as List?;
                final correctIdx = ex.content['correct_index'] as int?;
                expect(options, isNotNull,
                    reason: 'Faltan options en ${ex.id} (${lesson.id})');
                expect(correctIdx, isNotNull,
                    reason: 'Falta correct_index en ${ex.id} (${lesson.id})');
                expect(
                  correctIdx! >= 0 && correctIdx < options!.length,
                  isTrue,
                  reason:
                      'En ${ex.id} (${lesson.id}), correct_index $correctIdx fuera de rango para options $options',
                );
              } else if (ex.type == ExerciseType.fillBlank) {
                final options = ex.content['options'] as List?;
                final correctAnswer = ex.content['correct_answer'];
                expect(options, isNotNull,
                    reason: 'Faltan options en ${ex.id} (${lesson.id})');
                expect(
                  options!.contains(correctAnswer),
                  isTrue,
                  reason:
                      'En ${ex.id} (${lesson.id}), correct_answer "$correctAnswer" no está en options $options',
                );
              } else if (ex.type == ExerciseType.dragDrop) {
                final mapping = ex.content['correct_mapping'] as Map?;
                expect(mapping, isNotEmpty,
                    reason: 'Falta correct_mapping en ${ex.id} (${lesson.id})');
              }
            }
          }
        }
      }
    });
  });
}
