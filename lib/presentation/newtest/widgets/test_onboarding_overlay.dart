import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/test_onboarding_step.dart';
import 'package:my_eyes/presentation/newtest/data/test_onboarding_data.dart';
import 'package:my_eyes/presentation/newtest/widgets/onboarding_page.dart';
import 'package:my_eyes/presentation/newtest/widgets/test_onboarding_stepper.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

class TestOnboardingOverlay extends StatefulWidget {
  const TestOnboardingOverlay({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  State<TestOnboardingOverlay> createState() => _TestOnboardingOverlayState();
}

class _TestOnboardingOverlayState extends State<TestOnboardingOverlay> {
  final List<TestOnboardingStep> _steps = TestOnboardingData.steps;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  bool get _isLastStep => _currentIndex == _steps.length - 1;
  bool get _isFirstStep => _currentIndex == 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLastStep) {
      widget.onDone();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previous() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.background,
      child: Column(
        spacing: AppSpacing.spacingL,
        children: [
          TestOnboardingStepper(
            totalSteps: _steps.length,
            currentIndex: _currentIndex,
            onSkip: widget.onDone,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemCount: _steps.length,
              itemBuilder: (_, index) => OnboardingPage(step: _steps[index]),
            ),
          ),
          Row(
            spacing: AppSpacing.spacingM,
            children: [
              if (!_isFirstStep)
                Expanded(
                  child: AppButton.outlined(
                    text: AppStrings.eyeTestOnboardingPrevious,
                    onPressed: _previous,
                  ),
                ),
              Expanded(
                child: _isLastStep
                    ? AppButton.filled(
                        text: AppStrings.eyeTestOnboardingStart,
                        onPressed: _next,
                      )
                    : AppButton.outlined(
                        text: AppStrings.eyeTestOnboardingNext,
                        onPressed: _next,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
