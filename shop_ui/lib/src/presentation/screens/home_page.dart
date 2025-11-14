import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/feed.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_cubit.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

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
                final feed = state.feed;
                if (feed == null || feed.sections.isEmpty) {
                  return const _EmptyView();
                }
                final allItems = feed.sections
                    .expand((section) => section.items)
                    .toList(growable: false);
                return _LoadedView(
                  feed: feed,
                  onProductTap: (product) =>
                      _openProduct(context, product, allItems),
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
    required this.feed,
    required this.onProductTap,
  });

  final FeedData feed;
  final ValueChanged<Product> onProductTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderBanner(header: feed.header),
          const SizedBox(height: 24),
          for (final section in feed.sections) ...[
            _ProductSection(
              section: section,
              onProductTap: onProductTap,
            ),
            const SizedBox(height: 32),
          ],
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

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner({required this.header});

  final FeedHeader header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            AspectRatio(
              aspectRatio: 376 / 196,
              child: Image.network(
                header.bannerImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFC4C4C4),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xCC000000),
                    Color(0x00000000),
                  ],
                ),
              ),
              child: Text(
                header.title,
                style: const TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductSection extends StatelessWidget {
  const _ProductSection({
    required this.section,
    required this.onProductTap,
  });

  final FeedSection section;
  final ValueChanged<Product> onProductTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            section.subtitle,
            style: const TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 13,
              color: Color(0xFF9B9B9B),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final product = section.items[index];
                return ProductCard(
                  product: product,
                  onTap: () => onProductTap(product),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: section.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
