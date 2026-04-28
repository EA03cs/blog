import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryRed = Color(0xFFB40001);

  static const Color darkRed = Color(0xFF8B0001);
  static const Color darkerRed = Color(0xFF6B0001);
  static const Color deepRed = Color(0xFF4B0000);

  static const Color lightRed = Color(0xFFD63335);
  static const Color lighterRed = Color(0xFFE86668);
  static const Color paleRed = Color(0xFFF5999A);
  static const Color softRed = Color(0xFFFCCCCD);

  static const Color redBackground = Color(0xFFFFF5F5);
  static const Color lightRedBackground = Color(0xFFFFEBEB);

  static const Color blackText = Colors.black;
  static const Color greyText = Color(0xFF757575);
  static const Color darkGreyText = Color(0xFF424242);
  static const Color lightGreyText = Color(0xFF9E9E9E);

  static const Color white = Colors.white;
  static const Color offWhite = Color(0xFFFAFAFA);
  static const Color lightGrey = Color(0xFFF5F5F5);

  static const Color error = Color(0xFFB40001);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  static const LinearGradient redGradient = LinearGradient(
    colors: [
      Color(0xFFB40001),
      Color(0xFFD63335),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lightRedGradient = LinearGradient(
    colors: [
      Color(0xFFE86668),
      Color(0xFFF5999A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Color redShadow = primaryRed.withOpacity(0.2);
  static Color lightRedShadow = lightRed.withOpacity(0.15);

  static const Color redBorder = Color(0xFFB40001);
  static const Color lightRedBorder = Color(0xFFE86668);
  static const Color greyBorder = Color(0xFFE0E0E0);

  static Color redOverlay = primaryRed.withOpacity(0.1);
  static Color darkRedOverlay = darkRed.withOpacity(0.3);
}