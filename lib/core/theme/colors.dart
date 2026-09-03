import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Pastel Tranquil Theme
  static const Color primary = Color(0xFFFF9A9E); // Salmon pink
  static const Color secondary = Color(0xFFD4C4FB); // Soft lavender
  static const Color accent = Color(0xFFFFDAB9); // Soft peach

  // Background colors
  static const Color backgroundLight = Color(0xFFFFF0F5);
  static const Color backgroundDark = Color(0xFFFFF0F5); // Keep pastel for dark mode too to match aesthetic
  
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Colors.white;

  // Text colors
  static const Color textPrimaryLight = Color(0xFF2D3142); // Dark slate
  static const Color textSecondaryLight = Color(0xFF9094A6); // Gray
  
  static const Color textPrimaryDark = Color(0xFF2D3142); // Dark slate for light pastel backgrounds
  static const Color textSecondaryDark = Color(0xFF9094A6);
  // Error & Feedback
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF00FF66);
  static const Color warning = Color(0xFFFF9500);
}
