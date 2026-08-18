import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:edplay_ft/features/auth/domain/entities/auth_entities.dart';
import 'package:edplay_ft/features/auth/domain/repositories/auth_repository.dart';
import 'package:edplay_ft/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:edplay_ft/features/auth/presentation/screens/parent_login_screen.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

const _parentTokens = AuthTokens(
  accessToken: 'access',
  refreshToken: 'refresh',
  actorType: 'parent',
  actorId: 'parent-001',
);

Widget _wrap(AuthCubit cubit) {
  final router = GoRouter(
    initialLocation: '/auth/login',
    routes: [
      GoRoute(
        path: '/auth/login',
        builder: (_, __) => const ParentLoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (_, __) => const Scaffold(body: Text('REGISTER')),
      ),
      GoRoute(
        path: '/auth/select-child',
        builder: (_, __) => const Scaffold(body: Text('SELECT_CHILD')),
      ),
    ],
  );

  return BlocProvider.value(
    value: cubit,
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('ParentLoginScreen', () {
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

    testWidgets('muestra los campos de email, contraseña y el botón Ingresar',
        (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Ingresar'), findsOneWidget);
    });

    testWidgets('con campos vacíos muestra errores de validación',
        (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ingresar'));
      await tester.pump();

      expect(find.text('Ingresa tu correo'), findsOneWidget);
      expect(find.text('Ingresa tu contraseña'), findsOneWidget);
      verifyNever(() => repository.loginParent(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ));
    });

    testWidgets('con correo inválido muestra "Correo no válido"',
        (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'no-es-correo');
      await tester.enterText(find.byType(TextFormField).last, 'clave123');
      await tester.tap(find.text('Ingresar'));
      await tester.pump();

      expect(find.text('Correo no válido'), findsOneWidget);
    });

    testWidgets('con contraseña corta muestra "Mínimo 6 caracteres"',
        (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).first, 'padre@ejemplo.com');
      await tester.enterText(find.byType(TextFormField).last, '123');
      await tester.tap(find.text('Ingresar'));
      await tester.pump();

      expect(find.text('Mínimo 6 caracteres'), findsOneWidget);
    });

    testWidgets('con datos válidos llama a loginParent con email y password',
        (tester) async {
      final pending = Completer<AuthTokens>();
      when(() => repository.loginParent(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) => pending.future);

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).first, ' padre@ejemplo.com ');
      await tester.enterText(find.byType(TextFormField).last, 'MiPass123!');
      await tester.tap(find.text('Ingresar'));
      await tester.pump();

      verify(() => repository.loginParent(
            email: 'padre@ejemplo.com',
            password: 'MiPass123!',
          )).called(1);
    });

    testWidgets(
        'mientras AuthLoading el botón muestra spinner y no se puede tocar de nuevo',
        (tester) async {
      final pending = Completer<AuthTokens>();
      when(() => repository.loginParent(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) => pending.future);

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).first, 'padre@ejemplo.com');
      await tester.enterText(find.byType(TextFormField).last, 'MiPass123!');
      await tester.tap(find.text('Ingresar'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('AuthError muestra un SnackBar con el mensaje', (tester) async {
      when(() => repository.loginParent(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception('Contraseña incorrecta'));

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).first, 'padre@ejemplo.com');
      await tester.enterText(find.byType(TextFormField).last, 'malaClave');
      await tester.tap(find.text('Ingresar'));
      await tester.pump();
      await tester.pump();

      expect(
        find.text('La contraseña o PIN es incorrecto. ¡Intenta de nuevo!'),
        findsOneWidget,
      );
    });

    testWidgets('login exitoso navega a /auth/select-child', (tester) async {
      when(() => repository.loginParent(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => _parentTokens);
      when(() => repository.saveTokens(any())).thenAnswer((_) async {});
      when(() => repository.getChildren()).thenAnswer((_) async => const []);

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).first, 'padre@ejemplo.com');
      await tester.enterText(find.byType(TextFormField).last, 'MiPass123!');
      await tester.tap(find.text('Ingresar'));
      await tester.pumpAndSettle();

      expect(find.text('SELECT_CHILD'), findsOneWidget);
    });

    testWidgets('el link "Regístrate" navega a /auth/register', (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      // "Regístrate" es un TextSpan dentro de un Text.rich, no un Text plano.
      final registerLink = find.byType(TextButton).last;
      await tester.ensureVisible(registerLink);
      await tester.tap(registerLink, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('REGISTER'), findsOneWidget);
    });
  });
}
