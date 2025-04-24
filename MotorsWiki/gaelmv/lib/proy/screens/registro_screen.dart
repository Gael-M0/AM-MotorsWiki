import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models/usuario.dart';
import 'package:provider/provider.dart';
import '../providers/favoritos_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart'; // Reemplazar flutter_local_notifications por awesome_notifications
import 'package:gaelmv/proy/maincar.dart';

class RegistroScreen extends StatelessWidget {
  final _formRegistroKey = GlobalKey<FormState>();
  final _formInicioSesionKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginUsernameController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  void _showLoginNotification(String usuario) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Inicio exitoso',
        body: 'Bienvenido, $usuario',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritosProvider = Provider.of<FavoritosProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Usuario', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registro', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Form(
              key: _formRegistroKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de usuario',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Por favor ingresa un nombre de usuario' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Por favor ingresa una contraseña' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formRegistroKey.currentState!.validate()) {
                        final usuario = Usuario()
                          ..username = _usernameController.text
                          ..password = _passwordController.text;

                        await favoritosProvider.isar.writeTxn(() async {
                          await favoritosProvider.isar.usuarios.put(usuario);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registro exitoso')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Registrar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Inicio de Sesión', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Form(
              key: _formInicioSesionKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _loginUsernameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de usuario',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Por favor ingresa un nombre de usuario' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _loginPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Por favor ingresa una contraseña' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formInicioSesionKey.currentState!.validate()) {
                        final usuario = await favoritosProvider.isar.usuarios.filter()
                            .usernameEqualTo(_loginUsernameController.text)
                            .passwordEqualTo(_loginPasswordController.text)
                            .findFirst();

                        if (usuario != null) {
                          await favoritosProvider.cargarFavoritos(usuario.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Inicio de sesión exitoso')),
                          );
                          _showLoginNotification(usuario.username);
                          Navigator.pushReplacementNamed(context, '/'); // Redirigir a InicioScreen
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Credenciales incorrectas')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Iniciar Sesión'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
