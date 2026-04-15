// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:injectable/injectable.dart' as _i526;
import 'package:my_eyes/core/network/connectivity_cubit/connectivity_cubit.dart'
    as _i645;
import 'package:my_eyes/core/network/connectivity_service.dart' as _i586;
import 'package:my_eyes/core/theme/theme_cubit/theme_cubit.dart' as _i1000;
import 'package:my_eyes/data/datasources/prescription_local_datasource.dart'
    as _i844;
import 'package:my_eyes/data/datasources/profile_local_datasource.dart'
    as _i776;
import 'package:my_eyes/data/models/prescription_model.dart' as _i369;
import 'package:my_eyes/data/models/user_profile_model.dart' as _i534;
import 'package:my_eyes/data/repositories/prescription_repository_impl.dart'
    as _i683;
import 'package:my_eyes/data/repositories/profile_repository_impl.dart'
    as _i183;
import 'package:my_eyes/domain/repositories/prescription_repository.dart'
    as _i852;
import 'package:my_eyes/domain/repositories/profile_repository.dart' as _i622;
import 'package:my_eyes/injection.dart' as _i122;
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart' as _i281;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i895.Connectivity>(() => registerModule.connectivity);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    await gh.singletonAsync<_i738.Box<_i369.PrescriptionModel>>(
      () => registerModule.prescriptionBox,
      preResolve: true,
    );
    await gh.singletonAsync<_i738.Box<_i534.UserProfileModel>>(
      () => registerModule.profileBox,
      preResolve: true,
    );
    gh.lazySingleton<_i844.PrescriptionLocalDataSource>(
      () => _i844.HivePrescriptionLocalDataSource(
        gh<_i738.Box<_i369.PrescriptionModel>>(),
      ),
    );
    gh.singleton<_i586.ConnectivityService>(
      () => _i586.ConnectivityService(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i776.ProfileLocalDataSource>(
      () => _i776.HiveProfileLocalDataSource(
        gh<_i738.Box<_i534.UserProfileModel>>(),
      ),
    );
    gh.singleton<_i1000.ThemeCubit>(
      () => _i1000.ThemeCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i852.PrescriptionRepository>(
      () => _i683.PrescriptionRepositoryImpl(
        gh<_i844.PrescriptionLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i622.ProfileRepository>(
      () => _i183.ProfileRepositoryImpl(gh<_i776.ProfileLocalDataSource>()),
    );
    gh.singleton<_i645.ConnectivityCubit>(
      () => _i645.ConnectivityCubit(gh<_i586.ConnectivityService>()),
    );
    gh.factory<_i281.ProfileCubit>(
      () => _i281.ProfileCubit(
        gh<_i622.ProfileRepository>(),
        gh<_i852.PrescriptionRepository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i122.RegisterModule {}
