import 'package:my_eyes/domain/entities/test_onboarding_step.dart';

abstract class TestOnboardingData {
  static const List<TestOnboardingStep> steps = [
    TestOnboardingStep(
      stepLabel: '1st',
      title: 'Find the right distance',
      description:
          'Hold your device at arm\'s length — about 40 cm away from your eyes. Make sure you are in a well-lit room.',
      shortDescription: 'Hold device ~40 cm away in a well-lit room.',
      image: 'assets/images/onboarding_distance.png',
    ),
    TestOnboardingStep(
      stepLabel: '2nd',
      title: 'Cover one eye',
      description:
          'Use your hand or a piece of paper to cover one eye at a time. Keep both eyes open to avoid straining.',
      shortDescription: 'Cover one eye at a time with your hand.',
      image: 'assets/images/onboarding_cover.png',
    ),
    TestOnboardingStep(
      stepLabel: '3rd',
      title: 'Read each line carefully',
      description:
          'Read the letters on screen from top to bottom. Stop when the letters become too blurry to identify.',
      shortDescription: 'Read top to bottom, stop when lines blur.',
      image: 'assets/images/onboarding_read.png',
    ),
  ];
}
