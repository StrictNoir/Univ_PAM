import '../../domain/entities/feed.dart';
import '../../domain/entities/product_detail.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({ProductRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? ProductRemoteDataSource();

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<FeedData> getFeed() async {
    final dto = await _remoteDataSource.fetchFeed();
    return dto.toDomain();
  }

  @override
  Future<ProductDetailResponse> getProductDetail(String id) async {
    final dto = await _remoteDataSource.fetchProductDetail(id);
    return dto.toDomain();
  }
}
