// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_tea_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllTeaModelAdapter extends TypeAdapter<AllTeaModel> {
  @override
  final int typeId = 1;

  @override
  AllTeaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllTeaModel(
      id: fields[0] == null ? 0 : fields[0] as int,
      name: fields[1] == null ? '' : fields[1] as String,
      img: fields[2] == null ? '' : fields[2] as String,
      type: fields[3] == null ? '' : fields[3] as String,
      subtype: fields[4] == null ? '' : fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AllTeaModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.subtype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllTeaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeaModelAdapter extends TypeAdapter<TeaModel> {
  @override
  final int typeId = 2;

  @override
  TeaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeaModel(
      id: fields[0] == null ? 0 : fields[0] as int,
      name: fields[1] == null ? '' : fields[1] as String,
      price: fields[2] == null ? 0 : fields[2] as double,
      fullPrice: fields[3] == null ? 0 : fields[3] as double,
      weight: fields[4] == null ? '' : fields[4] as String,
      description: fields[5] == null ? [] : (fields[5] as List).cast<String>(),
      type: fields[6] == null ? '' : fields[6] as String,
      subtype: fields[7] == null ? '' : fields[7] as String,
      quantity: fields[8] == null ? 0 : fields[8] as double,
      saleQuantity: fields[9] == null ? 0 : fields[9] as double,
      full: fields[10] == null ? false : fields[10] as bool,
      images: fields[11] == null ? [] : (fields[11] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TeaModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.fullPrice)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.subtype)
      ..writeByte(8)
      ..write(obj.quantity)
      ..writeByte(9)
      ..write(obj.saleQuantity)
      ..writeByte(10)
      ..write(obj.full)
      ..writeByte(11)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
