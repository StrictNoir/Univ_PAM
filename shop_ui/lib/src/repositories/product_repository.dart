import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../models/product.dart';

class ProductRepository {
  ProductRepository({
    AssetBundle? bundle,
    this.assetPath = 'assets/data/products.json',
    this.loadDelay = const Duration(milliseconds: 400),
  }) : bundle = bundle ?? rootBundle;

  final AssetBundle bundle;
  final String assetPath;
  final Duration loadDelay;

  Future<List<Product>> fetchProducts() async {
    // Simulate network delay to mimic API latency.
    if (loadDelay > Duration.zero) {
      await Future.delayed(loadDelay);
    }

    final rawJson = await bundle.loadString(assetPath);
    final decoded = json.decode(rawJson) as List<dynamic>;
    return decoded
        .cast<Map<String, dynamic>>()
        .map(Product.fromJson)
        .toList(growable: false);
  }
}