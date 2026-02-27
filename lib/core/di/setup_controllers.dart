

import 'package:get/get_core/src/get_main.dart';
import 'package:zavisoft_task/core/utils/getx_helper.dart';

import '../../features/users/controllers/user_controller.dart';

Future<void> setupControllers() async {
  // Get.getOrPutLazy(() => ThemeController(), fenix: true);

  // Get.getOrPutLazy(() => HomeController(), fenix: true);
  Get.getOrPutLazy(() => UserController(), fenix: true);
}
