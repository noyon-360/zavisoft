import 'package:get/get.dart';

import '../models/product_model.dart';
import '../repo/product_repo.dart';

class ProductController extends GetxController {
  final _productRepo = Get.find<ProductRepo>();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _forceRefresh = false.obs;
  bool get forceRefresh => _forceRefresh.value;

  final Rxn<List<ProductModel>> _products = Rxn<List<ProductModel>>();
  List<ProductModel>? get products => _products.value;

  Future<void> getProducts({bool forceRefresh = false}) async {
    _isLoading.value = true;
    final result = await _productRepo.getProducts();

    result.fold((fail) {}, (success) {
      _products.value = success.data;
    });

    _isLoading.value = false;
  }
}
