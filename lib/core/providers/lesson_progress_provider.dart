import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _completedLessonsKey = 'completed_lessons';

final lessonProgressProvider =
    StateNotifierProvider<LessonProgressNotifier, Set<String>>(
  (ref) => LessonProgressNotifier(),
);

class LessonProgressNotifier extends StateNotifier<Set<String>> {
  final SharedPreferences? _prefs;

  LessonProgressNotifier([this._prefs]) : super(_load(_prefs));

  static Set<String> _load(SharedPreferences? prefs) {
    if (prefs == null) return const {};
    final list = prefs.getStringList(_completedLessonsKey);
    return list != null ? list.toSet() : const {};
  }

  void completeLesson(String lessonId) {
    if (state.contains(lessonId)) return;
    final updated = {...state, lessonId};
    state = updated;
    _prefs?.setStringList(_completedLessonsKey, updated.toList());
  }
}
