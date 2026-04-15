import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/core/constants/app_keys.dart';
import 'package:my_eyes/data/models/user_profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<UserProfileModel?> get();
  Future<void> save(UserProfileModel model);
  Future<void> update(UserProfileModel model);
}

@LazySingleton(as: ProfileLocalDataSource)
class HiveProfileLocalDataSource implements ProfileLocalDataSource {
  HiveProfileLocalDataSource(this._box);

  final Box<UserProfileModel> _box;

  static const _profileKey = AppKeys.hiveProfileRecordKey;

  @override
  Future<UserProfileModel?> get() async => _box.get(_profileKey);

  @override
  Future<void> save(UserProfileModel model) => _box.put(_profileKey, model);

  @override
  Future<void> update(UserProfileModel model) => _box.put(_profileKey, model);
}
