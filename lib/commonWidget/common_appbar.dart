import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';

AppBar commonAppBar(
    {required String titleTxt,
    Widget? leadingWidget,
    Widget? actionWidget,
    double? leadingWidth,
    PreferredSizeWidget? bottom}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0.0,
    bottomOpacity: 0.0,
    scrolledUnderElevation: 0,
    leading: leadingWidget ?? const SizedBox(),
    leadingWidth: leadingWidth ?? 0.w,
    actions: [actionWidget ?? const SizedBox(), SizedBox(width: 8.w)],
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LocalAssets(
          imagePath: AppImageAssets.sanademaylogo,
          width: 33.52.w,
          height: 27.2.h,
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomText(
          titleTxt,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
      ],
    ),
    bottom: bottom == null
        ? null
        : PreferredSize(
            preferredSize: Size(Get.width, 20.h), child: SizedBox()),
  );
}

commonBackArrowAppBar({
  required String titleTxt,
  String? actionTitle,
  bool leadingWidget = true,
  bool actionWidget = true,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leadingWidget == true
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.black.withOpacity(0.10),
                          blurRadius: 20)
                    ],
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(17)),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.black0E,
                ),
              )
            : SizedBox(
                width: 50.w,
              ),
        CustomText(
          titleTxt,
          color: AppColors.black0E,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
        actionWidget == true
            ? CustomText(
                actionTitle ?? '',
                color: AppColors.color8B,
                fontWeight: FontWeight.w500,
              )
            : SizedBox(
                width: 50.w,
              )
      ],
    ),
  );
}
