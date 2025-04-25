import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive/hive.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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
  DateTime? _startTime;
  DateTime? _endTime;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

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

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

      setState(() {
        if (isStartTime) {
          _startTime = selectedTime;
        } else {
          _endTime = selectedTime;
        }
      });
    }
  }

  Future<void> _saveEvent() async {
    if (_titleController.text.isEmpty || _startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    final newEvent = Event(
      title: _titleController.text,
      description: _descriptionController.text,
      imagePath: _image?.path,
      latitude: _latitude,
      longitude: _longitude,
      startTime: _startTime,
      endTime: _endTime,
    );

    final eventBox = Hive.box<Event>('events');
    final eventIndex = await eventBox.add(newEvent); // Usa await para obtener el índice

    // Programar notificaciones
    _scheduleNotifications(newEvent, eventIndex);

    Navigator.pop(context);
  }

  void _scheduleNotifications(Event event, int eventIndex) {
    // Notificación de inicio
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: eventIndex, // Usa el índice del evento como ID de la notificación
        channelKey: 'basic_channel',
        title: 'Inicio del evento',
        body: 'El evento "${event.title}" ha comenzado.',
      ),
      schedule: NotificationCalendar.fromDate(date: event.startTime!),
    );

    // Notificación de fin
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: eventIndex + 1000, // ID único para la notificación de fin
        channelKey: 'basic_channel',
        title: 'Fin del evento',
        body: 'El evento "${event.title}" ha terminado.',
      ),
      schedule: NotificationCalendar.fromDate(date: event.endTime!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nuevo Evento")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              Row(
                children: [
                  Expanded(
                    child: Text(_startTime == null
                        ? 'Hora de inicio no seleccionada'
                        : 'Inicio: ${_startTime!.hour}:${_startTime!.minute}'),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectTime(context, true),
                    child: const Text('Seleccionar Hora de Inicio'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(_endTime == null
                        ? 'Hora de fin no seleccionada'
                        : 'Fin: ${_endTime!.hour}:${_endTime!.minute}'),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectTime(context, false),
                    child: const Text('Seleccionar Hora de Fin'),
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
      ),
    );
  }
}