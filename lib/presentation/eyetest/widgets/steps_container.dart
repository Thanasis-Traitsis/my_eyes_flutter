import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class StepsContainer extends StatelessWidget {
  const StepsContainer({
    super.key,
    required this.step,
    required this.description,
  });

  final String step;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.spacingL),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.spacingS,
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.spacingM),
                decoration: BoxDecoration(
                  color: context.colors.tintBlue,
                  borderRadius: AppBorders.smallBorderRadius,
                ),
                child: CustomText(
                  text: step,
                  textType: CustomTextType.smallHeading,
                  color: context.colors.primary,
                ),
              ),
              CustomText(
                text: AppStrings.eyeTestStep.toUpperCase(),
                textType: CustomTextType.regularHeading,
                color: context.colors.primary,
              ),
            ],
          ),
          CustomText(text: description),
        ],
      ),
    );
  }
}
