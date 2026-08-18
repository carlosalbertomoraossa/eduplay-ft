import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:edplay_ft/features/auth/domain/repositories/auth_repository.dart';
import 'package:edplay_ft/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:edplay_ft/features/auth/presentation/screens/parent_register_screen.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

Widget _wrap(AuthCubit cubit) {
  final router = GoRouter(
    initialLocation: '/auth/register',
    routes: [
      GoRoute(
        path: '/auth/register',
        builder: (_, __) => const ParentRegisterScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (_, __) => const Scaffold(body: Text('LOGIN')),
      ),
    ],
  );

  return BlocProvider.value(
    value: cubit,
    child: MaterialApp.router(routerConfig: router),
  );
}

Future<void> _fillValidForm(WidgetTester tester) async {
  final fields = find.byType(TextFormField);
  await tester.enterText(fields.at(0), 'padre@ejemplo.com');
  await tester.enterText(fields.at(1), 'MiPass123!');
  await tester.enterText(fields.at(2), 'MiPass123!');
}

void main() {
  group('ParentRegisterScreen', () {
    late MockAuthRepository repository;
    late AuthCubit cubit;

    setUp(() {
      repository = MockAuthRepository();
      cubit = AuthCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    testWidgets(
        'muestra email, contraseña, confirmar contraseña, checkbox de consentimiento y botón',
        (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text('Crear cuenta'), findsOneWidget);
    });

    testWidgets('con campos vacíos muestra errores de validación',
        (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Crear cuenta'));
      await tester.tap(find.text('Crear cuenta'));
      await tester.pump();

      expect(find.text('Ingresa tu correo'), findsOneWidget);
      expect(find.text('Ingresa tu contraseña'), findsOneWidget);
      expect(find.text('Confirma tu contraseña'), findsOneWidget);
      verifyNever(() => repository.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            consentGiven: any(named: 'consentGiven'),
          ));
    });

    testWidgets('contraseñas que no coinciden muestran error', (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'padre@ejemplo.com');
      await tester.enterText(fields.at(1), 'MiPass123!');
      await tester.enterText(fields.at(2), 'OtraClave123!');
      await tester.ensureVisible(find.text('Crear cuenta'));
      await tester.tap(find.text('Crear cuenta'));
      await tester.pump();

      expect(find.text('Las contraseñas no coinciden'), findsOneWidget);
    });

    testWidgets(
        'formulario válido sin marcar el checkbox no llama a register y muestra el aviso',
        (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await _fillValidForm(tester);
      await tester.ensureVisible(find.text('Crear cuenta'));
      await tester.tap(find.text('Crear cuenta'));
      await tester.pump();

      expect(
        find.text('Debes confirmar el consentimiento parental para continuar'),
        findsOneWidget,
      );
      verifyNever(() => repository.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            consentGiven: any(named: 'consentGiven'),
          ));
    });

    testWidgets(
        'formulario válido con checkbox marcado llama a register con consentGiven=true',
        (tester) async {
      final pending = Completer<void>();
      when(() => repository.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            consentGiven: any(named: 'consentGiven'),
          )).thenAnswer((_) => pending.future);

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await _fillValidForm(tester);
      await tester.ensureVisible(find.byType(Checkbox));
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      await tester.ensureVisible(find.text('Crear cuenta'));
      await tester.tap(find.text('Crear cuenta'));
      await tester.pump();

      verify(() => repository.register(
            email: 'padre@ejemplo.com',
            password: 'MiPass123!',
            consentGiven: true,
          )).called(1);
    });

    testWidgets(
        'registro exitoso muestra snackbar de verificación y navega a /auth/login',
        (tester) async {
      when(() => repository.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            consentGiven: any(named: 'consentGiven'),
          )).thenAnswer((_) async {});

      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      await _fillValidForm(tester);
      await tester.ensureVisible(find.byType(Checkbox));
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      await tester.ensureVisible(find.text('Crear cuenta'));
      await tester.tap(find.text('Crear cuenta'));
      await tester.pumpAndSettle();

      expect(find.text('LOGIN'), findsOneWidget);
      expect(
        find.text('Revisa padre@ejemplo.com para verificar tu cuenta'),
        findsOneWidget,
      );
    });

    testWidgets('el link "Inicia sesión" navega a /auth/login', (tester) async {
      await tester.pumpWidget(_wrap(cubit));
      await tester.pumpAndSettle();

      final loginLink = find.byType(TextButton).last;
      await tester.ensureVisible(loginLink);
      await tester.tap(loginLink, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('LOGIN'), findsOneWidget);
    });
  });
}
