import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2D5BE3);
  static const Color primaryLight = Color(0xFF6B8FF2);
  static const Color primaryDark = Color(0xFF1A3FA0);

  // Secondary colors
  static const Color secondary = Color(0xFF26C6DA);
  static const Color secondaryLight = Color(0xFF6FF9FF);
  static const Color secondaryDark = Color(0xFF0095A8);

  // Accent colors
  static const Color accent = Color(0xFFFFA726);
  static const Color accentLight = Color(0xFFFFD95B);
  static const Color accentDark = Color(0xFFC77800);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8F9FC);
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);

  // Text colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF718096);
  static const Color textTertiary = Color(0xFFA0AEC0);
  static const Color textLight = Color(0xFFFFFFFF);

  // Shadow colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
