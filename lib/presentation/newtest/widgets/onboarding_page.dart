import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/test_onboarding_step.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.step});

  final TestOnboardingStep step;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                spacing: AppSpacing.spacingL,
                crossAxisAlignment: .start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: AppBorders.largeBorderRadius,
                      child: Image.asset(
                        step.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.colors.divider,
                            borderRadius: AppBorders.largeBorderRadius,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: AppSpacing.spacingM,
                      children: [
                        CustomText(
                          text: step.title,
                          textType: CustomTextType.regularHeading,
                        ),
                        CustomText(
                          text: step.description,
                          textType: CustomTextType.regularBody,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
