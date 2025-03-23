//import 'productocondetalle.dart'; // Asegúrate de que esta ruta sea correcta
import 'package:flutter/material.dart';
//import 'productosStack.dart';
import 'productostextbutton.dart';


class DetalleProductoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Obtener el producto desde los argumentos pasados
    final Product producto = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(producto.imagenUrl),
              SizedBox(height: 10),
              Text(
                producto.nombre,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '\$${producto.precio.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                'Descripción del producto',
                style: TextStyle(fontSize: 18),
              ),
              // Aquí se puede añadir más detalles del producto si es necesario
            ],
          ),
        ),
      ),
    );
  }
}
