import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/date_and_event.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/dotted_line_painter.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/month_tag.dart';
import 'package:my_eyes/presentation/shared/widgets/carousel/custom_carousel.dart';
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
          CustomContainer(
            buttonText: AppStrings.homeButtonEdit,
            onButtonPressed: () {
              NavigationService.push(AppPages.editProfile.path);
            },
            containerTitle: AppStrings.homeSectionPrescription,
            containerChild: state.latestPrescription != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            "${AppStrings.prescriptionOdRight}: ${state.latestPrescription?.formattedRight}",
                      ),
                      CustomText(
                        text:
                            "${AppStrings.prescriptionOsLeft}: ${state.latestPrescription?.formattedLeft}",
                      ),
                    ],
                  )
                : const Center(child: Text("No prescription data found")),
          ),
          CustomContainer(
            buttonText: AppStrings.homeButtonViewAll,
            onButtonPressed: () {},
            containerTitle: AppStrings.homeSectionEyewear,
            containerChild: CustomCarousel(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: .all(AppSpacing.spacingXL),
                  color: context.colors.white,
                  child: CustomText(
                    text: "Page 1",
                    textType: CustomTextType.regularHeading,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: .all(AppSpacing.spacingXL),
                  color: context.colors.white,
                  child: CustomText(
                    text: "Page 2",
                    textType: CustomTextType.regularHeading,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: .all(AppSpacing.spacingXL),
                  color: context.colors.white,
                  child: CustomText(
                    text: "Page 3",
                    textType: CustomTextType.regularHeading,
                  ),
                ),
              ],
            ),
            footerTitle: AppStrings.homeSectionDetails,
            footerContent: Column(
              crossAxisAlignment: .start,
              children: [
                CustomText(
                  text: "${AppStrings.prescriptionOdRight}: -2,50 -0.75 x 180",
                ),
                CustomText(
                  text: "${AppStrings.prescriptionOsLeft}: -2,25 -0.50 x 170",
                ),
              ],
            ),
          ),
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
          ),
          ShortcutCard(
            cardTitle: AppStrings.shortcutAddLenses,
            icon: Icons.fiber_new_outlined,
          ),
        ],
      ),
    );
  }
}
