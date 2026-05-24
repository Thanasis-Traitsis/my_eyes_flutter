import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/presentation/newtest/widgets/test_onboarding_overlay.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class NewTestScreen extends StatefulWidget {
  const NewTestScreen({super.key});

  @override
  State<NewTestScreen> createState() => _NewTestScreenState();
}

class _NewTestScreenState extends State<NewTestScreen> {
  bool _onboardingDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingL),
          child: Stack(
            children: [
              const _TestContent(),
              if (!_onboardingDone)
                TestOnboardingOverlay(
                  onDone: () => setState(() => _onboardingDone = true),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestContent extends StatelessWidget {
  const _TestContent();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomText(text: 'Test screen'));
  }
}
