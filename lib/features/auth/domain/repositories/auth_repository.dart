// Interfaz del repositorio Auth
// Spec: /specs/domains/auth/spec.md

import '../entities/auth_entities.dart';

abstract class AuthRepository {
  Future<AuthTokens> loginParent({
    required String email,
    required String password,
  });

  Future<AuthTokens> loginChild({
    required String childId,
    required String pin,
  });

  Future<void> register({
    required String email,
    required String password,
  });

  Future<List<ChildProfile>> getChildren();

  Future<void> logout();

  Future<AuthTokens?> getStoredTokens();

  Future<void> saveTokens(AuthTokens tokens);

  Future<void> clearTokens();
}
