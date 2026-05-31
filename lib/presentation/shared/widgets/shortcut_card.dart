import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ShortcutCard extends StatelessWidget {
  const ShortcutCard({
    super.key,
    required this.cardTitle,
    this.cardSubtitle,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  final String cardTitle;
  final String? cardSubtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: AppBorders.largeBorderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorders.largeBorderRadius,
        child: Container(
          padding: .all(AppSpacing.spacingL),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: AppBorders.largeBorderRadius,
            border: Border.all(
              color: context.colors.textPrimary.withValues(alpha: .4),
              width: AppBorders.smallBorderWidth,
            ),
          ),
          child: Row(
            spacing: AppSpacing.spacingM,
            crossAxisAlignment: .center,
            children: [
              Container(
                padding: .all(AppSpacing.spacingM),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: AppBorders.mediumBorderRadius,
                ),
                child: Icon(icon, size: AppSizes.iconSizeL, color: iconColor),
              ),
              Expanded(
                child: Column(
                  spacing: AppSpacing.spacingS,
                  crossAxisAlignment: .start,
                  children: [
                    CustomText(
                      text: cardTitle.toUpperCase(),
                      textType: CustomTextType.smallHeading,
                    ),
                    if (cardSubtitle != null) CustomText(text: cardSubtitle!),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, size: AppSizes.iconSizeL),
            ],
          ),
        ),
      ),
    );
  }
}
