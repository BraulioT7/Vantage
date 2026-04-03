import 'package:flutter/material.dart';

class VantageColors {
  // --- PALETA BASE (OBSIDIAN MATTE) ---
  static const Color obsidian = Color(0xFF020202);
  static const Color surface = Color(0xFF0A0A0A);   // Cartas base
  static const Color elevatedSurface = Color(0xFF121212); // Cartas secundarias
  
  // --- ACENTOS TECNOLÓGICOS ---
  static const Color neonMint = Color(0xFF00FFCC);      // Éxito / Precisión / Ghost-Sync
  static const Color electricViolet = Color(0xFF8B00FF);// Energía / Héroes / Especiales
  static const Color vividCyan = Color(0xFF00F0FF);     // UI / Info / Tecnología
  static const Color warningAmber = Color(0xFFFFAB00);  // Alertas Meta / Tilt
  
  // --- ESTADOS SEMÁNTICOS ---
  static const Color success = Color(0xFF00FFCC);
  static const Color error = Color(0xFFFF3D00);
  static const Color info = Color(0xFF00F0FF);
  
  // --- JERARQUÍA DE TEXTO ---
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E8E);
  static const Color textMuted = Color(0xFF404040);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: VantageColors.obsidian,
      primaryColor: VantageColors.vividCyan,
      
      // Tipografía: Roboto como fallback estándar
      fontFamily: 'Roboto', 
      
      useMaterial3: true,
      
      // Se han añadido los parámetros obligatorios faltantes para evitar errores de compilación
      colorScheme: const ColorScheme.dark(
        primary: VantageColors.vividCyan,
        onPrimary: Colors.black,
        secondary: VantageColors.electricViolet,
        onSecondary: Colors.white,
        surface: VantageColors.surface,
        onSurface: VantageColors.textPrimary,
        error: VantageColors.error,
        onError: Colors.white,
      ),

      // --- ESTILO DE CARTAS CORREGIDO ---
      cardTheme: CardThemeData(
        color: VantageColors.surface,
        surfaceTintColor: Colors.transparent, // Evita el tinte automático de Material 3
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),

      // --- BOTONES DINÁMICOS ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 1.1,
            fontStyle: FontStyle.italic,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),

      // --- INPUTS DE TEXTO ---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        hintStyle: const TextStyle(color: VantageColors.textMuted, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: VantageColors.vividCyan, width: 1),
        ),
      ),
      
      // --- NAVEGACIÓN ---
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: VantageColors.obsidian,
        selectedItemColor: VantageColors.neonMint,
        unselectedItemColor: VantageColors.textMuted,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
        unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}