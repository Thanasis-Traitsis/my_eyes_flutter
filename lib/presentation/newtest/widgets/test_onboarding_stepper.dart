import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
import 'package:my_eyes/presentation/shared/widgets/carousel/carousel_page_indicator.dart';

class TestOnboardingStepper extends StatelessWidget {
  const TestOnboardingStepper({
    super.key,
    required this.totalSteps,
    required this.currentIndex,
    required this.onSkip,
  });

  final int totalSteps;
  final int currentIndex;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacingS,
      mainAxisAlignment: .spaceBetween,
      children: [
        Flexible(
          child: AppButton.outlined(
            text: AppStrings.eyeTestOnboardingExit,
            onPressed: NavigationService.pop,
          ),
        ),
        CarouselPageIndicator(
          indicatorsCount: totalSteps,
          currentIndex: currentIndex,
        ),
        Flexible(
          child: AppButton.outlined(
            text: AppStrings.eyeTestOnboardingSkip,
            onPressed: onSkip,
          ),
        ),
      ],
    );
  }
}
