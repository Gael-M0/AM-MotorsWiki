import 'package:flutter/material.dart';
import '../modelsp1/vehiculo.dart';
import 'package:provider/provider.dart';
import '../providers/favoritos_provider.dart';

class DescripcionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Vehiculo vehiculo = ModalRoute.of(context)!.settings.arguments as Vehiculo;
    final favoritosProvider = Provider.of<FavoritosProvider>(context);
    final userId = 1;

    final Map<String, String> descripcionesDetalladas = {
      'LA Ferrari': 'La Ferrari es un superdeportivo híbrido presentado por primera vez en 2013. Combina un motor V12 con un motor eléctrico, ofreciendo 950 caballos de fuerza. Representa un enfoque hacia la sostenibilidad sin comprometer el rendimiento.',
      'Lamborghini Aventador': 'El Lamborghini Aventador es un superdeportivo emblemático de la marca Lamborghini. Lanzado en 2011, cuenta con un motor V12 que genera 700 caballos de fuerza, destacándose por su diseño aerodinámico y alta tecnología.',
      'BMW SP': 'El BMW SP es un modelo conceptual que combina la elegancia de BMW con un rendimiento sobresaliente. Este vehículo refleja la dedicación de la marca hacia la innovación y la experiencia de conducción única.',
    };

    // **Corrección del error RangeError**
    List<String> descripcionPartes = vehiculo.descripcion.split("\n");
    String empresa = "No disponible";
    String fechaCreacion = "No disponible";

    if (descripcionPartes.length > 1) {
      empresa = descripcionPartes[0].contains(":")
          ? descripcionPartes[0].split(":")[1].trim()
          : "No disponible";
      fechaCreacion = descripcionPartes[1].contains(":")
          ? descripcionPartes[1].split(":")[1].trim()
          : "No disponible";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Detalles',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                vehiculo.imagen,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 15),
              Text(
                vehiculo.nombre,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Empresa: $empresa',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Fecha de creación: $fechaCreacion',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              Text(
                descripcionesDetalladas[vehiculo.nombre] ?? 'Descripción no disponible.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              IconButton(
                icon: Icon(
                  favoritosProvider.favoritos.any((fav) => fav.id == vehiculo.id)
                      ? Icons.star
                      : Icons.star_border,
                  color: favoritosProvider.favoritos.any((fav) => fav.id == vehiculo.id)
                      ? Colors.black
                      : null,
                ),
                onPressed: () async {
                  if (favoritosProvider.favoritos.any((fav) => fav.id == vehiculo.id)) {
                    await favoritosProvider.eliminarDeFavoritos(vehiculo, userId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${vehiculo.nombre} eliminado de favoritos')),
                    );
                  } else {
                    await favoritosProvider.agregarAFavoritos(vehiculo, userId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${vehiculo.nombre} agregado a favoritos')),
                    );
                  }
                  favoritosProvider.notifyListeners();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
