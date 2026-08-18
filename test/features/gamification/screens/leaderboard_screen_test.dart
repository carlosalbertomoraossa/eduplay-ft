import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:edplay_ft/features/gamification/presentation/screens/leaderboard_screen.dart';

Widget _wrap() {
  final router = GoRouter(
    initialLocation: '/leaderboard',
    routes: [
      GoRoute(
        path: '/leaderboard',
        builder: (_, __) => const LeaderboardScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const Scaffold(body: Text('HOME')),
      ),
    ],
  );
  return MaterialApp.router(routerConfig: router);
}

// La lista de 8 niños no cabe en el viewport por defecto de los tests.
void _useTallViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 2000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

void main() {
  group('LeaderboardScreen', () {
    testWidgets('muestra los 8 niños del ranking semanal con su XP',
        (tester) async {
      _useTallViewport(tester);
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('Mateo'), findsOneWidget);
      expect(find.text('Sofía'), findsOneWidget);
      expect(find.text('Samuel'), findsOneWidget);
      expect(find.text('210 XP'), findsOneWidget);
    });

    testWidgets('destaca la posición del niño actual (Sofía) con "Tú"',
        (tester) async {
      _useTallViewport(tester);
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('Tú'), findsOneWidget);
    });

    testWidgets('muestra medallas para el top 3', (tester) async {
      _useTallViewport(tester);
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('🥇'), findsOneWidget);
      expect(find.text('🥈'), findsOneWidget);
      expect(find.text('🥉'), findsOneWidget);
    });

    testWidgets('el botón de volver navega a /home si no hay historial',
        (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back_ios_rounded));
      await tester.pumpAndSettle();

      expect(find.text('HOME'), findsOneWidget);
    });
  });
}
