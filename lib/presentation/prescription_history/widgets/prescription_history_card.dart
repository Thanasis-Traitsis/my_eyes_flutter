import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
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

class PrescriptionHistoryCard extends StatelessWidget {
  const PrescriptionHistoryCard({super.key, required this.prescription});

  final Prescription prescription;

  String? get _reminderLabel => switch (prescription.reminderMonths) {
    3 => AppStrings.prescriptionHistoryReminder3M,
    6 => AppStrings.prescriptionHistoryReminder6M,
    12 => AppStrings.prescriptionHistoryReminder1Y,
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.push(
        AppPages.prescriptionEdit.path,
        extra: prescription,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacingM),
        decoration: BoxDecoration(
          color: context.colors.black,
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
                text: prescription.issueDate.formattedDate,
                textType: CustomTextType.extraSmallHeading,
              ),
            ),
            Expanded(
              child: Column(
                spacing: AppSpacing.spacingS,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        '${AppStrings.prescriptionOdRight}: ${prescription.formattedRight}',
                    textType: CustomTextType.smallBody,
                    color: context.colors.white,
                  ),
                  CustomText(
                    text:
                        '${AppStrings.prescriptionOsLeft}: ${prescription.formattedLeft}',
                    textType: CustomTextType.smallBody,
                    color: context.colors.white,
                  ),
                  if (prescription.doctor != null &&
                      prescription.doctor!.isNotEmpty)
                    CustomText(
                      text: prescription.doctor!,
                      textType: CustomTextType.xSmallBody,
                      color: context.colors.white,
                    ),
                  if (_reminderLabel != null)
                    CustomText(
                      text: _reminderLabel!,
                      textType: CustomTextType.xSmallBody,
                      color: context.colors.white,
                    ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: context.colors.white),
          ],
        ),
      ),
    );
  }
}
