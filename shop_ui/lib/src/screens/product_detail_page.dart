import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/favorite_button.dart';
import '../widgets/rating_stars.dart';
import '../widgets/size_dropdown.dart';
import '../widgets/collapsible_panel.dart';
import '../widgets/product_card.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product, required this.related});
  final Product product;
  final List<Product> related;

  static const _baseW = 375.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final scale = width / _baseW;
        double sx(double value) => value * scale;
        final safeTop = MediaQuery.of(context).padding.top;
        double py(double value) => safeTop + sx(value);
        final totalHeight = safeTop + sx(1346);

        return Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          body: SingleChildScrollView(
            child: SizedBox(
              height: totalHeight,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: safeTop + sx(88),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 24,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: safeTop),
                        child: Stack(
                          children: [
                            Positioned(
                              left: sx(8),
                              top: sx(8),
                              child: IconButton(
                                iconSize: sx(24),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints.tight(Size(sx(40), sx(40))),
                                icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF222222)),
                                onPressed: () => Navigator.maybePop(context),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: sx(11),
                              child: Center(
                                child: Text(
                                  product.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: sx(18),
                                    height: 22 / 18,
                                    color: const Color(0xFF222222),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: sx(8),
                              top: sx(8),
                              child: IconButton(
                                iconSize: sx(24),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints.tight(Size(sx(40), sx(40))),
                                icon: const Icon(Icons.share, color: Color(0xFF222222)),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: sx(0),
                    top: py(88),
                    width: sx(275),
                    height: sx(413),
                    child: Image.asset(product.imageMainLeft, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: sx(279),
                    top: py(88),
                    width: sx(276),
                    height: sx(413),
                    child: Image.asset(product.imageMainRight, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: sx(0),
                    top: py(498),
                    width: sx(125),
                    height: sx(3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(sx(4)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: sx(16),
                    top: py(513),
                    width: sx(138),
                    height: sx(40),
                    child: SizeDropdown(
                      label: 'Size',
                      isError: true,
                      scale: scale,
                    ),
                  ),
                  Positioned(
                    left: sx(170),
                    top: py(513),
                    width: sx(137),
                    height: sx(40),
                    child: SizeDropdown(
                      label: product.color,
                      scale: scale,
                    ),
                  ),
                  Positioned(
                    left: sx(323),
                    top: py(515),
                    width: sx(36),
                    height: sx(36),
                    child: FavoriteButton(size: sx(36), borderRadius: sx(12)),
                  ),
                  Positioned(
                    left: sx(16),
                    top: py(575),
                    child: Text(
                      product.brand,
                      style: TextStyle(
                        fontSize: sx(24),
                        height: 1.2,
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    right: sx(16),
                    top: py(575),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: sx(24),
                        height: 1.2,
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: sx(16),
                    top: py(604),
                    child: Text(
                      product.title,
                      style: TextStyle(
                        fontSize: sx(11),
                        height: 1,
                        color: const Color(0xFF9B9B9B),
                      ),
                    ),
                  ),
                  Positioned(
                    left: sx(16),
                    top: py(623),
                    child: RatingStars(
                      value: product.rating,
                      size: sx(14),
                      gap: sx(2),
                      showCount: product.ratingCount > 0 ? product.ratingCount : null,
                      countBuilder: (count) => '$count',
                      countTextStyle: TextStyle(
                        fontSize: sx(10),
                        color: const Color(0xFF9B9B9B),
                      ),
                    ),
                  ),
                  Positioned(
                    left: sx(16),
                    top: py(653),
                    width: sx(343),
                    child: Text(
                      product.description,
                      style: TextStyle(
                        fontSize: sx(14),
                        height: 1.5,
                        letterSpacing: -0.15 * scale,
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: py(700),
                    height: sx(112),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 8,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: width * 0.3227,
                            right: width * 0.32,
                            top: sx(66),
                            height: sx(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100 * scale),
                              ),
                            ),
                          ),
                          Positioned(
                            left: sx(16),
                            right: sx(16),
                            top: sx(20),
                            height: sx(48),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFDB3022),
                                elevation: 6,
                                shadowColor: const Color(0x40D32626),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(sx(25)),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'ADD TO CART',
                                style: TextStyle(
                                  fontSize: sx(14),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: py(778),
                    child: CollapsiblePanel(
                      items: const [
                        CollapsibleItem('Item details'),
                        CollapsibleItem('Shipping info'),
                        CollapsibleItem('Support'),
                      ],
                      scale: scale,
                    ),
                  ),
                  Positioned(
                    left: sx(16),
                    top: py(946),
                    child: Text(
                      'You can also like this',
                      style: TextStyle(
                        fontSize: sx(18),
                        height: 22 / 18,
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    right: sx(16),
                    top: py(951),
                    child: Text(
                      '${related.length} items',
                      style: TextStyle(
                        fontSize: sx(11),
                        height: 1,
                        color: const Color(0xFF9B9B9B),
                      ),
                    ),
                  ),
                  Positioned(
                    left: sx(16),
                    right: 0,
                    top: py(980),
                    height: sx(260),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(right: sx(16)),
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(width: sx(12)),
                      itemCount: related.length,
                      itemBuilder: (_, i) => ProductCard(
                        product: related[i],
                        onTap: () {},
                        scale: scale,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}