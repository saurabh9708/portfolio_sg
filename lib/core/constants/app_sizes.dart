import 'package:flutter/material.dart';

class AppSizes {
  // Layout constraints
  static const double mobileBreakPoint = 600.0;
  static const double tabletBreakPoint = 1024.0;
  static const double maxContentWidth = 1200.0;

  // Padding & Margins
  static const double sectionPaddingHMobile = 24.0;
  static const double sectionPaddingHTablet = 48.0;
  static const double sectionPaddingHDesktop = 0.0; // Handled by centering max width constraint
  
  static const double sectionPaddingVMobile = 64.0;
  static const double sectionPaddingVDesktop = 100.0;

  // Animation Durations
  static const Duration animDurationFast = Duration(milliseconds: 200);
  static const Duration animDurationMedium = Duration(milliseconds: 300);
  static const Duration animDurationSlow = Duration(milliseconds: 600);
  static const Duration animDurationSlower = Duration(milliseconds: 900);
  
  static const Duration staggerDelay = Duration(milliseconds: 80);

  // Curves
  static const Curve curveIn = Curves.easeOutCubic;
  static const Curve curveOut = Curves.easeInCubic;
}
