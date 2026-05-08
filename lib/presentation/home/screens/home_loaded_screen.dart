import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/presentation/home/widgets/home_current_prescription.dart';
import 'package:my_eyes/presentation/home/widgets/home_eyewear_collection.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/date_and_event.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/dotted_line_painter.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/month_tag.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/shortcut_card.dart';

class HomeLoadedScreen extends StatelessWidget {
  const HomeLoadedScreen({super.key, required this.state});

  final ProfileLoaded state;

  @override
  Widget build(BuildContext context) {
    return CustomScreen.withBottomNavbar(
      regularTitle: AppStrings.greetingMorning,
      subtitle: state.profile.username,
      suffixButtons: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            NavigationService.push(AppPages.notifications.path);
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            NavigationService.push(AppPages.settings.path);
          },
        ),
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
          HomeCurrentPrescription(latestPrescription: state.latestPrescription),
          const HomeEyewearCollection(),
          CustomContainer(
            icon: Icons.calendar_month,
            buttonText: AppStrings.homeButtonAddNew,
            onButtonPressed: () {},
            containerTitle: AppStrings.homeSectionUpcoming,
            containerChild: Stack(
              children: [
                Positioned(
                  left: AppSpacing.spacingM,
                  top: 0,
                  bottom: AppSpacing.spacingS,
                  child: CustomPaint(painter: DottedLinePainter()),
                ),
                Column(
                  crossAxisAlignment: .start,
                  spacing: AppSpacing.spacingL,
                  children: [
                    MonthTag(monthText: 'March 2025'),
                    DateAndEvent(date: 25, event: 'Lens replacement'),
                    DateAndEvent(date: 16, event: 'Lens replacement'),
                    MonthTag(monthText: 'January 2025'),
                    DateAndEvent(date: 28, event: 'Lens replacement'),
                  ],
                ),
              ],
            ),
          ),
          ShortcutCard(
            cardTitle: AppStrings.shortcutAddPrescription,
            icon: Icons.fiber_new_outlined,
            onTap: () {},
          ),
          ShortcutCard(
            cardTitle: AppStrings.shortcutAddLenses,
            icon: Icons.fiber_new_outlined,
            onTap: () {
              NavigationService.push(
                AppPages.eyewearNew.path,
                extra: EyewearCategory.contactLenses,
              );
            },
          ),
        ],
      ),
    );
  }
}
