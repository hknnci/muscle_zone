// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteListAdapter extends TypeAdapter<FavoriteList> {
  @override
  final int typeId = 0;

  @override
  FavoriteList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteList(
      name: fields[0] as String,
      exerciseIds: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.exerciseIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
