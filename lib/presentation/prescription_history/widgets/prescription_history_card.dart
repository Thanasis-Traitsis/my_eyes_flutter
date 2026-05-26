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
import 'package:my_eyes/domain/enums/reminder_interval.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class PrescriptionHistoryCard extends StatelessWidget {
  const PrescriptionHistoryCard({super.key, required this.prescription});

  final Prescription prescription;

  String? get _reminderLabel => ReminderInterval.fromMonths(
    prescription.reminderMonths,
  )?.historyLabel.toUpperCase();

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
          color: context.colors.black,
          borderRadius: AppBorders.largeBorderRadius,
        ),
        child: Row(
          spacing: AppSpacing.spacingM,
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Column(
                spacing: AppSpacing.spacingS,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      spacing: AppSpacing.spacingS,
                      crossAxisAlignment: .stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const .symmetric(
                            horizontal: AppSpacing.spacingM,
                            vertical: AppSpacing.spacingS,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.divider,
                            borderRadius: AppBorders.smallBorderRadius,
                            border: Border.all(
                              color: context.colors.textHint,
                              width: AppBorders.smallBorderWidth,
                            ),
                          ),
                          child: CustomText(
                            text: prescription.issueDate.formattedDate,
                            textType: CustomTextType.regularBody,
                          ),
                        ),
                        if (_reminderLabel != null)
                          Container(
                            alignment: Alignment.center,
                            padding: const .symmetric(
                              horizontal: AppSpacing.spacingM,
                              vertical: AppSpacing.spacingS,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              borderRadius: AppBorders.smallBorderRadius,
                              border: Border.all(
                                color: context.colors.primaryLight,
                                width: AppBorders.smallBorderWidth,
                              ),
                            ),
                            child: Row(
                              spacing: AppSpacing.spacingM,
                              mainAxisAlignment: .center,
                              children: [
                                Icon(
                                  Icons.notifications_active,
                                  color: context.colors.white,
                                  size: AppSizes.iconSizeS,
                                ),
                                CustomText(
                                  text: _reminderLabel!,
                                  textType: CustomTextType.regularBody,
                                  color: context.colors.white,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  CustomText(
                    text:
                        '${AppStrings.prescriptionOdRight}: ${prescription.formattedRight}',
                    textType: CustomTextType.extraSmallHeading,
                    color: context.colors.white,
                  ),
                  CustomText(
                    text:
                        '${AppStrings.prescriptionOsLeft}: ${prescription.formattedLeft}',
                    textType: CustomTextType.extraSmallHeading,
                    color: context.colors.white,
                  ),
                  if (prescription.notes != null)
                    CustomText(
                      text: "Note: ${prescription.notes}",
                      textType: CustomTextType.smallBody,
                      color: context.colors.white,
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: context.colors.white,
              size: AppSizes.iconSizeL,
            ),
          ],
        ),
      ),
    );
  }
}
