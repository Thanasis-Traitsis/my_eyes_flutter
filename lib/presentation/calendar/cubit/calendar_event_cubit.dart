import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/domain/repositories/calendar_event_repository.dart';

part 'calendar_event_state.dart';

@singleton
class CalendarEventCubit extends Cubit<CalendarEventState> {
  CalendarEventCubit(this._repository) : super(const CalendarEventInitial());

  final CalendarEventRepository _repository;

  Future<void> loadEvents() async {
    emit(const CalendarEventLoading());
    try {
      final events = await _repository.getEvents();
      emit(CalendarEventLoaded(events: events));
    } catch (e) {
      emit(CalendarEventError(e.toString()));
    }
  }

  Future<void> addEvent(CalendarEvent event) async {
    try {
      await _repository.saveEvent(event);
      await loadEvents();
    } catch (e) {
      emit(CalendarEventError(e.toString()));
    }
  }

  Future<void> updateEvent(CalendarEvent event) async {
    try {
      await _repository.updateEvent(event);
      await loadEvents();
    } catch (e) {
      emit(CalendarEventError(e.toString()));
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await _repository.deleteEvent(id);
      await loadEvents();
    } catch (e) {
      emit(CalendarEventError(e.toString()));
    }
  }
}
