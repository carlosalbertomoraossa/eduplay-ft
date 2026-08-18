import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:edplay_ft/features/auth/domain/entities/auth_entities.dart';
import 'package:edplay_ft/features/auth/domain/repositories/auth_repository.dart';
import 'package:edplay_ft/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:edplay_ft/features/auth/presentation/screens/splash_screen.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

Widget _wrap(AuthRepository repository) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const Scaffold(body: Text('ONBOARDING')),
      ),
      GoRoute(
        path: '/auth/select-child',
        builder: (_, __) => const Scaffold(body: Text('SELECT_CHILD')),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const Scaffold(body: Text('HOME')),
      ),
    ],
  );

  return BlocProvider(
    create: (_) => AuthCubit(repository),
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('SplashScreen', () {
    late MockAuthRepository repository;

    setUp(() {
      repository = MockAuthRepository();
    });

    testWidgets('muestra el logo, el título y el eslogan', (tester) async {
      when(() => repository.getStoredTokens()).thenAnswer((_) async => null);

      await tester.pumpWidget(_wrap(repository));

      expect(find.text('EduPlay'), findsOneWidget);
      expect(find.text('¡Aprender es una aventura!'), findsOneWidget);
      expect(find.text('🌟'), findsOneWidget);

      // Deja correr el timer de 1800ms pendiente para que no queden pending timers.
      await tester.pump(const Duration(milliseconds: 1800));
      await tester.pumpAndSettle();
    });

    testWidgets('sin sesión guardada navega a /onboarding', (tester) async {
      when(() => repository.getStoredTokens()).thenAnswer((_) async => null);

      await tester.pumpWidget(_wrap(repository));
      await tester.pump(const Duration(milliseconds: 1800));
      await tester.pumpAndSettle();

      expect(find.text('ONBOARDING'), findsOneWidget);
    });

    testWidgets('con sesión de padre guardada navega a /auth/select-child',
        (tester) async {
      when(() => repository.getStoredTokens()).thenAnswer(
        (_) async => const AuthTokens(
          accessToken: 'a',
          refreshToken: 'r',
          actorType: 'parent',
          actorId: 'parent-001',
        ),
      );
      when(() => repository.getChildren()).thenAnswer((_) async => const []);

      await tester.pumpWidget(_wrap(repository));
      await tester.pump(const Duration(milliseconds: 1800));
      await tester.pumpAndSettle();

      expect(find.text('SELECT_CHILD'), findsOneWidget);
    });
  });
}
