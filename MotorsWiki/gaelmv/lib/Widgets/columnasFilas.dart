import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: const ButtonPage(),
    );
  }
}

class RowColumnContainer extends StatefulWidget {
  const RowColumnContainer({super.key});

  @override
  State<RowColumnContainer> createState() => _RowColumnContainerState();
}

class _RowColumnContainerState extends State<RowColumnContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Alineación horizontal
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación vertical
        mainAxisSize: MainAxisSize.max, // Tamaño máximo del eje principal
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.blue,
            child: const Center(
              child: Text(
                "Uno",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Text("Dos"),
          const Text("Tres"),
        ],
      ),
    );
  }
}

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi app"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("Hola Mundo");
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.accessibility_new),
              SizedBox(width: 5), // Espacio entre el icono y el texto
              Text("Click me"),
            ],
          ),
        ),
      ),
    );
  }
}