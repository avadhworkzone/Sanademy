
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/local_assets.dart';

AppBar commonAppBar(String titleTxt){

  return AppBar(
    backgroundColor: AppColors.primaryColor,
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
         LocalAssets(imagePath: AppImageAssets.sanademaylogo,width: 35.52.w,height: 28.2.h,),
        SizedBox(width: 10.w,),
        CustomText(
            titleTxt,
          color: AppColors.white,
          fontSize: 22.sp,
        ),
      ],
    ),
    bottom: PreferredSize(preferredSize: Size(Get.width, 20.h), child: SizedBox()),
  );
}
