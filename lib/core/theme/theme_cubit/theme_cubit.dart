import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_keys.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._prefs) : super(const ThemeState());

  final SharedPreferences _prefs;

  Future<void> loadTheme() async {
    try {
      final stored = _prefs.getString(AppKeys.themeModeKey);
      if (stored != null) {
        emit(state.copyWith(themeMode: ThemeMode.values.byName(stored)));
      }
    } catch (e) {
      debugPrint('${AppStrings.devThemeLoadError}: $e');
    }
  }

  Future<void> setLightTheme() async {
    emit(state.copyWith(themeMode: ThemeMode.light));
    await _saveTheme(ThemeMode.light);
  }

  Future<void> setDarkTheme() async {
    emit(state.copyWith(themeMode: ThemeMode.dark));
    await _saveTheme(ThemeMode.dark);
  }

  Future<void> setSystemTheme() async {
    emit(state.copyWith(themeMode: ThemeMode.system));
    await _saveTheme(ThemeMode.system);
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    try {
      await _prefs.setString(AppKeys.themeModeKey, themeMode.name);
    } catch (e) {
      debugPrint('${AppStrings.devThemeSaveError}: $e');
    }
  }
}
