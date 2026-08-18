import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _key = 'selected_grade';
const _defaultGrade = 1;

final selectedGradeProvider =
    StateNotifierProvider<SelectedGradeNotifier, int>(
  (ref) => throw UnimplementedError('Call configureSelectedGrade() first'),
);

class SelectedGradeNotifier extends StateNotifier<int> {
  final SharedPreferences _prefs;

  SelectedGradeNotifier(this._prefs) : super(_loadGrade(_prefs));

  static int _loadGrade(SharedPreferences prefs) =>
      prefs.getInt(_key) ?? _defaultGrade;

  void setGrade(int grade) {
    state = grade;
    _prefs.setInt(_key, grade);
  }
}

SelectedGradeNotifier configureSelectedGrade(SharedPreferences prefs) =>
    SelectedGradeNotifier(prefs);
