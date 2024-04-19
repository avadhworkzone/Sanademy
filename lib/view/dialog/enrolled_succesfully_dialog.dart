import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';

void enrolledSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LocalAssets(
                imagePath: AppImageAssets.enrollSuccessfullyImg,
                height: 150.h,
                width: 150.w,
              ),
              CustomText(
                AppStrings.enrollSuccessfully,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black0E,
              ),
              SizeConfig.sH16,
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: AppStrings.enrollSuccessfullyTxt.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.black0E),
                      children: [
                        TextSpan(
                          text: AppStrings.fundamentalTxt.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AppColors.black0E),
                        )
                      ])),
            ],
          ),
        )
      ],
    ),
  );
}
