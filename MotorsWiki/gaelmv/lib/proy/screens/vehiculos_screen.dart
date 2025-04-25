import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import 'dart:io';
import '../modelsp1/vehiculo.dart';
import '../providers/favoritos_provider.dart';

class VehiculosScreen extends StatelessWidget {
  final List<String> vehiculosBase = ['LA Ferrari', 'Lamborghini Aventador', 'BMW SP'];

  @override
  Widget build(BuildContext context) {
    final isar = Provider.of<FavoritosProvider>(context, listen: false).isar;

    return FutureBuilder<List<Vehiculo>>(
      future: isar.vehiculos.where().findAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final vehiculos = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text('Inspeccionar', style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                icon: const Icon(Icons.star, color: Colors.yellow),
                onPressed: () => Navigator.pushNamed(context, '/favoritos'),
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/registro'),
              ),
              IconButton(
                icon: const Icon(Icons.bluetooth, color: Colors.blue),
                onPressed: () => Navigator.pushNamed(context, '/bluetooth'), // Botón para Bluetooth
              ),
            ],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: vehiculos.length,
            itemBuilder: (context, index) {
              final vehiculo = vehiculos[index];
              final favoritosProvider = Provider.of<FavoritosProvider>(context);

              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/descripcion', arguments: vehiculo),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          vehiculo.imagen.startsWith('http')
                              ? Image.network(vehiculo.imagen, width: 80, height: 80, fit: BoxFit.cover)
                              : Image.file(File(vehiculo.imagen), width: 80, height: 80, fit: BoxFit.cover),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vehiculo.nombre,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  vehiculo.descripcion,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          if (!vehiculosBase.contains(vehiculo.nombre))
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                try {
                                  // Verificar si el archivo de imagen existe
                                  final file = File(vehiculo.imagen);
                                  if (await file.exists()) {
                                    await file.delete(); // Eliminar el archivo de imagen
                                  }

                                  // Eliminar el vehículo de la base de datos
                                  await isar.writeTxn(() async {
                                    await isar.vehiculos.delete(vehiculo.id);
                                  });

                                  // Mostrar un mensaje de éxito
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${vehiculo.nombre} eliminado correctamente')),
                                  );

                                  // Redirigir al usuario a InicioScreen
                                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                                } catch (e) {
                                  // Manejar errores durante la eliminación
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error al eliminar ${vehiculo.nombre}: $e')),
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/camara'),
                    icon: const Icon(Icons.camera_alt, color: Colors.purple),
                    label: const Text('Cámara'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/eventos'); // Cambiar la ruta a UbicacionScreen
                    },
                    icon: const Icon(Icons.event, color: Colors.purple),
                    label: const Text('Eventos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}