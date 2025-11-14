import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/feed.dart';
import '../../domain/repositories/product_repository.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState {
  const ProductState({
    this.status = ProductStatus.initial,
    this.feed,
    this.errorMessage,
  });

  final ProductStatus status;
  final FeedData? feed;
  final String? errorMessage;

  ProductState copyWith({
    ProductStatus? status,
    FeedData? feed,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._repository) : super(const ProductState());

  final ProductRepository _repository;

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final feed = await _repository.getFeed();
      emit(
        state.copyWith(
          status: ProductStatus.success,
          feed: feed,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ProductStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
