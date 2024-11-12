// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartHiveModelAdapter extends TypeAdapter<CartHiveModel> {
  @override
  final int typeId = 6;

  @override
  CartHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartHiveModel(
      name: fields[0] == null ? '' : fields[0] as String,
      weight: fields[1] == null ? 0 : fields[1] as int,
      price: fields[2] == null ? 0 : fields[2] as int,
      image: fields[3] == null ? '' : fields[3] as String,
      indexEl: fields[4] == null ? 0 : fields[4] as int,
      wholePack: fields[5] == null ? false : fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CartHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.indexEl)
      ..writeByte(5)
      ..write(obj.wholePack);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
