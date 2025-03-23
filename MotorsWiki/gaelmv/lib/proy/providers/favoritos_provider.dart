import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../modelsp1/vehiculo.dart';
import '../models/usuario.dart';

class FavoritosProvider with ChangeNotifier {
  final Isar isar;
  List<Vehiculo> _favoritos = [];

  FavoritosProvider(this.isar);

  List<Vehiculo> get favoritos => _favoritos;

  Future<void> cargarFavoritos(int userId) async {
    final usuario = await isar.usuarios.get(userId);
    _favoritos = usuario?.favoritos.toList() ?? [];
    notifyListeners();
  }

  Future<void> agregarAFavoritos(Vehiculo vehiculo, int userId) async {
    final usuario = await isar.usuarios.get(userId);
    if (usuario != null) {
      await isar.writeTxn(() async {
        usuario.favoritos.add(vehiculo);
        await usuario.favoritos.save();
      });
      await cargarFavoritos(userId);
    }
  }

  Future<void> eliminarDeFavoritos(Vehiculo vehiculo, int userId) async {
    final usuario = await isar.usuarios.get(userId);
    if (usuario != null) {
      await isar.writeTxn(() async {
        usuario.favoritos.remove(vehiculo);
        await usuario.favoritos.save();
      });
      await cargarFavoritos(userId);
    }
  }
}
