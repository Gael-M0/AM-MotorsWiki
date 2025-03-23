import 'package:flutter/material.dart';
import 'detalles.dart';

class TiendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String usuario = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tienda en Línea - Bienvenido $usuario'),
      ),
      body: Column(
        children: [
          producto(context, 'Camisa', '200',
              'https://images-na.ssl-images-amazon.com/images/I/61kd7B51gKL._AC_UL1096_.jpg'),
          producto(context, 'Pantalones', '100',
              'https://th.bing.com/th/id/R.af899331b19cb04ae2a957e569e355da?rik=FaQOJ3VgAMoChw&pid=ImgRaw&r=0'),
          producto(context, 'Zapatos', '100',
              'https://th.bing.com/th/id/OIP.1JYVj0hBhTL_j01IB2mX1AHaHa?rs=1&pid=ImgDetMain'),
        ],
      ),
    );
  }
}

Widget producto(BuildContext context, String nombre, String precio, String urlImagen) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        '/detalles',
        arguments: {
          'nombre': nombre,
          'precio': precio,
          'urlImagen': urlImagen,
        },
      );
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.network(
            urlImagen,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('\$$precio', style: const TextStyle(color: Colors.green)),
            ],
          ),
        ],
      ),
    ),
  );
}
