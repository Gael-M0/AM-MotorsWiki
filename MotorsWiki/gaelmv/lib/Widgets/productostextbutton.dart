import 'detallesproducto.dart';
import 'package:flutter/material.dart';

class productobutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String user = args?['user'] ?? 'No user';
    String password = args?['password'] ?? 'No password';

    return TiendaScreen(user: user, password: password);
  }
}

class TiendaScreen extends StatelessWidget {
  final String user;
  final String password;
  final List<Product> productos = [
    Product(
      nombre: 'Camisa',
      precio: 29.99,
      imagenUrl: 'https://safetydepot.com.mx/cdn/shop/files/Mesadetrabajo1_b4cafa52-24a2-405d-8b39-0b39ab0b3710_1024x1024.jpg?v=1720021404',
    ),
    Product(
      nombre: 'Pantalones',
      precio: 49.99,
      imagenUrl: 'https://vittorioforti.com.mx/cdn/shop/products/VSA03038GC-VCA06535AZ-VPN03064GC4.jpg?v=1617635791&width=700',
    ),
    Product(
      nombre: 'Zapatos',
      precio: 69.99,
      imagenUrl: 'https://pakar.com/cdn/shop/files/120507-CE-12.jpg?v=1722924835',
    ),
    Product(
      nombre: 'Camisa',
      precio: 29.99,
      imagenUrl: 'https://safetydepot.com.mx/cdn/shop/files/Mesadetrabajo1_b4cafa52-24a2-405d-8b39-0b39ab0b3710_1024x1024.jpg?v=1720021404',
    ),
    Product(
      nombre: 'Pantalones',
      precio: 49.99,
      imagenUrl: 'https://vittorioforti.com.mx/cdn/shop/products/VSA03038GC-VCA06535AZ-VPN03064GC4.jpg?v=1617635791&width=700',
    ),
    Product(
      nombre: 'Zapatos',
      precio: 69.99,
      imagenUrl: 'https://pakar.com/cdn/shop/files/120507-CE-12.jpg?v=1722924835',
    ),
  ];

  TiendaScreen({required this.user, required this.password});

  @override
  Widget build(BuildContext context) {
    print("Password: $password");
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido $user'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Acción del botón de texto')),
              );
            },
            child: Text(
              'Acción',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return ProductCard(producto: productos[index]);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Añadir nuevo producto')),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Añadir producto',
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product producto;

  ProductCard({required this.producto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detalles',
          arguments: producto,
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.network(
              producto.imagenUrl,
              width: 100,
              height: 100,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$${producto.precio.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_shopping_cart, color: Colors.blue),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${producto.nombre} añadido al carrito')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String nombre;
  final double precio;
  final String imagenUrl;

  Product({
    required this.nombre,
    required this.precio,
    required this.imagenUrl,
  });
}
