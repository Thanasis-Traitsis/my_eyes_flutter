import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_text_sizes.dart';
import 'package:my_eyes/core/theme/app_colors.dart';
import 'package:my_eyes/core/theme/app_theme.dart';

enum CustomTextType {
  bigHeading,
  regularHeading,
  smallHeading,
  extraSmallHeading,
  regularBody,
  smallBody,
  bigButtonText,
  regularButtonText,
}

extension CustomFontSize on CustomTextType {
  double get fontSize => switch (this) {
    CustomTextType.bigHeading => AppTextSizes.textSizeXL,
    CustomTextType.regularHeading ||
    CustomTextType.bigButtonText => AppTextSizes.textSizeL,
    CustomTextType.smallHeading => AppTextSizes.textSizeM,
    CustomTextType.regularBody ||
    CustomTextType.extraSmallHeading ||
    CustomTextType.regularButtonText => AppTextSizes.textSizeS,
    CustomTextType.smallBody => AppTextSizes.textSizeXS,
  };
}

extension CustomFontWeight on CustomTextType {
  FontWeight get fontWeight => switch (this) {
    CustomTextType.regularBody || CustomTextType.smallBody => FontWeight.normal,
    _ => FontWeight.bold,
  };
}

extension CustomFontFamily on CustomTextType {
  String get fontFamily => AppTheme.appFont;
}

extension CustomTextStyle on CustomTextType {
  TextStyle getTextStyle(BuildContext context, bool isItalic, {Color? color}) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      color: color ?? appColors.textPrimary,
      height: 1.2,
      leadingDistribution: TextLeadingDistribution.even,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
