import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/local_assets.dart';

AppBar commonAppBar(
    {required String titleTxt,
    Widget? leadingWidget,
    Widget? actionWidget,
    Widget? sizedBox,
    double? leadingWidth,
      Color? textColor,
      FontWeight? textFontWeight,
      Color? appBarBackgroundColor,

    PreferredSizeWidget? bottom}) {
  return AppBar(
    backgroundColor: appBarBackgroundColor??AppColors.primaryColor,
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
        sizedBox ??LocalAssets(
          imagePath: AppImageAssets.sanademaylogo,
          width: 33.52.w,
          height: 27.2.h,
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomText(
          titleTxt,
          color: textColor??AppColors.white,
          fontWeight: textFontWeight??FontWeight.w500,
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
