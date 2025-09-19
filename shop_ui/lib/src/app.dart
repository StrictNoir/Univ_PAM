import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'theme.dart';

class ShopUiApp extends StatelessWidget {
  const ShopUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop UI',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomePage(),
    );
  }
}