// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTableAdapter extends TypeAdapter<UserTable> {
  @override
  final int typeId = 0;

  @override
  UserTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTable(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserTable obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
