import 'package:flutter/material.dart';
import 'state/speed_controller.dart';
import 'ui/main_page.dart';

void main() {
  final controller = SpeedController();
  runApp(AverageSpeedApp(controller: controller));
}

class AverageSpeedApp extends StatelessWidget {
  const AverageSpeedApp({super.key, required this.controller});
  final SpeedController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viteza Medie',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2563EB),
      ),
      home: AverageSpeedPage(controller: controller),
    );
  }
}
