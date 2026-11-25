// Pantalla de unidades de una materia
// Spec: ../.sdd/implemented/features/domain-learning/technical-specs.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/colombia_calendar_provider.dart';
import '../../../../../core/providers/lesson_progress_provider.dart';
import '../../../../../core/providers/selected_grade_provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/playful_world_background.dart';
import '../../../lesson/data/curriculum_data.dart';

int _completedCount(String unitId, Set<String> completed) =>
    completed.intersection(CurriculumData.getLessonIdsForUnit(unitId)).length;

bool _isUnlocked(int index, List<String> unitIds, Set<String> completed) {
  if (index == 0) return true;
  final prevId = unitIds[index - 1];
  final prevTotal = CurriculumData.getLessonsForUnit(prevId).length;
  return _completedCount(prevId, completed) >= prevTotal;
}

class UnitsScreen extends ConsumerStatefulWidget {
  final String subjectCode;
  const UnitsScreen({super.key, required this.subjectCode});

  @override
  ConsumerState<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends ConsumerState<UnitsScreen> {
  int _selectedPeriodFilter = 0; // 0 = Todos, 1..4 = Período 1..4

  @override
  Widget build(BuildContext context) {
    final completed = ref.watch(lessonProgressProvider);
    final grade = ref.watch(selectedGradeProvider);
    final calendar = ref.watch(colombiaCalendarProvider);
    final currentPeriod = calendar.activePeriod();
    final allUnitIds = CurriculumData.getUnitIdsForGrade(grade);
    final visibleEntries = <(int globalIdx, String unitId)>[
      for (int i = 0; i < allUnitIds.length; i++)
        if (_selectedPeriodFilter == 0 ||
            CurriculumData.getUnitPeriod(allUnitIds[i]) ==
                _selectedPeriodFilter)
          (i, allUnitIds[i]),
    ];

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
      body: PlayfulWorldBackground(
        theme: PlayfulWorldBackground.fromPeriod(
          _selectedPeriodFilter == 0 ? 1 : _selectedPeriodFilter,
        ),
        child: Column(
          children: [
            // Selector rápido de Período (1 a 4) alineado al calendario escolar Colombia
            Container(
              color: Colors.white.withValues(alpha: 0.90),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('🇨🇴', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Cronograma activo: ${calendar.summaryLabel()}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0369A1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final p in [0, 1, 2, 3, 4])
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedPeriodFilter = p),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedPeriodFilter == p
                                      ? EduPlayColors.primaryBlue
                                      : (p == currentPeriod
                                          ? const Color(0xFFFEF9C3)
                                          : Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: p == currentPeriod
                                        ? const Color(0xFFF59E0B)
                                        : EduPlayColors.primaryBlue
                                            .withValues(alpha: 0.35),
                                    width: p == currentPeriod ? 1.8 : 1.2,
                                  ),
                                ),
                                child: Text(
                                  p == 0
                                      ? '📅 Todos'
                                      : (p == currentPeriod
                                          ? '📍 Período $p (Hoy)'
                                          : '🌟 Período $p'),
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: _selectedPeriodFilter == p
                                        ? Colors.white
                                        : EduPlayColors.textDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: visibleEntries.length,
                itemBuilder: (_, idx) {
                  final entry = visibleEntries[idx];
                  final globalIdx = entry.$1;
                  final unitId = entry.$2;
                  final title = CurriculumData.unitTitles[unitId] ?? unitId;
                  final description = CurriculumData.unitDescriptions[unitId];
                  final period = CurriculumData.getUnitPeriod(unitId);
                  final prevPeriod = idx > 0
                      ? CurriculumData.getUnitPeriod(visibleEntries[idx - 1].$2)
                      : null;
                  final showPeriodHeader = period != prevPeriod;
                  final lessonsTotal =
                      CurriculumData.getLessonsForUnit(unitId).length;
                  final lessonsCompleted = _completedCount(unitId, completed);
                  final unlocked = _isUnlocked(globalIdx, allUnitIds, completed);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showPeriodHeader)
                        _PeriodHeader(
                          period: period,
                          isFirst: idx == 0,
                        ),
                      _UnitCard(
                        id: unitId,
                        order: globalIdx + 1,
                        period: period,
                        title: title,
                        description: description,
                        lessonsTotal: lessonsTotal,
                        lessonsCompleted: lessonsCompleted,
                        isUnlocked: unlocked,
                      ),
                    ],
                  )
                      .animate(delay: Duration(milliseconds: idx * 60))
                      .fadeIn(duration: 350.ms)
                      .slideX(begin: 0.1, end: 0);
                },
              ),
            ),
          ],
        ),
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
    final borderAccent = isComplete
        ? EduPlayColors.successGreen
        : !isUnlocked
            ? const Color(0xFFCBD5E1)
            : const Color(0xFF60A5FA);

    return Playful3DCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      borderColor: borderAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.push(
              isUnlocked
                  ? '/subjects/$id/lessons'
                  : '/subjects/$id/lessons?zone=prep',
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: !isUnlocked
                        ? const Color(0xFF94A3B8)
                        : isComplete
                            ? EduPlayColors.successGreen
                            : EduPlayColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: !isUnlocked
                        ? const Icon(
                            Icons.menu_book_rounded,
                            color: Colors.white,
                            size: 22,
                          )
                        : isComplete
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24,
                              )
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
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: EduPlayColors.textDark,
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
                            ? '📖 Temario abierto · Completa la unidad anterior para los retos'
                            : '$lessonsCompleted/$lessonsTotal ejercicios completados',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          color: !isUnlocked
                              ? const Color(0xFFD97706)
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
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Botones de las 2 zonas de la sección: Zona de Preparación y Zona de Ejercicios
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      context.push('/subjects/$id/lessons?zone=prep'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFB45309),
                    backgroundColor: const Color(0xFFFFFBEB),
                    side: const BorderSide(
                      color: Color(0xFFF59E0B),
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Text('📖', style: TextStyle(fontSize: 15)),
                  label: const Text(
                    'Preparación',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: isUnlocked
                      ? () => context.push('/subjects/$id/lessons')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isComplete
                        ? EduPlayColors.successGreen
                        : EduPlayColors.primaryBlue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFE2E8F0),
                    disabledForegroundColor: const Color(0xFF94A3B8),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Text(
                    isUnlocked ? '🎯' : '🔒',
                    style: const TextStyle(fontSize: 15),
                  ),
                  label: const Text(
                    'Ejercicios',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
