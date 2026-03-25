import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/shortcut_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      regularTitle: "Good Morning",
      subtitle: "Thanasis",
      suffixButtons: [
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
      ],
      child: Column(
        spacing: AppSpacing.spacingM,
        children: [
          CustomContainer(
            icon: Icons.notification_important,
            containerTitle: "Random notification title",
            containerChild: CustomText(
              text: "Random notification description text",
            ),
          ),
          CustomContainer(
            buttonText: "edit",
            onButtonPressed: () {},
            containerTitle: "Current prescription",
            containerChild: Column(
              crossAxisAlignment: .start,
              children: [
                CustomText(text: "OD (Right): -2,50 -0.75 x 180"),
                CustomText(text: "OS (Left): -2,25 -0.50 x 170"),
              ],
            ),
          ),
          CustomContainer(
            buttonText: "view all",
            onButtonPressed: () {},
            containerTitle: "my eyewear collection",
            containerChild: Container(
              margin: .symmetric(vertical: AppSpacing.spacingM),
              width: double.infinity,
              height: 200,
              color: context.colors.white,
            ),
            footerTitle: "details",
            footerContent: Column(
              crossAxisAlignment: .start,
              children: [
                CustomText(text: "OD (Right): -2,50 -0.75 x 180"),
                CustomText(text: "OS (Left): -2,25 -0.50 x 170"),
              ],
            ),
          ),
          CustomContainer(
            icon: Icons.calendar_month,
            buttonText: "add new",
            onButtonPressed: () {},
            containerTitle: "upcoming",
            containerChild: CustomText(text: "Calendar events"),
          ),
          ShortcutCard(
            cardTitle: "add new prescription",
            icon: Icons.fiber_new_outlined,
          ),
          ShortcutCard(
            cardTitle: "add new lenses",
            icon: Icons.fiber_new_outlined,
          ),
        ],
      ),
    );
  }
}
