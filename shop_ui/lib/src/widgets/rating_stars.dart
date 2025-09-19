import 'package:flutter/material.dart';

import '../theme.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating, this.size = 16});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    final stars = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      IconData icon;
      if (rating >= i) {
        icon = Icons.star;
      } else if (rating + 0.5 >= i) {
        icon = Icons.star_half;
      } else {
        icon = Icons.star_border;
      }
      stars.add(Icon(
        icon,
        size: size,
        color: icon == Icons.star_border ? AppColors.gray : AppColors.star,
      ));
    }

    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}