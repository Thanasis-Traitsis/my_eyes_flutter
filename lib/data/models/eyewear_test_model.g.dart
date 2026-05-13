// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eyewear_test_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EyewearTestModelAdapter extends TypeAdapter<EyewearTestModel> {
  @override
  final typeId = 4;

  @override
  EyewearTestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EyewearTestModel(
      id: fields[0] as String,
      eyewearId: fields[1] as String,
      score: (fields[2] as num).toInt(),
      takenAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, EyewearTestModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.eyewearId)
      ..writeByte(2)
      ..write(obj.score)
      ..writeByte(3)
      ..write(obj.takenAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EyewearTestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
