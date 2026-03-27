import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/network/connectivity_cubit/connectivity_cubit.dart';
import 'package:my_eyes/core/network/connectivity_service.dart';
import 'package:my_eyes/core/router/app_router.dart';
import 'package:my_eyes/core/theme/app_theme.dart';
import 'package:my_eyes/core/theme/theme_cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final themeCubit = ThemeCubit(prefs);
  await themeCubit.loadTheme();

  final connectivityService = ConnectivityService(Connectivity());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeCubit),
        BlocProvider(create: (_) => ConnectivityCubit(connectivityService)),
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
