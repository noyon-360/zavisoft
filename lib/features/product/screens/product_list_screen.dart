import 'package:flutter/material.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';
import 'package:zavisoft_task/core/constants/app_colors.dart';
import 'package:zavisoft_task/core/extensions/input_decoration_extensions.dart';

import '../../../core/config/app_theme.dart';
import '../../users/controllers/user_controller.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _userController = Get.find<UserController>();
  final _productController = Get.put(ProductController());
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _productController.updateSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_productController.isLoading &&
            _productController.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_productController.categories.isEmpty) {
          return const Center(child: Text("No Categories Found"));
        }

        return DefaultTabController(
          length: _productController.categories.length,
          child: RefreshIndicator(
            onRefresh: _productController.refreshAll,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 200,
                          floating: false,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(
                              "Products",
                              style: const TextStyle(color: Colors.white),
                            ),
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  "https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=2070&auto=format&fit=crop",
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: _searchController,
                              decoration: context.primaryInputDecoration
                                  .copyWith(
                                    hintText: "Search products...",
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              // theme
                              dividerColor: AppColors.primaryGrayDark,
                              unselectedLabelColor: AppColors.primaryGrayDark,
                              labelColor: AppColors.primaryBlue,
                              indicatorColor: AppColors.primaryBlue,
                              indicatorWeight: 2,
                              isScrollable: true,
                              tabs: _productController.categories
                                  .map((cat) => Tab(text: cat.toUpperCase()))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: _productController.categories.map((category) {
                  return ProductTab(category: category);
                }).toList(),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ProductTab extends StatefulWidget {
  final String category;
  const ProductTab({super.key, required this.category});

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab>
    with AutomaticKeepAliveClientMixin {
  final _productController = Get.find<ProductController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      final products = _productController.getFilteredProducts(widget.category);

      if (_productController.isLoading && products.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (products.isEmpty) {
        return const Center(child: Text("No products found"));
      }

      return CustomScrollView(
        key: PageStorageKey<String>(widget.category),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ProductCard(product: products[index]);
            }, childCount: products.length),
          ),
        ],
      );
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.primaryWhite, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
