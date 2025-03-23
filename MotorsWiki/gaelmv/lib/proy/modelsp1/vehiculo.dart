import 'package:isar/isar.dart';
import '../models/usuario.dart';

part 'vehiculo.g.dart';

@collection
class Vehiculo {
  Id id = Isar.autoIncrement; // ID autoincremental para cada vehículo
  late String nombre;         // Nombre del vehículo
  late String descripcion;    // Descripción del vehículo
  late String imagen;         // URL de la imagen del vehículo

  final IsarLink<Usuario> usuario = IsarLink<Usuario>(); // Relación con un usuario

  Vehiculo({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
  });

  Vehiculo.empty();
}
