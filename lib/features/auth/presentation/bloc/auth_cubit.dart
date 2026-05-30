// Auth Cubit — maneja el estado de autenticación
// Spec: /specs/domains/auth/spec.md

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_entities.dart';
import '../../domain/repositories/auth_repository.dart';

// ─── States ────────────────────────────────────────────────────────
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class AuthParentLoggedIn extends AuthState {
  final AuthTokens tokens;
  final List<ChildProfile> children;
  AuthParentLoggedIn({required this.tokens, required this.children});
  @override
  List<Object?> get props => [tokens.actorId];
}

class AuthChildLoggedIn extends AuthState {
  final AuthTokens tokens;
  final ChildProfile child;
  AuthChildLoggedIn({required this.tokens, required this.child});
  @override
  List<Object?> get props => [tokens.actorId];
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthUnauthenticated extends AuthState {}

// ─── Cubit ─────────────────────────────────────────────────────────
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(AuthInitial());

  Future<void> checkStoredSession() async {
    final tokens = await _repository.getStoredTokens();
    if (tokens == null) {
      emit(AuthUnauthenticated());
      return;
    }
    if (tokens.isParent) {
      final children = await _repository.getChildren();
      emit(AuthParentLoggedIn(tokens: tokens, children: children));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> loginParent({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final tokens = await _repository.loginParent(
        email: email,
        password: password,
      );
      await _repository.saveTokens(tokens);
      final children = await _repository.getChildren();
      emit(AuthParentLoggedIn(tokens: tokens, children: children));
    } catch (e) {
      emit(AuthError(_friendlyError(e)));
    }
  }

  Future<void> loginChild({
    required ChildProfile child,
    required String pin,
  }) async {
    emit(AuthLoading());
    try {
      final tokens = await _repository.loginChild(
        childId: child.id,
        pin: pin,
      );
      await _repository.saveTokens(tokens);
      emit(AuthChildLoggedIn(tokens: tokens, child: child));
    } catch (e) {
      emit(AuthError(_friendlyError(e)));
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    await _repository.clearTokens();
    emit(AuthUnauthenticated());
  }

  String _friendlyError(Object e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('contraseña') || msg.contains('pin')) {
      return 'La contraseña o PIN es incorrecto. ¡Intenta de nuevo!';
    }
    if (msg.contains('network') || msg.contains('connection')) {
      return 'Sin conexión. Revisa tu internet.';
    }
    return 'Algo salió mal. ¡Intenta de nuevo!';
  }
}
