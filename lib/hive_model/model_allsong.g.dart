// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_allsong.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class saveDballsongAdapter extends TypeAdapter<saveDballsong> {
  @override
  final int typeId = 2;

  @override
  saveDballsong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return saveDballsong(
      id: fields[0] as int,
      data: fields[1] as String,
      uri: fields[2] as String,
      displayName: fields[3] as String,
      displayNameWOExt: fields[4] as String,
      artist: fields[5] as String,
      artistId: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, saveDballsong obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.displayName)
      ..writeByte(4)
      ..write(obj.displayNameWOExt)
      ..writeByte(5)
      ..write(obj.artist)
      ..writeByte(6)
      ..write(obj.artistId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is saveDballsongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
