import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/homeScreen/sub_screens/course_description_screen.dart';
import 'package:sanademy/view/homeScreen/widget/home_screen_new.dart';
import 'package:sanademy/view/homeScreen/widget/simmer_effect_course.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';
import 'package:shimmer/shimmer.dart';

class HomeRecommendedWidget extends StatefulWidget {
  const HomeRecommendedWidget({super.key});

  @override
  State<HomeRecommendedWidget> createState() => _HomeRecommendedWidgetState();
}

class _HomeRecommendedWidgetState extends State<HomeRecommendedWidget> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("----------------${homeScreenViewModel.coursesResponseStatus.value}");
    return Obx(
      () {
        return homeScreenViewModel.coursesResponseStatus.value ==
                ResponseStatus.Completed
            ? Column(
                children: [
                  (homeScreenViewModel.courses.isNotEmpty)
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: homeScreenViewModel.courses.length,
                              itemBuilder: (context, index) {
                                final course =
                                    homeScreenViewModel.courses[index];
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 15.h, top: 10.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => CourseDescriptionScreen(
                                            homeCourse: course,
                                            courseId: (course.id ?? 0).toInt(),
                                            // Example ID for demonstration
                                            // courseId: "course_$index", // Example ID for demonstration
                                            // videoUrl: "https://codeyesinfotech.com/sana_academy/public/videos/49041718343861.mp4", // Add a placeholder for video URL
                                            videoUrl: course.videoUrl ?? "",
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.w,
                                                    vertical: 15.h),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(16.r),
                                                    bottom:
                                                        Radius.circular(16.r),
                                                  ),
                                                  child: NetWorkOcToAssets(
                                                    height: 185.h,
                                                    width: Get.width,
                                                    imgUrl: course.banner ?? '',
                                                    boxFit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0.h,
                                                left: 20.w,
                                                child: Container(
                                                  height: 32.h,
                                                  // width: 118.w,
                                                  padding: EdgeInsets.only(
                                                      left: 7.w, right: 2.w),
                                                  // padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 0.h),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 3),
                                                        blurRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child:
                                                            NetWorkOcToAssets(
                                                          height: 22.h,
                                                          width: 22.w,
                                                          // width: Get.width,
                                                          imgUrl: course.teacher
                                                                  ?.image ??
                                                              '',
                                                          boxFit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      // SizedBox(width: 1.w),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: CustomText(
                                                          course.teacher!.name
                                                              .toString(),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              AppColors.blue34,
                                                        ),
                                                      ),
                                                      // Html(
                                                      //   data:
                                                      //       course.instructor ??
                                                      //           '',
                                                      //   shrinkWrap: true,
                                                      //   style: {
                                                      //     "body": Style(
                                                      //       fontSize:
                                                      //           FontSize(12.sp),
                                                      //       fontWeight:
                                                      //           FontWeight.w600,
                                                      //       color: AppColors
                                                      //           .blue34,
                                                      //       fontFamily:
                                                      //           AppConstants
                                                      //               .metropolis,
                                                      //     ),
                                                      //   },
                                                      // ),
                                                      // CustomText(
                                                      //   course.instructor ?? '',
                                                      //   fontSize: 12.sp,
                                                      //   fontWeight: FontWeight.w600,
                                                      //   color: Colors.grey[700],
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0.h,
                                                right: 20.w,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w,
                                                      vertical: 4.h),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 3),
                                                        blurRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            (course.price ?? 0)
                                                                .toString(),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          CustomText(
                                                            ' IQD',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),

                                                      /// Discount Amount And Percent
                                                      // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment
                                                      //           .spaceBetween,
                                                      //   children: [
                                                      //     CustomText(
                                                      //       '123456 IQD',
                                                      //       fontSize: 12.sp,
                                                      //       decoration:
                                                      //           TextDecoration
                                                      //               .lineThrough,
                                                      //       color: AppColors
                                                      //           .grey74,
                                                      //     ),
                                                      //     SizedBox(width: 5.w),
                                                      //     CustomText(
                                                      //       '-40%',
                                                      //       fontSize: 12.sp,
                                                      //       color: AppColors
                                                      //           .borderColor,
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 6.h),
                                                CustomText(
                                                  course.title ?? '',
                                                  fontSize: 20.sp,
                                                  letterSpacing: -1.sp,
                                                  color: AppColors.blue34,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(height: 6.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.w,
                                                                  vertical:
                                                                      4.h),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .greyF7),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              LocalAssets(
                                                                imagePath:
                                                                    AppImageAssets
                                                                        .clock,
                                                                height: 14.h,
                                                                imgColor:
                                                                    AppColors
                                                                        .blue34,
                                                                width: 14.w,
                                                              ),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              RichText(
                                                                text: TextSpan(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: AppColors
                                                                        .grey74,
                                                                  ),
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          '${course.hours ?? 0}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: AppColors
                                                                            .blue34,
                                                                        fontFamily:
                                                                            AppConstants.metropolis,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          'h ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: AppColors
                                                                            .grey74,
                                                                        fontFamily:
                                                                            AppConstants.metropolis,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          '${course.minutes ?? 0}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: AppColors
                                                                            .blue34,
                                                                        fontFamily:
                                                                            AppConstants.metropolis,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: 'm',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: AppColors
                                                                            .grey74,
                                                                        fontFamily:
                                                                            AppConstants.metropolis,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 10.w),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.w,
                                                                  vertical:
                                                                      4.h),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .greyF7),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              LocalAssets(
                                                                imagePath:
                                                                    AppImageAssets
                                                                        .bookOutlined,
                                                                height: 14.h,
                                                                width: 14.w,
                                                                imgColor:
                                                                    AppColors
                                                                        .blue34,
                                                              ),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              RichText(
                                                                text: TextSpan(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: AppColors
                                                                        .grey74,
                                                                  ),
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          '${course.numberOfLecture ?? 0} ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: AppColors
                                                                            .blue34,
                                                                        fontFamily:
                                                                            AppConstants.metropolis,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: AppStrings
                                                                          .courseContentLectures
                                                                          .tr,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: AppColors
                                                                            .grey74,
                                                                        fontFamily:
                                                                            AppConstants.metropolis,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    LocalAssets(
                                                      imagePath: AppImageAssets
                                                          .playIcon,
                                                      height: 32.sp,
                                                      width: 32.sp,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 12.h),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            // ListView.builder(
                            //   padding: EdgeInsets.zero,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     itemCount: homeScreenViewModel.courses.length >= 5
                            //         ? 5
                            //         : homeScreenViewModel.courses.length,
                            //     itemBuilder: (context, index) {
                            //       final courses =
                            //           homeScreenViewModel.courses[index];
                            //       return Padding(
                            //         padding:
                            //             EdgeInsets.only(bottom: 15.h, top: 10.h),
                            //         child: GestureDetector(
                            //           onTap: () {
                            //             /* SharedPreferenceUtils.getIsLogin() == true
                            //                 ?*/
                            //             ///old
                            //             // Get.to(() => DescriptionScreen(
                            //             //       courseId: courses.id.toString(),
                            //             //       videoUrl: courses.videoUrl ?? '',
                            //             //     ));
                            //             /// new
                            //             Get.to(() => CourseDescriptionScreen(
                            //                   courseId: courses.id.toString(),
                            //                   videoUrl: courses.videoUrl ?? '',
                            //                 ));
                            //             // : Get.to(() => const SignUpScreen());
                            //           },
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius:
                            //                   BorderRadius.circular(16.r),
                            //               boxShadow: [
                            //                 BoxShadow(
                            //                   color: Colors.black
                            //                       .withOpacity(0.1),
                            //                   blurRadius: 8,
                            //                   offset: const Offset(0, 4),
                            //                 ),
                            //               ],
                            //             ),
                            //             child: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Stack(
                            //                   children: [
                            //                     Padding(
                            //                       padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                            //                       child: ClipRRect(
                            //                         borderRadius:
                            //                             BorderRadius.vertical(
                            //                           top: Radius.circular(16.r),
                            //                           bottom: Radius.circular(16.r),
                            //                         ),
                            //                         child: Image.network(
                            //                           courses.banner ?? '',
                            //                           height: 150.h,
                            //                           width: double.infinity,
                            //                           fit: BoxFit.cover,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       bottom: 0.h,
                            //                       left: 20.w,
                            //                       child: Container(
                            //                         padding: EdgeInsets.symmetric(
                            //                             horizontal: 8.w, vertical: 4.h),
                            //                         decoration: BoxDecoration(
                            //                           color: Colors.white,
                            //                           borderRadius:
                            //                           BorderRadius.circular(8),
                            //                           boxShadow: [
                            //                             BoxShadow(
                            //                               color: Colors.black.withOpacity(0.2), // Shadow color
                            //                               offset: const Offset(0, 4),
                            //                               blurRadius: 6,
                            //                               spreadRadius: 0,
                            //                             ),
                            //                           ],
                            //                         ),
                            //                         child:  Row(
                            //                           children: [
                            //                             CircleAvatar(
                            //                               backgroundImage:
                            //                               NetworkImage(courses
                            //                                   .teacher!
                            //                                   .image ??
                            //                                   ''),
                            //                               radius: 16.r,
                            //                             ),
                            //                             SizedBox(width: 8.w),
                            //                             CustomText(
                            //                               courses.teacher!
                            //                                   .name ??
                            //                                   '',
                            //                               fontSize: 12.sp,
                            //                               fontWeight: FontWeight.w600,
                            //                               color: Colors
                            //                                   .grey[700],
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       bottom: 3.h,
                            //                       right: 20.w,
                            //                       child: Container(
                            //                         padding: EdgeInsets.symmetric(
                            //                             horizontal: 8.w, vertical: 4.h),
                            //                         decoration: BoxDecoration(
                            //                           color: Colors.white,
                            //                           borderRadius:
                            //                           BorderRadius.circular(8),
                            //                           boxShadow: [
                            //                             BoxShadow(
                            //                               color: Colors.black.withOpacity(0.2), // Shadow color
                            //                               offset: const Offset(0, 4),
                            //                               blurRadius: 6,
                            //                               spreadRadius: 0,
                            //                             ),
                            //                           ],
                            //                         ),
                            //                         child:   Column(
                            //                           children: [
                            //                             Row(
                            //                               children: [
                            //                                 CustomText(
                            //                                   '123456',
                            //                                   fontSize: 14.sp,
                            //                                   fontWeight:
                            //                                   FontWeight
                            //                                       .w700,
                            //                                 ), CustomText(
                            //                                   ' IQD',
                            //                                   fontSize: 14.sp,
                            //                                   fontWeight:
                            //                                   FontWeight
                            //                                       .w500,
                            //                                   fontFamily: AppConstants.metropolis,
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                             Row(
                            //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                               children: [
                            //                                 CustomText(
                            //                                   '123456 IQD',
                            //                                   fontSize: 12.sp,
                            //                                   decoration:
                            //                                   TextDecoration
                            //                                       .lineThrough,
                            //                                   color: AppColors.grey74,
                            //                                   fontFamily: AppConstants.metropolis,
                            //                                 ),
                            //                                 SizedBox(width: 5.w),
                            //                                 CustomText(
                            //                                   '-40%',
                            //                                   fontSize: 12.sp,
                            //                                   color: AppColors.borderColor,
                            //                                   fontFamily: AppConstants.metropolis,
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 Padding(
                            //                   padding:   EdgeInsets.symmetric(horizontal: 12.w, ),
                            //                   child: Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                     children: [
                            //                       SizedBox(height: 6.h),
                            //                       CustomText(
                            //                         courses.title ?? '',
                            //                           fontSize: 20.sp,
                            //                         fontFamily: AppConstants.metropolis,
                            //                           fontWeight:
                            //                               FontWeight.w600,
                            //                       ),
                            //                       SizedBox(height: 4.h),
                            //                       SizedBox(height: 8.h),
                            //                       Row(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment
                            //                                 .spaceBetween,
                            //                         children: [
                            //                           Container(
                            //                             padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                            //                             decoration: BoxDecoration(
                            //
                            //                               borderRadius: BorderRadius.circular(15),
                            //                               border: Border.all(color: AppColors.grey74.withOpacity(0.1),)
                            //                             ),
                            //                             child: Row(
                            //                               children: [
                            //                                 Icon(Icons.watch_later_outlined, size: 18.sp,),
                            //                                 SizedBox(width: 5.w),
                            //                                 CustomText(
                            //                                   '${courses.hours ?? 0}h ${courses.minutes ?? 0}m',
                            //                                     fontSize: 12.sp,
                            //                                     color: Colors
                            //                                         .grey[600],
                            //                                   fontFamily: AppConstants.metropolis,
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                           ),
                            //                           Container(
                            //                             padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                            //                             decoration: BoxDecoration(
                            //
                            //                               borderRadius: BorderRadius.circular(15),
                            //                               border: Border.all(color: AppColors.grey74.withOpacity(0.1),)
                            //                             ),
                            //                             child: Row(
                            //                               children: [
                            //
                            //                                 LocalAssets(
                            //                                   imagePath: AppImageAssets.bookOutlined, height: 18.sp, width: 18.sp,
                            //                                 ),
                            //                                 SizedBox(width: 5.w),
                            //                                 CustomText(
                            //                                   '${courses.numberOfLecture ?? 0} Lectures',
                            //                                     fontSize: 12.sp,
                            //                                     color: Colors
                            //                                         .grey[600],
                            //                                   fontFamily: AppConstants.metropolis,
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                           ),
                            //                           LocalAssets(
                            //                             imagePath: AppImageAssets.playIcon, height: 32.sp, width: 32.sp,
                            //                           ),
                            //
                            //                         ],
                            //                       ),
                            //                       SizedBox(height: 20.h),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     }),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: CustomText(
                            AppStrings.noDataFound,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                  SizeConfig.sH30,
                ],
              )
            : ShimmerEffectWidget();
      },
    );
  }
}
