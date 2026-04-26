import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/dev/dev_seeder.dart';
import 'package:my_eyes/core/network/connectivity_cubit/connectivity_cubit.dart';
import 'package:my_eyes/core/router/app_router.dart';
import 'package:my_eyes/core/storage/hive_setup.dart';
import 'package:my_eyes/core/theme/app_theme.dart';
import 'package:my_eyes/core/theme/theme_cubit/theme_cubit.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/domain/repositories/profile_repository.dart';
import 'package:my_eyes/injection.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await configureDependencies();
  await getIt<ThemeCubit>().loadTheme();

  if (kDebugMode) {
    await DevSeeder.seed(
      profileRepo: getIt<ProfileRepository>(),
      prescriptionRepo: getIt<PrescriptionRepository>(),
    );
  }

  await getIt<ProfileCubit>().loadProfile();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ThemeCubit>()),
        BlocProvider.value(value: getIt<ConnectivityCubit>()),
        BlocProvider.value(value: getIt<ProfileCubit>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      themeMode: themeState.themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: AppRouter.router,
    );
  }
}
