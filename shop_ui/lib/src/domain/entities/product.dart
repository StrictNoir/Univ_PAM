class Product {
  const Product({
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

  Product copyWith({
    String? id,
    String? brand,
    String? title,
    double? price,
    double? oldPrice,
    double? rating,
    int? ratingCount,
    String? image,
    int? salePercent,
    bool? isNew,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      title: title ?? this.title,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      image: image ?? this.image,
      salePercent: salePercent ?? this.salePercent,
      isNew: isNew ?? this.isNew,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
