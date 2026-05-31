import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/presentation/calendar/widgets/calendar_event_card.dart';
import 'package:my_eyes/presentation/calendar/widgets/calendar_section_header.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class CalendarEventList extends StatelessWidget {
  const CalendarEventList({
    super.key,
    required this.upcoming,
    required this.previous,
  });

  final List<CalendarEvent> upcoming;
  final List<CalendarEvent> previous;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.spacingL,
      children: [
        CalendarSectionHeader(title: AppStrings.calendarSectionUpcoming),
        if (upcoming.isEmpty)
          Center(child: CustomText(text: AppStrings.calendarUpcomingEmpty))
        else
          Column(
            spacing: AppSpacing.spacingM,
            children: [
              for (final (index, event) in upcoming.indexed)
                CalendarEventCard(
                  event: event,
                  isPast: false,
                  isNext: index == 0,
                ),
            ],
          ),
        if (previous.isNotEmpty) ...[
          CalendarSectionHeader(title: AppStrings.calendarSectionPrevious),
          Column(
            spacing: AppSpacing.spacingM,
            children: [
              for (final event in previous)
                CalendarEventCard(event: event, isPast: true),
            ],
          ),
        ],
      ],
    );
  }
}
