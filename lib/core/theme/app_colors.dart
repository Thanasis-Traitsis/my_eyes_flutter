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
  final Color errorLight;
  final Color success;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color divider;
  final Color cardBackground;
  final Color tintBlue;
  final Color tintPink;
  final Color tintMint;
  final Color tintLavender;
  final Color tintPeach;
  final Color tintPinkDark;
  final Color tintMintDark;
  final Color tintLavenderDark;
  final Color tintPeachDark;

  AppColors({
    required this.white,
    required this.black,
    required this.background,
    required this.surface,
    required this.primary,
    required this.primaryLight,
    required this.secondary,
    required this.error,
    required this.errorLight,
    required this.success,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.divider,
    required this.cardBackground,
    required this.tintBlue,
    required this.tintPink,
    required this.tintMint,
    required this.tintLavender,
    required this.tintPeach,
    required this.tintPinkDark,
    required this.tintMintDark,
    required this.tintLavenderDark,
    required this.tintPeachDark,
  });

  static final AppColors light = AppColors(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    background: const Color(0xFFF1F3F9),
    surface: const Color(0xFFFFFFFF),
    primary: const Color(0xFF2563CC),
    primaryLight: const Color(0xFFE4ECFB),
    secondary: const Color(0xFF1F8A5B),
    error: const Color(0xFFD23B43),
    errorLight: const Color(0xFFFBE0E2),
    success: const Color(0xFF1F8A5B),
    textPrimary: const Color(0xFF15171F),
    textSecondary: const Color(0xFF5A5A72),
    textHint: const Color(0xFF9E9EAF),
    divider: const Color(0xFFE0E0E0),
    cardBackground: const Color(0xFFFFFFFF),
    tintBlue: const Color(0xFFDEE9FB),
    tintPink: const Color(0xFFFAE0EA),
    tintMint: const Color(0xFFDCF0E6),
    tintLavender: const Color(0xFFE9E6FB),
    tintPeach: const Color(0xFFFCE7DA),
    tintPinkDark: const Color(0xFFC2376B),
    tintMintDark: const Color(0xFF1F8A5B),
    tintLavenderDark: const Color(0xFF5E50C4),
    tintPeachDark: const Color(0xFFD1763C),
  );

  static final AppColors dark = AppColors(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    background: const Color(0xFF0F1117),
    surface: const Color(0xFF1A1D27),
    primary: const Color(0xFF4D85E0),
    primaryLight: const Color(0xFF1E2A40),
    secondary: const Color(0xFF2AAF72),
    error: const Color(0xFFEF5350),
    errorLight: const Color(0xFF3A1E20),
    success: const Color(0xFF2AAF72),
    textPrimary: const Color(0xFFF0F0F5),
    textSecondary: const Color(0xFFB0B0C3),
    textHint: const Color(0xFF6B6B80),
    divider: const Color(0xFF2A2D3A),
    cardBackground: const Color(0xFF1A1D27),
    tintBlue: const Color(0xFF1A2540),
    tintPink: const Color(0xFF2E1A22),
    tintMint: const Color(0xFF152A20),
    tintLavender: const Color(0xFF201E30),
    tintPeach: const Color(0xFF2E1E14),
    tintPinkDark: const Color(0xFFE86A9B),
    tintMintDark: const Color(0xFF2AAF72),
    tintLavenderDark: const Color(0xFF8A7DE8),
    tintPeachDark: const Color(0xFFE89A63),
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
    Color? errorLight,
    Color? success,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? divider,
    Color? cardBackground,
    Color? tintBlue,
    Color? tintPink,
    Color? tintMint,
    Color? tintLavender,
    Color? tintPeach,
    Color? tintPinkDark,
    Color? tintMintDark,
    Color? tintLavenderDark,
    Color? tintPeachDark,
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
      errorLight: errorLight ?? this.errorLight,
      success: success ?? this.success,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      divider: divider ?? this.divider,
      cardBackground: cardBackground ?? this.cardBackground,
      tintBlue: tintBlue ?? this.tintBlue,
      tintPink: tintPink ?? this.tintPink,
      tintMint: tintMint ?? this.tintMint,
      tintLavender: tintLavender ?? this.tintLavender,
      tintPeach: tintPeach ?? this.tintPeach,
      tintPinkDark: tintPinkDark ?? this.tintPinkDark,
      tintMintDark: tintMintDark ?? this.tintMintDark,
      tintLavenderDark: tintLavenderDark ?? this.tintLavenderDark,
      tintPeachDark: tintPeachDark ?? this.tintPeachDark,
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
      errorLight: Color.lerp(errorLight, other.errorLight, t)!,
      success: Color.lerp(success, other.success, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      tintBlue: Color.lerp(tintBlue, other.tintBlue, t)!,
      tintPink: Color.lerp(tintPink, other.tintPink, t)!,
      tintMint: Color.lerp(tintMint, other.tintMint, t)!,
      tintLavender: Color.lerp(tintLavender, other.tintLavender, t)!,
      tintPeach: Color.lerp(tintPeach, other.tintPeach, t)!,
      tintPinkDark: Color.lerp(tintPinkDark, other.tintPinkDark, t)!,
      tintMintDark: Color.lerp(tintMintDark, other.tintMintDark, t)!,
      tintLavenderDark: Color.lerp(
        tintLavenderDark,
        other.tintLavenderDark,
        t,
      )!,
      tintPeachDark: Color.lerp(tintPeachDark, other.tintPeachDark, t)!,
    );
  }
}
