// Pantalla de unidades de una materia
// Spec: ../.sdd/implemented/features/domain-learning/technical-specs.md

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
          final description = CurriculumData.unitDescriptions[unitId];
          final period = CurriculumData.getUnitPeriod(unitId);
          final prevPeriod =
              i > 0 ? CurriculumData.getUnitPeriod(unitIds[i - 1]) : null;
          final showPeriodHeader = period != prevPeriod;
          final lessonsTotal = CurriculumData.getLessonsForUnit(unitId).length;
          final lessonsCompleted = _completedCount(unitId, completed);
          final unlocked = _isUnlocked(i, unitIds, completed);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showPeriodHeader)
                _PeriodHeader(
                  period: period,
                  isFirst: i == 0,
                ),
              _UnitCard(
                id: unitId,
                order: i + 1,
                period: period,
                title: title,
                description: description,
                lessonsTotal: lessonsTotal,
                lessonsCompleted: lessonsCompleted,
                isUnlocked: unlocked,
              ),
            ],
          )
              .animate(delay: Duration(milliseconds: i * 60))
              .fadeIn(duration: 350.ms)
              .slideX(begin: 0.1, end: 0);
        },
      ),
    );
  }
}

class _PeriodHeader extends StatelessWidget {
  final int period;
  final bool isFirst;

  const _PeriodHeader({
    required this.period,
    required this.isFirst,
  });

  static const _periodLabels = {
    1: 'Período 1 · Primer Bimestre',
    2: 'Período 2 · Segundo Bimestre',
    3: 'Período 3 · Tercer Bimestre',
    4: 'Período 4 · Cuarto Bimestre',
  };

  static const _periodColors = {
    1: Color(0xFF3B82F6),
    2: Color(0xFF8B5CF6),
    3: Color(0xFF10B981),
    4: Color(0xFFF59E0B),
  };

  @override
  Widget build(BuildContext context) {
    final color = _periodColors[period] ?? EduPlayColors.primaryBlue;
    final label = _periodLabels[period] ?? 'Período $period';

    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : 12, bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_month_rounded, size: 16, color: color),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: color,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Divider(
              color: color.withValues(alpha: 0.2),
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitCard extends StatelessWidget {
  final String id;
  final int order;
  final int period;
  final String title;
  final String? description;
  final int lessonsTotal;
  final int lessonsCompleted;
  final bool isUnlocked;

  const _UnitCard({
    required this.id,
    required this.order,
    required this.period,
    required this.title,
    this.description,
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
                  if (description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      description!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: EduPlayColors.textMedium,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
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
