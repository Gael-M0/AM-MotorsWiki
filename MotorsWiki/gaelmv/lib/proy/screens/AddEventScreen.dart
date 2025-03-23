import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive/hive.dart';
import '../modelsev/event_model.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;
  double? _latitude;
  double? _longitude;
  String _locationDetails = "Ubicación desconocida";

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _getLocation() async {
    try {
      // Obtener la posición actual con alta precisión
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      // Obtener detalles de la ubicación usando geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _locationDetails = """
        Calle: ${place.street ?? "Desconocida"}
        Localidad: ${place.locality ?? "Desconocida"}
        Región: ${place.administrativeArea ?? "Desconocida"}
        País: ${place.country ?? "Desconocido"}
        """;
      });
    } catch (e) {
      setState(() {
        _locationDetails = "No se pudo obtener la ubicación: $e";
      });
    }
  }

  void _saveEvent() {
    final newEvent = Event(
      title: _titleController.text,
      description: _descriptionController.text,
      imagePath: _image?.path,
      latitude: _latitude,
      longitude: _longitude,
    );

    final eventBox = Hive.box<Event>('events');
    eventBox.add(newEvent);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nuevo Evento")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 10),
            _image != null
                ? Image.file(_image!, height: 100)
                : ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.camera),
                    label: const Text("Tomar Foto"),
                  ),
            const SizedBox(height: 10),
            _latitude == null
                ? ElevatedButton.icon(
                    onPressed: _getLocation,
                    icon: const Icon(Icons.location_on),
                    label: const Text("Obtener Ubicación"),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ubicación: $_latitude, $_longitude",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _locationDetails,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveEvent,
              child: const Text("Guardar Evento"),
            ),
          ],
        ),
      ),
    );
  }
}