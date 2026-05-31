import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class TestHistoryCard extends StatelessWidget {
  const TestHistoryCard({super.key, required this.test});

  final EyewearTest test;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacingM),
      decoration: BoxDecoration(
        color: context.colors.textPrimary,
        borderRadius: AppBorders.largeBorderRadius,
      ),
      child: Row(
        spacing: AppSpacing.spacingM,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.spacingM),
            decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: AppBorders.mediumBorderRadius,
            ),
            child: CustomText(
              text: '${test.score}%',
              textType: CustomTextType.smallHeading,
            ),
          ),
          Expanded(
            child: Column(
              spacing: AppSpacing.spacingS,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: test.id.toUpperCase(),
                  textType: CustomTextType.extraSmallHeading,
                  color: context.colors.white,
                ),
                CustomText(
                  text: test.takenAt.formattedDate,
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
