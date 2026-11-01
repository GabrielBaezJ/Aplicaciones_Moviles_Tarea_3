import 'dart:async';
import 'package:flutter/material.dart';

class SplashPantalla extends StatefulWidget {
  const SplashPantalla({super.key});

  @override
  State<SplashPantalla> createState() => _SplashPantallaState();
}

class _SplashPantallaState extends State<SplashPantalla>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animacionFade;
  late Animation<double> _animacionEscala;
  Timer? _temporizador;

  @override
  void initState() {
    super.initState();

    // Configuracion de animacion basica (aparicion progresiva y cambio de tamano)
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _animacionFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    _animacionEscala = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _animController.forward();

    // Navegacion automatica hacia la pantalla de lugares despues de 3 segundos
    _temporizador = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        //rutas
        Navigator.pushReplacementNamed(context, '/lugares');
      }
    });
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade900,
              Colors.deepPurple.shade600,
              Colors.deepPurple.shade400,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animacion combinada de escala y aparicion
            ScaleTransition(
              scale: _animacionEscala,
              child: FadeTransition(
                opacity: _animacionFade,
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.travel_explore_rounded,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            FadeTransition(
              opacity: _animacionFade,
              child: const Column(
                children: [
                  Text(
                    'Ecuador Turístico',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Descubre los mejores destinos',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48.0),
            FadeTransition(
              opacity: _animacionFade,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                strokeWidth: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
