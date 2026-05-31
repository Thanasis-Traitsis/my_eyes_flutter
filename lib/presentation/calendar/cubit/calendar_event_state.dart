part of 'calendar_event_cubit.dart';

sealed class CalendarEventState extends Equatable {
  const CalendarEventState();

  @override
  List<Object?> get props => [];
}

class CalendarEventInitial extends CalendarEventState {
  const CalendarEventInitial();
}

class CalendarEventLoading extends CalendarEventState {
  const CalendarEventLoading();
}

class CalendarEventLoaded extends CalendarEventState {
  const CalendarEventLoaded({required this.events});

  final List<CalendarEvent> events;

  List<CalendarEvent> get upcoming {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    return events.where((e) => !e.date.isBefore(todayStart)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  List<CalendarEvent> get previous {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    return events.where((e) => e.date.isBefore(todayStart)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  List<Object?> get props => [events];
}

class CalendarEventError extends CalendarEventState {
  const CalendarEventError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
