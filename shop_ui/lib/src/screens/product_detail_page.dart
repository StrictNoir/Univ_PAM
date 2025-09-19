import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme.dart';
import '../widgets/collapsible_panel.dart';
import '../widgets/favorite_button.dart';
import '../widgets/product_card.dart';
import '../widgets/rating_stars.dart';
import '../widgets/size_dropdown.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? _selectedSize;
  bool _showSizeError = false;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final displayImages = product.images.length >= 2
        ? product.images.take(2).toList()
        : [product.images.first, product.images.first];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (var i = 0; i < displayImages.length; i++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: i == 0 ? 8 : 0,
                          left: i == 0 ? 0 : 8,
                        ),
                        child: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              displayImages[i],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brand,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.shortDescription,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${String.fromCharCode(36)}${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: AppColors.black),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  RatingStars(rating: product.rating),
                  const SizedBox(width: 8),
                  Text(
                    '${product.rating.toStringAsFixed(1)} (${product.ratingCount})',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  FavoriteButton(
                    initialIsFavorite: _isFavorite,
                    onChanged: (value) => setState(() => _isFavorite = value),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizeDropdown(
                sizes: product.sizes,
                value: _selectedSize,
                onChanged: (size) => setState(() {
                  _selectedSize = size;
                  _showSizeError = false;
                }),
                showError: _showSizeError,
              ),
              const SizedBox(height: 24),
              Text(
                product.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              CollapsiblePanel(
                title: 'Item details',
                content:
                'Composition: 100% cotton. Care: machine wash cold. Fit: true to size.',
                initiallyExpanded: true,
              ),
              CollapsiblePanel(
                title: 'Shipping info',
                content:
                'Free standard shipping on orders over ${String.fromCharCode(36)}50. Express options available at checkout.',
              ),
              CollapsiblePanel(
                title: 'Support',
                content:
                'Need help? Contact our style experts 24/7 via chat or email support.',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'You can also like this',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    '${recommendedProducts.length} items',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final product = recommendedProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: () => _openAnotherProduct(context, product),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: SafeArea(
          top: false,
          child: ElevatedButton(
            onPressed: _handleAddToCart,
            child: const Text('Add to Cart'),
          ),
        ),
      ),
    );
  }

  void _handleAddToCart() {
    if (_selectedSize == null) {
      setState(() {
        _showSizeError = true;
      });
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added size $_selectedSize to cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openAnotherProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: product),
      ),
    );
  }
}