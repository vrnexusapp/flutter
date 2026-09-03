import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/products_repository_impl.dart';

part 'products_provider.g.dart';

class ProductsState {
  final List<Product> products;
  final bool hasMore;
  final int skip;
  final String searchQuery;
  final bool isLoadingMore;

  ProductsState({
    this.products = const [],
    this.hasMore = true,
    this.skip = 0,
    this.searchQuery = '',
    this.isLoadingMore = false,
  });

  ProductsState copyWith({
    List<Product>? products,
    bool? hasMore,
    int? skip,
    String? searchQuery,
    bool? isLoadingMore,
  }) {
    return ProductsState(
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
      skip: skip ?? this.skip,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  static const int _limit = 20;

  @override
  FutureOr<ProductsState> build() async {
    return _fetchProducts(skip: 0, searchQuery: '');
  }

  Future<ProductsState> _fetchProducts({
    required int skip,
    required String searchQuery,
  }) async {
    final repository = ref.read(productsRepositoryProvider);
    final response = await repository.getProducts(
      limit: _limit,
      skip: skip,
      search: searchQuery,
    );

    return ProductsState(
      products: response.products,
      hasMore: response.skip + response.limit < response.total,
      skip: skip,
      searchQuery: searchQuery,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.hasError) return;
    final currentState = state.value;
    if (currentState == null ||
        !currentState.hasMore ||
        currentState.isLoadingMore)
      return;

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));
    try {
      final repository = ref.read(productsRepositoryProvider);
      final newSkip = currentState.skip + _limit;
      final response = await repository.getProducts(
        limit: _limit,
        skip: newSkip,
        search: currentState.searchQuery,
      );

      state = AsyncValue.data(
        currentState.copyWith(
          products: [...currentState.products, ...response.products],
          skip: newSkip,
          hasMore: response.skip + response.limit < response.total,
          isLoadingMore: false,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    try {
      final newState = await _fetchProducts(skip: 0, searchQuery: query);
      state = AsyncValue.data(newState);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    // We don't set state to AsyncValue.loading() here because RefreshIndicator already shows a spinner
    try {
      final currentState = state.value;
      final query = currentState?.searchQuery ?? '';
      final newState = await _fetchProducts(skip: 0, searchQuery: query);
      state = AsyncValue.data(newState);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
