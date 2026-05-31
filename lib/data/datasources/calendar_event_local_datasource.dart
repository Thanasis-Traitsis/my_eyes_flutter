import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/models/calendar_event_model.dart';

abstract class CalendarEventLocalDataSource {
  Future<List<CalendarEventModel>> getAll();
  Future<void> save(CalendarEventModel model);
  Future<void> update(CalendarEventModel model);
  Future<void> delete(String id);
}

@LazySingleton(as: CalendarEventLocalDataSource)
class HiveCalendarEventLocalDataSource implements CalendarEventLocalDataSource {
  HiveCalendarEventLocalDataSource(this._box);

  final Box<CalendarEventModel> _box;

  @override
  Future<List<CalendarEventModel>> getAll() async {
    final values = _box.values.toList();
    values.sort((a, b) => a.date.compareTo(b.date));
    return values;
  }

  @override
  Future<void> save(CalendarEventModel model) => _box.put(model.id, model);

  @override
  Future<void> update(CalendarEventModel model) => _box.put(model.id, model);

  @override
  Future<void> delete(String id) => _box.delete(id);
}
