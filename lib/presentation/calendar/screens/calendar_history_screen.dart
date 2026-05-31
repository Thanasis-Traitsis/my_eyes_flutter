import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/presentation/calendar/cubit/calendar_event_cubit.dart';
import 'package:my_eyes/presentation/calendar/widgets/calendar_event_list.dart';
import 'package:my_eyes/presentation/shared/screens/full_screen_with_title.dart';

class CalendarHistoryScreen extends StatelessWidget {
  const CalendarHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FullScreenWithTitle(
      currentPage: AppPages.calendarHistory,
      child: BlocBuilder<CalendarEventCubit, CalendarEventState>(
        builder: (context, state) => switch (state) {
          CalendarEventInitial() || CalendarEventLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          CalendarEventError(:final message) => Center(child: Text(message)),
          CalendarEventLoaded() => CalendarEventList(
            upcoming: state.upcoming,
            previous: state.previous,
          ),
        },
      ),
    );
  }
}
