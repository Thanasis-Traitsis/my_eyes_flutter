import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/date_and_event.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/dotted_line_painter.dart';
import 'package:my_eyes/presentation/shared/widgets/calendar/month_tag.dart';
import 'package:my_eyes/presentation/shared/widgets/carousel/custom_carousel.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/shortcut_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen.withBottomNavbar(
      regularTitle: "Good Morning",
      subtitle: "Thanasis",
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
