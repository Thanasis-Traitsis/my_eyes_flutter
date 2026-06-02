// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_lens_supply_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactLensSupplyModelAdapter
    extends TypeAdapter<ContactLensSupplyModel> {
  @override
  final typeId = 6;

  @override
  ContactLensSupplyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactLensSupplyModel(
      lensTypeIndex: (fields[0] as num).toInt(),
      quantity: (fields[1] as num).toInt(),
      expirationDate: fields[2] as DateTime?,
      activatedAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ContactLensSupplyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.lensTypeIndex)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.expirationDate)
      ..writeByte(3)
      ..write(obj.activatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactLensSupplyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
