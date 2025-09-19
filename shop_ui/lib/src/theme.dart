import 'package:flutter/material.dart';

ThemeData buildTheme() {
  const black = Color(0xFF222222);
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFDB3022)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF9F9F9),
      foregroundColor: black,
      elevation: 1,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: black),
    ),
  );
}
