import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';

AppBar commonAppBar(
    {String? titleTxt,
    Widget? leadingWidget,
    Widget? actionWidget,
    Widget? titleWidget,
    Widget? sizedBox,
    bool? centerTitle,
    double? leadingWidth,
    Color? textColor,
    FontWeight? textFontWeight,
    Color? appBarBackgroundColor,
    PreferredSizeWidget? bottom}) {
  return AppBar(
    backgroundColor: appBarBackgroundColor ?? AppColors.primaryColor,
    automaticallyImplyLeading: false,
    centerTitle: centerTitle ?? true,
    elevation: 0.0,
    bottomOpacity: 0.0,
    scrolledUnderElevation: 0,
    leading: leadingWidget ?? const SizedBox(),
    leadingWidth: leadingWidth ?? 0.w,
    actions: [actionWidget ?? const SizedBox(), SizedBox(width: 8.w)],
    title: titleWidget ??
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            sizedBox ??
                LocalAssets(
                  imagePath: AppImageAssets.sanademaylogo,
                  width: 33.52.w,
                  height: 27.2.h,
                ),
            SizedBox(
              width: 10.w,
            ),
            CustomText(
              titleTxt!.tr,
              color: textColor ?? AppColors.white,
              fontWeight: textFontWeight ?? FontWeight.w500,
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
  Color? actionWidgetColor,
  Color? titleWidgetColor,
  double? horizontalPadding,
  double? verticalPadding,
  FontWeight? actionWidgetFontWeight,
  double? actionFontSize,
  void Function()? actionTextOnTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 20.w,
        vertical: verticalPadding ?? 20.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leadingWidget == true
            ? InkWell(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Get.back();
                },
                borderRadius: BorderRadius.circular(17.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
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
                ),
              )
            : SizedBox(
                width: 50.w,
              ),
        CustomText(
          titleTxt.tr,
          color: titleWidgetColor ?? AppColors.black0E,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
        actionWidget == true
            ? GestureDetector(
                onTap: actionTextOnTap,
                child: CustomText(
                  actionTitle?.tr ?? '',
                  color: actionWidgetColor ?? AppColors.color8B,
                  fontWeight: actionWidgetFontWeight ?? FontWeight.w500,
                  fontSize: actionFontSize,
                ),
              )
            : SizedBox(
                width: 50.w,
              )
      ],
    ),
  );
}
