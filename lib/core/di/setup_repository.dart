import 'package:get/get.dart';
import 'package:zavisoft_task/features/auth/repo/login_repo.dart';
import 'package:zavisoft_task/features/auth/repo/login_repo_impl.dart';

import '../utils/getx_helper.dart';

Future<void> setupRepository() async {
  Get.lazyPut<LoginRepo>(
    () => LoginRepoImpl(apiClient: Get.find()),
  );
}
