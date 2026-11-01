import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/lugar_viewmodel.dart';
import 'view/pantallas/splash_pantalla.dart';
import 'view/pantallas/lugares_pantalla.dart';
import 'view/pantallas/detalle_pantalla.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LugarViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turismo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPantalla(),
        '/lugares': (context) => const LugaresPantalla(),
        '/detalle': (context) => const DetallePantalla(),
      },
    );
  }
}
