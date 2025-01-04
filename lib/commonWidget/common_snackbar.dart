import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_colors.dart';

commonSnackBar(
    {required String title,
    required String subTitle,
    Color? backGroundColor,
    Color? textColor,
    int? sec}) {
  return Get.snackbar(
    title,
    subTitle,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backGroundColor ?? AppColors.primaryColor,
    colorText: textColor ?? AppColors.white,
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    duration: Duration(seconds: sec ?? 2),
  );
}
