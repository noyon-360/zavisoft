import 'package:zavisoft_task/core/constants/api_constants.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/network_result.dart';
import '../models/product_model.dart';
import 'product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ApiClient _apiClient;
  ProductRepoImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<List<ProductModel>> getProducts({bool forceRefresh = false}) {
    return _apiClient.get(
      endpoint: ApiConstants.product.products,
      fromJsonT: (json) =>
          (json as List).map((e) => ProductModel.fromJson(e)).toList(),
    );
  }

  @override
  NetworkResult<List<ProductModel>> getProductsByCategory(
    String category, {
    bool forceRefresh = false,
  }) {
    return _apiClient.get(
      endpoint: "${ApiConstants.product.products}/category/$category",
      fromJsonT: (json) =>
          (json as List).map((e) => ProductModel.fromJson(e)).toList(),
    );
  }

  @override
  NetworkResult<List<String>> getCategories({bool forceRefresh = false}) {
    return _apiClient.get(
      endpoint: ApiConstants.product.categories,
      fromJsonT: (json) => (json as List).map((e) => e.toString()).toList(),
    );
  }
}
