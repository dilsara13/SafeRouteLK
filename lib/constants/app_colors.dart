// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2A5C82);
  static const Color secondary = Color(0xFF4CAF50);
  static const Color accent = Color(0xFFFF6B6B);

  // Emergency Colors
  static const Color emergency = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB74D);
  static const Color safe = Color(0xFF66BB6A);

  // Background Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);

  // Gradients
  static Gradient get safetyGradient => const LinearGradient(
        colors: [Color(0xFF2A5C82), Color(0xFF4CAF50)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static Gradient get emergencyGradient => const LinearGradient(
        colors: [Color(0xFFE53935), Color(0xFFFF6B6B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
