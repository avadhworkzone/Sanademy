import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';

void logoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: 50.w,
        ),
        content: CustomText(
            textAlign: TextAlign.center,
            AppStrings.logOutTxt,
            fontWeight: FontWeight.w600),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
              children: [
                Expanded(
                  child: CustomBtn(
                    borderColor: AppColors.primaryColor,
                    bgColor: AppColors.white,
                    textColor: AppColors.primaryColor,
                    title: AppStrings.yes,
                    onTap: () async {
                      await logout();
                    },
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: CustomBtn(
                    height: 50.h,
                    onTap: () {
                      Get.back();
                    },
                    title: AppStrings.no,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
          )
        ],
      );
    },
  );
}

Future<void> logout() async {
  await SharedPreferenceUtils.clearPreference();
  Get.offAll(() => const SignUpScreen());
}
