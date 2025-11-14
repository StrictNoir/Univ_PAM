import 'product.dart';

class FeedHeader {
  const FeedHeader({required this.title, required this.bannerImage});

  final String title;
  final String bannerImage;
}

class FeedSection {
  const FeedSection({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  final String title;
  final String subtitle;
  final List<Product> items;
}

class FeedData {
  const FeedData({required this.header, required this.sections});

  final FeedHeader header;
  final List<FeedSection> sections;
}
