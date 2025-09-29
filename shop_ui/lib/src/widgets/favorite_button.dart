import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    this.onTap,
    this.size = 36,
    this.borderRadius,
  });

  final VoidCallback? onTap;
  final double size;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? size / 2.25;
    final iconSize = size * .36;
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: const Color(0x14000000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(
              Icons.favorite_border,
              size: iconSize,
              color: const Color(0xFF9B9B9B),
            ),
          ),
        ),
      ),
    );
  }
}