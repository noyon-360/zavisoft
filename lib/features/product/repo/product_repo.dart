import 'package:zavisoft_task/core/api/network_result.dart';

import '../models/product_model.dart';

abstract class ProductRepo {
  NetworkResult<List<ProductModel>> getProducts();

  NetworkResult<List<ProductModel>> getProductsByCategory(String category);

  NetworkResult<List<String>> getCategories();
}
