// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eye_measurement_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EyeMeasurementModelAdapter extends TypeAdapter<EyeMeasurementModel> {
  @override
  final typeId = 1;

  @override
  EyeMeasurementModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EyeMeasurementModel(
      sphere: (fields[0] as num).toDouble(),
      cylinder: (fields[1] as num).toDouble(),
      axis: (fields[2] as num).toInt(),
      addition: (fields[3] as num).toDouble(),
      pd: (fields[4] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, EyeMeasurementModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sphere)
      ..writeByte(1)
      ..write(obj.cylinder)
      ..writeByte(2)
      ..write(obj.axis)
      ..writeByte(3)
      ..write(obj.addition)
      ..writeByte(4)
      ..write(obj.pd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EyeMeasurementModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
