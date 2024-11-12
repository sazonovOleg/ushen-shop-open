// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_orders_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserOrdersHiveModelAdapter extends TypeAdapter<UserOrdersHiveModel> {
  @override
  final int typeId = 4;

  @override
  UserOrdersHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserOrdersHiveModel(
      id: fields[0] == null ? 0 : fields[0] as int,
      userId: fields[1] == null ? 0 : fields[1] as int,
      date: fields[2] == null ? '' : fields[2] as String,
      goods: fields[3] == null
          ? []
          : (fields[3] as List).cast<OrdersGoodsHiveModel>(),
      totalSum: fields[4] == null ? '' : fields[4] as String,
      status: fields[5] == null ? '' : fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserOrdersHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.goods)
      ..writeByte(4)
      ..write(obj.totalSum)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserOrdersHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrdersGoodsHiveModelAdapter extends TypeAdapter<OrdersGoodsHiveModel> {
  @override
  final int typeId = 5;

  @override
  OrdersGoodsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrdersGoodsHiveModel(
      name: fields[0] == null ? '' : fields[0] as String,
      weight: fields[1] == null ? '' : fields[1] as String,
      price: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrdersGoodsHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdersGoodsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
