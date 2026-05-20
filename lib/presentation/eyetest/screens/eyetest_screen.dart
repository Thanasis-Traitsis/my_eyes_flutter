import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/presentation/eyetest/widgets/steps_container.dart';
import 'package:my_eyes/presentation/eyetest/widgets/steps_grid.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/test_history_container.dart';

class EyetestScreen extends StatelessWidget {
  const EyetestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen.withBottomNavbar(
      bigTitle: AppPages.eyeTest.title,
      child: Column(
        spacing: AppSpacing.spacingM,
        children: [
          CustomContainer(
            icon: Icons.content_paste_go_sharp,
            containerTitle: "test instructions",
            containerChild: CustomText(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Odio vel amet sit id luctus. Et viverra massa commodo diam sapien dignissim lorem sed sem. Condimentum eget pretium nisl pellentesque duis massa. Erat rhoncus massa lectus non sagittis faucibus suspendisse a.",
            ),
          ),
          StepsGrid(
            children: [
              StepsContainer(step: '1st', description: '...'),
              StepsContainer(step: '2nd', description: '...'),
              StepsContainer(step: '3rd', description: '...'),
            ],
          ),
          CustomContainer(
            isDropdown: true,
            buttonText: "all",
            onButtonPressed: () {},
            containerTitle: "test statistics",
            containerChild: CustomText(text: "Small description for the tests"),
          ),
          TestHistoryContainer(),
        ],
      ),
    );
  }
}
