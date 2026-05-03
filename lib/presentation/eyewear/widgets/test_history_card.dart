import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class TestHistoryCard extends StatelessWidget {
  const TestHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(AppSpacing.spacingM),
      decoration: BoxDecoration(
        color: context.colors.black,
        borderRadius: AppBorders.largeBorderRadius,
      ),
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
            child: CustomText(
              text: '65%',
              textType: CustomTextType.smallHeading,
            ),
          ),
          Expanded(
            child: Column(
              spacing: AppSpacing.spacingS,
              crossAxisAlignment: .start,
              children: [
                CustomText(
                  text: "near-sighted glasses".toUpperCase(),
                  textType: CustomTextType.extraSmallHeading,
                  color: context.colors.white,
                ),
                CustomText(
                  text: "22/06/2026",
                  textType: CustomTextType.smallBody,
                  color: context.colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
