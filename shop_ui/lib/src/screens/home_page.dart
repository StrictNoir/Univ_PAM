import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_cubit.dart';
import '../models/product.dart';
import 'product_detail_page.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            switch (state.status) {
              case ProductStatus.initial:
              case ProductStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ProductStatus.failure:
                return _ErrorView(
                  message: state.errorMessage ?? 'Failed to load products.',
                  onRetry: () => context.read<ProductCubit>().loadProducts(),
                );
              case ProductStatus.success:
                final items = state.products;
                if (items.isEmpty) {
                  return const _EmptyView();
                }
                return _LoadedView(
                  items: items,
                  onProductTap: (product) =>
                      _openProduct(context, product, items),
                );
            }
          },
        ),
      ),
    );
  }

  void _openProduct(BuildContext context, Product product, List<Product> all) {
    final related = all.where((p) => p.id != product.id).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: product, related: related),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({
    required this.items,
    required this.onProductTap,
  });

  final List<Product> items;
  final ValueChanged<Product> onProductTap;

  @override
  Widget build(BuildContext context) {
    final saleItems = items.where((p) => p.salePercent != null).toList();
    final nonSaleItems = items.where((p) => p.salePercent == null).toList();
    final newItems = items.where((p) => p.isNew).toList();

    List<Product> fillSaleRow() {
      if (saleItems.length >= 3) {
        return saleItems.take(3).toList();
      }
      final combined = [
        ...saleItems,
        ...nonSaleItems,
      ];
      return combined.take(3).toList();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: _SmallBanner(
              foregroundImage: 'assets/images/small_banner.png',
            ),
          ),
          const SizedBox(height: 80),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SaleBlock(
              title: 'Sale',
              subtitle: 'Super summer sale',
              actionText: 'View all',
              products: fillSaleRow(),
              onProductTap: onProductTap,
            ),
          ),
          if (newItems.isNotEmpty) const SizedBox(height: 40),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SaleBlock(
              title: 'New',
              subtitle: "You've never seen it before!",
              actionText: 'View all',
              products: newItems.isNotEmpty ? newItems : items,
              onProductTap: onProductTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Color(0xFF222222)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No products available right now.',
        style: TextStyle(fontSize: 16, color: Color(0xFF222222)),
      ),
    );
  }
}

class _SmallBanner extends StatelessWidget {
  const _SmallBanner({
    required this.foregroundImage,
  });

  final String foregroundImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 376,
      height: 196,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFC4C4C4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: _StatusBar(),
          ),
          Positioned(
            left: -5,
            top: -22,
            width: 390,
            height: 260,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                foregroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 136,
            child: SizedBox(
              width: 238,
              height: 34,
              child: Text(
                'Street clothes',
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  height: 1,
                  letterSpacing: 0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              '9:41',
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 15,
                height: 18 / 15,
                letterSpacing: -0.02,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Icon(
              Icons.signal_cellular_alt,
              size: 18,
              color: Colors.black,
            ),
            SizedBox(width: 6),
            Icon(
              Icons.wifi,
              size: 18,
              color: Colors.black,
            ),
            SizedBox(width: 6),
            Icon(
              Icons.battery_full,
              size: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}



class _SaleBlock extends StatelessWidget {
  const _SaleBlock({
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.products,
    required this.onProductTap,
  });

  final String title;
  final String subtitle;
  final String actionText;
  final List<Product> products;
  final ValueChanged<Product> onProductTap;

  @override
  Widget build(BuildContext context) {
    final visible = products.take(3).toList();
    return SizedBox(
      width: 482,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 34,
                        height: 1,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    actionText,
                    style: const TextStyle(
                      fontFamily: 'Metropolis',
                      fontSize: 11,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF222222),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 11,
                  height: 1,
                  color: Color(0xFF9B9B9B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 266,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < visible.length; i++) ...[
                  if (i > 0) const SizedBox(width: 16),
                  ProductCard(
                    product: visible[i],
                    onTap: () => onProductTap(visible[i]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}