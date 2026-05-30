// Pantalla de unidades de una materia
// Spec: /specs/domains/learning/spec.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/lesson_progress_provider.dart';
import '../../../../../core/providers/selected_grade_provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../lesson/data/curriculum_data.dart';

int _completedCount(String unitId, Set<String> completed) =>
    completed.intersection(CurriculumData.getLessonIdsForUnit(unitId)).length;

bool _isUnlocked(int index, List<String> unitIds, Set<String> completed) {
  if (index == 0) return true;
  final prevId = unitIds[index - 1];
  final prevTotal = CurriculumData.getLessonsForUnit(prevId).length;
  return _completedCount(prevId, completed) >= prevTotal;
}

class UnitsScreen extends ConsumerWidget {
  final String subjectCode;
  const UnitsScreen({super.key, required this.subjectCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(lessonProgressProvider);
    final grade = ref.watch(selectedGradeProvider);
    final unitIds = CurriculumData.getUnitIdsForGrade(grade);

    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      appBar: AppBar(
        title: Text(CurriculumData.getGradeTitle(grade)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: unitIds.length,
        itemBuilder: (_, i) {
          final unitId = unitIds[i];
          final title = CurriculumData.unitTitles[unitId] ?? unitId;
          final lessonsTotal = CurriculumData.getLessonsForUnit(unitId).length;
          final lessonsCompleted = _completedCount(unitId, completed);
          final unlocked = _isUnlocked(i, unitIds, completed);

          return _UnitCard(
            id: unitId,
            order: i + 1,
            title: title,
            lessonsTotal: lessonsTotal,
            lessonsCompleted: lessonsCompleted,
            isUnlocked: unlocked,
          )
              .animate(delay: Duration(milliseconds: i * 80))
              .fadeIn(duration: 350.ms)
              .slideX(begin: 0.1, end: 0);
        },
      ),
    );
  }
}

class _UnitCard extends StatelessWidget {
  final String id;
  final int order;
  final String title;
  final int lessonsTotal;
  final int lessonsCompleted;
  final bool isUnlocked;

  const _UnitCard({
    required this.id,
    required this.order,
    required this.title,
    required this.lessonsTotal,
    required this.lessonsCompleted,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    final isComplete = lessonsCompleted >= lessonsTotal;
    final progress =
        lessonsTotal == 0 ? 0.0 : lessonsCompleted / lessonsTotal;

    return GestureDetector(
      onTap: isUnlocked ? () => context.push('/subjects/$id/lessons') : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: !isUnlocked ? const Color(0xFFF8FAFC) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isComplete
                ? EduPlayColors.successGreen
                : !isUnlocked
                    ? const Color(0xFFE2E8F0)
                    : Colors.transparent,
            width: isComplete ? 2 : 1,
          ),
          boxShadow: !isUnlocked
              ? []
              : [
                  BoxShadow(
                    color: EduPlayColors.primaryBlue.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: !isUnlocked
                    ? const Color(0xFFE2E8F0)
                    : isComplete
                        ? EduPlayColors.successGreen
                        : EduPlayColors.primaryBlue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: !isUnlocked
                    ? const Icon(Icons.lock, color: Colors.white, size: 20)
                    : isComplete
                        ? const Icon(Icons.check, color: Colors.white, size: 24)
                        : Text(
                            '$order',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontFamily: 'Nunito',
                            ),
                          ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: !isUnlocked
                          ? EduPlayColors.textMedium
                          : EduPlayColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    !isUnlocked
                        ? 'Completa la unidad anterior primero'
                        : '$lessonsCompleted/$lessonsTotal lecciones',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Nunito',
                      color: !isUnlocked
                          ? EduPlayColors.textMedium
                          : lessonsCompleted > 0
                              ? EduPlayColors.successGreen
                              : EduPlayColors.textMedium,
                    ),
                  ),
                  if (isUnlocked) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: EduPlayColors.backgroundLight,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isComplete
                              ? EduPlayColors.successGreen
                              : EduPlayColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isUnlocked)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: EduPlayColors.textMedium,
              ),
          ],
        ),
      ),
    );
  }
}
