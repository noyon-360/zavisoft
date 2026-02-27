import 'package:flutter/material.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';

import '../../../core/services/auth_storage_service.dart';
import '../../product/screens/product_list_screen.dart';
import '../models/login_request_model.dart';
import '../repo/login_repo.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(text: "mor_2314");
  final passwordController = TextEditingController(text: "83r5^_");
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final loginErrorMessage = "".obs;
  final obscurePassword = true.obs;

  final _loginRepo = Get.find<LoginRepo>();

  final AuthStorageService authStorageService = AuthStorageService();

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      loginErrorMessage.value = "";

      DPrint.log(
        "Login data : ${usernameController.text} ${passwordController.text}",
      );

      final result = await _loginRepo.login(
        LoginRequestModel(
          username: usernameController.text,
          password: passwordController.text,
        ),
      );

      result.fold(
        (fail) {
          loginErrorMessage.value = fail.message;
        },
        (success) {
          DPrint.log("Login success : ${success.data.token}");

          if (success.data.token != null) {
            authStorageService.storeAccessToken(
              // accessToken: "Bearer ${success.data.token!}",
              accessToken: success.data.token!,
            );
            Get.offAll(() => ProductListScreen());
          }
        },
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
