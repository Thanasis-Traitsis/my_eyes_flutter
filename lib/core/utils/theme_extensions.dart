import 'package:flutter/material.dart';
import 'package:my_eyes/core/theme/app_colors.dart';

extension ThemeExtensions on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}