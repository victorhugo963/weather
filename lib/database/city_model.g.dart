// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityAdapter extends TypeAdapter<City> {
  @override
  final typeId = 0;

  @override
  City read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return City()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..description = fields[2] as String
      ..icon = fields[3] as String
      ..temp = fields[4] as double
      ..minTemp = fields[5] as double
      ..maxTemp = fields[6] as double
      ..country = fields[7] as String
      ..favorite = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, City obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.temp)
      ..writeByte(5)
      ..write(obj.minTemp)
      ..writeByte(6)
      ..write(obj.maxTemp)
      ..writeByte(7)
      ..write(obj.country)
      ..writeByte(8)
      ..write(obj.favorite);
  }
}
