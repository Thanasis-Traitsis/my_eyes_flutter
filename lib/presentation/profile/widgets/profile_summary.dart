import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/prescription/eye_card.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({
    super.key,
    required this.username,
    this.prescription,
    this.avatarUrl,
  });

  final String username;
  final Prescription? prescription;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacingL),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: AppBorders.largeBorderRadius,
        border: Border.all(
          color: context.colors.textPrimary.withValues(alpha: .4),
          width: AppBorders.smallBorderWidth,
        ),
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
                ClipRRect(
                  borderRadius: AppBorders.mediumBorderRadius,
                  child: avatarUrl != null
                      ? Image.asset(
                          avatarUrl!,
                          width: AppSizes.profileAvatarSize,
                          height: AppSizes.profileAvatarSize,
                          fit: BoxFit.fitHeight,
                        )
                      : Container(
                          width: AppSizes.profileAvatarSize,
                          height: AppSizes.profileAvatarSize,
                          color: context.colors.white,
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
                        child: AppButton.outlined(
                          text: AppStrings.profileButtonEdit,
                          iconAlignment: IconAlignment.end,
                          icon: Icons.arrow_outward,
                          onPressed: () {
                            NavigationService.push(AppPages.editProfile.path);
                          },
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
              EyeCard(
                label: AppStrings.prescriptionOsLeft,
                value: p.formattedLeft,
              ),
              EyeCard(
                label: AppStrings.prescriptionOdRight,
                value: p.formattedRight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
