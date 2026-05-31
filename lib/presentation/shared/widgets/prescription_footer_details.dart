import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/enums/eye_side.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class PrescriptionFooterDetails extends StatelessWidget {
  const PrescriptionFooterDetails({
    super.key,
    this.prescription,
    this.selectedSide,
  });

  final Prescription? prescription;
  final EyeSide? selectedSide;

  @override
  Widget build(BuildContext context) {
    final showRight = selectedSide == null || selectedSide == EyeSide.right;
    final showLeft = selectedSide == null || selectedSide == EyeSide.left;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacingM),
      decoration: BoxDecoration(
        color: context.colors.tintBlue,
        borderRadius: AppBorders.smallBorderRadius,
      ),
      child: Column(
        spacing: AppSpacing.spacingM,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showRight)
            Row(
              spacing: AppSpacing.spacingM,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: '${AppStrings.prescriptionOdRight}:',
                  textType: CustomTextType.smallHeading,
                  color: context.colors.primary,
                ),
                Expanded(
                  child: CustomText(text: prescription.formattedRightOrEmpty),
                ),
              ],
            ),
          if (showLeft)
            Row(
              spacing: AppSpacing.spacingM,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: '${AppStrings.prescriptionOsLeft}:',
                  textType: CustomTextType.smallHeading,
                  color: context.colors.primary,
                ),
                Expanded(
                  child: CustomText(text: prescription.formattedLeftOrEmpty),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
