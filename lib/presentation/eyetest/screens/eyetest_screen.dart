import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/eyetest/widgets/statistics_section.dart';
import 'package:my_eyes/presentation/eyetest/widgets/steps_container.dart';
import 'package:my_eyes/presentation/eyetest/widgets/steps_grid.dart';
import 'package:my_eyes/presentation/newtest/data/test_onboarding_data.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/floating_button_section.dart';
import 'package:my_eyes/presentation/shared/widgets/test_history_container.dart';

class EyetestScreen extends StatelessWidget {
  const EyetestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScreen.withBottomNavbar(
          bigTitle: AppPages.eyeTest.title,
          child: Column(
            spacing: AppSpacing.spacingM,
            children: [
              CustomContainer(
                icon: Icons.content_paste_go_sharp,
                containerTitle: AppStrings.eyeTestInstructionHeader,
                containerChild: CustomText(
                  text: AppStrings.eyeTestInstructionDescription,
                ),
                iconColor: context.colors.primary,
                iconBackgroundColor: context.colors.tintBlue,
              ),
              StepsGrid(
                children: [
                  for (final step in TestOnboardingData.steps)
                    StepsContainer(
                      step: step.stepLabel,
                      description: step.shortDescription,
                    ),
                ],
              ),
              const StatisticsSection(),
              TestHistoryContainer(),
            ],
          ),
        ),
        FloatingButtonSection(
          buttonText: AppStrings.eyeTestFloatingButtonText,
          buttonIcon: Icons.add,
          onTap: () => NavigationService.push(AppPages.newEyeTest.path),
        ),
      ],
    );
  }
}
