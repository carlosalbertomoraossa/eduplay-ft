import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:edplay_ft/features/auth/domain/entities/auth_entities.dart';
import 'package:edplay_ft/features/auth/domain/repositories/auth_repository.dart';
import 'package:edplay_ft/features/auth/presentation/bloc/auth_cubit.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthCubit', () {
    late MockAuthRepository repository;

    const parentTokens = AuthTokens(
      accessToken: 'access',
      refreshToken: 'refresh',
      actorType: 'parent',
      actorId: 'parent-001',
    );

    const childTokens = AuthTokens(
      accessToken: 'access-child',
      refreshToken: 'refresh-child',
      actorType: 'child',
      actorId: 'child-001',
    );

    const child = ChildProfile(
      id: 'child-001',
      displayName: 'Sofía',
      grade: 2,
      avatarId: 'avatar_girl_01',
      avatarUrl: 'assets/images/avatars/avatar_girl_01.png',
    );

    const children = [child];

    setUpAll(() {
      registerFallbackValue(parentTokens);
    });

    setUp(() {
      repository = MockAuthRepository();
    });

    blocTest<AuthCubit, AuthState>(
      'checkStoredSession sin tokens guardados emite AuthUnauthenticated',
      setUp: () {
        when(() => repository.getStoredTokens())
            .thenAnswer((_) async => null);
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.checkStoredSession(),
      expect: () => [isA<AuthUnauthenticated>()],
    );

    blocTest<AuthCubit, AuthState>(
      'checkStoredSession con tokens de padre emite AuthParentLoggedIn con hijos',
      setUp: () {
        when(() => repository.getStoredTokens())
            .thenAnswer((_) async => parentTokens);
        when(() => repository.getChildren())
            .thenAnswer((_) async => children);
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.checkStoredSession(),
      expect: () => [
        isA<AuthParentLoggedIn>()
            .having((s) => s.tokens.actorId, 'actorId', 'parent-001')
            .having((s) => s.children, 'children', children),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'checkStoredSession con tokens de niño emite AuthUnauthenticated (solo padre reanuda sesión)',
      setUp: () {
        when(() => repository.getStoredTokens())
            .thenAnswer((_) async => childTokens);
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.checkStoredSession(),
      expect: () => [isA<AuthUnauthenticated>()],
    );

    blocTest<AuthCubit, AuthState>(
      'loginParent exitoso emite AuthLoading y luego AuthParentLoggedIn, guarda tokens',
      setUp: () {
        when(() => repository.loginParent(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => parentTokens);
        when(() => repository.saveTokens(any()))
            .thenAnswer((_) async {});
        when(() => repository.getChildren())
            .thenAnswer((_) async => children);
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.loginParent(
        email: 'padre@ejemplo.com',
        password: 'MiPass123!',
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthParentLoggedIn>()
            .having((s) => s.tokens, 'tokens', parentTokens)
            .having((s) => s.children, 'children', children),
      ],
      verify: (_) {
        verify(() => repository.saveTokens(parentTokens)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'loginParent con contraseña incorrecta emite AuthLoading y AuthError amigable',
      setUp: () {
        when(() => repository.loginParent(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(Exception('Contraseña incorrecta'));
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.loginParent(
        email: 'padre@ejemplo.com',
        password: 'mal',
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          'La contraseña o PIN es incorrecto. ¡Intenta de nuevo!',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'loginParent sin conexión emite mensaje de error de red',
      setUp: () {
        when(() => repository.loginParent(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(Exception('Network connection failed'));
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.loginParent(
        email: 'padre@ejemplo.com',
        password: 'MiPass123!',
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          'Sin conexión. Revisa tu internet.',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'loginChild exitoso emite AuthLoading y luego AuthChildLoggedIn, guarda tokens',
      setUp: () {
        when(() => repository.loginChild(
              childId: any(named: 'childId'),
              pin: any(named: 'pin'),
            )).thenAnswer((_) async => childTokens);
        when(() => repository.saveTokens(any()))
            .thenAnswer((_) async {});
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.loginChild(child: child, pin: '1234'),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthChildLoggedIn>()
            .having((s) => s.tokens, 'tokens', childTokens)
            .having((s) => s.child, 'child', child),
      ],
      verify: (_) {
        verify(() => repository.saveTokens(childTokens)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'loginChild con PIN incorrecto emite AuthLoading y AuthError amigable',
      setUp: () {
        when(() => repository.loginChild(
              childId: any(named: 'childId'),
              pin: any(named: 'pin'),
            )).thenThrow(Exception('PIN incorrecto'));
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.loginChild(child: child, pin: '0000'),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          'La contraseña o PIN es incorrecto. ¡Intenta de nuevo!',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'register exitoso emite AuthLoading y luego AuthRegistered con el email',
      setUp: () {
        when(() => repository.register(
              email: any(named: 'email'),
              password: any(named: 'password'),
              consentGiven: any(named: 'consentGiven'),
            )).thenAnswer((_) async {});
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.register(
        email: 'padre@ejemplo.com',
        password: 'MiPass123!',
        consentGiven: true,
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthRegistered>().having(
          (s) => s.email,
          'email',
          'padre@ejemplo.com',
        ),
      ],
      verify: (_) {
        verify(() => repository.register(
              email: 'padre@ejemplo.com',
              password: 'MiPass123!',
              consentGiven: true,
            )).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'register sin consentimiento emite AuthLoading y AuthError',
      setUp: () {
        when(() => repository.register(
              email: any(named: 'email'),
              password: any(named: 'password'),
              consentGiven: any(named: 'consentGiven'),
            )).thenThrow(
          Exception('Se requiere el consentimiento parental para registrarte'),
        );
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.register(
        email: 'padre@ejemplo.com',
        password: 'MiPass123!',
        consentGiven: false,
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'logout limpia tokens y emite AuthUnauthenticated',
      setUp: () {
        when(() => repository.logout()).thenAnswer((_) async {});
        when(() => repository.clearTokens()).thenAnswer((_) async {});
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.logout(),
      expect: () => [isA<AuthUnauthenticated>()],
      verify: (_) {
        verify(() => repository.logout()).called(1);
        verify(() => repository.clearTokens()).called(1);
      },
    );
  });
}
