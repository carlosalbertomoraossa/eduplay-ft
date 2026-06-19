// Pantalla de lección — flujo completo de ejercicios
// UX Spec: /specs/product/ux-children.md
// Spec: /specs/domains/learning/spec.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/ep_button.dart';
import '../../../../../shared/widgets/heart_indicator.dart';
import '../../domain/entities/lesson.dart';
import '../bloc/lesson_bloc.dart';
import '../widgets/exercise_multiple_choice.dart';
import '../widgets/exercise_fill_blank.dart';
import '../widgets/exercise_drag_drop.dart';

class LessonScreen extends StatelessWidget {
  final String lessonId;
  const LessonScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LessonBloc>()..add(LessonStarted(lessonId)),
      child: const _LessonView(),
    );
  }
}

class _LessonView extends StatelessWidget {
  const _LessonView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonBloc, LessonState>(
      listener: (context, state) {
        if (state is LessonCompleted) {
          context.push('/lesson-result', extra: state.result);
        }
      },
      builder: (context, state) {
        return switch (state) {
          LessonLoading() => const _LoadingView(),
          LessonInProgress() => _InProgressView(state: state),
          ExerciseFeedback() => _FeedbackView(state: state),
          LessonFailed() => _FailedView(lesson: state.lesson),
          _ => const _LoadingView(),
        };
      },
    );
  }
}

// ─── Loading ────────────────────────────────────────────────────────
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

// ─── Lección en progreso ────────────────────────────────────────────
class _InProgressView extends StatelessWidget {
  final LessonInProgress state;
  const _InProgressView({required this.state});

  @override
  Widget build(BuildContext context) {
    final exercise = state.currentExercise;
    final total = state.lesson.exercises.length;
    final current = state.currentExerciseIndex + 1;
    final progressValue = current / total;

    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header: progreso y corazones
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  // Cerrar lección
                  IconButton(
                    icon: const Icon(Icons.close, color: EduPlayColors.textMedium),
                    onPressed: () => _confirmExit(context),
                  ),
                  // Barra de progreso
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        minHeight: 12,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          EduPlayColors.primaryBlue,
                        ),
                      ),
                    )
                        .animate(key: ValueKey(current))
                        .custom(
                          duration: 400.ms,
                          builder: (_, v, child) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: (progressValue - (1 / total)) +
                                  v * (1 / total),
                              minHeight: 12,
                              backgroundColor: const Color(0xFFE2E8F0),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                EduPlayColors.primaryBlue,
                              ),
                            ),
                          ),
                        ),
                  ),
                  const SizedBox(width: 12),
                  HeartIndicator(currentHearts: state.heartsRemaining),
                ],
              ),
            ),

            // Contador de ejercicios
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '$current de $total',
                style: const TextStyle(
                  fontSize: 14,
                  color: EduPlayColors.textMedium,
                  fontFamily: 'Nunito',
                ),
              ),
            ),

            // Ejercicio
            Expanded(
              child: _ExerciseWidget(exercise: exercise)
                  .animate(key: ValueKey(exercise.id))
                  .fadeIn(duration: 300.ms)
                  .slideX(begin: 0.05, end: 0),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '¿Salir de la lección?',
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Perderás el progreso de esta lección.',
          style: TextStyle(fontFamily: 'Nunito'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuar', style: TextStyle(fontFamily: 'Nunito')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text(
              'Salir',
              style: TextStyle(
                color: EduPlayColors.softRed,
                fontFamily: 'Nunito',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Widget selector de tipo de ejercicio ──────────────────────────
class _ExerciseWidget extends StatelessWidget {
  final Exercise exercise;
  const _ExerciseWidget({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return switch (exercise.type) {
      ExerciseType.multipleChoice => ExerciseMultipleChoice(exercise: exercise),
      ExerciseType.fillBlank => ExerciseFillBlank(exercise: exercise),
      ExerciseType.dragDrop => ExerciseDragDrop(exercise: exercise),
      _ => _UnsupportedExercise(type: exercise.type),
    };
  }
}

class _UnsupportedExercise extends StatelessWidget {
  final ExerciseType type;
  const _UnsupportedExercise({required this.type});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ejercicio tipo ${type.name} — próximamente',
        style: const TextStyle(fontFamily: 'Nunito', fontSize: 16),
      ),
    );
  }
}

// ─── Feedback de respuesta ──────────────────────────────────────────
class _FeedbackView extends StatelessWidget {
  final ExerciseFeedback state;
  const _FeedbackView({required this.state});

  @override
  Widget build(BuildContext context) {
    final correct = state.wasCorrect;

    return Scaffold(
      backgroundColor: correct
          ? EduPlayColors.successGreen.withOpacity(0.08)
          : EduPlayColors.softRed.withOpacity(0.08),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    correct ? '🎉' : '💪',
                    style: const TextStyle(fontSize: 80),
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        duration: 400.ms,
                        curve: Curves.elasticOut,
                      ),
                  const SizedBox(height: 16),
                  Text(
                    correct ? '¡Correcto!' : '¡Casi! Sigue intentando',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: correct
                          ? EduPlayColors.successGreen
                          : EduPlayColors.softRed,
                      fontFamily: 'Nunito',
                    ),
                  )
                      .animate(delay: 100.ms)
                      .fadeIn(duration: 300.ms),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: EpButton(
                label: state.previousState.isLastExercise
                    ? 'Ver resultado'
                    : 'Continuar',
                onPressed: () {
                  if (state.previousState.isLastExercise) {
                    context.read<LessonBloc>().add(LessonSubmitted());
                  } else {
                    context.read<LessonBloc>().add(NextExercise());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Lección fallida (sin vidas) ────────────────────────────────────
class _FailedView extends StatelessWidget {
  final Lesson lesson;
  const _FailedView({required this.lesson});

  // UX Spec: "¡Necesitas practicar más esto!" (no "Game Over")
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('💪', style: TextStyle(fontSize: 80))
                  .animate()
                  .scale(duration: 500.ms, curve: Curves.elasticOut),

              const SizedBox(height: 24),

              const Text(
                '¡Necesitas practicar\nmás esto!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: EduPlayColors.textDark,
                  fontFamily: 'Nunito',
                ),
              )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 12),

              const Text(
                'Lumi dice: "¡Practiquemos\njuntos de nuevo!"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: EduPlayColors.textMedium,
                  fontFamily: 'Nunito',
                ),
              )
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 48),

              EpButton(
                label: '¡Intentar de nuevo!',
                onPressed: () {
                  context
                      .read<LessonBloc>()
                      .add(LessonStarted(lesson.id));
                },
              ),

              const SizedBox(height: 12),

              EpButton(
                label: 'Ir al inicio',
                variant: EpButtonVariant.secondary,
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
