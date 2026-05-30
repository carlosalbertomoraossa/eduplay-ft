// Pantalla de camino de lecciones — estilo Duolingo
// Spec: /specs/domains/learning/spec.md

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/providers/lesson_progress_provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../lesson/data/curriculum_data.dart';

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
class LessonsScreen extends ConsumerWidget {
  final String unitId;
  const LessonsScreen({super.key, required this.unitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(lessonProgressProvider);
    final lessons = CurriculumData.getLessonsForUnit(unitId);
    final unitTitle = CurriculumData.unitTitles[unitId] ?? 'Lecciones';
    final unitDesc = CurriculumData.unitDescriptions[unitId] ?? 'Matemáticas';

    final completedInUnit =
        completed.intersection(lessons.map((l) => l.id).toSet()).length;
    final isUnitComplete = lessons.isNotEmpty && completedInUnit >= lessons.length;

    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      bottomSheet: isUnitComplete
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
              onPressed: () =>
                  context.canPop() ? context.pop() : context.go('/subjects/math/units'),
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
              preferredSize: const Size.fromHeight(52),
              child: _UnitInfoBar(
                description: unitDesc,
                completed: completed,
                lessons: lessons,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (_, constraints) {
                final w = constraints.maxWidth;
                final positions = _nodePositions(w, lessons.length);
                final h = _totalHeight(lessons.length);

                return Container(
                  height: h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F9FF),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
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
                        final isCompleted = completed.contains(lesson.id);
                        final isLocked = i > 0 && !completed.contains(lessons[i - 1].id);
                        final isCurrent = !isCompleted && !isLocked;

                        return Positioned(
                          left: positions[i].dx - _nodeW / 2,
                          top: positions[i].dy - _nodeR - (isCurrent ? _bubbleH : 0),
                          child: SizedBox(
                            width: _nodeW,
                            child: _LessonNode(
                              lesson: lesson,
                              isCompleted: isCompleted,
                              isLocked: isLocked,
                              isCurrent: isCurrent,
                            )
                                .animate(delay: Duration(milliseconds: i * 100))
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
              color: Colors.white.withOpacity(0.22),
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
        _drawSolid(canvas, from, to, EduPlayColors.successGreen.withOpacity(0.75), 7);
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

  const _LessonNode({
    required this.lesson,
    required this.isCompleted,
    required this.isLocked,
    required this.isCurrent,
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
                    color: EduPlayColors.primaryBlue.withOpacity(0.18),
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
                                color: _circleColor.withOpacity(0.5),
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

          Text(
            lesson.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              height: 1.3,
              fontFamily: 'Nunito',
              color: isLocked ? EduPlayColors.textMedium : EduPlayColors.textDark,
            ),
          ),

          if (!isLocked) ...[
            const SizedBox(height: 3),
            Text(
              '⭐ ${lesson.xpReward} XP',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'Nunito',
                color: Color(0xFFB45309),
              ),
            ),
          ],
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
            boxShadow: [
              BoxShadow(
                color: EduPlayColors.energyYellow.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Text(
            '¡JUGAR!',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontFamily: 'Nunito',
              letterSpacing: 0.8,
            ),
          ),
        ),
        CustomPaint(
          painter: _TrianglePainter(EduPlayColors.energyYellow),
          size: const Size(12, 6),
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
              color: Colors.white.withOpacity(0.4),
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
