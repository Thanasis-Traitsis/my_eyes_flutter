import 'package:hive_ce/hive.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 2)
class UserProfileModel extends HiveObject {
  UserProfileModel({
    required this.id,
    required this.username,
    required this.updatedAt,
    this.email,
    this.avatarUrl,
    this.pendingSync = true,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? avatarUrl;

  @HiveField(4)
  DateTime updatedAt;

  @HiveField(5)
  bool pendingSync;

  UserProfile toEntity() => UserProfile(
    id: id,
    username: username,
    email: email,
    avatarUrl: avatarUrl,
    updatedAt: updatedAt,
  );

  factory UserProfileModel.fromEntity(UserProfile p) => UserProfileModel(
    id: p.id,
    username: p.username,
    email: p.email,
    avatarUrl: p.avatarUrl,
    updatedAt: p.updatedAt,
    pendingSync: true,
  );
}
