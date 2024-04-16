import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizeConfig.sH25,
              LocalAssets(
                imagePath: AppImageAssets.congratulationImage,
                // height: Get.width / 1.5,
              ),
              SizeConfig.sH25,
              // SizedBox(height: 10.h),
              CustomText(
                AppStrings.congratulations,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: AppColors.black0E,
              ),
              SizeConfig.sH6,
              CustomText(
                AppStrings.youHaveCompletedMathematicsMasteryTest,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.black0E,
              ),
              SizedBox(height: 18.h),

              ///container
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 8.2.w, vertical: 5.h),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteShadeFD,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.greyEE),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizeConfig.sH15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CustomText(
                              AppStrings.yourScore,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AppColors.black0E,
                            ),
                            SizeConfig.sH10,
                            CustomText(
                              '16/20',
                              fontWeight: FontWeight.w700,
                              fontSize: 32.sp,
                              color: AppColors.black0E,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomText(
                              AppStrings.yourTime,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AppColors.black0E,
                            ),
                            SizeConfig.sH10,
                            CustomText(
                              '10:00',
                              fontWeight: FontWeight.w700,
                              fontSize: 32.sp,
                              color: AppColors.black0E,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizeConfig.sH15,
                    CustomText(
                      AppStrings.yourAnswers,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.black0E,
                    ),
                    SizeConfig.sH8,
                    Wrap(
                      spacing: 9.w,
                      runSpacing: 10.w,
                      children: List.generate(
                          20,
                          (index) => const CircleAvatar(
                                backgroundColor: AppColors.green0B,
                                radius: 11,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              )),
                    ),
                    SizeConfig.sH20,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.2.w),
                      child: CustomBtn(
                        onTap: () {},
                        height: 55.h,
                        textColor: AppColors.primaryColor,
                        title: AppStrings.viewSolution,
                        bgColor: AppColors.whiteShadeFD,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        borderColor: AppColors.primaryColor,
                        radius: 10,
                      ),
                    ),
                    SizeConfig.sH25,
                  ],
                ),
              ),

              ///percentage
              SizeConfig.sH17,
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 20.h),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteShadeFD,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.greyEE),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CustomText(
                          AppStrings.percentage,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.black0E,
                        ),
                        SizeConfig.sH10,
                        CustomText(
                          '80%',
                          fontWeight: FontWeight.w700,
                          fontSize: 32.sp,
                          color: AppColors.black0E,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomText(
                          AppStrings.result,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.black0E,
                        ),
                        SizeConfig.sH10,
                        CustomText(
                          'Pass',
                          fontWeight: FontWeight.w700,
                          fontSize: 32.sp,
                          color: AppColors.green0B,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizeConfig.sH25,

              ///
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomBtn(
                  onTap: () {},
                  height: 55.h,
                  // textColor: AppColors.primaryColor,
                  title: AppStrings.continues,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  borderColor: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 28.h),
            ],
          ),
        ),
      ),
    );
  }
}
