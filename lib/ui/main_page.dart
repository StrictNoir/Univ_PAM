import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../state/speed_controller.dart';

class AverageSpeedPage extends StatefulWidget {
  const AverageSpeedPage({super.key, required this.controller});
  final SpeedController controller;

  @override
  State<AverageSpeedPage> createState() => _AverageSpeedPageState();
}

class _AverageSpeedPageState extends State<AverageSpeedPage> {
  final _distanceCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();

  // Input formatter: permite doar cifre, punct si virgula
  final _numFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
  ];

  @override
  void dispose() {
    _distanceCtrl.dispose();
    _timeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return AnimatedBuilder(
      animation: c,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Calculator viteza medie')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _distanceCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Distanta (km)',
                    hintText: 'ex: 120.5',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: _numFormatter,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _timeCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Timpul (ore)',
                    hintText: 'ex: 1.8',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: _numFormatter,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => c.calculate(
                          distanceText: _distanceCtrl.text,
                          timeText: _timeCtrl.text,
                        ),
                        child: const Text('Calculeaza'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      tooltip: 'Reset',
                      onPressed: () {
                        _distanceCtrl.clear();
                        _timeCtrl.clear();
                        c.reset();
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (c.error != null)
                  Text(
                    c.error!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                if (c.average != null)
                  Text(
                    'Viteza medie: ${c.average!.toStringAsFixed(2)} km/h',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
