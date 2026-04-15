import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/datasources/profile_local_datasource.dart';
import 'package:my_eyes/data/models/user_profile_model.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';
import 'package:my_eyes/domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._localDataSource);

  final ProfileLocalDataSource _localDataSource;

  @override
  Future<UserProfile?> getProfile() async {
    final model = await _localDataSource.get();
    return model?.toEntity();
  }

  @override
  Future<void> saveProfile(UserProfile profile) =>
      _localDataSource.save(UserProfileModel.fromEntity(profile));

  @override
  Future<void> updateProfile(UserProfile profile) =>
      _localDataSource.update(UserProfileModel.fromEntity(profile));
}
