import 'package:flutter/material.dart';

class DetallesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String nombre = args['nombre'];
    final String precio = args['precio'];
    final String urlImagen = args['urlImagen'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de $nombre'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.network(urlImagen, width: 150, height: 150),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            Text('\$$precio', style: const TextStyle(color: Colors.green, fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Agregar al carrito'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
