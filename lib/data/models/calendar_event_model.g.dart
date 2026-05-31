// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarEventModelAdapter extends TypeAdapter<CalendarEventModel> {
  @override
  final typeId = 5;

  @override
  CalendarEventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarEventModel(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      title: fields[2] as String,
      typeIndex: (fields[3] as num).toInt(),
      description: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarEventModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.typeIndex)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarEventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
