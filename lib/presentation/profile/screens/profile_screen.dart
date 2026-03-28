import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/presentation/profile/widgets/profile_insight.dart';
import 'package:my_eyes/presentation/profile/widgets/profile_summary.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/shortcut_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen.withBottomNavbar(
      bigTitle: AppPages.profile.title,
      child: Column(
        spacing: AppSpacing.spacingM,
        children: [
          const ProfileSummary(),
          const ProfileInsight(),
          ShortcutCard(
            cardTitle: AppStrings.shortcutCalendarEvents,
            cardSubtitle: "3 upcoming events",
            icon: Icons.fiber_new_outlined,
          ),
          ShortcutCard(
            cardTitle: AppStrings.shortcutPrescriptionHistory,
            icon: Icons.fiber_new_outlined,
          ),
        ],
      ),
    );
  }
}
