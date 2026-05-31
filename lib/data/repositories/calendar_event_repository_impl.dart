import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/datasources/calendar_event_local_datasource.dart';
import 'package:my_eyes/data/models/calendar_event_model.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/domain/repositories/calendar_event_repository.dart';

@LazySingleton(as: CalendarEventRepository)
class CalendarEventRepositoryImpl implements CalendarEventRepository {
  CalendarEventRepositoryImpl(this._localDataSource);

  final CalendarEventLocalDataSource _localDataSource;

  @override
  Future<List<CalendarEvent>> getEvents() async {
    final models = await _localDataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveEvent(CalendarEvent event) =>
      _localDataSource.save(CalendarEventModel.fromEntity(event));

  @override
  Future<void> updateEvent(CalendarEvent event) =>
      _localDataSource.update(CalendarEventModel.fromEntity(event));

  @override
  Future<void> deleteEvent(String id) => _localDataSource.delete(id);
}
