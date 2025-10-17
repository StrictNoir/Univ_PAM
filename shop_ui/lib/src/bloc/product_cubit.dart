import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product.dart';
import '../repositories/product_repository.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState {
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <Product>[],
    this.errorMessage,
  });

  final ProductStatus status;
  final List<Product> products;
  final String? errorMessage;

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
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
      final products = await _repository.fetchProducts();
      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: products,
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
