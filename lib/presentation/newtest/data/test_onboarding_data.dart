import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/test_onboarding_step.dart';

abstract class TestOnboardingData {
  static const List<TestOnboardingStep> steps = [
    TestOnboardingStep(
      stepLabel: AppStrings.eyeTestStep1Label,
      title: AppStrings.eyeTestStep1Title,
      description: AppStrings.eyeTestStep1Description,
      shortDescription: AppStrings.eyeTestStep1Short,
      image: 'assets/images/onboarding_distance.png',
    ),
    TestOnboardingStep(
      stepLabel: AppStrings.eyeTestStep2Label,
      title: AppStrings.eyeTestStep2Title,
      description: AppStrings.eyeTestStep2Description,
      shortDescription: AppStrings.eyeTestStep2Short,
      image: 'assets/images/onboarding_cover.png',
    ),
    TestOnboardingStep(
      stepLabel: AppStrings.eyeTestStep3Label,
      title: AppStrings.eyeTestStep3Title,
      description: AppStrings.eyeTestStep3Description,
      shortDescription: AppStrings.eyeTestStep3Short,
      image: 'assets/images/onboarding_read.png',
    ),
  ];
}
