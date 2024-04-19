import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';

void showErrorSnackBar(String title, String message) {
  Get.closeAllSnackbars();
  Get.showSnackbar(GetSnackBar(
    titleText: title.isNotEmpty
        ? CustomText(
            title,
            textAlign: TextAlign.center,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          )
        : null,
    messageText: CustomText(
      message,
      textAlign: TextAlign.center,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
    margin: EdgeInsets.symmetric(
      horizontal: 15.w,
      vertical: 30.h,
    ),
    borderRadius: 5,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.whiteShadeF8,
    duration: const Duration(seconds: 4),
  ));
}

void showSussesSnackBar(String title, String message) {
  Get.closeAllSnackbars();
  Get.showSnackbar(GetSnackBar(
    titleText: title.isNotEmpty
        ? CustomText(
            title,
            textAlign: TextAlign.center,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          )
        : null,
    messageText: CustomText(
      message,
      textAlign: TextAlign.center,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
    margin: EdgeInsets.symmetric(
      horizontal: 15.w,
      vertical: 30.h,
    ),
    borderRadius: 5,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.whiteShadeF8,
    duration: const Duration(seconds: 4),
  ));
}

void logs(String message) {
  if (kDebugMode) {
    log(message);
  }
}

unFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}
