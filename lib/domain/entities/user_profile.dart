import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.username,
    required this.updatedAt,
    this.email,
    this.avatarUrl,
  });

  final String id;
  final String username;
  final String? email;
  final String? avatarUrl;
  final DateTime updatedAt;

  UserProfile copyWith({
    String? id,
    String? username,
    String? email,
    String? avatarUrl,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, username, email, avatarUrl, updatedAt];
}
