import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class EyeCard extends StatelessWidget {
  const EyeCard({
    super.key,
    required this.label,
    required this.value,
    this.paddingSpacing = AppSpacing.spacingL,
    this.textType = CustomTextType.smallHeading,
  });
  const EyeCard.small({
    super.key,
    required this.label,
    required this.value,
    this.paddingSpacing = AppSpacing.spacingM,
    this.textType = CustomTextType.extraSmallHeading,
  });

  final String label;
  final String value;
  final double paddingSpacing;
  final CustomTextType textType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: paddingSpacing,
          vertical: AppSpacing.spacingM,
        ),
        decoration: BoxDecoration(
          color: context.colors.tintBlue,
          borderRadius: AppBorders.mediumBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.spacingS,
          children: [
            CustomText(
              text: label,
              textType: textType,
              color: context.colors.primary,
            ),
            CustomText(text: value),
          ],
        ),
      ),
    );
  }
}
