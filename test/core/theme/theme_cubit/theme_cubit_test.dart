import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/core/constants/app_keys.dart';
import 'package:my_eyes/core/theme/theme_cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences prefs;

  setUp(() {
    prefs = MockSharedPreferences();
  });

  ThemeCubit buildCubit() => ThemeCubit(prefs);

  group('ThemeCubit initial state', () {
    test('defaults to ThemeMode.system', () {
      when(() => prefs.getString(any())).thenReturn(null);
      expect(buildCubit().state.themeMode, ThemeMode.system);
    });
  });

  group('loadTheme', () {
    blocTest<ThemeCubit, ThemeState>(
      'emits light when prefs has "light"',
      build: () {
        when(() => prefs.getString(AppKeys.themeModeKey)).thenReturn('light');
        return buildCubit();
      },
      act: (cubit) => cubit.loadTheme(),
      expect: () => [const ThemeState(themeMode: ThemeMode.light)],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits dark when prefs has "dark"',
      build: () {
        when(() => prefs.getString(AppKeys.themeModeKey)).thenReturn('dark');
        return buildCubit();
      },
      act: (cubit) => cubit.loadTheme(),
      expect: () => [const ThemeState(themeMode: ThemeMode.dark)],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits nothing when prefs has no stored value',
      build: () {
        when(() => prefs.getString(AppKeys.themeModeKey)).thenReturn(null);
        return buildCubit();
      },
      act: (cubit) => cubit.loadTheme(),
      expect: () => [],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits nothing and does not throw when prefs throws',
      build: () {
        when(() => prefs.getString(AppKeys.themeModeKey))
            .thenThrow(Exception('disk error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadTheme(),
      expect: () => [],
      errors: () => [],
    );
  });

  group('setLightTheme', () {
    blocTest<ThemeCubit, ThemeState>(
      'emits ThemeMode.light and persists to prefs',
      build: () {
        when(() => prefs.getString(any())).thenReturn(null);
        when(() => prefs.setString(AppKeys.themeModeKey, 'light'))
            .thenAnswer((_) async => true);
        return buildCubit();
      },
      act: (cubit) => cubit.setLightTheme(),
      expect: () => [const ThemeState(themeMode: ThemeMode.light)],
      verify: (_) {
        verify(() => prefs.setString(AppKeys.themeModeKey, 'light')).called(1);
      },
    );
  });

  group('setDarkTheme', () {
    blocTest<ThemeCubit, ThemeState>(
      'emits ThemeMode.dark and persists to prefs',
      build: () {
        when(() => prefs.getString(any())).thenReturn(null);
        when(() => prefs.setString(AppKeys.themeModeKey, 'dark'))
            .thenAnswer((_) async => true);
        return buildCubit();
      },
      act: (cubit) => cubit.setDarkTheme(),
      expect: () => [const ThemeState(themeMode: ThemeMode.dark)],
      verify: (_) {
        verify(() => prefs.setString(AppKeys.themeModeKey, 'dark')).called(1);
      },
    );
  });

  group('setSystemTheme', () {
    blocTest<ThemeCubit, ThemeState>(
      'emits ThemeMode.system and persists to prefs',
      build: () {
        when(() => prefs.getString(any())).thenReturn(null);
        when(() => prefs.setString(AppKeys.themeModeKey, 'system'))
            .thenAnswer((_) async => true);
        return buildCubit();
      },
      act: (cubit) => cubit.setSystemTheme(),
      expect: () => [const ThemeState(themeMode: ThemeMode.system)],
      verify: (_) {
        verify(() => prefs.setString(AppKeys.themeModeKey, 'system')).called(1);
      },
    );
  });

  group('_saveTheme error handling', () {
    blocTest<ThemeCubit, ThemeState>(
      'still emits state even when prefs.setString throws',
      build: () {
        when(() => prefs.getString(any())).thenReturn(null);
        when(() => prefs.setString(any(), any()))
            .thenThrow(Exception('write error'));
        return buildCubit();
      },
      act: (cubit) => cubit.setDarkTheme(),
      expect: () => [const ThemeState(themeMode: ThemeMode.dark)],
      errors: () => [],
    );
  });
}
