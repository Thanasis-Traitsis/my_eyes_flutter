import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/presentation/calendar/cubit/calendar_event_cubit.dart';
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

  List<Widget> _buildEventWidgets(List<CalendarEvent> events) {
    final sorted = [...events]..sort((a, b) => a.date.compareTo(b.date));
    final widgets = <Widget>[];
    String? currentMonth;
    for (final event in sorted) {
      final monthLabel = event.date.formattedMonth;
      if (monthLabel != currentMonth) {
        widgets.add(MonthTag(monthText: monthLabel));
        currentMonth = monthLabel;
      }
      widgets.add(DateAndEvent(date: event.date.day, event: event.title));
    }
    return widgets;
  }

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
          HomeCurrentPrescription(latestPrescription: state.latestPrescription),
          const HomeEyewearCollection(),
          BlocBuilder<CalendarEventCubit, CalendarEventState>(
            builder: (context, calendarState) {
              final events = calendarState is CalendarEventLoaded
                  ? calendarState.upcoming
                  : <CalendarEvent>[];

              return CustomContainer(
                icon: Icons.calendar_month,
                buttonText: AppStrings.homeButtonAddNew,
                onButtonPressed: () {
                  NavigationService.push(AppPages.calendarEventNew.path);
                },
                containerTitle: AppStrings.homeSectionUpcoming,
                iconColor: context.colors.tintMintDark,
                iconBackgroundColor: context.colors.tintMint,
                containerChild: events.isEmpty
                    ? Center(
                        child: CustomText(
                          text: AppStrings.homeSectionUpcomingEmpty,
                        ),
                      )
                    : Stack(
                        children: [
                          Positioned(
                            left: AppSpacing.spacingM,
                            top: 0,
                            bottom: AppSpacing.spacingS,
                            child: CustomPaint(painter: DottedLinePainter()),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: AppSpacing.spacingL,
                            children: _buildEventWidgets(events),
                          ),
                        ],
                      ),
              );
            },
          ),
          ShortcutCard(
            cardTitle: AppStrings.shortcutAddPrescription,
            icon: Icons.file_open_outlined,
            onTap: () => NavigationService.push(AppPages.prescriptionNew.path),
            iconColor: context.colors.primary,
            iconBackgroundColor: context.colors.tintBlue,
          ),
          ShortcutCard(
            cardTitle: AppStrings.shortcutAddLenses,
            icon: Icons.water_drop_outlined,
            onTap: () {
              NavigationService.push(
                AppPages.eyewearNew.path,
                extra: EyewearCategory.contactLenses,
              );
            },
            iconColor: context.colors.primary,
            iconBackgroundColor: context.colors.tintBlue,
          ),
        ],
      ),
    );
  }
}
