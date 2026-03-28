import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class PrescriptionSingleEyeCard extends StatelessWidget {
  const PrescriptionSingleEyeCard({
    super.key,
    required this.eyeType,
    required this.prescription,
  });

  final String eyeType;
  final String prescription;

  const PrescriptionSingleEyeCard.isLeft({
    super.key,
    this.eyeType = AppStrings.eyeLeft,
    required this.prescription,
  });

  const PrescriptionSingleEyeCard.isRight({
    super.key,
    this.eyeType = AppStrings.eyeRight,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(AppSpacing.spacingM),
      decoration: BoxDecoration(
        color: context.colors.textHint,
        borderRadius: AppBorders.mediumBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.spacingS,
        children: [
          CustomText(
            text: eyeType.toUpperCase(),
            textType: CustomTextType.smallHeading,
          ),
          CustomText(text: prescription.toUpperCase()),
        ],
      ),
    );
  }
}
