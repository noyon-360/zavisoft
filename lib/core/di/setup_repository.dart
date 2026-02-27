import 'package:get/get.dart';
import 'package:zavisoft_task/features/auth/repo/login_repo.dart';
import 'package:zavisoft_task/features/auth/repo/login_repo_impl.dart';

import '../../features/product/repo/product_repo.dart';
import '../../features/product/repo/product_repo_impl.dart';
import '../../features/users/repo/user_repo.dart';
import '../../features/users/repo/user_repo_impl.dart';

Future<void> setupRepository() async {
  Get.lazyPut<LoginRepo>(() => LoginRepoImpl(apiClient: Get.find()));

  Get.lazyPut<UserRepo>(() => UserRepoImpl(apiClient: Get.find()));

  Get.lazyPut<ProductRepo>(() => ProductRepoImpl(apiClient: Get.find()));
}
