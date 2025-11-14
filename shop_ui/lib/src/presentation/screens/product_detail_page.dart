import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/product_detail.dart';
import '../../domain/repositories/product_repository.dart';
import '../widgets/product_card.dart';
import '../widgets/rating_stars.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product, required this.related});

  final Product product;
  final List<Product> related;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<ProductDetailResponse> _future;

  @override
  void initState() {
    super.initState();
    final repository = context.read<ProductRepository>();
    _future = repository.getProductDetail(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title)),
      backgroundColor: const Color(0xFFF9F9F9),
      body: FutureBuilder<ProductDetailResponse>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _ErrorView(
              message: snapshot.error.toString(),
              onRetry: () {
                setState(() {
                  final repository = context.read<ProductRepository>();
                  _future = repository.getProductDetail(widget.product.id);
                });
              },
            );
          }
          final response = snapshot.data;
          if (response == null) {
            return const _ErrorView(message: 'Unable to load product details.');
          }
          return _DetailView(
            product: widget.product,
            fallbackRelated: widget.related,
            response: response,
          );
        },
      ),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({required this.product, required this.fallbackRelated, required this.response});

  final Product product;
  final List<Product> fallbackRelated;
  final ProductDetailResponse response;

  @override
  Widget build(BuildContext context) {
    final detail = response.detail;
    final gallery = detail.gallery.isNotEmpty ? detail.gallery : <String>[product.image];
    final related = response.related.isNotEmpty
        ? response.related
        : fallbackRelated.where((p) => p.id != product.id).toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: Image.network(
                gallery.first,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: const Color(0xFFE0E0E0)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(detail.brand, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF222222))),
          const SizedBox(height: 4),
          Text(detail.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF222222))),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(_formatPrice(detail.price, detail.currency),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFDB3022))),
              const SizedBox(width: 12),
              RatingStars(
                value: detail.rating,
                size: 18,
                gap: 4,
                showCount: detail.reviewsCount > 0 ? detail.reviewsCount : null,
                countBuilder: (count) => '($count)',
                countTextStyle: const TextStyle(fontSize: 14, color: Color(0xFF9B9B9B)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (detail.description.isNotEmpty)
            Text(detail.description, style: const TextStyle(fontSize: 15, height: 1.5, color: Color(0xFF4F4F4F))),
          if (detail.description.isNotEmpty) const SizedBox(height: 24),
          if (detail.sizes.isNotEmpty) ...[
            const Text('Sizes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: detail.sizes.map((size) => Chip(label: Text(size))).toList(),
            ),
            const SizedBox(height: 24),
          ],
          if (detail.colors.isNotEmpty) ...[
            const Text('Colors', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: detail.colors
                  .map((color) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _parseColor(color.hex),
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(color.name, style: const TextStyle(fontSize: 12)),
                        ],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],
          const Text('Shipping', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(detail.shippingInfo.delivery, style: const TextStyle(fontSize: 14, color: Color(0xFF4F4F4F))),
          const SizedBox(height: 8),
          Text(detail.shippingInfo.returns, style: const TextStyle(fontSize: 14, color: Color(0xFF4F4F4F))),
          const SizedBox(height: 24),
          const Text('Support', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(detail.support.contactEmail, style: const TextStyle(fontSize: 14, color: Color(0xFF4F4F4F))),
          const SizedBox(height: 4),
          Text(detail.support.faqUrl, style: const TextStyle(fontSize: 14, color: Color(0xFF4F4F4F))),
          const SizedBox(height: 24),
          _ActionButtons(actions: detail.actions),
          if (related.isNotEmpty) ...[
            const SizedBox(height: 32),
            const Text('Related products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: related.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = related[index];
                  return ProductCard(
                    product: item,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(product: item, related: related),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _parseColor(String hex) {
    try {
      final value = int.parse(hex.replaceFirst('#', ''), radix: 16);
      return Color(0xFF000000 | value);
    } catch (_) {
      return const Color(0xFFCCCCCC);
    }
  }

  String _formatPrice(double price, String currency) {
    final decimals = price.truncateToDouble() == price ? 0 : 2;
    final formatted = price.toStringAsFixed(decimals);
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$' + formatted;
      case 'EUR':
        return '€' + formatted;
      default:
        return formatted + ' ' + currency;
    }
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.actions});

  final ProductActions actions;

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];
    if (actions.addToCart) {
      buttons.add(
        Expanded(
          child: ElevatedButton(onPressed: () {}, child: const Text('Add to cart')),
        ),
      );
    }
    if (actions.addToWishlist) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 12));
      buttons.add(
        Expanded(
          child: OutlinedButton(onPressed: () {}, child: const Text('Wishlist')),
        ),
      );
    }
    if (actions.share) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 12));
      buttons.add(
        Expanded(
          child: OutlinedButton(onPressed: () {}, child: const Text('Share')),
        ),
      );
    }
    if (buttons.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(children: buttons);
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Color(0xFF222222))),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ],
        ),
      ),
    );
  }
}
