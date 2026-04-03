import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/home_screen.dart';


void main() {
  // Asegurar inmersión (Barra de estado transparente)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const VantageApp());
}


class VantageApp extends StatelessWidget {
  const VantageApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VANTAGE',
      debugShowCheckedModeBanner: false,
     
      // Aplicar el tema centralizado
      theme: AppTheme.darkTheme,
     
      // Pantalla de inicio modularizada
      home: const HomeScreen(),
    );
  }
}
