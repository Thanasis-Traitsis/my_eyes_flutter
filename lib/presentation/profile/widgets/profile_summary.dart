import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/profile/widgets/prescription_single_eye_card.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(AppSpacing.spacingL),
      decoration: BoxDecoration(
        color: context.colors.divider,
        borderRadius: AppBorders.largeBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.spacingXL,
        children: [
          IntrinsicHeight(
            child: Row(
              spacing: AppSpacing.spacingM,
              crossAxisAlignment: .start,
              children: [
                Container(
                  width: AppSizes.profileAvatarSize,
                  height: AppSizes.profileAvatarSize,
                  decoration: BoxDecoration(
                    color: context.colors.white,
                    borderRadius: AppBorders.mediumBorderRadius,
                  ),
                ),
                Expanded(
                  child: Row(
                    spacing: AppSpacing.spacingM,
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentGeometry.bottomLeft,
                          child: Column(
                            crossAxisAlignment: .start,
                            mainAxisAlignment: .end,
                            children: [
                              CustomText(
                                text: "${AppStrings.profileLabelNickname}:"
                                    .toUpperCase(),
                              ),
                              CustomText(
                                text: 'Thanasis'.toUpperCase(),
                                textType: CustomTextType.smallHeading,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentGeometry.topRight,
                        child: OutlinedButton.icon(
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(
                            Icons.arrow_outward,
                            size: AppSizes.iconSizeS,
                          ),
                          label: Text(
                            AppStrings.profileButtonEdit.toUpperCase(),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: .start,
            spacing: AppSpacing.spacingM,
            children: [
              CustomText(
                text: AppStrings.profileSectionPrescription.toUpperCase(),
                textType: CustomTextType.smallHeading,
              ),
              IntrinsicHeight(
                child: Row(
                  spacing: AppSpacing.spacingS,
                  children: [
                    Expanded(
                      child: PrescriptionSingleEyeCard.isLeft(
                        prescription: "-2,25 -0.50 x 170",
                      ),
                    ),
                    Expanded(
                      child: PrescriptionSingleEyeCard.isRight(
                        prescription: "-2,50 -0.75 x 180",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
