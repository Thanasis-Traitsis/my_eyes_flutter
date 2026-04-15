import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/presentation/profile/widgets/prescription_single_eye_card.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key, required this.username, this.prescription});

  final String username;
  final Prescription? prescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacingL),
      decoration: BoxDecoration(
        color: context.colors.divider,
        borderRadius: AppBorders.largeBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.spacingXL,
        children: [
          IntrinsicHeight(
            child: Row(
              spacing: AppSpacing.spacingM,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: '${AppStrings.profileLabelNickname}:'
                                    .toUpperCase(),
                              ),
                              CustomText(
                                text: username.toUpperCase(),
                                textType: CustomTextType.smallHeading,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
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
          if (prescription != null) _buildPrescriptionSection(prescription!),
        ],
      ),
    );
  }

  Widget _buildPrescriptionSection(Prescription p) {
    String formatEye(eye) => '${eye.sphere} ${eye.cylinder} x ${eye.axis}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  prescription: formatEye(p.leftEye),
                ),
              ),
              Expanded(
                child: PrescriptionSingleEyeCard.isRight(
                  prescription: formatEye(p.rightEye),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
