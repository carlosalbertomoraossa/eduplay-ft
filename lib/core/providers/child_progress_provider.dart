import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _xpKey = 'child_total_xp';
const _coinsKey = 'child_coins';
const _starsKey = 'child_stars';
const _streakKey = 'child_streak_days';
const _shieldsKey = 'child_streak_shields';
const _lastActiveDateKey = 'child_last_active_date';
const _weeklyDaysKey = 'child_weekly_active_days';
const _stampsKey = 'child_unlocked_stamps';

const int _xpPerLevel = 200;
const int _weeklyGoalTarget = 4;

String formatIsoDate(DateTime date) {
  final y = date.year.toString().padLeft(4, '0');
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

DateTime startOfWeekMonday(DateTime date) {
  final normalized = DateTime(date.year, date.month, date.day);
  return normalized.subtract(Duration(days: normalized.weekday - 1));
}

/// Progreso real y economía unificada del niño (lecciones + juego + misiones).
/// Implementa hábito saludable: meta flexible de 4 días/semana + escudos de racha.
class ChildProgressState {
  final int totalXp;
  final int coins;
  final int stars;
  final int streakDays;
  final int streakShields;
  final String? lastActiveDate;
  final Set<String> activeDates;
  final Set<String> unlockedStamps;

  const ChildProgressState({
    this.totalXp = 120,
    this.coins = 60,
    this.stars = 6,
    this.streakDays = 1,
    this.streakShields = 1,
    this.lastActiveDate,
    this.activeDates = const {},
    this.unlockedStamps = const {},
  });

  int get level => (totalXp ~/ _xpPerLevel) + 1;
  int get xpIntoCurrentLevel => totalXp % _xpPerLevel;
  int get xpToNextLevel => _xpPerLevel;
  int get weeklyGoalDays => _weeklyGoalTarget;

  String get levelTitle {
    if (level >= 10) return 'Maestro del Cuaderno';
    if (level >= 6) return 'Guardián de Números';
    if (level >= 3) return 'Aventurero del Saber';
    return 'Explorador Curioso';
  }

  bool hasActivityOn(DateTime date) => activeDates.contains(formatIsoDate(date));

  int activeDaysInWeek([DateTime? now]) {
    final monday = startOfWeekMonday(now ?? DateTime.now());
    var count = 0;
    for (var i = 0; i < 7; i++) {
      final day = monday.add(Duration(days: i));
      if (activeDates.contains(formatIsoDate(day))) count++;
    }
    return count;
  }

  List<bool> weekActivityPattern([DateTime? now]) {
    final monday = startOfWeekMonday(now ?? DateTime.now());
    return List.generate(
      7,
      (i) => activeDates.contains(formatIsoDate(monday.add(Duration(days: i)))),
    );
  }

  ChildProgressState copyWith({
    int? totalXp,
    int? coins,
    int? stars,
    int? streakDays,
    int? streakShields,
    String? lastActiveDate,
    Set<String>? activeDates,
    Set<String>? unlockedStamps,
  }) {
    return ChildProgressState(
      totalXp: totalXp ?? this.totalXp,
      coins: coins ?? this.coins,
      stars: stars ?? this.stars,
      streakDays: streakDays ?? this.streakDays,
      streakShields: streakShields ?? this.streakShields,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      activeDates: activeDates ?? this.activeDates,
      unlockedStamps: unlockedStamps ?? this.unlockedStamps,
    );
  }
}

final childProgressProvider =
    StateNotifierProvider<ChildProgressNotifier, ChildProgressState>(
  (ref) => ChildProgressNotifier(),
);

class ChildProgressNotifier extends StateNotifier<ChildProgressState> {
  final SharedPreferences? _prefs;

  ChildProgressNotifier([this._prefs]) : super(_load(_prefs));

  static ChildProgressState _load(SharedPreferences? prefs) {
    if (prefs == null) return const ChildProgressState();
    return ChildProgressState(
      totalXp: prefs.getInt(_xpKey) ?? 120,
      coins: prefs.getInt(_coinsKey) ?? 60,
      stars: prefs.getInt(_starsKey) ?? 6,
      streakDays: prefs.getInt(_streakKey) ?? 1,
      streakShields: prefs.getInt(_shieldsKey) ?? 1,
      lastActiveDate: prefs.getString(_lastActiveDateKey),
      activeDates: (prefs.getStringList(_weeklyDaysKey) ?? const []).toSet(),
      unlockedStamps: (prefs.getStringList(_stampsKey) ?? const []).toSet(),
    );
  }

  void _persist(ChildProgressState next) {
    state = next;
    _prefs?.setInt(_xpKey, next.totalXp);
    _prefs?.setInt(_coinsKey, next.coins);
    _prefs?.setInt(_starsKey, next.stars);
    _prefs?.setInt(_streakKey, next.streakDays);
    _prefs?.setInt(_shieldsKey, next.streakShields);
    if (next.lastActiveDate != null) {
      _prefs?.setString(_lastActiveDateKey, next.lastActiveDate!);
    }
    _prefs?.setStringList(_weeklyDaysKey, next.activeDates.toList());
    _prefs?.setStringList(_stampsKey, next.unlockedStamps.toList());
  }

  /// Registra actividad hoy con lógica saludable: si faltó 1 día y tiene escudo,
  /// consume 1 escudo en vez de borrarle la racha; al cumplir 4 días/semana gana +1 escudo.
  void registerActivity({DateTime? now}) {
    final today = now ?? DateTime.now();
    final todayKey = formatIsoDate(today);
    if (state.activeDates.contains(todayKey) && state.lastActiveDate == todayKey) {
      return;
    }

    var nextStreak = state.streakDays;
    var nextShields = state.streakShields;

    if (state.lastActiveDate == null) {
      nextStreak = nextStreak < 1 ? 1 : nextStreak;
    } else if (state.lastActiveDate != todayKey) {
      final prev = DateTime.tryParse(state.lastActiveDate!);
      if (prev != null) {
        final diffDays = DateTime(today.year, today.month, today.day)
            .difference(DateTime(prev.year, prev.month, prev.day))
            .inDays;
        if (diffDays == 1) {
          nextStreak += 1;
        } else if (diffDays == 2 && nextShields > 0) {
          // Escudo de racha protege al niño de perder su progreso por 1 día de descanso
          nextShields -= 1;
          nextStreak += 1;
        } else if (diffDays > 1) {
          nextStreak = 1;
        }
      }
    }

    // Conserva fechas recientes (últimos 21 días)
    final cutoff = today.subtract(const Duration(days: 21));
    final updatedDates = <String>{
      for (final d in state.activeDates)
        if ((DateTime.tryParse(d) ?? today).isAfter(cutoff)) d,
      todayKey,
    };

    final prevWeekCount = state.activeDaysInWeek(today);
    final candidate = state.copyWith(
      streakDays: nextStreak,
      streakShields: nextShields,
      lastActiveDate: todayKey,
      activeDates: updatedDates,
    );
    final newWeekCount = candidate.activeDaysInWeek(today);
    if (prevWeekCount < _weeklyGoalTarget &&
        newWeekCount >= _weeklyGoalTarget &&
        candidate.streakShields < 3) {
      _persist(candidate.copyWith(streakShields: candidate.streakShields + 1));
    } else {
      _persist(candidate);
    }
  }

  void recordLessonCompleted({
    required int xpEarned,
    required int coinsEarned,
    int starsEarned = 1,
    String? unitStampId,
    DateTime? now,
  }) {
    registerActivity(now: now);
    final nextStamps = unitStampId != null
        ? {...state.unlockedStamps, unitStampId}
        : state.unlockedStamps;
    _persist(state.copyWith(
      totalXp: state.totalXp + xpEarned,
      coins: state.coins + coinsEarned,
      stars: state.stars + starsEarned,
      unlockedStamps: nextStamps,
    ));
  }

  void recordGameCompleted({
    required int xpEarned,
    required int coinsEarned,
    required int starsEarned,
    String? chapterStampId,
    DateTime? now,
  }) {
    registerActivity(now: now);
    final nextStamps = chapterStampId != null
        ? {...state.unlockedStamps, chapterStampId}
        : state.unlockedStamps;
    _persist(state.copyWith(
      totalXp: state.totalXp + xpEarned,
      coins: state.coins + coinsEarned,
      stars: state.stars + starsEarned,
      unlockedStamps: nextStamps,
    ));
  }

  void addReward({int xp = 0, int coins = 0, int stars = 0}) {
    _persist(state.copyWith(
      totalXp: state.totalXp + xp,
      coins: state.coins + coins,
      stars: state.stars + stars,
    ));
  }

  bool spendCoins(int amount) {
    if (amount <= 0) return true;
    if (state.coins < amount) return false;
    _persist(state.copyWith(coins: state.coins - amount));
    return true;
  }
}
