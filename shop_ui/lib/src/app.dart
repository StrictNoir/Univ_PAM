import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home_page.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop UI',
      theme: buildTheme(),
      home: const HomePage(),
    );
  }
}
