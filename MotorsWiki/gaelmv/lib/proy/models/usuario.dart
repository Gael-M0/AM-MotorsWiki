import 'package:isar/isar.dart';
import '../modelsp1/vehiculo.dart';

part 'usuario.g.dart';

@collection
class Usuario {
  Id id = Isar.autoIncrement;
  late String username;
  late String password;
  @Backlink(to: 'usuario')
  final IsarLinks<Vehiculo> favoritos = IsarLinks<Vehiculo>();
}
