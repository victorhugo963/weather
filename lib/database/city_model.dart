import 'package:hive/hive.dart';

part 'city_model.g.dart';

@HiveType(typeId: 0)
class City extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String icon;
  @HiveField(4)
  double temp;
  @HiveField(5)
  double minTemp;
  @HiveField(6)
  double maxTemp;
  @HiveField(7)
  String country;
  @HiveField(8)
  bool favorite;
}
