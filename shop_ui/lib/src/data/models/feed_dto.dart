import '../../domain/entities/feed.dart';
import 'product_dto.dart';

class FeedHeaderDto {
  const FeedHeaderDto({required this.title, required this.bannerImage});

  final String title;
  final String bannerImage;

  factory FeedHeaderDto.fromJson(Map<String, dynamic> json) {
    return FeedHeaderDto(
      title: (json['title'] ?? '') as String,
      bannerImage: (json['bannerImage'] ?? '') as String,
    );
  }

  FeedHeader toDomain() {
    return FeedHeader(title: title, bannerImage: bannerImage);
  }
}

class FeedSectionDto {
  const FeedSectionDto({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  final String title;
  final String subtitle;
  final List<ProductDto> items;

  factory FeedSectionDto.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>? ?? [])
        .map((e) => ProductDto.fromFeedJson(e as Map<String, dynamic>))
        .toList();
    return FeedSectionDto(
      title: (json['title'] ?? '') as String,
      subtitle: (json['subtitle'] ?? '') as String,
      items: items,
    );
  }

  FeedSection toDomain() {
    return FeedSection(
      title: title,
      subtitle: subtitle,
      items: items.map((item) => item.toDomain()).toList(),
    );
  }
}

class FeedDto {
  const FeedDto({required this.header, required this.sections});

  final FeedHeaderDto header;
  final List<FeedSectionDto> sections;

  factory FeedDto.fromJson(Map<String, dynamic> json) {
    final sections = (json['sections'] as List<dynamic>? ?? [])
        .map((e) => FeedSectionDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return FeedDto(
      header: FeedHeaderDto.fromJson(json['header'] as Map<String, dynamic>),
      sections: sections,
    );
  }

  FeedData toDomain() {
    return FeedData(
      header: header.toDomain(),
      sections: sections.map((section) => section.toDomain()).toList(),
    );
  }
}
