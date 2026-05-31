import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/label_tag.dart';
import 'package:my_eyes/presentation/shared/widgets/prescription/eye_card.dart';

class PrescriptionHistoryCard extends StatelessWidget {
  const PrescriptionHistoryCard({
    super.key,
    required this.prescription,
    this.isLatest = false,
  });

  final Prescription prescription;
  final bool isLatest;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.push(
        AppPages.prescriptionEdit.path,
        extra: prescription,
      ),
      child: Container(
        padding: const .all(AppSpacing.spacingL),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: AppBorders.largeBorderRadius,
          border: Border.all(
            color: isLatest
                ? context.colors.primary
                : context.colors.primary.withValues(alpha: .4),
            width: isLatest
                ? AppBorders.mediumBorderWidth
                : AppBorders.smallBorderWidth,
          ),
        ),
        child: Row(
          spacing: AppSpacing.spacingM,
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Column(
                spacing: AppSpacing.spacingM,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isLatest)
                    LabelTag(label: AppStrings.prescriptionHistoryCurrentTag),
                  CustomText(
                    text: prescription.issueDate.formattedDate,
                    textType: CustomTextType.smallHeading,
                  ),
                  Row(
                    spacing: AppSpacing.spacingM,
                    children: [
                      EyeCard.small(
                        label: AppStrings.prescriptionOsLeft,
                        value: prescription.formattedLeft,
                      ),
                      EyeCard.small(
                        label: AppStrings.prescriptionOdRight,
                        value: prescription.formattedRight,
                      ),
                    ],
                  ),
                  if (prescription.notes != null)
                    CustomText(
                      text: AppStrings.noteLabel(prescription.notes!),
                      textType: CustomTextType.smallBody,
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: context.colors.textPrimary,
              size: AppSizes.iconSizeL,
            ),
          ],
        ),
      ),
    );
  }
}
