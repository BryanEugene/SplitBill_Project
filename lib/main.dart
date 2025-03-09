import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Import halaman Login
import 'screens/register_screen.dart'; // Import halaman Register
import 'screens/home_screen.dart'; // Import halaman Home

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split Bill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFDCF2F1),
      ),
      home: LoginScreen(), // Mulai dari halaman Login
      routes: {
        '/home': (ctx) => HomeScreen(), // Route untuk HomeScreen
        '/login': (ctx) => LoginScreen(), // Route untuk LoginScreen
        '/register': (ctx) => RegisterScreen(), // Route untuk RegisterScreen
      },
    );
  }
}