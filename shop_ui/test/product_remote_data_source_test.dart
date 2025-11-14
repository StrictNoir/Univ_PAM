import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:shop_ui/src/data/datasources/product_remote_data_source.dart';

void main() {
  group('ProductRemoteDataSource', () {
    test('parses feed images from API payload', () async {
      const feedResponse = {
        "header": {
          "title": "Street clothes",
          "bannerImage":
              "https://img.pikbest.com/templates/20240715/urban-street-wear-apparel-banner-template-_10669353.jpg!w700wp"
        },
        "sections": [
          {
            "title": "Sale",
            "subtitle": "Super summer sale",
            "items": [
              {
                "id": 1,
                "brand": "Dorothy Perkins",
                "name": "Evening Dress",
                "image": "https://www.thedressoutlet.com/cdn/shop/files/43172_1.jpg?v=1731945128",
                "oldPrice": 15,
                "newPrice": 12,
                "discount": 20,
                "rating": 4.8,
                "reviews": 10,
                "isFavorite": false
              },
              {
                "id": 2,
                "brand": "Sitlly",
                "name": "Sport Dress",
                "images": [
                  "https://www.inheritco.com/cdn/shop/files/simona-midi-sport-dress-ff-dresses-gray-xs-32144532176983.jpg?v=1747492540&width=2343"
                ],
                "oldPrice": 22,
                "newPrice": 19,
                "discount": 15,
                "rating": 4.7,
                "reviews": 10,
                "isFavorite": true
              }
            ]
          }
        ]
      };

      final client = MockClient((request) async {
        expect(request.url.toString(), 'https://example.com/feed');
        return http.Response(jsonEncode(feedResponse), 200);
      });

      final dataSource = ProductRemoteDataSource(
        client: client,
        feedUrl: 'https://example.com/feed',
        detailUrl: 'https://example.com/details',
      );

      final dto = await dataSource.fetchFeed();
      final feed = dto.toDomain();

      expect(feed.header.bannerImage, feedResponse['header']!['bannerImage']);
      expect(feed.sections, isNotEmpty);
      expect(feed.sections.first.items.first.image.isNotEmpty, isTrue);
      expect(feed.sections.first.items[1].image,
          feedResponse['sections']![0]['items']![1]['images']![0]);
    });

    test('parses detail gallery and related product images', () async {
      const detailResponse = {
        "product": {
          "id": "hm_short_dress_black_01",
          "title": "Short dress",
          "brand": "H&M",
          "description":
              "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed neckline.",
          "price": 19.99,
          "currency": "USD",
          "rating": 4.8,
          "reviewsCount": 10,
          "images": [
            "https://www2.hm.com/content/dam/hm2/products/12/82/38/3002/1282383002_1_1_1.jpg"
          ],
          "colors": [
            {
              "name": "Black",
              "hex": "#000000",
              "images": [
                "https://lp2.hm.com/hmgoepprod?set=source[/1a/b5/1ab5ac8a546a0b3b9df2ce3c1e8dcf1f2431f3d3.jpg],origin[dam],category[ladies_dresses_shortdresses],type[LOOKBOOKIMAGE],res[m],hmver[1]&call=url[file:/product/main]",
                "https://lp2.hm.com/hmgoepprod?set=source[/62/94/6294a3e383e47633d6fa3a07fbd2dc98ddfda3b1.jpg],origin[dam],category[ladies_dresses_shortdresses],type[LOOKBOOKIMAGE],res[m],hmver[1]&call=url[file:/product/main]"
              ]
            },
            {
              "name": "Beige",
              "hex": "#F5F5DC",
              "images": [
                "https://www2.hm.com/content/dam/hm2/products/12/53/50/01/1253505001_1_1_1.jpg"
              ]
            }
          ],
          "sizes": ["XS", "S", "M", "L", "XL"],
          "shippingInfo": {
            "delivery": "Standard delivery in 2-5 business days.",
            "returns": "Free returns within 30 days."
          },
          "support": {
            "contactEmail": "support@hm.com",
            "faqUrl": "https://www2.hm.com/en_us/customer-service.html"
          },
          "actions": {"addToCart": true, "addToWishlist": true, "share": true}
        },
        "relatedProducts": [
          {
            "id": "evening_dress_01",
            "title": "Evening Dress",
            "brand": "Dorothy Perkins",
            "price": 12,
            "oldPrice": 15,
            "currency": "USD",
            "discount": "-20%",
            "rating": 4.7,
            "reviewsCount": 10,
            "image":
                "https://assets.asosservices.com/products/dorothy-perkins-lace-top-skater-mini-dress-in-pink/205629657-1-pink?$n_640w$&wid=634&fit=constrain"
          }
        ]
      };

      final client = MockClient((request) async {
        expect(request.url.toString(), startsWith('https://example.com/details'));
        return http.Response(jsonEncode(detailResponse), 200);
      });

      final dataSource = ProductRemoteDataSource(
        client: client,
        feedUrl: 'https://example.com/feed',
        detailUrl: 'https://example.com/details',
      );

      final dto = await dataSource.fetchProductDetail('hm_short_dress_black_01');
      final response = dto.toDomain();

      expect(response.detail.gallery.length, greaterThanOrEqualTo(3));
      expect(response.detail.gallery.first,
          detailResponse['product']!['images']!.first);
      expect(response.related.first.image,
          detailResponse['relatedProducts']![0]['image']);
    });
  });
}
