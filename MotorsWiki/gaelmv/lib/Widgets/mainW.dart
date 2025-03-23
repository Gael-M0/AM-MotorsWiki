import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TiendaScreen(),
    );
  }
}

class TiendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda en Línea'),
      ),
      body: Column(
        children: [
          producto('Camisa', '200',
              'https://images-na.ssl-images-amazon.com/images/I/61kd7B51gKL._AC_UL1096_.jpg'),
          producto('Pantalones', '100',
              'https://th.bing.com/th/id/R.af899331b19cb04ae2a957e569e355da?rik=FaQOJ3VgAMoChw&pid=ImgRaw&r=0'),
          producto('Zapatos', '100',
              'https://th.bing.com/th/id/OIP.1JYVj0hBhTL_j01IB2mX1AHaHa?rs=1&pid=ImgDetMain'),
        ],
      ),
    );
  }

  Widget producto(String nombre, String precio, String urlImagen) {
    return Container(
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
    );
  }
}
