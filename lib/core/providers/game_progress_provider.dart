import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _unlockedLevelKey = 'g4_unlocked_level';
const _starsPrefix = 'g4_stars_level_';
const _scorePrefix = 'g4_score_level_';

class GameProgressState {
  final int unlockedLevel;
  final Map<int, int> starsByLevel;
  final Map<int, int> bestScoreByLevel;

  const GameProgressState({
    this.unlockedLevel = 1,
    this.starsByLevel = const {},
    this.bestScoreByLevel = const {},
  });

  int starsFor(int level) => starsByLevel[level] ?? 0;
  int bestScoreFor(int level) => bestScoreByLevel[level] ?? 0;
  bool isUnlocked(int level) => level <= unlockedLevel;
}

final gameProgressProvider =
    StateNotifierProvider<GameProgressNotifier, GameProgressState>(
  (ref) => GameProgressNotifier(),
);

class GameProgressNotifier extends StateNotifier<GameProgressState> {
  final SharedPreferences? _prefs;

  GameProgressNotifier([this._prefs]) : super(_load(_prefs));

  static GameProgressState _load(SharedPreferences? prefs) {
    if (prefs == null) return const GameProgressState();
    final unlocked = prefs.getInt(_unlockedLevelKey) ?? 1;
    final stars = <int, int>{};
    final scores = <int, int>{};
    for (var level = 1; level <= 8; level++) {
      final s = prefs.getInt('$_starsPrefix$level');
      if (s != null) stars[level] = s;
      final sc = prefs.getInt('$_scorePrefix$level');
      if (sc != null) scores[level] = sc;
    }
    return GameProgressState(
      unlockedLevel: unlocked,
      starsByLevel: stars,
      bestScoreByLevel: scores,
    );
  }

  void recordLevelCompleted({
    required int level,
    required int score,
    required double accuracy,
  }) {
    final earnedStars = accuracy >= 0.9
        ? 3
        : accuracy >= 0.7
            ? 2
            : 1;
    final prevStars = state.starsFor(level);
    final newStars = earnedStars > prevStars ? earnedStars : prevStars;

    final prevScore = state.bestScoreFor(level);
    final newScore = score > prevScore ? score : prevScore;

    final nextUnlocked =
        (level < 8 && level + 1 > state.unlockedLevel) ? level + 1 : state.unlockedLevel;

    final updatedStars = {...state.starsByLevel, level: newStars};
    final updatedScores = {...state.bestScoreByLevel, level: newScore};

    state = GameProgressState(
      unlockedLevel: nextUnlocked,
      starsByLevel: updatedStars,
      bestScoreByLevel: updatedScores,
    );

    _prefs?.setInt(_unlockedLevelKey, nextUnlocked);
    _prefs?.setInt('$_starsPrefix$level', newStars);
    _prefs?.setInt('$_scorePrefix$level', newScore);
  }
}
