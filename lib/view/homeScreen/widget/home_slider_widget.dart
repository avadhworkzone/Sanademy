import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

class HomeSliderWidget extends StatefulWidget {
  const HomeSliderWidget({super.key});

  @override
  State<HomeSliderWidget> createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100.w,
            margin: EdgeInsets.only(bottom: 80.h),
            color: AppColors.primaryColor,
          ),
          Positioned(
            bottom: 20,
            child: Stack(
              children: [
                SizedBox(
                  height: 150.w,
                  width: 380.w,
                  child: PageView.builder(
                    itemCount: homeScreenViewModel.bannerData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: NetWorkOcToAssets(
                              imgUrl: homeScreenViewModel.bannerData[index].image,
                              boxFit: BoxFit.cover,
                            )),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 15,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildIndicators(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < homeScreenViewModel.bannerData.length; i++) {
      indicators.add(buildIndicator(i == _currentIndex));
    }
    return indicators;
  }

  int _currentIndex = 0;

  Widget buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: isActive ? 20 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
///

// class MyCoursesWidget extends StatefulWidget {
//   const MyCoursesWidget({super.key});
//
//   @override
//   State<MyCoursesWidget> createState() => _MyCoursesWidgetState();
// }
//
// class _MyCoursesWidgetState extends State<MyCoursesWidget> {
//   final List<Map<String, dynamic>> courses = [
//     {
//       "title": "Exploring the Beauty of Mathematical Structures",
//       "completed": 6,
//       "total": 10,
//       "progress": 60,
//     },
//     {
//       "title": "Understanding Physics with Practical Applications",
//       "completed": 8,
//       "total": 10,
//       "progress": 80,
//     },
//     {
//       "title": "Basics of Computer Science for Beginners",
//       "completed": 4,
//       "total": 10,
//       "progress": 40,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizeConfig.sH5,
//           CustomText(AppStrings.myCourses,
//             color: AppColors.black,
//             fontWeight: FontWeight.w600,
//             fontSize: 16.sp,
//             fontFamily: AppConstants.metropolis,),
//           SizeConfig.sH10,
//           SizedBox(
//             height: 150.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: courses.length,
//               itemBuilder: (context, index) {
//                 final course = courses[index];
//                 return Container(
//                   width: 300.w,
//                   margin: EdgeInsets.only(right: 16.w),
//                   padding: EdgeInsets.all(16.w),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor,
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: CustomText(
//                               course["title"],
//                               color: AppColors.white,
//                               fontFamily: AppConstants.metropolis,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.sp,
//                               fontSize: 16.sp,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           LocalAssets(
//                             imagePath: AppImageAssets.playIcon, height: 46.sp, width: 46.sp,
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               LocalAssets(
//                                 imagePath: AppImageAssets.bookIcon, height: 16.sp, width: 16.sp,
//                               ),
//                               SizedBox(width: 8.w),
//                               CustomText(
//                                 "${course["completed"]}/${course["total"]}",
//                                 color: AppColors.white,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: AppConstants.metropolis,
//                                 fontSize: 14.sp,
//                               ),
//                             ],
//                           ),
//                           Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 38.w,
//                                 height: 38.w,
//                                 child: CircularProgressIndicator(
//                                   value: course["progress"] / 100,
//                                   color: AppColors.yellow,
//                                   backgroundColor: AppColors.white,
//                                   strokeWidth: 5.w,
//                                 ),
//                               ),
//                               CustomText(
//                                 "${course["progress"]}%",
//                                 color: AppColors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 10.sp,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 13.h),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Row(
//                               children: List.generate(10, (i) {
//                                 return Expanded(
//                                   child: Container(
//                                     margin: EdgeInsets.symmetric(horizontal: 3.w),
//                                     height: 4.5.h,
//                                     decoration: BoxDecoration(
//                                       color: i < course["completed"]
//                                           ? AppColors.yellow
//                                           : AppColors.white,
//                                       borderRadius: BorderRadius.circular(5)
//                                     ),
//
//                                   ),
//                                 );
//                               }),
//                             ),
//                           ),
//                           SizedBox(width: 8.w),
//
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


class MyCoursesWidget extends StatefulWidget {
  const MyCoursesWidget({Key? key}) : super(key: key);

  @override
  State<MyCoursesWidget> createState() => _MyCoursesWidgetState();
}

class _MyCoursesWidgetState extends State<MyCoursesWidget> {
  final List<Map<String, dynamic>> courses = [
    {
      "title": "Exploring the Beauty of Mathematical Structures",
      "completed": 0,
      "total": 10,
      "progress": 0,
    },
    {
      "title": "Understanding Physics with Practical Applications",
      "completed": 0,
      "total": 10,
      "progress": 0,
    },
    {
      "title": "Basics of Computer Science for Beginners",
      "completed": 0,
      "total": 10,
      "progress": 0,
    },
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoProgress();
  }

  void _startAutoProgress() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        for (var course in courses) {
          if (course["completed"] < course["total"]) {
            course["completed"] += 1;
            course["progress"] = (course["completed"] / course["total"] * 100).toInt();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizeConfig.sH5,
          CustomText(
            AppStrings.myCourses,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            fontFamily: AppConstants.metropolis,
          ),
          SizeConfig.sH10,
          SizedBox(
            height: 150.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Container(
                  width: 300.w,
                  margin: EdgeInsets.only(right: 16.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              course["title"],
                              color: AppColors.white,
                              fontFamily: AppConstants.metropolis,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.sp,
                              fontSize: 16.sp,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          LocalAssets(
                                imagePath: AppImageAssets.playIcon, height: 46.sp, width: 46.sp,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              LocalAssets(
                            imagePath: AppImageAssets.bookIcon, height: 14.sp, width: 14.sp,
                          ),
                              SizedBox(width: 8.w),
                              CustomText(
                                "${course["completed"]}/${course["total"]}",
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.metropolis,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 38.w,
                                height: 38.w,
                                child: CircularProgressIndicator(
                                  value: course["progress"] / 100,
                                  color: AppColors.yellow,
                                  backgroundColor: AppColors.white,
                                  strokeWidth: 5.w,
                                ),
                              ),
                              CustomText(
                                "${course["progress"]}%",
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: List.generate(10, (i) {
                                bool isActiveSegment = i == course["completed"];
                                return Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                                    height: 4.5.h,
                                    decoration: BoxDecoration(
                                      color: i < course["completed"]
                                          ? AppColors.yellow
                                          : AppColors.white,
                                      border: isActiveSegment
                                          ? Border.all(color: AppColors.yellow, width: 1.5.w)
                                          : null,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(width: 8.w),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
