import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.value,
    this.size = 14,
    this.color = const Color(0xFFFFBA49),
    this.inactiveColor = const Color(0xFF9B9B9B),
    this.showCount,
    this.countBuilder,
    this.gap = 2,
    this.countTextStyle,
  });

  final double value; // 0..5
  final double size;
  final Color color;
  final Color inactiveColor;
  final int? showCount;
  final String Function(int count)? countBuilder;
  final double gap;
  final TextStyle? countTextStyle;


  @override
  Widget build(BuildContext context) {
    final stars = <Widget>[];
    for (var i = 0; i < 5; i++) {
      final filled = value >= i + 1;
      final half = value > i && value < i + 1;
      if (i != 0) {
        stars.add(SizedBox(width: gap));
      }
      stars.add(Icon(
        half ? Icons.star_half : (filled ? Icons.star : Icons.star_border),
        size: size,
        color: filled || half ? color : inactiveColor,
      ));
    }
    if (showCount != null) {
      stars
        ..add(SizedBox(width: gap * 2))
        ..add(Text(
          countBuilder?.call(showCount!) ?? '(${showCount!})',
          style:
          countTextStyle ?? const TextStyle(fontSize: 10, color: Color(0xFF9B9B9B)),
        ));
    }
    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}