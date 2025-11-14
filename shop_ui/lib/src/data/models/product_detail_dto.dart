import '../../domain/entities/product.dart';
import '../../domain/entities/product_detail.dart';
import 'product_dto.dart';

class ProductDetailResponseDto {
  const ProductDetailResponseDto({
    required this.detail,
    required this.related,
  });

  final ProductDetailDto detail;
  final List<ProductDto> related;

  factory ProductDetailResponseDto.fromJson(Map<String, dynamic> json) {
    final detail = ProductDetailDto.fromJson(json['product'] as Map<String, dynamic>);
    final related = (json['relatedProducts'] as List<dynamic>? ?? [])
        .map((e) => ProductDto.fromRelatedJson(e as Map<String, dynamic>))
        .toList();
    return ProductDetailResponseDto(detail: detail, related: related);
  }

  ProductDetailResponse toDomain() {
    return ProductDetailResponse(
      detail: detail.toDomain(),
      related: related.map((item) => item.toDomain()).toList(),
    );
  }
}

class ProductDetailDto {
  const ProductDetailDto({
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
  final List<ProductColorOptionDto> colors;
  final List<String> sizes;
  final ShippingInfoDto shippingInfo;
  final SupportInfoDto support;
  final ProductActionsDto actions;

  factory ProductDetailDto.fromJson(Map<String, dynamic> json) {
    return ProductDetailDto(
      id: (json['id'] ?? '') as String,
      title: (json['title'] ?? '') as String,
      brand: (json['brand'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: (json['currency'] ?? '') as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      images: _parseImages(json),
      colors: (json['colors'] as List<dynamic>? ?? [])
          .map((e) => ProductColorOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      shippingInfo: ShippingInfoDto.fromJson(
        json['shippingInfo'] as Map<String, dynamic>? ?? const {},
      ),
      support: SupportInfoDto.fromJson(
        json['support'] as Map<String, dynamic>? ?? const {},
      ),
      actions: ProductActionsDto.fromJson(
        json['actions'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  ProductDetail toDomain() {
    return ProductDetail(
      id: id,
      title: title,
      brand: brand,
      description: description,
      price: price,
      currency: currency,
      rating: rating,
      reviewsCount: reviewsCount,
      images: images,
      colors: colors.map((color) => color.toDomain()).toList(),
      sizes: sizes,
      shippingInfo: shippingInfo.toDomain(),
      support: support.toDomain(),
      actions: actions.toDomain(),
    );
  }

  static List<String> _parseImages(Map<String, dynamic> json) {
    final rawImages = json['images'] ?? json['gallery'];
    if (rawImages is List) {
      return rawImages
          .whereType<String>()
          .where((value) => value.isNotEmpty)
          .toList();
    }

    if (rawImages is String && rawImages.isNotEmpty) {
      return [rawImages];
    }

    return const [];
  }
}

class ProductColorOptionDto {
  const ProductColorOptionDto({
    required this.name,
    required this.hex,
    required this.images,
  });

  final String name;
  final String hex;
  final List<String> images;

  factory ProductColorOptionDto.fromJson(Map<String, dynamic> json) {
    return ProductColorOptionDto(
      name: (json['name'] ?? '') as String,
      hex: (json['hex'] ?? '#000000') as String,
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  ProductColorOption toDomain() {
    return ProductColorOption(name: name, hex: hex, images: images);
  }
}

class ShippingInfoDto {
  const ShippingInfoDto({
    required this.delivery,
    required this.returns,
  });

  final String delivery;
  final String returns;

  factory ShippingInfoDto.fromJson(Map<String, dynamic> json) {
    return ShippingInfoDto(
      delivery: (json['delivery'] ?? '') as String,
      returns: (json['returns'] ?? '') as String,
    );
  }

  ShippingInfo toDomain() {
    return ShippingInfo(delivery: delivery, returns: returns);
  }
}

class SupportInfoDto {
  const SupportInfoDto({
    required this.contactEmail,
    required this.faqUrl,
  });

  final String contactEmail;
  final String faqUrl;

  factory SupportInfoDto.fromJson(Map<String, dynamic> json) {
    return SupportInfoDto(
      contactEmail: (json['contactEmail'] ?? '') as String,
      faqUrl: (json['faqUrl'] ?? '') as String,
    );
  }

  SupportInfo toDomain() {
    return SupportInfo(contactEmail: contactEmail, faqUrl: faqUrl);
  }
}

class ProductActionsDto {
  const ProductActionsDto({
    required this.addToCart,
    required this.addToWishlist,
    required this.share,
  });

  final bool addToCart;
  final bool addToWishlist;
  final bool share;

  factory ProductActionsDto.fromJson(Map<String, dynamic> json) {
    return ProductActionsDto(
      addToCart: json['addToCart'] as bool? ?? false,
      addToWishlist: json['addToWishlist'] as bool? ?? false,
      share: json['share'] as bool? ?? false,
    );
  }

  ProductActions toDomain() {
    return ProductActions(
      addToCart: addToCart,
      addToWishlist: addToWishlist,
      share: share,
    );
  }
}
