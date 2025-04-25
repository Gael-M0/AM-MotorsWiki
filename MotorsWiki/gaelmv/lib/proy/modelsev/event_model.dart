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

  @HiveField(5)
  DateTime? startTime; // Nueva hora de inicio

  @HiveField(6)
  DateTime? endTime; // Nueva hora de fin

  Event({
    required this.title,
    required this.description,
    this.imagePath,
    this.latitude,
    this.longitude,
    this.startTime,
    this.endTime,
  });
}