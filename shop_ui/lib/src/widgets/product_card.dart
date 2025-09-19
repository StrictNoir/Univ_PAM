import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme.dart';
import 'favorite_button.dart';
import 'rating_stars.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSale = product.isOnSale;
    final isNew = product.isNew;
    final priceStyle = theme.textTheme.bodyMedium;
    final compareStyle = theme.textTheme.bodyMedium?.copyWith(
      color: AppColors.gray,
      decoration: TextDecoration.lineThrough,
    );

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      product.images.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isSale || isNew)
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSale ? AppColors.primary : AppColors.black,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Text(
                        isSale ? '-${_salePercent(product)}%' : 'NEW',
                        style: theme.chipTheme.labelStyle,
                      ),
                    ),
                  ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: FavoriteButton(
                    initialIsFavorite: false,
                    size: 36,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              product.brand,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              product.name,
              style: theme.textTheme.titleLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                RatingStars(rating: product.rating, size: 14),
                const SizedBox(width: 6),
                Text(
                  '(${product.ratingCount})',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${String.fromCharCode(36)}${product.price.toStringAsFixed(2)}',
                  style: priceStyle?.copyWith(
                    color: isSale ? AppColors.primary : AppColors.black,
                  ),
                ),
                if (isSale) ...[
                  const SizedBox(width: 8),
                  Text(
                    '${String.fromCharCode(36)}${product.compareAtPrice!.toStringAsFixed(2)}',
                    style: compareStyle,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _salePercent(Product product) {
    if (!product.isOnSale) {
      return 0;
    }
    final discount = 1 - (product.price / product.compareAtPrice!.clamp(0.01, double.infinity));
    return (discount * 100).round();
  }
}