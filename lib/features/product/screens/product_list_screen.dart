import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zavisoft_task/core/constants/app_colors.dart';
import '../../auth/screens/login_screen.dart';
import '../../../core/services/auth_storage_service.dart';
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
      backgroundColor: Colors.grey[50],
      drawer: _buildDrawer(context),
      body: Obx(() {
        if (_productController.isLoading &&
            _productController.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_productController.categories.isEmpty) {
          return const Center(child: Text("No Categories Found"));
        }

        final categories = _productController.categories.toList();

        return DefaultTabController(
          length: categories.length,
          child: SafeArea(
            bottom: false,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: Obx(() {
                        final user = _userController.user;
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryBlue
                                    .withOpacity(0.1),
                                child: Text(
                                  user?.name.firstname[0].toUpperCase() ?? "U",
                                  style: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello, ${user?.name.firstname.capitalizeFirst ?? 'User'}",
                                    style: const TextStyle(
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  const Text(
                                    "Welcome back!",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: SliverPersistentHeader(
                      pinned: true,
                      delegate: _PersistentHeaderDelegate(
                        height: 118,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 70,
                              color: Colors.grey[50], // Match screen background
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: "Search Products",
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 48,
                              color: Colors.white,
                              child: TabBar(
                                labelColor: AppColors.primaryBlue,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: AppColors.primaryBlue,
                                isScrollable: true,
                                tabs: categories
                                    .map((cat) => Tab(text: cat.toUpperCase()))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: categories.map((category) {
                  return ProductTab(category: category);
                }).toList(),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final authStorage = AuthStorageService();
    return Drawer(
      child: Column(
        children: [
          Obx(() {
            final user = _userController.user;
            return UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primaryBlue),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  user?.name.firstname[0].toUpperCase() ?? "U",
                  style: const TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              accountName: Text(
                "${user?.name.firstname.capitalizeFirst ?? ''} ${user?.name.lastname.capitalizeFirst ?? ''}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(user?.email ?? 'user@example.com'),
            );
          }),
          // const ListTile(
          //   leading: Icon(Icons.person_outline),
          //   title: Text("Profile"),
          // ),
          // const ListTile(
          //   leading: Icon(Icons.settings_outlined),
          //   title: Text("Settings"),
          // ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              await authStorage.clearAuthData();
              Get.offAll(() => const LoginScreen());
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
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

      return SafeArea(
        top: false,
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _productController.refreshAll,
          edgeOffset: 118, // Pinned header height (70+48)
          displacement: 40,
          child: Builder(
            builder: (context) {
              return CustomScrollView(
                key: PageStorageKey<String>(widget.category),
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Inject the overlap margin
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ProductCard(product: products[index]);
                      }, childCount: products.length),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}

class _PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _PersistentHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _PersistentHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
