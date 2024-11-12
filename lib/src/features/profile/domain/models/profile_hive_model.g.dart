// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileHiveModelAdapter extends TypeAdapter<ProfileHiveModel> {
  @override
  final int typeId = 3;

  @override
  ProfileHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileHiveModel(
      id: fields[0] == null ? 0 : fields[0] as int,
      name: fields[1] == null ? '' : fields[1] as String,
      lastName: fields[2] == null ? '' : fields[2] as String,
      email: fields[3] == null ? '' : fields[3] as String,
      phone: fields[4] == null ? '' : fields[4] as String,
      isVerified: fields[5] == null ? false : fields[5] as bool,
      discount: fields[6] == null ? '0' : fields[6] as String,
      totalPurchaseAmount: fields[7] == null ? '0' : fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.isVerified)
      ..writeByte(6)
      ..write(obj.discount)
      ..writeByte(7)
      ..write(obj.totalPurchaseAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
