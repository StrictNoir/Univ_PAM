class Product {
  const Product({
    required this.id,
    required this.brand,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.price,
    this.compareAtPrice,
    required this.rating,
    required this.ratingCount,
    required this.isNew,
    required this.images,
    required this.sizes,
  });

  final String id;
  final String brand;
  final String name;
  final String shortDescription;
  final String description;
  final double price;
  final double? compareAtPrice;
  final double rating;
  final int ratingCount;
  final bool isNew;
  final List<String> images;
  final List<String> sizes;

  bool get isOnSale =>
      compareAtPrice != null && (compareAtPrice ?? 0) > price;

  String get heroTag => '$id-${images.isNotEmpty ? images.first : 'image'}';
}

const _loremDescription =
    'Short dress in soft cotton jersey with decorative buttons down the front and a '
    'wide, frill-trimmed square neckline with concealed elastication. Elasticated '
    'seam under the bust and short puff sleeves with a small frill trim.';

final Product featuredProduct = Product(
  id: 'prd-featured',
  brand: 'H&M',
  name: 'Short Black Dress',
  shortDescription: 'Short black dress',
  description: _loremDescription,
  price: 19.99,
  compareAtPrice: 29.99,
  rating: 4.8,
  ratingCount: 321,
  isNew: false,
  images: const [
    'assets/images/product_1.png',
    'assets/images/product_2.png',
  ],
  sizes: const ['XS', 'S', 'M', 'L', 'XL'],
);

final List<Product> saleProducts = [
  featuredProduct,
  Product(
    id: 'prd-sale-2',
    brand: 'Zara',
    name: 'Relaxed Shirt',
    shortDescription: 'Cotton blend shirt',
    description: _loremDescription,
    price: 24.99,
    compareAtPrice: 39.99,
    rating: 4.3,
    ratingCount: 210,
    isNew: false,
    images: const [
      'assets/images/product_3.png',
      'assets/images/product_4.png',
    ],
    sizes: const ['S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'prd-sale-3',
    brand: 'Uniqlo',
    name: 'City Backpack',
    shortDescription: 'Minimal daily backpack',
    description: _loremDescription,
    price: 49.99,
    compareAtPrice: 69.99,
    rating: 4.6,
    ratingCount: 98,
    isNew: false,
    images: const [
      'assets/images/product_3.png',
      'assets/images/product_5.png',
    ],
    sizes: const ['One Size'],
  ),
  Product(
    id: 'prd-sale-4',
    brand: 'Adidas',
    name: 'Street Sneaker',
    shortDescription: 'Comfort knit upper',
    description: _loremDescription,
    price: 79.99,
    compareAtPrice: 109.99,
    rating: 4.4,
    ratingCount: 145,
    isNew: false,
    images: const [
      'assets/images/product_4.png',
      'assets/images/product_6.png',
    ],
    sizes: const ['7', '8', '9', '10', '11'],
  ),
  Product(
    id: 'prd-sale-5',
    brand: 'Mango',
    name: 'Wide Brim Hat',
    shortDescription: 'Straw summer hat',
    description: _loremDescription,
    price: 14.99,
    compareAtPrice: 24.99,
    rating: 4.1,
    ratingCount: 54,
    isNew: false,
    images: const [
      'assets/images/product_5.png',
      'assets/images/product_1.png',
    ],
    sizes: const ['One Size'],
  ),
  Product(
    id: 'prd-sale-6',
    brand: 'Levi’s',
    name: 'Vintage Jeans',
    shortDescription: 'Straight fit denim',
    description: _loremDescription,
    price: 59.99,
    compareAtPrice: 89.99,
    rating: 4.7,
    ratingCount: 412,
    isNew: false,
    images: const [
      'assets/images/product_6.png',
      'assets/images/product_7.png',
    ],
    sizes: const ['24', '26', '28', '30', '32'],
  ),
];

final List<Product> newProducts = [
  Product(
    id: 'prd-new-1',
    brand: 'H&M',
    name: 'Soft Knit Hoodie',
    shortDescription: 'Fleece lined hoodie',
    description: _loremDescription,
    price: 34.99,
    compareAtPrice: null,
    rating: 0,
    ratingCount: 0,
    isNew: true,
    images: const [
      'assets/images/product_8.png',
      'assets/images/product_2.png',
    ],
    sizes: const ['XS', 'S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'prd-new-2',
    brand: 'COS',
    name: 'Minimal Jacket',
    shortDescription: 'Structured cotton jacket',
    description: _loremDescription,
    price: 129.99,
    compareAtPrice: null,
    rating: 4.9,
    ratingCount: 52,
    isNew: true,
    images: const [
      'assets/images/product_9.png',
      'assets/images/product_3.png',
    ],
    sizes: const ['S', 'M', 'L'],
  ),
  Product(
    id: 'prd-new-3',
    brand: 'Bershka',
    name: 'Pleated Skirt',
    shortDescription: 'High waist midi skirt',
    description: _loremDescription,
    price: 44.99,
    compareAtPrice: null,
    rating: 4.5,
    ratingCount: 75,
    isNew: true,
    images: const [
      'assets/images/product_2.png',
      'assets/images/product_5.png',
    ],
    sizes: const ['XS', 'S', 'M', 'L'],
  ),
  Product(
    id: 'prd-new-4',
    brand: 'Massimo Dutti',
    name: 'Leather Tote',
    shortDescription: 'Italian leather tote',
    description: _loremDescription,
    price: 159.99,
    compareAtPrice: null,
    rating: 4.0,
    ratingCount: 18,
    isNew: true,
    images: const [
      'assets/images/product_3.png',
      'assets/images/product_1.png',
    ],
    sizes: const ['One Size'],
  ),
  Product(
    id: 'prd-new-5',
    brand: 'Pull&Bear',
    name: 'Relaxed Tee',
    shortDescription: 'Graphic cotton tee',
    description: _loremDescription,
    price: 19.99,
    compareAtPrice: null,
    rating: 3.8,
    ratingCount: 33,
    isNew: true,
    images: const [
      'assets/images/product_4.png',
      'assets/images/product_2.png',
    ],
    sizes: const ['S', 'M', 'L'],
  ),
  Product(
    id: 'prd-new-6',
    brand: 'Arket',
    name: 'Silk Scarf',
    shortDescription: 'Printed silk scarf',
    description: _loremDescription,
    price: 24.99,
    compareAtPrice: null,
    rating: 0,
    ratingCount: 0,
    isNew: true,
    images: const [
      'assets/images/product_9.png',
      'assets/images/product_6.png',
    ],
    sizes: const ['One Size'],
  ),
];

final List<Product> recommendedProducts = [
  ...saleProducts.take(3),
  ...newProducts.take(3),
];