import 'package:equatable/equatable.dart';
import 'package:my_eyes/domain/enums/calendar_event_type.dart';

class CalendarEvent extends Equatable {
  const CalendarEvent({
    required this.id,
    required this.date,
    required this.title,
    required this.type,
    this.description,
  });

  final String id;
  final DateTime date;
  final String title;
  final CalendarEventType type;
  final String? description;

  CalendarEvent copyWith({
    String? id,
    DateTime? date,
    String? title,
    CalendarEventType? type,
    String? description,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, date, title, type, description];
}
