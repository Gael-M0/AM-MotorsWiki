import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import 'package:awesome_notifications/awesome_notifications.dart'; // Importar AwesomeNotifications
import '../modelsp1/vehiculo.dart';
import '../providers/favoritos_provider.dart';

class CamaraScreen extends StatefulWidget {
  @override
  _CamaraScreenState createState() => _CamaraScreenState();
}

class _CamaraScreenState extends State<CamaraScreen> {
  File? _imageFile;
  final TextEditingController _nombreController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print("No se seleccionó ninguna imagen.");
    }
  }

  Future<void> _guardarVehiculo() async {
    if (_imageFile == null || _nombreController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    final favoritosProvider = Provider.of<FavoritosProvider>(context, listen: false);
    final isar = favoritosProvider.isar;

    final nuevoVehiculo = Vehiculo(
      nombre: _nombreController.text,
      descripcion: 'Empresa: Usuario\nFecha de creación: ${DateTime.now().year}', // Se asegura el formato correcto
      imagen: _imageFile!.path,
    );

    await isar.writeTxn(() async {
      await isar.vehiculos.put(nuevoVehiculo);
    });

    // Mostrar notificación de éxito
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2, // ID único para esta notificación
        channelKey: 'basic_channel',
        title: 'Vehículo agregado',
        body: 'Vehículo "${_nombreController.text}" agregado con éxito.',
        notificationLayout: NotificationLayout.Default,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vehículo agregado exitosamente')),
    );

    // Redirigir al usuario a InicioScreen
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir Vehículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            _imageFile != null
                ? Image.file(_imageFile!, height: 100)
                : ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Tomar Foto"),
                  ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _guardarVehiculo,
              child: const Text("Guardar Vehículo"),
            ),
          ],
        ),
      ),
    );
  }
}
