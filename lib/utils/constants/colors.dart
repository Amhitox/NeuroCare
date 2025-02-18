import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primary = Color(0xFF6A5ACD); // Soft Purple (Main theme)
  static const Color secondary = Color(0xFF4C4F77); // Dark Purple (Accent)
  static const Color background = Color(
    0xFFF8F9FA,
  ); // Light Grey/White (Background)
  static const Color textPrimary = Color(0xFF2E2E2E); // Dark Grey (Text)
  static const Color textSecondary = Color(0xFF6D6D6D); // Light Grey (Subtext)
  static const Color buttonColor = Color(0xFF6A5ACD); // Primary Button
  static const Color alertColor = Color(0xFFFF4C4C); // Red for emergency alerts
  static const Color successColor =
      Color(0xFF4CAF50); // Green for confirmations
}

class DarkAppColors {
  DarkAppColors._();
  static const Color primary = Color(0xFF6A5ACD); // Soft Purple
  static const Color secondary = Color(0xFF282A36); // Dark Greyish Blue
  static const Color background = Color(0xFF121212); // Deep Black
  static const Color textPrimary = Color(0xFFEAEAEA); // Light Grey (Text)
  static const Color textSecondary = Color(0xFFB0B0B0); // Muted Grey (Subtext)
  static const Color buttonColor = Color(0xFF6A5ACD); // Purple Buttons
  static const Color alertColor = Color(0xFFFF4C4C); // Emergency Red
  static const Color successColor = Color(0xFF4CAF50); // Success Green
}
