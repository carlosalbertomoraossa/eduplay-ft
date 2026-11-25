import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edplay_ft/core/providers/child_progress_provider.dart';

void main() {
  group('ChildProgressNotifier', () {
    test('suma XP, monedas, estrellas y sube de nivel al completar lecciones', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final notifier = ChildProgressNotifier(prefs);

      final initialCoins = notifier.state.coins;
      final initialXp = notifier.state.totalXp;

      notifier.recordLessonCompleted(
        xpEarned: 100,
        coinsEarned: 25,
        starsEarned: 3,
        unitStampId: 'unit-401',
        now: DateTime(2026, 11, 24),
      );

      expect(notifier.state.totalXp, initialXp + 100);
      expect(notifier.state.coins, initialCoins + 25);
      expect(notifier.state.level, greaterThanOrEqualTo(2));
      expect(notifier.state.unlockedStamps.contains('unit-401'), isTrue);

      // Recarga desde SharedPreferences conserva todo
      final reloaded = ChildProgressNotifier(prefs);
      expect(reloaded.state.totalXp, initialXp + 100);
      expect(reloaded.state.coins, initialCoins + 25);
      expect(reloaded.state.unlockedStamps.contains('unit-401'), isTrue);
    });

    test('el escudo de racha protege al niño si descansa 1 día', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final notifier = ChildProgressNotifier(prefs);

      notifier.registerActivity(now: DateTime(2026, 11, 20));
      final streakAfterDay1 = notifier.state.streakDays;
      final shieldsBefore = notifier.state.streakShields;

      // Falta el 21, vuelve el 22 -> consume 1 escudo y conserva/incrementa racha
      notifier.registerActivity(now: DateTime(2026, 11, 22));
      expect(notifier.state.streakShields, shieldsBefore - 1);
      expect(notifier.state.streakDays, streakAfterDay1 + 1);
    });

    test('spendCoins valida saldo insuficiente', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final notifier = ChildProgressNotifier(prefs);

      expect(notifier.spendCoins(9999), isFalse);
      expect(notifier.spendCoins(30), isTrue);
      expect(notifier.state.coins, 30);
    });
  });
}
