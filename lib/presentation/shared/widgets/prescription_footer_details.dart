import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';

class PrescriptionFooterDetails extends StatelessWidget {
  const PrescriptionFooterDetails({super.key, this.prescription});

  final Prescription? prescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.spacingS,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: AppSpacing.spacingM,
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          children: [
            CustomText(text: '${AppStrings.prescriptionOdRight}:'),
            Expanded(
              child: CustomText(text: prescription.formattedRightOrEmpty),
            ),
          ],
        ),
        Row(
          spacing: AppSpacing.spacingM,
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          children: [
            CustomText(text: '${AppStrings.prescriptionOsLeft}:'),
            Expanded(
              child: CustomText(text: prescription.formattedLeftOrEmpty),
            ),
          ],
        ),
      ],
    );
  }
}
