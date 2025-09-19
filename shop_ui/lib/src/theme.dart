import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFDB3022);
  static const Color black = Color(0xFF222222);
  static const Color gray = Color(0xFF9B9B9B);
  static const Color background = Color(0xFFF9F9F9);
  static const Color star = Color(0xFFFFBA49);
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.black,
      background: AppColors.background,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors.black,
      onSurface: AppColors.black,
    ),
    fontFamily: 'Metropolis',
    fontFamilyFallback: const ['Roboto'],
  );

  final textTheme = base.textTheme.copyWith(
    headlineLarge: const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
      height: 1.0,
    ),
    headlineMedium: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
      height: 1.2,
    ),
    titleLarge: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
      height: 1.22,
    ),
    bodyLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      height: 1.5,
      letterSpacing: -0.15,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      height: 1.4,
    ),
    bodySmall: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.gray,
      height: 1.1,
    ),
    labelLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.4,
      letterSpacing: 0.2,
    ),
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: textTheme,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: AppColors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 4,
        shadowColor: AppColors.primary.withOpacity(0.25),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: AppColors.black,
      labelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: const StadiumBorder(),
    ),
  );
}