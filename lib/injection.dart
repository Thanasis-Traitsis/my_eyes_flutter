import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/core/constants/app_keys.dart';
import 'package:my_eyes/data/models/eyewear_item_model.dart';
import 'package:my_eyes/data/models/prescription_model.dart';
import 'package:my_eyes/data/models/user_profile_model.dart';
import 'package:my_eyes/injection.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @singleton
  Connectivity get connectivity => Connectivity();

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @preResolve
  @singleton
  Future<Box<PrescriptionModel>> get prescriptionBox =>
      Hive.openBox<PrescriptionModel>(AppKeys.hiveBoxPrescriptions);

  @preResolve
  @singleton
  Future<Box<UserProfileModel>> get profileBox =>
      Hive.openBox<UserProfileModel>(AppKeys.hiveBoxProfile);

  @preResolve
  @singleton
  Future<Box<EyewearItemModel>> get eyewearBox =>
      Hive.openBox<EyewearItemModel>(AppKeys.hiveBoxEyewear);
}
