import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ShortcutCard extends StatelessWidget {
  const ShortcutCard({super.key, required this.cardTitle, required this.icon});

  final String cardTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.divider,
      borderRadius: AppBorders.largeBorderRadius,
      child: InkWell(
        onTap: () {},
        borderRadius: AppBorders.largeBorderRadius,
        child: Padding(
          padding: .all(AppSpacing.spacingL),
          child: Row(
            spacing: AppSpacing.spacingM,
            crossAxisAlignment: .center,
            children: [
              Container(
                padding: .all(AppSpacing.spacingM),
                decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: AppBorders.mediumBorderRadius,
                ),
                child: Icon(icon, size: AppSizes.iconSizeL),
              ),
              Expanded(
                child: CustomText(
                  text: cardTitle.toUpperCase(),
                  textType: CustomTextType.smallHeading,
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
