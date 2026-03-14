import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color primaryBackground = Color(0xFF0A0A0F);
  static const Color surfaceColor = Color(0xFF111118);
  static const Color cardBackground = Color(0xFF1A1A24);

  // Accents
  static const Color primaryColor = Color(0xFF00E5FF); // Alias for primary accent
  static const Color accentColor = Color(0xFF00E5FF);
  static const Color secondaryAccent = Color(0xFF7B61FF);

  // Text
  static const Color textPrimary = Color(0xFFF0F0F5);
  static const Color textSecondary = Color(0xFF8A8A9A);

  // Borders & Dividers
  static const Color border = Color(0x14FFFFFF); // rgba(255, 255, 255, 0.08)

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentColor, secondaryAccent],
    stops: [0.0, 1.0], // 135 degrees roughly via Alignment
  );

  // Shadow Colors
  static const Color floatShadow = Color(0x0D00E5FF); // rgba(0, 229, 255, 0.05)
}
