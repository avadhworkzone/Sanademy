import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';

class MyProgressScreen extends StatefulWidget {
  const MyProgressScreen({super.key});

  @override
  State<MyProgressScreen> createState() => _MyProgressScreenState();
}

class _MyProgressScreenState extends State<MyProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: 63.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              AppStrings.myProgress,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black0E,
            ),
            SizedBox(height: 24.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                child: CustomText(
                  AppStrings.progressIntroductionTxt,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black0E,
                ),
              ),
            ),
            SizedBox(height: 24.h,),
            Container(
              width: 390.w,
              height: 162.01.h,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImageAssets.myProgressBgImg1)),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  CustomText(
                    AppStrings.progressIntroductionTxt,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
