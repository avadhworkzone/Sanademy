import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            LocalAssets(
              imagePath: AppImageAssets.congratulationImage,
              height: Get.width / 1.5,
            ),
            // SizedBox(height: 10.h),
            CustomText(
              AppStrings.congratulations,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: AppColors.black0E,
            ),
            SizedBox(height: 8.h),
            CustomText(
              AppStrings.youHaveCompletedMathematicsMasteryTest,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.black0E,
            ),
            SizedBox(height: 18.h),

            ///container
            Container(
              height: 290.h,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.whiteShadeFD,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.greyEE),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15.h),
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
                          SizedBox(height: 10.h),
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
                          SizedBox(height: 10.h),
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
                  SizedBox(height: 15.h),

                  ///
                  CustomText(
                    AppStrings.yourAnswers,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.black0E,
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.green0B,
                              radius: 11,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            SizedBox(width: 9.w),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.green0B,
                              radius: 11,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            SizedBox(width: 9.w),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: CustomBtn(
                      onTap: () {},
                      height: 55.h,
                      textColor: AppColors.primaryColor,
                      title: AppStrings.viewSolution,
                      bgColor: AppColors.whiteShadeFD,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      borderColor: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),

            ///percentage
            SizedBox(height: 18.h),
            Container(
              // height: 290.h,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 20.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.whiteShadeFD,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.greyEE),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomText(
                        AppStrings.percentage,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.black0E,
                      ),
                      SizedBox(height: 10.h),
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
                      SizedBox(height: 10.h),
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
            SizedBox(height: 18.h),

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
    );
  }
}
