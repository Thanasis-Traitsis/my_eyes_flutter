import 'package:my_eyes/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile?> getProfile();
  Future<void> saveProfile(UserProfile profile);
  Future<void> updateProfile(UserProfile profile);
}
