// Mock repository — datos de prueba para desarrollo sin backend
// Reemplazar con RemoteAuthRepository cuando el auth-service esté listo

import '../../domain/entities/auth_entities.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  static const _mockChildren = [
    ChildProfile(
      id: 'child-001',
      displayName: 'Sofía',
      grade: 2,
      avatarId: 'avatar_girl_01',
      avatarUrl: 'assets/images/avatars/avatar_girl_01.png',
    ),
    ChildProfile(
      id: 'child-002',
      displayName: 'Mateo',
      grade: 1,
      avatarId: 'avatar_boy_01',
      avatarUrl: 'assets/images/avatars/avatar_boy_01.png',
    ),
  ];

  @override
  Future<AuthTokens> loginParent({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (password.length < 4) throw Exception('Contraseña incorrecta');
    return const AuthTokens(
      accessToken: 'mock-parent-token',
      refreshToken: 'mock-refresh-token',
      actorType: 'parent',
      actorId: 'parent-001',
    );
  }

  @override
  Future<AuthTokens> loginChild({
    required String childId,
    required String pin,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (pin != '1234') throw Exception('PIN incorrecto');
    return AuthTokens(
      accessToken: 'mock-child-token-$childId',
      refreshToken: 'mock-refresh-child',
      actorType: 'child',
      actorId: childId,
    );
  }

  @override
  Future<void> register({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future<List<ChildProfile>> getChildren() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockChildren;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<AuthTokens?> getStoredTokens() async => null;

  @override
  Future<void> saveTokens(AuthTokens tokens) async {}

  @override
  Future<void> clearTokens() async {}
}
