// EduPlay Design System
// Spec: /specs/product/ux-children.md — sección de colores y tipografía

import 'package:flutter/material.dart';

abstract final class EduPlayColors {
  static const primaryBlue = Color(0xFF3B82F6);
  static const successGreen = Color(0xFF22C55E);
  static const energyYellow = Color(0xFFFBBF24);
  static const softRed = Color(0xFFF87171);
  static const adventurePurple = Color(0xFFA855F7);
  static const backgroundLight = Color(0xFFF0F9FF);
  static const textDark = Color(0xFF1E293B);
  static const textMedium = Color(0xFF64748B);
  static const surfaceWhite = Color(0xFFFFFFFF);
  static const cardBackground = Color(0xFFFFFFFF);
}

abstract final class EduPlayTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: EduPlayColors.primaryBlue,
          surface: EduPlayColors.surfaceWhite,
        ),
        fontFamily: 'Nunito',
        textTheme: const TextTheme(
          // Títulos grandes para niños — mínimo 28sp
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: EduPlayColors.textDark,
          ),
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: EduPlayColors.textDark,
          ),
          // Cuerpo — mínimo 18sp según spec UX infantil
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: EduPlayColors.textDark,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: EduPlayColors.textDark,
          ),
          // Botones — 20sp SemiBold
          labelLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: EduPlayColors.surfaceWhite,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: EduPlayColors.primaryBlue,
            foregroundColor: EduPlayColors.surfaceWhite,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Nunito',
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: EduPlayColors.cardBackground,
          elevation: 4,
          shadowColor: EduPlayColors.primaryBlue.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        scaffoldBackgroundColor: EduPlayColors.backgroundLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: EduPlayColors.backgroundLight,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: EduPlayColors.textDark,
          ),
        ),
      );
}
