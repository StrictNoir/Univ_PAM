import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/feed_dto.dart';
import '../models/product_detail_dto.dart';

class ProductRemoteDataSource {
  ProductRemoteDataSource({
    http.Client? client,
    this.feedUrl = 'https://test-api-jlbn.onrender.com/v3/feed',
    this.detailUrl = 'https://test-api-jlbn.onrender.com/v3/feed/details',
  }) : client = client ?? http.Client();

  final http.Client client;
  final String feedUrl;
  final String detailUrl;

  Future<FeedDto> fetchFeed() async {
    final jsonMap = await _loadJson(Uri.parse(feedUrl));
    return FeedDto.fromJson(jsonMap);
  }

  Future<ProductDetailResponseDto> fetchProductDetail(String id) async {
    final uri = _buildDetailUri(id);
    final jsonMap = await _loadJson(uri);
    return ProductDetailResponseDto.fromJson(jsonMap);
  }

  Uri _buildDetailUri(String id) {
    final base = Uri.parse(detailUrl);
    final query = Map<String, String>.from(base.queryParameters);
    if (id.isNotEmpty) {
      query['id'] = id;
    }
    return base.replace(queryParameters: query.isEmpty ? null : query);
  }

  Future<Map<String, dynamic>> _loadJson(Uri uri) async {
    final response = await client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
    final decoded = json.decode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    throw const FormatException('Unexpected response format');
  }
}
