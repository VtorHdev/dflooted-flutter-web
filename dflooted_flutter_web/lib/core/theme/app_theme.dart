import 'package:flutter/material.dart';

class AppTheme {
  static const primaryGreen = Color(0xFF00FF9D);

  static TextTheme textTheme = TextTheme(
    // Título principal grande (MIS PARTIDAS)
    headlineMedium: const TextStyle(
      fontFamily: 'DeltaForce',
      fontSize: 24,
      letterSpacing: 2,
      color: primaryGreen,
      height: 1.2,
    ).apply(fontStyle: FontStyle.normal),
    // Títulos de sección (ESTADÍSTICAS POR MAPA)
    titleLarge: const TextStyle(
      fontFamily: 'DeltaForce',
      fontSize: 18,
      letterSpacing: 1.5,
      color: primaryGreen,
      height: 1.2,
    ).apply(fontStyle: FontStyle.normal),
    // Botones de navegación
    bodyLarge: const TextStyle(
      fontFamily: 'DeltaForce',
      fontSize: 16,
      letterSpacing: 1.2,
      color: Colors.white,
      height: 1.2,
    ).apply(fontStyle: FontStyle.normal),
    // Texto general
    bodyMedium: TextStyle(
      fontFamily: 'DeltaForce',
      fontSize: 14,
      letterSpacing: 1,
      color: Colors.white.withOpacity(0.9),
      height: 1.2,
    ).apply(fontStyle: FontStyle.normal),
  );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        textTheme: textTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          brightness: Brightness.dark,
        ),
      );
}
