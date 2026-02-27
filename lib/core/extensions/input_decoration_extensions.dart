import 'package:flutter/material.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

extension InputDecorationExtensions on BuildContext {
  Color get _suffixIconColor => AppColors.primaryGrayLight;
  InputDecoration get primaryInputDecoration => InputDecoration(
    filled: true,
    fillColor: Get.isDarkMode
        ? AppColors.inputBgColorDark
        : AppColors.inputBgColorLight,
    suffixIconColor: AppColors.primaryGrayLight,
    contentPadding: AppSizes.paddingMd.all,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: _suffixIconColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: _suffixIconColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: _suffixIconColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: AppColors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: AppColors.red, width: 1.5),
    ),
    hintStyle: TextStyle(
      color: AppColors.hintText,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelStyle: TextStyle(
      color: AppColors.hintText,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    errorStyle: TextStyle(
      color: AppColors.red,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}
