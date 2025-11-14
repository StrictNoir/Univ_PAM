import 'product.dart';

class ProductDetailResponse {
  const ProductDetailResponse({
    required this.detail,
    required this.related,
  });

  final ProductDetail detail;
  final List<Product> related;
}

class ProductDetail {
  const ProductDetail({
    required this.id,
    required this.title,
    required this.brand,
    required this.description,
    required this.price,
    required this.currency,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.shippingInfo,
    required this.support,
    required this.actions,
  });

  final String id;
  final String title;
  final String brand;
  final String description;
  final double price;
  final String currency;
  final double rating;
  final int reviewsCount;
  final List<String> images;
  final List<ProductColorOption> colors;
  final List<String> sizes;
  final ShippingInfo shippingInfo;
  final SupportInfo support;
  final ProductActions actions;

  List<String> get gallery {
    return [
      ...images,
      ...colors.expand((color) => color.images),
    ];
  }
}

class ProductColorOption {
  const ProductColorOption({
    required this.name,
    required this.hex,
    required this.images,
  });

  final String name;
  final String hex;
  final List<String> images;
}

class ShippingInfo {
  const ShippingInfo({
    required this.delivery,
    required this.returns,
  });

  final String delivery;
  final String returns;
}

class SupportInfo {
  const SupportInfo({
    required this.contactEmail,
    required this.faqUrl,
  });

  final String contactEmail;
  final String faqUrl;
}

class ProductActions {
  const ProductActions({
    required this.addToCart,
    required this.addToWishlist,
    required this.share,
  });

  final bool addToCart;
  final bool addToWishlist;
  final bool share;
}
