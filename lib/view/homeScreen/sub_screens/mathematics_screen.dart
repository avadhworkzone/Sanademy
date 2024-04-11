import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/homeScreen/sub_screens/description_screen.dart';

class MathematicsScreen extends StatefulWidget {
  const MathematicsScreen({super.key});

  @override
  State<MathematicsScreen> createState() => _MathematicsScreenState();
}

class _MathematicsScreenState extends State<MathematicsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,),
        child: Column(
          children: [
            SizeConfig.sH40,
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      height: 56.h,
                      width: 56.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.white,
                      ),
                      child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 20.h,
                            color: AppColors.black0E,
                          )),
                    ),
                  ),
                ),
                SizeConfig.sW65,
                CustomText(
                  AppStrings.mathematics,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black0E,
                )
              ],
            ),
            SizeConfig.sH10,
            Expanded(
              child: ListView.builder(
                itemCount: _recommendedList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const DescriptionScreen());
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 234.6.h,
                          width: 390.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: _recommendedList[index]['color']),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 30.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  _recommendedList[index]['titleTxt'],
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black0E,
                                ),
                                SizeConfig.sH8,
                                CustomText(
                                  _recommendedList[index]['lectures'],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black0E,
                                ),
                                SizeConfig.sH4,
                                CustomText(
                                  _recommendedList[index]['time'],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black0E,
                                ),
                                SizeConfig.sH8,
                                Container(
                                    height: 50.h,
                                    width: 137.39.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.greenAccent,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 17.r,
                                          backgroundImage: const NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'),
                                        ),
                                        SizeConfig.sW10,
                                        Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 7.h),
                                          child: Column(
                                            children: [
                                              CustomText(
                                                'Instructor',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                color: AppColors.black0E,
                                              ),
                                              SizeConfig.sH3,
                                              CustomText(
                                                'John Doe',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp,
                                                color: AppColors.black0E,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.h,
                          right: 0.w,
                          child: LocalAssets(
                            imagePath: AppImageAssets.teacherImg,
                            width: 160.02.w,
                            height: 214.8.h,
                          ),
                        ),
                      ],

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
  final List<Map<String, dynamic>> _recommendedList = [
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
