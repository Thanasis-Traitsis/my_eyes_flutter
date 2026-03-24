import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color white;
  final Color black;
  final Color background;
  final Color surface;
  final Color primary;
  final Color primaryLight;
  final Color secondary;
  final Color error;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color divider;
  final Color cardBackground;

  AppColors({
    required this.white,
    required this.black,
    required this.background,
    required this.surface,
    required this.primary,
    required this.primaryLight,
    required this.secondary,
    required this.error,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.divider,
    required this.cardBackground,
  });

  static final AppColors light = AppColors(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    background: const Color(0xFFF4F6FA),
    surface: const Color(0xFFFFFFFF),
    primary: const Color(0xFF1E88E5),
    primaryLight: const Color(0xFFBBDEFB),
    secondary: const Color(0xFF26C6DA),
    error: const Color(0xFFE53935),
    textPrimary: const Color(0xFF1A1A2E),
    textSecondary: const Color(0xFF5A5A72),
    textHint: const Color(0xFF9E9EAF),
    divider: const Color(0xFFE0E0E0),
    cardBackground: const Color(0xFFFFFFFF),
  );

  static final AppColors dark = AppColors(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    background: const Color(0xFF0F1117),
    surface: const Color(0xFF1A1D27),
    primary: const Color(0xFF1E88E5),
    primaryLight: const Color(0xFF1565C0),
    secondary: const Color(0xFF00ACC1),
    error: const Color(0xFFEF5350),
    textPrimary: const Color(0xFFF0F0F5),
    textSecondary: const Color(0xFFB0B0C3),
    textHint: const Color(0xFF6B6B80),
    divider: const Color(0xFF2A2D3A),
    cardBackground: const Color(0xFF1A1D27),
  );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? white,
    Color? black,
    Color? background,
    Color? surface,
    Color? primary,
    Color? primaryLight,
    Color? secondary,
    Color? error,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? divider,
    Color? cardBackground,
  }) {
    return AppColors(
      white: white ?? this.white,
      black: black ?? this.black,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      secondary: secondary ?? this.secondary,
      error: error ?? this.error,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      divider: divider ?? this.divider,
      cardBackground: cardBackground ?? this.cardBackground,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;
    return AppColors(
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
    );
  }
}
