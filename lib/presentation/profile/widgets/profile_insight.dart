import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/profile/widgets/insight_cards_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ProfileInsight extends StatelessWidget {
  const ProfileInsight({super.key});

  @override
  Widget build(BuildContext context) {
    final bool withLenses = true;

    return CustomContainer(
      icon: Icons.data_saver_off_rounded,
      containerTitle: AppStrings.profileSectionInsight,
      containerChild: withLenses
          ? _buildWithLenses(context)
          : InsightCardsContainer(withLenses: false),
    );
  }

  Widget _buildWithLenses(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        spacing: AppSpacing.spacingM,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.spacingS,
              children: [
                CustomText(text: "${AppStrings.profileLabelLensType}: Monthly"),
                CustomText(
                  text: "${AppStrings.profileLabelLensesRemaining}: 3",
                ),
                Expanded(
                  child: Column(
                    spacing: AppSpacing.spacingS,
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .end,
                    children: [
                      CustomText(text: AppStrings.profileLabelCurrentLens),
                      Container(
                        width: double.infinity,
                        padding: .all(AppSpacing.spacingM),
                        decoration: BoxDecoration(
                          borderRadius: AppBorders.mediumBorderRadius,
                          color: context.colors.textHint,
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .end,
                          children: [
                            CustomText(
                              text: "14",
                              textType: CustomTextType.bigHeading,
                            ),
                            CustomText(
                              text: AppStrings.profileStatDaysLeft
                                  .toUpperCase(),
                              textType: CustomTextType.smallHeading,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IntrinsicWidth(child: InsightCardsContainer(withLenses: true)),
        ],
      ),
    );
  }
}
