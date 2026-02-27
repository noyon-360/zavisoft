import 'package:flutter/material.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';

import '../../users/controllers/user_controller.dart';
import '../controllers/product_controller.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _userController = Get.find<UserController>();
  final _productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    _productController.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            _userController.user?.name.fullName.capitalizeFirstOfEach ?? "",
          ),
        ),
      ),
      body: Obx(() {
        if (_productController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_productController.products?.isEmpty ?? true) {
          return const Center(child: Text("No Products"));
        }
        return ListView.builder(
          itemCount: _productController.products?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_productController.products![index].title),
            );
          },
        );
      }),
    );
  }
}
