// Pantalla de camino de lecciones — estilo Duolingo
// Spec: ../.sdd/implemented/features/domain-learning/technical-specs.md

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/lesson_progress_provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/lumi_lion_mascot.dart';
import '../../../../../shared/widgets/playful_world_background.dart';
import '../../../lesson/data/curriculum_data.dart';
import '../widgets/unit_prep_zone.dart';

// ─── Layout constants ──────────────────────────────────────────────
const double _bubbleH   = 52.0;
const double _nodeR     = 36.0;
const double _nodeW     = 120.0;
const double _topPad    = 32.0;
const double _vSpacing  = 160.0;
const double _botPad    = 80.0;

double _totalHeight(int count) =>
    _topPad + _bubbleH + _nodeR + (count - 1) * _vSpacing + _nodeR + 64 + _botPad;

List<Offset> _nodePositions(double width, int count) {
  const y0 = _topPad + _bubbleH + _nodeR;
  final rx = width * 0.72;
  final lx = width * 0.28;
  return List.generate(
    count,
    (i) => Offset(i.isEven ? rx : lx, y0 + i * _vSpacing),
  );
}

// ─── Screen ────────────────────────────────────────────────────────
class LessonsScreen extends ConsumerStatefulWidget {
  final String unitId;
  final bool initialPrepZone;

  const LessonsScreen({
    super.key,
    required this.unitId,
    this.initialPrepZone = false,
  });

