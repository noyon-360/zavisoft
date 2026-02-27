import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '/core/common/widgets/app_scaffold.dart';
import '/core/common/widgets/button_widgets.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';

import '/core/constants/app_colors.dart';
import '/core/extensions/input_decoration_extensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCtrl = Get.put(LoginController());

    return AppScaffold(
      body: Form(
        key: loginCtrl.loginFormKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Login To Your Account",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap.h12,
                          Obx(
                            () => loginCtrl.loginErrorMessage.value.isNotEmpty
                                ? Center(
                                    child: Text(
                                      loginCtrl.loginErrorMessage.value,
                                      style: const TextStyle(
                                        color: AppColors.red,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          Gap.h12,
                          TextFormField(
                            controller: loginCtrl.usernameController,
                            focusNode: loginCtrl.usernameFocus,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: context.primaryInputDecoration.copyWith(
                              hintText: "username",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "username is required";
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => FocusScope.of(
                              context,
                            ).requestFocus(loginCtrl.passwordFocus),
                            autofillHints: const [AutofillHints.username],
                          ),
                          Gap.h16,
                          Obx(
                            () => TextFormField(
                              controller: loginCtrl.passwordController,
                              focusNode: loginCtrl.passwordFocus,
                              obscureText: loginCtrl.obscurePassword.value,
                              textInputAction: TextInputAction.done,

                              decoration: context.primaryInputDecoration
                                  .copyWith(
                                    hintText: "Enter your Password",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        loginCtrl.obscurePassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Get.isDarkMode
                                            ? AppColors.primaryGrayDark
                                            : AppColors.primaryGrayLight,
                                      ),
                                      onPressed: () =>
                                          loginCtrl.toggleObscurePassword(),
                                    ),
                                  ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
                              autofillHints: const [AutofillHints.password],
                              onFieldSubmitted: (_) => loginCtrl.login(),
                            ),
                          ),

                          // Forget Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text("Forget Password"),
                              ),
                            ],
                          ),

                          PrimaryButton(
                            text: "Login t",
                            onApiPressed: () => loginCtrl.login(),
                          ),

                          // const Spacer(),

                          // GestureDetector(
                          //   onTap: () => Get.to(() => const SignupScreen()),
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //       bottom: 20.0,
                          //       top: 20.0,
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           "Don’t have an account? ",
                          //           style: TextStyle(),
                          //         ),
                          //         const Text(
                          //           'Sign Up',
                          //           style: TextStyle(
                          //             color: AppColors.primaryBlue,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
