import 'package:isar/isar.dart';

part 'bluetooth_data.g.dart';

@collection
class BluetoothData {
  Id id = Isar.autoIncrement; // ID autoincremental

  late String deviceName; // Nombre del dispositivo
  late String deviceAddress; // Dirección MAC del dispositivo
  late String receivedData; // Datos recibidos del dispositivo
  late DateTime timestamp; // Fecha y hora de recepción
}