  @override
  ConsumerState<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends ConsumerState<LessonsScreen> {
  late bool _inPrepZone;
  int _selectedPrepLessonIdx = 0;

  @override
  void initState() {
    super.initState();
    _inPrepZone = widget.initialPrepZone;
  }

  @override
  void didUpdateWidget(covariant LessonsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.unitId != widget.unitId ||
        oldWidget.initialPrepZone != widget.initialPrepZone) {
      _inPrepZone = widget.initialPrepZone;
      _selectedPrepLessonIdx = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final completed = ref.watch(lessonProgressProvider);
    final lessons = CurriculumData.getLessonsForUnit(widget.unitId);
    final unitTitle = CurriculumData.unitTitles[widget.unitId] ?? 'Lecciones';
    final unitDesc =
        CurriculumData.unitDescriptions[widget.unitId] ?? 'Matemáticas';

    final completedInUnit =
        completed.intersection(lessons.map((l) => l.id).toSet()).length;
    final isUnitComplete =
        lessons.isNotEmpty && completedInUnit >= lessons.length;

    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      bottomSheet: (!_inPrepZone && isUnitComplete)
          ? _UnitCompleteBanner(onContinue: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/subjects/math/units');
              }
            })
          : null,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF1CB0F6),
            foregroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => context.canPop()
                  ? context.pop()
                  : context.go('/subjects/math/units'),
            ),
            title: Text(
              unitTitle,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(98),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _UnitInfoBar(
                    description: unitDesc,
                    completed: completed,
                    lessons: lessons,
                  ),
                  // Selector de las dos zonas: Preparación vs Ejercicios
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _inPrepZone = true),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: _inPrepZone
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '📖 Zona de Preparación',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: _inPrepZone
                                        ? const Color(0xFF1E3A8A)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _inPrepZone = false),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: !_inPrepZone
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '🎯 Zona de Ejercicios (${lessons.length})',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: !_inPrepZone
                                        ? const Color(0xFF1E3A8A)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_inPrepZone)
            SliverToBoxAdapter(
              child: UnitPrepZone(
                unitId: widget.unitId,
                initialLessonIdx: _selectedPrepLessonIdx,
                onStartExercises: () => setState(() => _inPrepZone = false),
              ),
            )
          else
            SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  final w = constraints.maxWidth;
                  final positions = _nodePositions(w, lessons.length);
                  final h = _totalHeight(lessons.length);

                  return ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(28)),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: AdventureMapLandscapePainter(
                              nodeCount: lessons.length,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                        // Tarjeta rápida para ir a prepararse con Lumi antes de los ejercicios
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                          child: GestureDetector(
                            onTap: () => setState(() => _inPrepZone = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFF59E0B),
                                  width: 1.5,
                                ),
                              ),
                              child: const Row(
                                children: [
                                  LumiLionMascot(size: 46, expressionVariant: 1),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '🦁 ¿Quieres repasar el temario con Lumi antes de jugar?',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFF92400E),
                                          ),
                                        ),
                                        Text(
                                          'Toca aquí para jugar con Lumi el Leoncito, tablitas y la Mesa Interactiva',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFFB45309),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                    color: Color(0xFFB45309),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CustomPaint(
                                size: Size(w, h),
                                painter: _PathPainter(
                                  positions: positions,
                                  completed: completed,
                                  lessons: lessons,
                                ),
                              ),
                              ...List.generate(lessons.length, (i) {
                                final lesson = lessons[i];
                                final isCompleted =
                                    completed.contains(lesson.id);
                                final isLocked = i > 0 &&
                                    !completed.contains(lessons[i - 1].id);
                                final isCurrent = !isCompleted && !isLocked;

                                return Positioned(
                                  left: positions[i].dx - _nodeW / 2,
                                  top: positions[i].dy -
                                      _nodeR -
                                      (isCurrent ? _bubbleH : 0),
                                  child: SizedBox(
                                    width: _nodeW,
                                    child: _LessonNode(
                                      lesson: lesson,
                                      isCompleted: isCompleted,
                                      isLocked: isLocked,
                                      isCurrent: isCurrent,
                                      onOpenPrep: () => setState(() {
                                        _selectedPrepLessonIdx = i;
                                        _inPrepZone = true;
                                      }),
                                    )
                                        .animate(
                                          delay: Duration(milliseconds: i * 100),
                                        )
                                        .fadeIn(duration: 350.ms)
                                        .scale(
                                          begin: const Offset(0.85, 0.85),
                                          end: const Offset(1, 1),
                                          duration: 350.ms,
                                        ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Header bar ────────────────────────────────────────────────────
class _UnitInfoBar extends StatelessWidget {
  final String description;
  final Set<String> completed;
  final List<LessonSummary> lessons;

  const _UnitInfoBar({
    required this.description,
    required this.completed,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    final count = lessons.where((l) => completed.contains(l.id)).length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          const Text('🔢', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count / ${lessons.length}',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Path painter ──────────────────────────────────────────────────
class _PathPainter extends CustomPainter {
  final List<Offset> positions;
  final Set<String> completed;
  final List<LessonSummary> lessons;

  const _PathPainter({
    required this.positions,
    required this.completed,
    required this.lessons,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < positions.length - 1; i++) {
      final from = positions[i];
      final to = positions[i + 1];
      final isActive = completed.contains(lessons[i].id);

      if (isActive) {
        _drawSolid(canvas, from, to, EduPlayColors.successGreen.withValues(alpha: 0.75), 7);
      } else {
        _drawDashed(canvas, from, to, const Color(0xFFCBD5E1), 6);
      }
    }
  }

  Path _bezier(Offset from, Offset to) {
    final midY = (from.dy + to.dy) / 2;
    return Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(from.dx, midY, to.dx, midY, to.dx, to.dy);
  }

  void _drawSolid(Canvas canvas, Offset from, Offset to, Color color, double w) {
    canvas.drawPath(
      _bezier(from, to),
      Paint()
        ..color = color
        ..strokeWidth = w
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawDashed(Canvas canvas, Offset from, Offset to, Color color, double w) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = w
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final metrics = _bezier(from, to).computeMetrics().first;
    const dash = 10.0;
    const gap = 7.0;
    var d = 0.0;
    while (d < metrics.length) {
      canvas.drawPath(
        metrics.extractPath(d, math.min(d + dash, metrics.length)),
        paint,
      );
      d += dash + gap;
    }
  }

  @override
  bool shouldRepaint(_PathPainter old) => old.completed != completed;
}

// ─── Lesson node ───────────────────────────────────────────────────
class _LessonNode extends StatelessWidget {
  final LessonSummary lesson;
  final bool isCompleted;
  final bool isLocked;
  final bool isCurrent;
  final VoidCallback onOpenPrep;

  const _LessonNode({
    required this.lesson,
    required this.isCompleted,
    required this.isLocked,
    required this.isCurrent,
    required this.onOpenPrep,
  });

  Color get _circleColor => isCompleted
      ? EduPlayColors.successGreen
      : isLocked
          ? const Color(0xFFE2E8F0)
          : EduPlayColors.primaryBlue;

  Color get _shadowColor => isCompleted
      ? const Color(0xFF15803D)
      : const Color(0xFF1D4ED8);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : () => context.push('/lessons/${lesson.id}'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCurrent) _BouncingBadge(),

          Stack(
            alignment: Alignment.center,
            children: [
              if (isCurrent)
                Container(
                  width: _nodeR * 2 + 18,
                  height: _nodeR * 2 + 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: EduPlayColors.primaryBlue.withValues(alpha: 0.18),
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.18, 1.18),
                      duration: 900.ms,
                      curve: Curves.easeInOut,
                    ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: _nodeR * 2,
                    height: _nodeR * 2 - 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _circleColor,
                      boxShadow: isLocked
                          ? null
                          : [
                              BoxShadow(
                                color: _circleColor.withValues(alpha: 0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                    ),
                    child: Center(child: _icon()),
                  ),
                  if (!isLocked)
                    Container(
                      width: _nodeR * 2 - 10,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(100),
                        ),
                        color: _shadowColor,
                      ),
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isLocked
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFF93C5FD),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lesson.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                    fontFamily: 'Nunito',
                    color: isLocked
                        ? const Color(0xFF475569)
                        : const Color(0xFF0F172A),
                  ),
                ),
                if (!isLocked) ...[
                  const SizedBox(height: 2),
                  Text(
                    '⭐ ${lesson.xpReward} XP',
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nunito',
                      color: Color(0xFF92400E),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onOpenPrep,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF8B5CF6)),
              ),
              child: const Text(
                '📖 Explicación',
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  color: Color(0xFF5B21B6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    if (isCompleted) {
      return const Icon(Icons.star_rounded, color: Colors.white, size: 30);
    }
    if (isLocked) {
      return const Icon(Icons.lock_rounded, color: Color(0xFF94A3B8), size: 24);
    }
    return Text(
      '${lesson.order}',
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        fontFamily: 'Nunito',
      ),
    );
  }
}

// ─── Bouncing badge ────────────────────────────────────────────────
class _BouncingBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: EduPlayColors.energyYellow,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFD97706),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: EduPlayColors.energyYellow.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🦁 ', style: TextStyle(fontSize: 12)),
              Text(
                '¡JUGAR!',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF78350F),
                  fontFamily: 'Nunito',
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        const CustomPaint(
          painter: _TrianglePainter(EduPlayColors.energyYellow),
          size: Size(12, 6),
        ),
        const SizedBox(height: 2),
      ],
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -5, duration: 700.ms, curve: Curves.easeInOut);
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  const _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(size.width, 0)
        ..close(),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── Banner de unidad completada ───────────────────────────────────
class _UnitCompleteBanner extends StatelessWidget {
  final VoidCallback onContinue;
  const _UnitCompleteBanner({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF16A34A), Color(0xFF22C55E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(color: Color(0x3316A34A), blurRadius: 16, offset: Offset(0, -4)),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40, height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text('🏆', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 10),
          const Text(
            '¡Unidad completada!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '¡Completaste todos los temas de esta unidad!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: EduPlayColors.successGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                '¡Ver mis materias!',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .slideY(begin: 0.4, end: 0, duration: 500.ms, curve: Curves.easeOut)
        .fadeIn(duration: 400.ms);
  }
}
