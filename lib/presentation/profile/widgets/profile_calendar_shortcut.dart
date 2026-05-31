import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/calendar/cubit/calendar_event_cubit.dart';
import 'package:my_eyes/presentation/shared/widgets/shortcut_card.dart';

class ProfileCalendarShortcut extends StatelessWidget {
  const ProfileCalendarShortcut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarEventCubit, CalendarEventState>(
      builder: (context, calendarState) {
        final eventsSize = calendarState is CalendarEventLoaded
            ? calendarState.upcoming.length
            : 0;

        return ShortcutCard(
          cardTitle: AppStrings.shortcutCalendarEvents,
          cardSubtitle: eventsSize > 0
              ? AppStrings.profileShortcutCalendarEventsSubtitle(eventsSize)
              : null,
          icon: Icons.calendar_month_outlined,
          onTap: () => NavigationService.push(AppPages.calendarHistory.path),
          iconColor: context.colors.tintMintDark,
          iconBackgroundColor: context.colors.tintMint,
        );
      },
    );
  }
}
