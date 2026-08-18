import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:edplay_ft/features/auth/domain/entities/auth_entities.dart';
import 'package:edplay_ft/features/auth/domain/repositories/auth_repository.dart';
import 'package:edplay_ft/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:edplay_ft/features/settings/presentation/screens/settings_screen.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

const _childTokens = AuthTokens(
  accessToken: 'access-child',
  refreshToken: 'refresh-child',
  actorType: 'child',
  actorId: 'child-001',
);

Widget _wrap(AuthCubit cubit) {
  final router = GoRouter(
    initialLocation: '/settings',
    routes: [
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const Scaffold(body: Text('ONBOARDING')),
      ),
    ],
  );

  return BlocProvider.value(
    value: cubit,
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('SettingsScreen', () {
    late MockAuthRepository repository;
    late AuthCubit cubit;

    setUp(() {
      repository = MockAuthRepository();
      cubit = AuthCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    testWidgets('muestra los controles de sonido y el botón de salir',
        (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      expect(find.text('Música de fondo'), findsOneWidget);
      expect(find.text('Volumen de efectos'), findsOneWidget);
      expect(find.text('Salir'), findsOneWidget);
    });

    testWidgets('el switch de música se puede alternar', (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      final switchFinder = find.byType(Switch);
      final initialValue = tester.widget<Switch>(switchFinder).value;

      await tester.tap(switchFinder);
      await tester.pump();

      final updatedValue = tester.widget<Switch>(switchFinder).value;
      expect(updatedValue, isNot(initialValue));
    });

    testWidgets('tocar Salir muestra diálogo de confirmación', (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Salir'));
      await tester.pumpAndSettle();

      expect(find.text('¿Salir de EduPlay?'), findsOneWidget);
    });

    testWidgets('confirmar salida llama logout y navega a /onboarding',
        (tester) async {
      when(() => repository.logout()).thenAnswer((_) async {});
      when(() => repository.clearTokens()).thenAnswer((_) async {});

      cubit.emit(AuthChildLoggedIn(
        tokens: _childTokens,
        child: const ChildProfile(
          id: 'child-001',
          displayName: 'Sofía',
          grade: 2,
          avatarId: 'avatar_girl_01',
          avatarUrl: 'assets/images/avatars/avatar_girl_01.png',
        ),
      ));

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Salir'));
      await tester.pumpAndSettle();

      // El diálogo tiene un botón "Salir" adicional — tomamos el último.
      await tester.tap(find.text('Salir').last);
      await tester.pumpAndSettle();

      verify(() => repository.logout()).called(1);
      expect(find.text('ONBOARDING'), findsOneWidget);
    });
  });
}
