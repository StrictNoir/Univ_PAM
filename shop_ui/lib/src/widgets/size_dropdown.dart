import 'package:flutter/material.dart';

class SizeDropdown extends StatelessWidget {
  const SizeDropdown({
    super.key,
    required this.label,
    this.isError = false,
    this.scale = 1,
  });

  final String label;
  final bool isError;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double sx(double value) => value * scale;
    return Container(
      height: sx(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sx(8)),
        border: Border.all(
          color: isError ? const Color(0xFFF01F0E) : const Color(0xFF9B9B9B),
          width: .4 * scale,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sx(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: sx(14),
                height: 20 / 14,
                color: const Color(0xFF222222),
              ),
            ),
            Icon(Icons.keyboard_arrow_down,
                size: sx(16), color: const Color(0xFF222222)),
          ],
        ),
      ),
    );
  }
}