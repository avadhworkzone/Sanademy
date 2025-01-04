import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view/homeScreen/sub_screens/course_description_screen.dart';
import 'package:sanademy/view/homeScreen/sub_screens/description_screen.dart';
import 'package:sanademy/view/homeScreen/widget/common_recommended_container_widget.dart';
import 'package:sanademy/view/view_all_screen/view_all_screen.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

// class HomeRecommendedWidget extends StatefulWidget {
//   const HomeRecommendedWidget({super.key});
//
//   @override
//   State<HomeRecommendedWidget> createState() => _HomeRecommendedWidgetState();
// }
//
// class _HomeRecommendedWidgetState extends State<HomeRecommendedWidget> {
//   HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return homeScreenViewModel.responseStatus.value ==
//               ResponseStatus.Completed
//           ? Column(
//               children: [
//                 // Padding(
//                 //   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //     children: [
//                 //       CustomText(
//                 //         AppStrings.recommended,
//                 //         fontWeight: FontWeight.w700,
//                 //         fontSize: 20.sp,
//                 //         color: AppColors.black0E,
//                 //       ),
//                 //       TextButton(
//                 //         onPressed: () {
//                 //           Get.to(const ViewAllScreen());
//                 //         },
//                 //         child: CustomText(
//                 //           AppStrings.viewAll,
//                 //           fontWeight: FontWeight.w600,
//                 //           fontSize: 13.sp,
//                 //           color: AppColors.color8B,
//                 //         ),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 (homeScreenViewModel.courses.isNotEmpty)
//                     ? SizedBox(
//                         height: (250 * homeScreenViewModel.courses.length).h,
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20.w),
//                           child: ListView.builder(
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: homeScreenViewModel.courses.length >= 5
//                                   ? 5
//                                   : homeScreenViewModel.courses.length,
//                               itemBuilder: (context, index) {
//                                 final courses =
//                                     homeScreenViewModel.courses[index];
//                                 final List<Color> colors = courses.colorCode!
//                                     .split(',')
//                                     .map((color) =>
//                                         Color(int.parse(color, radix: 16))
//                                             .withOpacity(1.0))
//                                     .toList();
//                                 return Padding(
//                                   padding:
//                                       EdgeInsets.only(bottom: 15.h, top: 10.h),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                      /* SharedPreferenceUtils.getIsLogin() == true
//                                           ?*/ Get.to(() => DescriptionScreen(
//                                         courseId: courses.id.toString(),
//                                         videoUrl: courses.videoUrl ?? '',
//                                       ));
//                                           // : Get.to(() => const SignUpScreen());
//
//                                     },
//                                     child: CommonContainerWidget(
//                                       color: colors,
//                                       title: courses.title ?? '',
//                                       numberOfLecture: courses.numberOfLecture ?? '',
//                                       minutes: (courses.minutes == null)?0:int.parse(courses.minutes.toString()),
//                                       teacherName: courses.teacher!.name ?? '',
//                                       teacherImage: courses.teacher!.image ?? '',
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                       )
//                     : Padding(
//                         padding: EdgeInsets.only(top: 40.h),
//                         child: CustomText(
//                           AppStrings.noDataFound,
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.black0E,
//                         ),
//                       )
//               ],
//             )
//           : const Material();
//     });
//   }
// }

class HomeRecommendedWidget extends StatefulWidget {
  const HomeRecommendedWidget({super.key});

  @override
  State<HomeRecommendedWidget> createState() => _HomeRecommendedWidgetState();
}

