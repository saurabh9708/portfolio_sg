import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primaryBackground,
      primaryColor: AppColors.accentColor,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentColor,
        secondary: AppColors.secondaryAccent,
        surface: AppColors.surfaceColor,
        background: AppColors.primaryBackground,
      ),
      textTheme: _textTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.dmSans(
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.dmSans(
        color: AppColors.textSecondary,
      ),
      labelLarge: GoogleFonts.jetBrainsMono(
        color: AppColors.accentColor,
      ),
    );
  }
}
