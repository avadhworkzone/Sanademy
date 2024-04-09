
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';

class Utils {
  static void warningMessage(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Warning!",
        message, /* backgroundColor: ThemeColors.colorWarningMessage, colorText: Colors.black*/
      );
    }
  }

  static void warningMessageWithTitle({String? title, String? message}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title ?? "Warning!",
        message!,
      );
    }
  }

  static void handleNetworkError(message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Error",
        message,
      );
    }
  }

  ///showSnackBar
  static void validationCheck({String? message, bool isError = false, Color? barColor, Color? iconColor, Color? textColor}) {
    Get.closeAllSnackbars();
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 3000),
        backgroundColor: AppColors.whiteShadeF8,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        margin: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 30.h,
        ),
        messageText: Row(
          children: [
            // Icon(
            //   isError ? Icons.error_rounded : Icons.check_circle_rounded,
            //   color: iconColor ?? AppColors.white,
            // ),
            // SizedBox(width: 3.w),
            Expanded(
              child: CustomText(
                message ?? 'Empty message',
                fontSize: 12.sp,
                textAlign: TextAlign.center,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }
  }
}
