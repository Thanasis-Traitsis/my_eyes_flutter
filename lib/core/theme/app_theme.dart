import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/constants/app_text_sizes.dart';
import 'package:my_eyes/core/theme/app_colors.dart';

class AppTheme {
  static const String appFont = AppStrings.appFont;

  static ThemeData light() => _buildTheme(AppColors.light);
  static ThemeData dark() => _buildTheme(AppColors.dark);

  static ThemeData _buildTheme(AppColors colors) {
    final colorScheme = ColorScheme(
      brightness: colors == AppColors.light
          ? Brightness.light
          : Brightness.dark,
      primary: colors.primary,
      onPrimary: colors.white,
      primaryContainer: colors.primaryLight,
      onPrimaryContainer: colors.textPrimary,
      secondary: colors.secondary,
      onSecondary: colors.white,
      secondaryContainer: colors.primaryLight,
      onSecondaryContainer: colors.textPrimary,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      error: colors.error,
      onError: colors.white,
      outline: colors.divider,
      outlineVariant: colors.divider,
    );

    return ThemeData(
      fontFamily: appFont,
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      extensions: <ThemeExtension<dynamic>>[colors],

      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: colors.background,
        titleTextStyle: TextStyle(
          fontFamily: appFont,
          fontSize: AppTextSizes.textSizeL,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
        actionsIconTheme: IconThemeData(color: colors.textPrimary),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: colors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.largeBorderRadius,
          side: BorderSide(color: colors.divider),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textHint,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        hintStyle: TextStyle(color: colors.textHint, fontFamily: appFont),
        border: OutlineInputBorder(
          borderRadius: AppBorders.mediumBorderRadius,
          borderSide: BorderSide(color: colors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorders.mediumBorderRadius,
          borderSide: BorderSide(color: colors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorders.mediumBorderRadius,
          borderSide: BorderSide(
            color: colors.primary,
            width: AppBorders.mediumBorderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppBorders.mediumBorderRadius,
          borderSide: BorderSide(color: colors.error),
        ),
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: AppBorders.smallBorderWidth,
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textPrimary,
          backgroundColor: colors.surface,
          textStyle: TextStyle(
            fontFamily: appFont,
            fontSize: AppTextSizes.textSizeS,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorders.largeBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacingL,
            vertical: AppSpacing.spacingM,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: AppBorders.mediumBorderRadius,
              side: BorderSide(color: colors.textPrimary),
            ),
          ),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          iconColor: WidgetStatePropertyAll(colors.textPrimary),
        ),
      ),
    );
  }
}
