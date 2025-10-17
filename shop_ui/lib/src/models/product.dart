class Product {
  final String id;
  final String brand;
  final String title;
  final String color; // e.g. "Black"
  final double price;
  final double? oldPrice;
  final double rating; // 0..5
  final int ratingCount;
  final String description;
  final String imageMainLeft; // large image
  final String imageMainRight; // large image right
  final String imageCard; // small card image
  final bool isNew;
  final int? salePercent; // -20 means -20%

  const Product({
    required this.id,
    required this.brand,
    required this.title,
    required this.color,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.imageMainLeft,
    required this.imageMainRight,
    required this.imageCard,
    this.isNew = false,
    this.salePercent,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      brand: json['brand'] as String,
      title: json['title'] as String,
      color: json['color'] as String,
      price: (json['price'] as num).toDouble(),
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['ratingCount'] as int,
      description: json['description'] as String,
      imageMainLeft: json['imageMainLeft'] as String,
      imageMainRight: json['imageMainRight'] as String,
      imageCard: json['imageCard'] as String,
      isNew: json['isNew'] as bool? ?? false,
      salePercent: json['salePercent'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'title': title,
      'color': color,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'ratingCount': ratingCount,
      'description': description,
      'imageMainLeft': imageMainLeft,
      'imageMainRight': imageMainRight,
      'imageCard': imageCard,
      'isNew': isNew,
      'salePercent': salePercent,
    };
  }
}
