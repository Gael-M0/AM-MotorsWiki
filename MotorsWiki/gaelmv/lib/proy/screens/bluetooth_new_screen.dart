import 'package:MotorsWiki/proy/screens/inicio_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../modelsp1/vehiculo.dart';
import '../providers/favoritos_provider.dart';

class BluetoothNewScreen extends StatefulWidget {
  final String deviceName;
  final String deviceId;

  BluetoothNewScreen({required this.deviceName, required this.deviceId});

  @override
  _BluetoothNewScreenState createState() => _BluetoothNewScreenState();
}

class _BluetoothNewScreenState extends State<BluetoothNewScreen> {
  File? _selectedImage;
  final TextEditingController _descripcionController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveVehiculo() async {
    final favoritosProvider = Provider.of<FavoritosProvider>(context, listen: false);
    final isar = favoritosProvider.isar;

    final nuevoVehiculo = Vehiculo(
      nombre: widget.deviceName,
      descripcion: _descripcionController.text.isNotEmpty
          ? _descripcionController.text
          : 'ID: ${widget.deviceId}',
      imagen: _selectedImage?.path ?? '', // Guardar la ruta de la imagen o vacío si no hay imagen
    );

    await isar.writeTxn(() async {
      await isar.vehiculos.put(nuevoVehiculo);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.deviceName} añadido a la lista de vehículos')),
    );

    // Redirigir a inicio_screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => InicioScreen()), // Asegúrate de importar InicioScreen
      (Route<dynamic> route) => false, // Elimina todas las pantallas anteriores
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Vehículo desde Bluetooth'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
          crossAxisAlignment: CrossAxisAlignment.center, // Centrar horizontalmente
          children: [
            Text(
              'Dispositivo: ${widget.deviceName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Centrar el texto
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _selectedImage != null
                ? Image.file(_selectedImage!, width: 100, height: 100, fit: BoxFit.cover)
                : const Text('No se ha seleccionado ninguna imagen'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Seleccionar Imagen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveVehiculo,
              child: const Text('Guardar Vehículo'),
            ),
          ],
        ),
      ),
    );
  }
}