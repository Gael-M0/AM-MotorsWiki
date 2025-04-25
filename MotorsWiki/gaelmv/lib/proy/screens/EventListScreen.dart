import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'AddEventScreen.dart';
import '../modelsev/event_model.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  void _deleteEvent(Box<Event> box, int index) {
    box.deleteAt(index); // Eliminar el evento en el índice especificado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Eventos")),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Event>('events').listenable(),
        builder: (context, Box<Event> box, _) {
          if (box.isEmpty) return const Center(child: Text("No hay eventos aún."));
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final event = box.getAt(index);

              // Verificar si el archivo de imagen existe
              Widget leadingWidget;
              if (event!.imagePath != null && File(event.imagePath!).existsSync()) {
                leadingWidget = Image.file(File(event.imagePath!), width: 50, height: 50, fit: BoxFit.cover);
              } else {
                leadingWidget = const Icon(Icons.event, size: 50, color: Colors.grey);
              }

              return Card(
                child: ListTile(
                  leading: leadingWidget,
                  title: Text(event.title),
                  subtitle: Text(
                    '${event.description}\n'
                    'Inicio: ${event.startTime?.hour}:${event.startTime?.minute}\n'
                    'Fin: ${event.endTime?.hour}:${event.endTime?.minute}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (event.latitude != null)
                        const Icon(Icons.location_on, color: Colors.red),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Confirmar antes de eliminar
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Eliminar Evento"),
                              content: const Text("¿Estás seguro de que deseas eliminar este evento?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _deleteEvent(box, index);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Eliminar"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddEventScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}