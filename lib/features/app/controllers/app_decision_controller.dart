import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';
import 'package:zavisoft_task/features/product/screens/product_list_screen.dart';
import '../../../core/di/setup_controllers.dart';
import '../../auth/screens/login_screen.dart';
import '/core/services/auth_storage_service.dart';

class AppDecisionController extends GetxController {
  final AuthStorageService _authStorageService = AuthStorageService();

  Future<void> initialController() async {
    await setupControllers();
  }

  // Check User Is Login or Not
  Future<void> nextScreen() async {
    final bool isAuthenticated = await _authStorageService.isAuthenticated();

    if (isAuthenticated) {
      DPrint.log("User is authenticated");
      await initialController();
      Get.offAll(() => const ProductListScreen());
    } else {
      DPrint.log("User is not authenticated");
      Get.offAll(() => const LoginScreen());
    }
  }
}
