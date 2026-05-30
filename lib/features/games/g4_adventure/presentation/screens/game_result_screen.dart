// Spec: specs/games/g4-adventure-plan.md Fase 5 §5.1

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/lesson_progress_provider.dart';
import '../../../../lesson/presentation/screens/lesson_result_screen.dart';
import '../../domain/entities/game_result.dart';

/// Pantalla de resultado final del juego.
///
/// Convierte [GameResult] a [LessonResult] y reutiliza [LessonResultScreen]
/// para mostrar XP, monedas y precisión con la misma UX que las lecciones
/// normales. Registra el progreso en [lessonProgressProvider] si ≥ 70%.
class GameResultScreen extends ConsumerWidget {
  final GameResult result;

  const GameResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonResult = result.toLessonResult();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (lessonResult.isCompleted) {
        ref
            .read(lessonProgressProvider.notifier)
            .completeLesson(lessonResult.lessonId);
      }
    });

    return LessonResultScreen(result: lessonResult);
  }
}
