import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class MyCertificateScreen extends StatefulWidget {
  const MyCertificateScreen({super.key});

  @override
  State<MyCertificateScreen> createState() => _MyCertificateScreenState();
}

class _MyCertificateScreenState extends State<MyCertificateScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizeConfig.sH40,
            CustomBtn(
              onTap: () {},
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
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: Container(
                    height: 200.6.h,
                    width: 390.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: myCertificateList[index]['color']),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 20.w),
                      child: Column(
                        children: [
                          CustomText(
                            myCertificateList[index]['titleTxt'],
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black0E,
                          ),
                          SizeConfig.sH8,
                          Row(
                            children: [
                              CustomText(
                                myCertificateList[index]['lectures'],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black0E,
                              ),
                              SizeConfig.sW8,
                              CustomText(
                                "•",
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                                color: AppColors.black0E,
                              ),
                              SizeConfig.sW3,
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> myCertificateList = [
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '12 lectures',
      'time': '7 hours 40 minutes',
      'color': Colors.green,
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '14 lectures',
      'time': '8 hours 30 minutes',
      'color': Colors.orangeAccent.shade200,
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '12 lectures',
      'time': '7 hours 40 minutes',
      'color': Colors.blue.shade300,
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '14 lectures',
      'time': '8 hours 30 minutes',
      'color': Colors.pink.shade200,
    },
  ];
}
