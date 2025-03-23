import 'detallesproducto.dart';
import 'productosGrid.dart';
//import 'package:ejemplowidgets/productosScroll.dart';
//import 'package:ejemplowidgets/productosStack.dart';
//import 'package:ejemplowidgets/productosTextFloatingButton.dart';
import 'package:flutter/material.dart';
import 'productocondetalle.dart';
import 'productosStack.dart';
import 'productostextbutton.dart';


// Función principal
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //ocultar debug
      title: 'My Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/productos': (context) => Productos(),
        '/productosGrid': (context) => productosGrid(),
        //'/productosStack': (context) => ProductosStack(),
        //'/productosScroll': (context) => ProductosScroll(),
        //'/productosButtons': (context) => ProductosButton(),
        '/detalles': (context) => DetalleProductoScreen(),
        '/productosStack': (context) => productosStack(),
        '/productostextbutton': (context) => productobutton(),
      },
    );  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String usuarioText = ""; // Variable para guardar el nombre de usuario
  String passwordText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://scontent.fqro1-1.fna.fbcdn.net/v/t1.6435-9/96258639_2990287924383412_422139691140120576_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=25d718&_nc_eui2=AeGwh-ZVyB_nFQloUPk2YH5FH_2M3Dy4FWAf_YzcPLgVYHLqFA6CVQ5WeSXK6JaxNA0&_nc_ohc=CwpGnF1x-qIQ7kNvgEg1wPr&_nc_zt=23&_nc_ht=scontent.fqro1-1.fna&_nc_gid=ASAFXhvQJpQJ2Dq-qFhS9rH&oh=00_AYCWBi5HM6BJAKf1Q1Gl16RW4MJ3AWpCg7WxHwnWMBGz4g&oe=6730CBAA"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                nombre(),
                usuario(),
                password(),
                SizedBox(
                  height: 10,
                ),
                boton(context)
              ],
            )));
  }

  Widget nombre() {
    return Text(
      "Login",
      style: TextStyle(
          color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),
    );
  }

  Widget usuario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        decoration: InputDecoration(
          hintText: "User",
          fillColor: Colors.white,
          filled: true,
        ),
        onChanged: (value) {
          // Guardamos el valor del usuario ingresado
          usuarioText = value;
        },
      ),
    );
  }

  Widget password() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          fillColor: Colors.white,
          filled: true,
        ),
        onChanged: (value) {
          // Guardamos el valor del usuario ingresado
          passwordText = value;
        },
      ),
    );
  }

  Widget boton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan, // Color de fondo
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
        ),
        onPressed: () {
          // Navegamos a la pantalla de productos y pasamos el nombre de usuario
          Navigator.pushNamed(
            context,
            '/productosStack',
            arguments:{
              'user':usuarioText,
              'password':passwordText,
            }
          );
        },
        child: Text(
          "Entrar",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ));
  }
}
