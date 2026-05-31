import 'package:hive_ce/hive.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/domain/enums/calendar_event_type.dart';

part 'calendar_event_model.g.dart';

@HiveType(typeId: 5)
class CalendarEventModel extends HiveObject {
  CalendarEventModel({
    required this.id,
    required this.date,
    required this.title,
    required this.typeIndex,
    this.description,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String title;

  @HiveField(3)
  int typeIndex;

  @HiveField(4)
  String? description;

  CalendarEvent toEntity() => CalendarEvent(
    id: id,
    date: date,
    title: title,
    type: typeIndex < CalendarEventType.values.length
        ? CalendarEventType.values[typeIndex]
        : CalendarEventType.custom,
    description: description,
  );

  factory CalendarEventModel.fromEntity(CalendarEvent e) => CalendarEventModel(
    id: e.id,
    date: e.date,
    title: e.title,
    typeIndex: e.type.index,
    description: e.description,
  );
}
