import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _calendarTypeKey = 'co_school_calendar_type';
const _manualPeriodKey = 'co_manual_period_override';

/// Calendario escolar oficial en Colombia (MEN).
/// - [calendarA]: Enero – Noviembre (mayoría de colegios públicos y privados).
/// - [calendarB]: Septiembre – Junio (colegios bilingües / internacionales).
enum SchoolCalendarType {
  calendarA,
  calendarB,
}

class ColombiaCalendarState {
  final SchoolCalendarType calendarType;

  /// Si es 1..4, sobreescribe el período calculado por fecha (útil si el colegio
  /// del niño va en otro corte). Si es null, se calcula automáticamente.
  final int? manualPeriodOverride;

  const ColombiaCalendarState({
    this.calendarType = SchoolCalendarType.calendarA,
    this.manualPeriodOverride,
  });

  int activePeriod([DateTime? now]) {
    if (manualPeriodOverride != null &&
        manualPeriodOverride! >= 1 &&
        manualPeriodOverride! <= 4) {
      return manualPeriodOverride!;
    }
    return calculatePeriodForDate(now ?? DateTime.now(), calendarType);
  }

  bool get isManualOverride => manualPeriodOverride != null;

  String get calendarShortLabel =>
      calendarType == SchoolCalendarType.calendarA ? 'Calendario A' : 'Calendario B';

  String periodRangeLabel([DateTime? now]) {
    final p = activePeriod(now);
    if (calendarType == SchoolCalendarType.calendarA) {
      return switch (p) {
        1 => 'Ene – Mar',
        2 => 'Abr – Jun',
        3 => 'Jul – Sep',
        _ => 'Oct – Nov',
      };
    }
    return switch (p) {
      1 => 'Sep – Nov',
      2 => 'Dic – Feb',
      3 => 'Mar – Abr',
      _ => 'May – Jun',
    };
  }

  String summaryLabel([DateTime? now]) {
    final p = activePeriod(now);
    return 'Período $p · ${periodRangeLabel(now)} ($calendarShortLabel)';
  }

  /// Calcula el período académico colombiano (1 a 4) a partir de la fecha.
  static int calculatePeriodForDate(DateTime date, SchoolCalendarType type) {
    final m = date.month;
    if (type == SchoolCalendarType.calendarA) {
      if (m <= 3) return 1; // Ene – Mar
      if (m <= 6) return 2; // Abr – Jun
      if (m <= 9) return 3; // Jul – Sep
      return 4; // Oct – Dic
    } else {
      // Calendario B: Sep–Nov (P1), Dic–Feb (P2), Mar–Abr (P3), May–Ago (P4)
      if (m >= 9 && m <= 11) return 1;
      if (m == 12 || m <= 2) return 2;
      if (m <= 4) return 3;
      return 4;
    }
  }
}

final colombiaCalendarProvider =
    StateNotifierProvider<ColombiaCalendarNotifier, ColombiaCalendarState>(
  (ref) => ColombiaCalendarNotifier(),
);

class ColombiaCalendarNotifier extends StateNotifier<ColombiaCalendarState> {
  final SharedPreferences? _prefs;

  ColombiaCalendarNotifier([this._prefs]) : super(_load(_prefs));

  static ColombiaCalendarState _load(SharedPreferences? prefs) {
    if (prefs == null) return const ColombiaCalendarState();
    final rawType = prefs.getString(_calendarTypeKey);
    final type = rawType == 'B'
        ? SchoolCalendarType.calendarB
        : SchoolCalendarType.calendarA;
    final manual = prefs.getInt(_manualPeriodKey);
    return ColombiaCalendarState(
      calendarType: type,
      manualPeriodOverride:
          (manual != null && manual >= 1 && manual <= 4) ? manual : null,
    );
  }

  void setCalendarType(SchoolCalendarType type) {
    state = ColombiaCalendarState(
      calendarType: type,
      manualPeriodOverride: state.manualPeriodOverride,
    );
    _prefs?.setString(
      _calendarTypeKey,
      type == SchoolCalendarType.calendarB ? 'B' : 'A',
    );
  }

  void setManualPeriod(int? period) {
    final valid = (period != null && period >= 1 && period <= 4) ? period : null;
    state = ColombiaCalendarState(
      calendarType: state.calendarType,
      manualPeriodOverride: valid,
    );
    if (valid == null) {
      _prefs?.remove(_manualPeriodKey);
    } else {
      _prefs?.setInt(_manualPeriodKey, valid);
    }
  }
}
