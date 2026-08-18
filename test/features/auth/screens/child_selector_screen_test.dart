import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:edplay_ft/features/auth/domain/entities/auth_entities.dart';
import 'package:edplay_ft/features/auth/domain/repositories/auth_repository.dart';
import 'package:edplay_ft/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:edplay_ft/features/auth/presentation/screens/child_selector_screen.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

const _parentTokens = AuthTokens(
  accessToken: 'access',
  refreshToken: 'refresh',
  actorType: 'parent',
  actorId: 'parent-001',
);

const _sofia = ChildProfile(
  id: 'child-001',
  displayName: 'Sofía',
  grade: 2,
  avatarId: 'avatar_girl_01',
  avatarUrl: 'assets/images/avatars/avatar_girl_01.png',
);

const _mateo = ChildProfile(
  id: 'child-002',
  displayName: 'Mateo',
  grade: 1,
  avatarId: 'avatar_boy_01',
  avatarUrl: 'assets/images/avatars/avatar_boy_01.png',
);

const _childTokens = AuthTokens(
  accessToken: 'access-child',
  refreshToken: 'refresh-child',
  actorType: 'child',
  actorId: 'child-001',
);

Widget _wrap(AuthCubit cubit) {
  final router = GoRouter(
    initialLocation: '/auth/select-child',
    routes: [
      GoRoute(
        path: '/auth/select-child',
        builder: (_, __) => const ChildSelectorScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (_, __) => const Scaffold(body: Text('LOGIN')),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const Scaffold(body: Text('HOME')),
      ),
      GoRoute(
        path: '/parent/dashboard',
        builder: (_, __) => const Scaffold(body: Text('PARENT_DASHBOARD')),
      ),
    ],
  );

  return BlocProvider.value(
    value: cubit,
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('ChildSelectorScreen', () {
    late MockAuthRepository repository;
    late AuthCubit cubit;

    setUpAll(() {
      registerFallbackValue(_parentTokens);
    });

    setUp(() {
      repository = MockAuthRepository();
      cubit = AuthCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    testWidgets('sin sesión de padre redirige a /auth/login', (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      expect(find.text('LOGIN'), findsOneWidget);
    });

    testWidgets('con padre logueado muestra la tarjeta de cada hijo',
        (tester) async {
      cubit.emit(AuthParentLoggedIn(
        tokens: _parentTokens,
        children: const [_sofia, _mateo],
      ));

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      expect(find.text('¿Quién va a jugar?'), findsOneWidget);
      expect(find.text('Sofía'), findsOneWidget);
      expect(find.text('Mateo'), findsOneWidget);
    });

    testWidgets('tocar una tarjeta abre el diálogo de PIN', (tester) async {
      cubit.emit(AuthParentLoggedIn(
        tokens: _parentTokens,
        children: const [_sofia],
      ));

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sofía'));
      await tester.pumpAndSettle();

      expect(find.text('¡Hola, Sofía!'), findsOneWidget);
      expect(find.text('Ingresa tu PIN de 4 dígitos'), findsOneWidget);
    });

    testWidgets('PIN correcto de 4 dígitos hace login y navega a /home',
        (tester) async {
      when(() => repository.loginChild(
            childId: any(named: 'childId'),
            pin: any(named: 'pin'),
          )).thenAnswer((_) async => _childTokens);
      when(() => repository.saveTokens(any())).thenAnswer((_) async {});

      cubit.emit(AuthParentLoggedIn(
        tokens: _parentTokens,
        children: const [_sofia],
      ));

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sofía'));
      await tester.pumpAndSettle();

      for (final digit in ['1', '2', '3', '4']) {
        await tester.tap(find.text(digit));
        await tester.pump();
      }
      await tester.pumpAndSettle();

      verify(() => repository.loginChild(childId: 'child-001', pin: '1234'))
          .called(1);
      expect(find.text('HOME'), findsOneWidget);
    });

    testWidgets('PIN incorrecto muestra error y limpia los dígitos',
        (tester) async {
      when(() => repository.loginChild(
            childId: any(named: 'childId'),
            pin: any(named: 'pin'),
          )).thenThrow(Exception('PIN incorrecto'));

      cubit.emit(AuthParentLoggedIn(
        tokens: _parentTokens,
        children: const [_sofia],
      ));

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sofía'));
      await tester.pumpAndSettle();

      for (final digit in ['9', '9', '9', '9']) {
        await tester.tap(find.text(digit));
        await tester.pump();
      }
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('¡PIN incorrecto! Intenta de nuevo'), findsOneWidget);
    });

    testWidgets('"Ver mi panel de padre/madre" navega a /parent/dashboard',
        (tester) async {
      cubit.emit(AuthParentLoggedIn(
        tokens: _parentTokens,
        children: const [_sofia],
      ));

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ver mi panel de padre/madre'));
      await tester.pumpAndSettle();

      expect(find.text('PARENT_DASHBOARD'), findsOneWidget);
    });
  });
}
