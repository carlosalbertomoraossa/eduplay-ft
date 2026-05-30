// Entidades del dominio Auth — Flutter
// Spec: /specs/domains/auth/spec.md

import 'package:equatable/equatable.dart';

class ParentAccount extends Equatable {
  final String id;
  final String email;
  final String subscriptionTier;
  final List<ChildProfile> children;

  const ParentAccount({
    required this.id,
    required this.email,
    required this.subscriptionTier,
    required this.children,
  });

  @override
  List<Object?> get props => [id, email];
}

class ChildProfile extends Equatable {
  final String id;
  final String displayName;
  final int grade; // 1–5, sistema colombiano
  final String avatarId;
  final String avatarUrl;

  const ChildProfile({
    required this.id,
    required this.displayName,
    required this.grade,
    required this.avatarId,
    required this.avatarUrl,
  });

  bool get isGirl => avatarId.contains('girl');
  String get genderLabel => isGirl ? 'Niña' : 'Niño';
  String get genderEmoji => isGirl ? '👧' : '👦';

  @override
  List<Object?> get props => [id, displayName, grade];
}

class AuthTokens extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String actorType; // 'parent' | 'child'
  final String actorId;

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.actorType,
    required this.actorId,
  });

  bool get isChild => actorType == 'child';
  bool get isParent => actorType == 'parent';

  @override
  List<Object?> get props => [accessToken, actorType, actorId];
}
