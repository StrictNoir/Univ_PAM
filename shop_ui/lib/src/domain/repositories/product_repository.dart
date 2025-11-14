import '../entities/feed.dart';
import '../entities/product_detail.dart';

abstract class ProductRepository {
  Future<FeedData> getFeed();

  Future<ProductDetailResponse> getProductDetail(String id);
}
