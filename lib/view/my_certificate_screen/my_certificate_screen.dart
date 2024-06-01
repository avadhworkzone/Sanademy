import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view/examScreen/exam_screen.dart';
import 'package:sanademy/view_model/bottom_bar_view_model.dart';

class MyCertificateScreen extends StatefulWidget {
  const MyCertificateScreen({super.key});

  @override
  State<MyCertificateScreen> createState() => _MyCertificateScreenState();
}

class _MyCertificateScreenState extends State<MyCertificateScreen> {
  BottomBarViewModel bottomBarViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomBarViewModel.selectedBottomIndex.value = 0;
        Get.offAll(() => const BottomBar());
        return Future.value(true);
      },
      child: SafeArea(
        child: Material(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: Column(
              children: [
                CustomText(
                  AppStrings.myCertificate,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black0E,
                ),
                SizeConfig.sH25,
                SizedBox(
                  child: CustomText(
                    AppStrings.certificateScreenTxt,
                    color: AppColors.black0E.withOpacity(0.8),
                  ),
                ),
                SizeConfig.sH30,
                CustomBtn(
                  onTap: () {
                    Get.to(() => const ExamScreen());
                  },
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  radius: 10.r,
                  title: AppStrings.getMoreCertificate,
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                ),
                SizeConfig.sH20,
                Expanded(
                  child: ListView.builder(
                    itemCount: myCertificateList.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: LinearGradient(colors: myCertificateList[index]['color']),
                          image: DecorationImage(
                              image: AssetImage(AppImageAssets.recommendedBgImg))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            myCertificateList[index]['titleTxt'],
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black0E,
                          ),
                          SizeConfig.sH8,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                myCertificateList[index]['lectures'],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black0E,
                              ),
                              SizeConfig.sW6,
                              CustomText(
                                "•",
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                                color: AppColors.black0E,
                              ),
                              SizeConfig.sW6,
                              CustomText(
                                myCertificateList[index]['time'],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black0E,
                              ),
                            ],
                          ),
                          SizeConfig.sH15,
                          Row(
                            children: [
                              Container(
                                width: 150.34.w,
                                height: 56.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.white),
                                child: Center(
                                    child: CustomText(
                                  AppStrings.downloadPDF,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: AppColors.black02,
                                )),
                              ),
                              SizeConfig.sW20,
                              Container(
                                width: 150.34.w,
                                height: 56.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.white),
                                child: Center(
                                    child: CustomText(
                                  AppStrings.requestHartCopy,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: AppColors.black02,
                                )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> myCertificateList = [
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '12 lectures',
      'time': '7 hours 40 minutes',
      'color': [
        Color(0xff9BEE42),
        Color(0xff9BEE42)
      ],
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '14 lectures',
      'time': '8 hours 30 minutes',
      'color':  [
        Color(0xffE9984E),
        Color(0xffDD6E07)
      ],
    },

  ];
}
