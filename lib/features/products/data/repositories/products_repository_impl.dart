import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../models/product_model.dart';

part 'products_repository_impl.g.dart';

class ProductsRepository {
  final Dio _dio;

  ProductsRepository(this._dio);

  Future<ProductResponse> getProducts({int limit = 20, int skip = 0, String? search}) async {
    try {
      final String endpoint = search != null && search.isNotEmpty 
          ? '/products/search' 
          : '/products';
          
      final Map<String, dynamic> queryParameters = {
        'limit': limit,
        'skip': skip,
      };
      
      if (search != null && search.isNotEmpty) {
        queryParameters['q'] = search;
      }

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      return ProductResponse.fromJson(response.data);
    } catch (e, st) {
      print('EXCEPTION IN GETPRODUCTS: $e');
      print(st);
      throw Exception('Failed to fetch products: $e');
    }
  }
}

@riverpod
ProductsRepository productsRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ProductsRepository(dio);
}
