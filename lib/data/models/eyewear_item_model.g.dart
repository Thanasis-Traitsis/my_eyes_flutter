// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eyewear_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EyewearItemModelAdapter extends TypeAdapter<EyewearItemModel> {
  @override
  final typeId = 3;

  @override
  EyewearItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EyewearItemModel(
      id: fields[0] as String,
      name: fields[1] as String,
      categoryIndex: (fields[2] as num).toInt(),
      updatedAt: fields[3] as DateTime,
      prescription: fields[4] as PrescriptionModel?,
      pendingSync: fields[5] == null ? true : fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EyewearItemModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.categoryIndex)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.prescription)
      ..writeByte(5)
      ..write(obj.pendingSync);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EyewearItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
