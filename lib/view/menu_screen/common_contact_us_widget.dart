import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/local_assets.dart';

class CommonContactUsWidget extends StatelessWidget {

  final String imagePath;
  final String? titleTxt;
  final String? subTitleTxt;
  const CommonContactUsWidget(
      {super.key, this.titleTxt, this.subTitleTxt, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.black.withOpacity(0.1))),
        child: ListTile(
          leading: LocalAssets(imagePath: imagePath),
          title: CustomText(
            titleTxt!,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black1D,
          ),
          subtitle: CustomText(
            subTitleTxt!,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black0E,
          ),
        ),
      ),
    );
  }
}
