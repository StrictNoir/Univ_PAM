import '../../domain/entities/product.dart';

class ProductDto {
  const ProductDto({
    required this.id,
    required this.brand,
    required this.title,
    required this.price,
    required this.rating,
    required this.ratingCount,
    required this.image,
    this.oldPrice,
    this.salePercent,
    this.isNew = false,
    this.isFavorite = false,
  });

  final String id;
  final String brand;
  final String title;
  final double price;
  final double? oldPrice;
  final double rating;
  final int ratingCount;
  final String image;
  final int? salePercent;
  final bool isNew;
  final bool isFavorite;

  factory ProductDto.fromFeedJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final title = (json['title'] ?? json['name'] ?? '') as String;
    final rating = (json['rating'] as num?)?.toDouble() ?? 0;
    final reviews = json['reviews'] ?? json['reviewsCount'] ?? 0;
    final ratingCount =
        reviews is num ? reviews.toInt() : int.tryParse(reviews.toString()) ?? 0;
    final isNew = json['isNew'] as bool? ?? false;
    final isFavorite = json['isFavorite'] as bool? ?? false;

    double? oldPrice;
    double price;
    if (json.containsKey('newPrice')) {
      price = (json['newPrice'] as num?)?.toDouble() ?? 0;
      oldPrice = (json['oldPrice'] as num?)?.toDouble();
    } else {
      price = (json['price'] as num?)?.toDouble() ?? 0;
      oldPrice = (json['oldPrice'] as num?)?.toDouble();
    }

    final discount = _parseDiscount(json['discount']);
    final salePercent = discount != null ? -discount.abs() : null;

    return ProductDto(
      id: id,
      brand: (json['brand'] ?? '') as String,
      title: title,
      price: price,
      oldPrice: oldPrice,
      rating: rating,
      ratingCount: ratingCount,
      image: _parseImage(json),
      salePercent: salePercent,
      isNew: isNew,
      isFavorite: isFavorite,
    );
  }

  factory ProductDto.fromRelatedJson(Map<String, dynamic> json) {
    final discount = _parseDiscount(json['discount']);
    return ProductDto(
      id: json['id']?.toString() ?? '',
      brand: (json['brand'] ?? '') as String,
      title: (json['title'] ?? json['name'] ?? '') as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      image: _parseImage(json),
      salePercent: discount != null ? discount.abs() * -1 : null,
      isNew: json['isNew'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Product toDomain() {
    return Product(
      id: id,
      brand: brand,
      title: title,
      price: price,
      oldPrice: oldPrice,
      rating: rating,
      ratingCount: ratingCount,
      image: image,
      salePercent: salePercent,
      isNew: isNew,
      isFavorite: isFavorite,
    );
  }

  static int? _parseDiscount(dynamic raw) {
    if (raw == null) {
      return null;
    }
    if (raw is num) {
      return raw.toInt();
    }
    final cleaned = raw.toString().replaceAll(RegExp(r'[^0-9-]'), '');
    if (cleaned.isEmpty) {
      return null;
    }
    return int.tryParse(cleaned);
  }

  static String _parseImage(Map<String, dynamic> json) {
    final candidates = <dynamic?>[
      json['image'],
      json['imageUrl'],
      json['imageURL'],
      json['thumbnail'],
      json['cover'],
    ];

    for (final candidate in candidates) {
      if (candidate is String && candidate.isNotEmpty) {
        return candidate;
      }
    }

    final rawImages = json['images'];
    if (rawImages is List) {
      for (final item in rawImages) {
        if (item is String && item.isNotEmpty) {
          return item;
        }
      }
    }

    return '';
  }
}
