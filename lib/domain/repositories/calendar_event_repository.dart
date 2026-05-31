import 'package:my_eyes/domain/entities/calendar_event.dart';

abstract class CalendarEventRepository {
  Future<List<CalendarEvent>> getEvents();
  Future<void> saveEvent(CalendarEvent event);
  Future<void> updateEvent(CalendarEvent event);
  Future<void> deleteEvent(String id);
}