class _HomeRecommendedWidgetState extends State<HomeRecommendedWidget> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeScreenViewModel.responseStatus.value ==
              ResponseStatus.Completed
          ? Column(
              children: [
                (homeScreenViewModel.courses.isNotEmpty)
                    ? SizedBox(
                        height: (300 * homeScreenViewModel.courses.length).h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: homeScreenViewModel.courses.length >= 5
                                  ? 5
                                  : homeScreenViewModel.courses.length,
                              itemBuilder: (context, index) {
                                final courses =
                                    homeScreenViewModel.courses[index];
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 15.h, top: 10.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      /* SharedPreferenceUtils.getIsLogin() == true
                                          ?*/
                                      ///old
                                      // Get.to(() => DescriptionScreen(
                                      //       courseId: courses.id.toString(),
                                      //       videoUrl: courses.videoUrl ?? '',
                                      //     ));
                                      /// new
                                      Get.to(() => CourseDescriptionScreen(
                                            courseId: courses.id.toString(),
                                            videoUrl: courses.videoUrl ?? '',
                                          ));
                                      // : Get.to(() => const SignUpScreen());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.1),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(16.r),
                                                    bottom: Radius.circular(16.r),
                                                  ),
                                                  child: Image.network(
                                                    courses.banner ?? '',
                                                    height: 150.h,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0.h,
                                                left: 20.w,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w, vertical: 4.h),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.2), // Shadow color
                                                        offset: const Offset(0, 4),
                                                        blurRadius: 6,
                                                        spreadRadius: 0,
                                                      ),
                                                    ],
                                                  ),
                                                  child:  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                        NetworkImage(courses
                                                            .teacher!
                                                            .image ??
                                                            ''),
                                                        radius: 16.r,
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      CustomText(
                                                        courses.teacher!
                                                            .name ??
                                                            '',
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: AppConstants.metropolis,
                                                        color: Colors
                                                            .grey[700],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 3.h,
                                                right: 20.w,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w, vertical: 4.h),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.2), // Shadow color
                                                        offset: const Offset(0, 4),
                                                        blurRadius: 6,
                                                        spreadRadius: 0,
                                                      ),
                                                    ],
                                                  ),
                                                  child:   Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            '123456',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            fontFamily: AppConstants.metropolis,
                                                          ), CustomText(
                                                            ' IQD',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            fontFamily: AppConstants.metropolis,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            '123456 IQD',
                                                            fontSize: 12.sp,
                                                            decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                            color: AppColors.grey74,
                                                            fontFamily: AppConstants.metropolis,
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          CustomText(
                                                            '-40%',
                                                            fontSize: 12.sp,
                                                            color: AppColors.borderColor,
                                                            fontFamily: AppConstants.metropolis,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:   EdgeInsets.symmetric(horizontal: 12.w, ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 6.h),
                                                CustomText(
                                                  courses.title ?? '',
                                                    fontSize: 20.sp,
                                                  fontFamily: AppConstants.metropolis,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                ),
                                                SizedBox(height: 4.h),
                                                SizedBox(height: 8.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                                      decoration: BoxDecoration(

                                                        borderRadius: BorderRadius.circular(15),
                                                        border: Border.all(color: AppColors.grey74.withOpacity(0.1),)
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.watch_later_outlined, size: 18.sp,),
                                                          SizedBox(width: 5.w),
                                                          CustomText(
                                                            '${courses.hours ?? 0}h ${courses.minutes ?? 0}m',
                                                              fontSize: 12.sp,
                                                              color: Colors
                                                                  .grey[600],
                                                            fontFamily: AppConstants.metropolis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                                      decoration: BoxDecoration(

                                                        borderRadius: BorderRadius.circular(15),
                                                        border: Border.all(color: AppColors.grey74.withOpacity(0.1),)
                                                      ),
                                                      child: Row(
                                                        children: [

                                                          LocalAssets(
                                                            imagePath: AppImageAssets.bookOutlined, height: 18.sp, width: 18.sp,
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          CustomText(
                                                            '${courses.numberOfLecture ?? 0} Lectures',
                                                              fontSize: 12.sp,
                                                              color: Colors
                                                                  .grey[600],
                                                            fontFamily: AppConstants.metropolis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    LocalAssets(
                                                      imagePath: AppImageAssets.playIcon, height: 32.sp, width: 32.sp,
                                                    ),

                                                  ],
                                                ),
                                                SizedBox(height: 20.h),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: CustomText(
                          'No Data Found',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          fontFamily: AppConstants.metropolis,
                        ),
                      ),
                SizeConfig.sH30,
              ],
            )
          : const CircularProgressIndicator();
    });
  }
}
