import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_page.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Demo data using your assets
  List<Product> _items() => [
    Product(
      id: '1',
      brand: 'H&M',
      title: 'Short black dress',
      color: 'Black',
      price: 19.99,
      oldPrice: null,
      rating: 5,
      ratingCount: 10,
      description:
      'Short dress in soft cotton jersey with decorative buttons down the front and a wide, '
          'frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust '
          'and short puff sleeves with a small frill trim.',
      imageMainLeft: 'assets/images/small_banner.png',
      imageMainRight: 'assets/images/product_2.png',
      imageCard: 'assets/images/product_3.png',
    ),
    Product(
      id: '2',
      brand: 'Dorothy Perkins',
      title: 'Evening Dress',
      color: 'Pink',
      price: 12,
      oldPrice: 15,
      rating: 4.5,
      ratingCount: 24,
      description: 'Elegant evening dress.',
      imageMainLeft: 'assets/images/product_4.png',
      imageMainRight: 'assets/images/product_5.png',
      imageCard: 'assets/images/product_7.png',
      salePercent: -20,
    ),
    Product(
      id: '3',
      brand: 'Mango Boy',
      title: 'T-Shirt Sailing',
      color: 'White',
      price: 10,
      rating: 0,
      ratingCount: 0,
      description: 'Casual tee',
      imageMainLeft: 'assets/images/small_banner.png',
      imageMainRight: 'assets/images/product_5.png',
      imageCard: 'assets/images/product_8.png',
      isNew: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items = _items();
    final saleItems = items.where((p) => p.salePercent != null).toList();
    final newItems = items.where((p) => p.isNew).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _SmallBanner(
                  backgroundImage: 'assets/images/product_9.png',
                  foregroundImage: 'assets/images/small_banner.png',
                ),
              ),
              const SizedBox(height: 40),
              if (saleItems.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _SaleBlock(
                    title: 'Sale',
                    subtitle: 'Super summer sale',
                    actionText: 'See more',
                    products: saleItems,
                    onProductTap: (product) =>
                        _openProduct(context, product, items),
                  ),
                ),
              if (saleItems.isNotEmpty && newItems.isNotEmpty)
                const SizedBox(height: 32),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _SaleBlock(
                  title: 'New',
                  subtitle: "You've never seen it before!",
                  actionText: 'View all',
                  products: newItems.isNotEmpty ? newItems : items,
                  onProductTap: (product) =>
                      _openProduct(context, product, items),
                ),
              ),
            ],
          ),
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

class _SmallBanner extends StatelessWidget {
  const _SmallBanner({
    required this.backgroundImage,
    required this.foregroundImage,
  });

  final String backgroundImage;
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
            left: -31,
            top: -282,
            width: 456,
            height: 688,
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F80ED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '376 × 196',
                  style: TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: 12,
                    height: 1,
                    color: Colors.white,
                  ),
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

  static const _cardOffsets = [0.0332, 0.3776, 0.7212];
  static const _cardTopRatio = 0.2145;

  @override
  Widget build(BuildContext context) {
    final visible = products.take(_cardOffsets.length).toList();
    return SizedBox(
      width: 482,
      height: 331,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: width * 0.0427,
                top: 0,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: 34,
                    height: 1,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
              Positioned(
                left: width * 0.048,
                top: 331 * 0.1148,
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: 11,
                    height: 1,
                    color: Color(0xFF9B9B9B),
                  ),
                ),
              ),
              Positioned(
                right: width * 0.0373,
                top: 331 * 0.0574,
                child: Text(
                  actionText,
                  style: const TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: 11,
                    height: 1,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
              for (var i = 0; i < visible.length; i++)
                Positioned(
                  left: width * _cardOffsets[i],
                  top: 331 * _cardTopRatio,
                  child: ProductCard(
                    product: visible[i],
                    onTap: () => onProductTap(visible[i]),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}