import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'child_progress_provider.dart';

const _questsDateKey = 'daily_quests_date';
const _questsDataKey = 'daily_quests_payload';

enum DailyQuestType {
  schoolLesson,
  gameChallenges,
  collectStars,
}

/// Micro-misión diaria pensada para sesiones cortas de 3–5 minutos (Generación Alfa).
class DailyQuest {
  final String id;
  final DailyQuestType type;
  final String title;
  final String subtitle;
  final String emoji;
  final int target;
  final int progress;
  final int coinReward;
  final int xpReward;
  final bool claimed;

  const DailyQuest({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.target,
    this.progress = 0,
    required this.coinReward,
    required this.xpReward,
    this.claimed = false,
  });

  bool get isCompleted => progress >= target;
  bool get canClaim => isCompleted && !claimed;
  double get ratio => target > 0 ? (progress / target).clamp(0.0, 1.0) : 0.0;

  DailyQuest copyWith({int? progress, bool? claimed}) {
    return DailyQuest(
      id: id,
      type: type,
      title: title,
      subtitle: subtitle,
      emoji: emoji,
      target: target,
      progress: progress ?? this.progress,
      coinReward: coinReward,
      xpReward: xpReward,
      claimed: claimed ?? this.claimed,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'title': title,
        'subtitle': subtitle,
        'emoji': emoji,
        'target': target,
        'progress': progress,
        'coinReward': coinReward,
        'xpReward': xpReward,
        'claimed': claimed,
      };

  static DailyQuest fromJson(Map<String, dynamic> map) {
    final typeName = map['type'] as String? ?? 'schoolLesson';
    final type = DailyQuestType.values.firstWhere(
      (e) => e.name == typeName,
      orElse: () => DailyQuestType.schoolLesson,
    );
    return DailyQuest(
      id: map['id'] as String? ?? 'q',
      type: type,
      title: map['title'] as String? ?? '',
      subtitle: map['subtitle'] as String? ?? '',
      emoji: map['emoji'] as String? ?? '🎯',
      target: map['target'] as int? ?? 1,
      progress: map['progress'] as int? ?? 0,
      coinReward: map['coinReward'] as int? ?? 25,
      xpReward: map['xpReward'] as int? ?? 30,
      claimed: map['claimed'] as bool? ?? false,
    );
  }
}

class DailyQuestsState {
  final String dateKey;
  final List<DailyQuest> quests;

  const DailyQuestsState({
    required this.dateKey,
    required this.quests,
  });

  int get completedCount => quests.where((q) => q.isCompleted).length;
  int get claimableCount => quests.where((q) => q.canClaim).length;
}

final dailyQuestsProvider =
    StateNotifierProvider<DailyQuestsNotifier, DailyQuestsState>(
  (ref) => DailyQuestsNotifier(),
);

class DailyQuestsNotifier extends StateNotifier<DailyQuestsState> {
  final SharedPreferences? _prefs;

  DailyQuestsNotifier([this._prefs, DateTime? now])
      : super(_loadOrCreate(_prefs, now ?? DateTime.now()));

  static List<DailyQuest> _defaultQuestsForToday() => const [
        DailyQuest(
          id: 'quest_lesson',
          type: DailyQuestType.schoolLesson,
          title: 'Reto del Período',
          subtitle: 'Completa 1 lección de tu grado',
          emoji: '📘',
          target: 1,
          coinReward: 40,
          xpReward: 50,
        ),
        DailyQuest(
          id: 'quest_game_challenges',
          type: DailyQuestType.gameChallenges,
          title: 'Aventura en el Cuaderno',
          subtitle: 'Responde 5 retos en el juego de Lumi',
          emoji: '🦁',
          target: 5,
          coinReward: 35,
          xpReward: 45,
        ),
        DailyQuest(
          id: 'quest_stars',
          type: DailyQuestType.collectStars,
          title: 'Cazador de Estrellas',
          subtitle: 'Recoge 10 estrellitas saltando con Lumi',
          emoji: '⭐',
          target: 10,
          coinReward: 25,
          xpReward: 30,
        ),
      ];

  static DailyQuestsState _loadOrCreate(
    SharedPreferences? prefs,
    DateTime now,
  ) {
    final todayKey = formatIsoDate(now);
    if (prefs != null) {
      final savedDate = prefs.getString(_questsDateKey);
      final raw = prefs.getString(_questsDataKey);
      if (savedDate == todayKey && raw != null) {
        try {
          final decoded = jsonDecode(raw) as List<dynamic>;
          final quests = decoded
              .map((e) => DailyQuest.fromJson(e as Map<String, dynamic>))
              .toList();
          if (quests.isNotEmpty) {
            return DailyQuestsState(dateKey: todayKey, quests: quests);
          }
        } catch (_) {}
      }
    }
    return DailyQuestsState(
      dateKey: todayKey,
      quests: _defaultQuestsForToday(),
    );
  }

  void _ensureToday([DateTime? now]) {
    final todayKey = formatIsoDate(now ?? DateTime.now());
    if (state.dateKey != todayKey) {
      _persist(DailyQuestsState(
        dateKey: todayKey,
        quests: _defaultQuestsForToday(),
      ));
    }
  }

  void _persist(DailyQuestsState next) {
    state = next;
    _prefs?.setString(_questsDateKey, next.dateKey);
    _prefs?.setString(
      _questsDataKey,
      jsonEncode(next.quests.map((q) => q.toJson()).toList()),
    );
  }

  void addProgress(DailyQuestType type, int delta, {DateTime? now}) {
    if (delta <= 0) return;
    _ensureToday(now);
    final updated = state.quests.map((q) {
      if (q.type != type) return q;
      final nextProgress = (q.progress + delta).clamp(0, q.target);
      return q.copyWith(progress: nextProgress);
    }).toList();
    _persist(DailyQuestsState(dateKey: state.dateKey, quests: updated));
  }

  /// Reclama una misión completada una sola vez y devuelve la misión reclamada
  /// para que el llamador abone las monedas y XP al niño.
  DailyQuest? claimQuest(String questId, {DateTime? now}) {
    _ensureToday(now);
    DailyQuest? claimedQuest;
    final updated = state.quests.map((q) {
      if (q.id == questId && q.canClaim) {
        claimedQuest = q.copyWith(claimed: true);
        return claimedQuest!;
      }
      return q;
    }).toList();
    if (claimedQuest == null) return null;
    _persist(DailyQuestsState(dateKey: state.dateKey, quests: updated));
    return claimedQuest;
  }
}
