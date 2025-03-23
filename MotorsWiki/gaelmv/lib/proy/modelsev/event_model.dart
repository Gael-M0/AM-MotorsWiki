import 'package:hive/hive.dart';

part 'event_model.g.dart'; // Archivo generado automáticamente

@HiveType(typeId: 0)
class Event {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String? imagePath;

  @HiveField(3)
  double? latitude;

  @HiveField(4)
  double? longitude;

  Event({
    required this.title,
    required this.description,
    this.imagePath,
    this.latitude,
    this.longitude,
  });
}