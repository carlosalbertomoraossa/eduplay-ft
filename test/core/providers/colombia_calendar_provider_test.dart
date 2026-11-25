import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edplay_ft/core/providers/colombia_calendar_provider.dart';

void main() {
  group('ColombiaCalendarState & ColombiaCalendarNotifier', () {
    test('calcula los 4 períodos correctamente en Calendario A', () {
      expect(
        ColombiaCalendarState.calculatePeriodForDate(
          DateTime(2026, 2, 15),
          SchoolCalendarType.calendarA,
        ),
        1,
      );
      expect(
        ColombiaCalendarState.calculatePeriodForDate(
          DateTime(2026, 5, 10),
          SchoolCalendarType.calendarA,
        ),
        2,
      );
      expect(
        ColombiaCalendarState.calculatePeriodForDate(
          DateTime(2026, 8, 20),
          SchoolCalendarType.calendarA,
        ),
        3,
      );
      expect(
        ColombiaCalendarState.calculatePeriodForDate(
          DateTime(2026, 11, 5),
          SchoolCalendarType.calendarA,
        ),
        4,
      );
    });

    test('calcula los 4 períodos correctamente en Calendario B', () {
      expect(
        ColombiaCalendarState.calculatePeriodForDate(
          DateTime(2026, 10, 12),
          SchoolCalendarType.calendarB,
        ),
        1,
      );
      expect(
        ColombiaCalendarState.calculatePeriodForDate(
          DateTime(2026, 1, 20),
          SchoolCalendarType.calendarB,
        ),
        2,
      );
      expect(
        ColombiaCalendarState.calculatePeriodForDate(
          DateTime(2026, 4, 1),
          SchoolCalendarType.calendarB,
        ),
        3,
      );
      expect(
        ColombiaCalendarState.calculatePeriodForDate(
          DateTime(2026, 6, 10),
          SchoolCalendarType.calendarB,
        ),
        4,
      );
    });

    test('persiste cambio de calendario y override manual en SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final notifier = ColombiaCalendarNotifier(prefs);
      notifier.setCalendarType(SchoolCalendarType.calendarB);
      notifier.setManualPeriod(3);

      final reloaded = ColombiaCalendarNotifier(prefs);
      expect(reloaded.state.calendarType, SchoolCalendarType.calendarB);
      expect(reloaded.state.activePeriod(DateTime(2026, 1, 1)), 3);
      expect(reloaded.state.isManualOverride, isTrue);

      reloaded.setManualPeriod(null);
      expect(reloaded.state.isManualOverride, isFalse);
      expect(reloaded.state.activePeriod(DateTime(2026, 1, 1)), 2);
    });
  });
}
