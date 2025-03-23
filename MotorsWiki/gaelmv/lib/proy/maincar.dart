import 'package:flutter/material.dart';
import 'package:gaelmv/proy/screens/camara_screen.dart';
import 'package:gaelmv/proy/screens/ubicacion_screen.dart'; // Importar UbicacionScreen
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'models/usuario.dart';
import 'modelsp1/vehiculo.dart';
import 'providers/favoritos_provider.dart';
import 'screens/inicio_screen.dart';
import 'screens/vehiculos_screen.dart';
import 'screens/descripcion_screen.dart';
import 'screens/registro_screen.dart';
import 'screens/favoritos_screen.dart';
import 'package:gaelmv/proy/modelsev/event_model.dart'; // Importar correctamente el modelo de eventos
import 'package:gaelmv/proy/screens/AddEventScreen.dart'; // Importar correctamente la pantalla de eventos
import 'package:gaelmv/proy/screens/EventListScreen.dart'; // Importar correctamente la pantalla de eventos

late final Isar isar;

Future<void> inicializarVehiculos(Isar isar) async {
  final vehiculos = [
    Vehiculo(
      nombre: 'LA Ferrari',
      descripcion: 'Empresa: Ferrari\nFecha de creación: 2000',
      imagen: 'https://th.bing.com/th/id/OIP.q5UUFPckn-WwccBPP0IigAHaF2?w=920&h=726&rs=1&pid=ImgDetMain',
    ),
    Vehiculo(
      nombre: 'Lamborghini Aventador',
      descripcion: 'Empresa: Lamborghini\nFecha de creación: 2000',
      imagen: 'https://th.bing.com/th/id/R.b966a5c2532ef37a1c03b463b6286279?rik=E8XKiuSFkbyE4w&pid=ImgRaw&r=0',
    ),
    Vehiculo(
      nombre: 'BMW SP',
      descripcion: 'Empresa: BMW\nFecha de creación: 2000',
      imagen: 'https://th.bing.com/th/id/R.9d8d647192a12a6e373a7f1d3131b1c5?rik=hEP7aAHS2ToAZg&pid=ImgRaw&r=0',
    ),
  ];

  await isar.writeTxn(() async {
    final nombres = vehiculos.map((v) => v.nombre).toSet();
    for (var nombre in nombres) {
      final duplicados = await isar.vehiculos.filter().nombreEqualTo(nombre).findAll();
      if (duplicados.length > 1) {
        for (var i = 1; i < duplicados.length; i++) {
          await isar.vehiculos.delete(duplicados[i].id!);
        }
      }
    }

    for (var vehiculo in vehiculos) {
      final existe = await isar.vehiculos.filter().nombreEqualTo(vehiculo.nombre).findFirst();
      if (existe == null) {
        await isar.vehiculos.put(vehiculo);
      }
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive
  await Hive.initFlutter();

  // Registrar adaptadores
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(EventAdapter());
  }

  // Abrir la caja de eventos
  await Hive.openBox<Event>('events');

  // Inicializar Isar
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [UsuarioSchema, VehiculoSchema],
    directory: dir.path,
  );

  await inicializarVehiculos(isar);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritosProvider(isar)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => InicioScreen(),
          '/vehiculos': (context) => VehiculosScreen(),
          '/favoritos': (context) => FavoritosScreen(),
          '/descripcion': (context) => DescripcionScreen(),
          '/registro': (context) => RegistroScreen(),
          '/camara': (context) => CamaraScreen(),
          '/ubicacion': (context) => UbicacionScreen(), // Agregar UbicacionScreen a las rutas
          '/eventos': (context) => EventListScreen(), // Agregar EventListScreen a las rutas
          '/addEvent': (context) => AddEventScreen(), // Agregar AddEventScreen a las rutas
        },
      ),
    );
  }
}