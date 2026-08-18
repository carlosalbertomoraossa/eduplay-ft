import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:edplay_ft/features/gamification/presentation/screens/achievements_screen.dart';

Widget _wrap() {
  final router = GoRouter(
    initialLocation: '/achievements',
    routes: [
      GoRoute(
        path: '/achievements',
        builder: (_, __) => const AchievementsScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const Scaffold(body: Text('HOME')),
      ),
    ],
  );
  return MaterialApp.router(routerConfig: router);
}

// El grid completo (10 tarjetas) no cabe en el viewport por defecto de los
// tests — se agranda para poder verificar contenido sin necesidad de scroll.
void _useTallViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

void main() {
  group('AchievementsScreen', () {
    testWidgets('muestra el conteo de logros desbloqueados', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('4 de 10 logros desbloqueados'), findsOneWidget);
    });

    testWidgets('muestra los 10 logros del catálogo con nombre y descripción',
        (tester) async {
      _useTallViewport(tester);
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('¡Primera Lección!'), findsOneWidget);
      expect(find.text('Una Semana Ganadora'), findsOneWidget);
      expect(find.text('Derroté al Jefe'), findsOneWidget);
      expect(find.text('Completa 1 lección'), findsOneWidget);
    });

    testWidgets('los logros bloqueados muestran ícono de candado',
        (tester) async {
      _useTallViewport(tester);
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      // 6 de 10 logros están bloqueados en el mock.
      expect(find.byIcon(Icons.lock_rounded), findsNWidgets(6));
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
