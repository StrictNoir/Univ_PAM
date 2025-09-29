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
  final String imageMainLeft;   // large image
  final String imageMainRight;  // large image right
  final String imageCard;       // small card image
  final bool isNew;
  final int? salePercent;       // -20 means -20%

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
}
