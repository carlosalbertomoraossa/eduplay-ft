import 'package:flutter_riverpod/flutter_riverpod.dart';

final lessonProgressProvider =
    StateNotifierProvider<LessonProgressNotifier, Set<String>>(
  (ref) => LessonProgressNotifier(),
);

class LessonProgressNotifier extends StateNotifier<Set<String>> {
  LessonProgressNotifier() : super(const {});

  void completeLesson(String lessonId) => state = {...state, lessonId};
}
