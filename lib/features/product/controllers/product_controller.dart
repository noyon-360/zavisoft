import 'package:get/get.dart';

import '../models/product_model.dart';
import '../repo/product_repo.dart';

class ProductController extends GetxController {
  final _productRepo = Get.find<ProductRepo>();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxList<String> _categories = <String>[].obs;
  List<String> get categories => _categories;

  final RxMap<String, List<ProductModel>> _productsByCategory =
      <String, List<ProductModel>>{}.obs;
  Map<String, List<ProductModel>> get productsByCategory => _productsByCategory;

  final RxString _searchQuery = "".obs;
  String get searchQuery => _searchQuery.value;

  void updateSearchQuery(String query) {
    _searchQuery.value = query;
  }

  List<ProductModel> getFilteredProducts(String category) {
    final products = _productsByCategory[category];
    if (products == null) return [];
    if (_searchQuery.isEmpty) return products;
    return products
        .where(
          (p) =>
              p.title.toLowerCase().contains(_searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    refreshAll();
  }

  Future<void> refreshAll() async {
    print("Refresh started..."); // Debug
    _isLoading.value = true;
    await getCategories();
    if (_categories.isNotEmpty) {
      // Load all categories
      final futures = _categories.map((cat) => getProductsByCategory(cat));
      await Future.wait(futures);
    }
    _isLoading.value = false;
    print("Refresh complete!"); // Debug
  }

  Future<void> getCategories() async {
    final result = await _productRepo.getCategories();
    result.fold(
      (fail) => _categories.clear(),
      (success) => _categories.value = success.data,
    );
  }

  Future<void> getProductsByCategory(String category) async {
    final result = await _productRepo.getProductsByCategory(category);
    result.fold(
      (fail) => _productsByCategory.remove(category),
      (success) => _productsByCategory[category] = success.data,
    );
  }
}
