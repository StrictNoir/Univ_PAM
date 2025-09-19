import 'package:flutter/material.dart';
import '../models/product.dart';
import 'favorite_button.dart';
import 'rating_stars.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.scale = 1,
  });

  final Product product;
  final VoidCallback? onTap;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double sx(double value) => value * scale;
    return SizedBox(
      width: sx(150),
      height: sx(260),
      child: Stack(
        children: [
          Positioned(
            left: sx(1),
            right: sx(1),
            top: 0,
            height: sx(215),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(sx(8)),
              child: Image.asset(product.imageCard, fit: BoxFit.cover),
            ),
          ),
          if (product.salePercent != null)
            Positioned(
              left: sx(10),
              top: sx(8),
              child: _Pill(
                bg: const Color(0xFFDB3022),
                text: '${product.salePercent}%',
                scale: scale,
              ),
            ),
          if (product.isNew)
            Positioned(
              left: sx(10),
              top: sx(8),
              child: _Pill(
                bg: const Color(0xFF222222),
                text: 'NEW',
                scale: scale,
              ),
            ),
          Positioned(
            left: sx(113),
            top: sx(164),
            width: sx(36),
            height: sx(36),
            child: FavoriteButton(size: sx(36), borderRadius: sx(12)),
          ),
          Positioned(
            left: sx(4),
            top: sx(211),
            child: Text(
              product.brand,
              style: TextStyle(
                fontSize: sx(11),
                height: 1,
                color: const Color(0xFF9B9B9B),
              ),
            ),
          ),
          Positioned(
            left: sx(4),
            top: sx(227),
            right: sx(8),
            child: Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: sx(16),
                height: 1,
                color: const Color(0xFF222222),
              ),
            ),
          ),
          Positioned(
            left: sx(4),
            top: sx(246),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (product.oldPrice != null) ...[
                  _OldPriceTag(value: _money(product.oldPrice!), scale: scale),
                  SizedBox(width: sx(8)),
                ],
                Text(
                  _money(product.price),
                  style: TextStyle(
                    fontSize: sx(14),
                    height: 20 / 14,
                    color: product.salePercent != null
                        ? const Color(0xFFDB3022)
                        : const Color(0xFF222222),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: sx(0),
            top: sx(191),
            width: sx(100),
            child: RatingStars(
              value: product.rating,
              size: sx(14),
              gap: sx(2),
              inactiveColor: const Color(0xFF9B9B9B),
              color: const Color(0xFFFFBA49),
              showCount: product.ratingCount > 0 ? product.ratingCount : null,
              countBuilder: (count) => '$count',
              countTextStyle: TextStyle(
                fontSize: sx(10),
                color: const Color(0xFF9B9B9B),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(sx(8))),
            ),
          ),
        ],
      ),
    );
  }

  String _money(double v) => '${v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 2)}\$';
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.bg,
    required this.text,
    required this.scale,
  });

  final Color bg;
  final String text;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double sx(double value) => value * scale;
    return Container(
      height: sx(24),
      padding: EdgeInsets.symmetric(horizontal: sx(12)),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(sx(29)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: sx(11), height: 1),
      ),
    );
  }
}

class _OldPriceTag extends StatelessWidget {
  const _OldPriceTag({required this.value, required this.scale});

  final String value;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double sx(double v) => v * scale;
    final thickness = (0.4 * scale).clamp(0.4, double.infinity).toDouble();
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: sx(14),
            height: 20 / 14,
            color: const Color(0xFF9B9B9B),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            height: thickness,
            color: const Color(0xFF9B9B9B),
          ),
        ),
      ],
    );
  }
}