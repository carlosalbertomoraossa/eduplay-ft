import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edplay_ft/core/providers/daily_quests_provider.dart';

void main() {
  group('DailyQuestsNotifier', () {
    test('crea 3 misiones diarias, registra progreso y evita doble reclamo', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final today = DateTime(2026, 11, 24);

      final notifier = DailyQuestsNotifier(prefs, today);
      expect(notifier.state.quests.length, 3);

      // No se puede reclamar antes de completar
      expect(notifier.claimQuest('quest_lesson', now: today), isNull);

      // Completar la misión de lección
      notifier.addProgress(DailyQuestType.schoolLesson, 1, now: today);
      final lessonQuest =
          notifier.state.quests.firstWhere((q) => q.id == 'quest_lesson');
      expect(lessonQuest.canClaim, isTrue);

      // Primer reclamo funciona; segundo retorna null
      final claimed = notifier.claimQuest('quest_lesson', now: today);
      expect(claimed, isNotNull);
      expect(claimed!.coinReward, greaterThan(0));
      expect(notifier.claimQuest('quest_lesson', now: today), isNull);

      // Al día siguiente se reinician las misiones automáticamente
      final tomorrow = DateTime(2026, 11, 25);
      notifier.addProgress(DailyQuestType.collectStars, 2, now: tomorrow);
      final resetLessonQuest =
          notifier.state.quests.firstWhere((q) => q.id == 'quest_lesson');
      expect(resetLessonQuest.progress, 0);
      expect(resetLessonQuest.claimed, isFalse);
    });
  });
}
