import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:edplay_ft/features/settings/presentation/screens/parent_settings_screen.dart';

Widget _wrap() {
  final router = GoRouter(
    initialLocation: '/parent/settings',
    routes: [
      GoRoute(
        path: '/parent/settings',
        builder: (_, __) => const ParentSettingsScreen(),
      ),
      GoRoute(
        path: '/parent/dashboard',
        builder: (_, __) => const Scaffold(body: Text('PARENT_DASHBOARD')),
      ),
    ],
  );
  return MaterialApp.router(routerConfig: router);
}

// La pantalla completa (controles + botón de bloqueo) no cabe en el
// viewport por defecto de los tests.
void _useTallViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

void main() {
  group('ParentSettingsScreen', () {
    testWidgets('muestra los controles parentales: límite, horario, ranking y notificaciones',
        (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('Límite de lecciones al día'), findsOneWidget);
      expect(find.text('Horario de uso permitido'), findsOneWidget);
      expect(find.text('Mostrar en ranking público'), findsOneWidget);
      expect(find.text('Notificaciones al padre/madre'), findsOneWidget);
      expect(find.text('Sin límite'), findsOneWidget);
    });

    testWidgets('el switch de ranking público inicia desactivado (default privacidad)',
        (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
      // Primer switch: "Mostrar en ranking público" — default false.
      expect(switches.first.value, isFalse);
    });

    testWidgets('tocar "Bloquear app temporalmente" abre el diálogo de confirmación',
        (tester) async {
      _useTallViewport(tester);
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Bloquear app temporalmente'));
      await tester.pumpAndSettle();

      expect(find.text('Bloquear la app temporalmente'), findsOneWidget);
      expect(find.textContaining('no podrá usar EduPlay'), findsOneWidget);
    });

    testWidgets('el botón de volver navega a /parent/dashboard si no hay historial',
        (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back_ios_rounded));
      await tester.pumpAndSettle();

      expect(find.text('PARENT_DASHBOARD'), findsOneWidget);
    });
  });
}
