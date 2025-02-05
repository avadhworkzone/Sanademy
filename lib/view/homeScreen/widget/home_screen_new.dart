import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/networks/model/get_course_progress_response_model.dart';
import 'package:sanademy/networks/model/new_api_models/get_home_screen_data_res_model.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/homeScreen/widget/home_category_widget.dart';
import 'package:sanademy/view/homeScreen/widget/home_recommend_widget.dart';
import 'package:sanademy/view/homeScreen/widget/home_slider_widget.dart';
import 'package:sanademy/view/menu_screen/menu_screen.dart';
import 'package:sanademy/view/notificationScreen/notification_screen_new.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/size_config_utils.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  HomeScreenViewModel homeScreenViewModel = Get.put(HomeScreenViewModel());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey();

  @override
  void initState() {
    homeApiCall();
    super.initState();
  }

  homeApiCall() async {
    // await homeScreenViewModel.homeViewModel(
    //     search: homeScreenViewModel.searchController.value.text);
    // await homeScreenViewModel.getHomeScreenData();
    // await homeScreenViewModel.getHomeScreenData();
    await homeScreenViewModel.getCoursesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const MenuScreen()),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonUpdateAppBar(
                paddingLeft: 15.w,
                context: context,
                isHomeScreen: true,
                isLogoRequired: true,
                actionWidget: Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*homeScreenViewModel.coursesResponseStatus.value ==
                                      ResponseStatus.Loading
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child:*/
                      LocalAssets(
                        imagePath: AppImageAssets.infoIcon,
                        height: 24.sp,
                        width: 24.sp,
                        /* ),*/
                      ),
                      /*    : LocalAssets(
                                      imagePath: AppImageAssets.infoIcon,
                                      height: 24.sp,
                                      width: 24.sp,
                                    ),*/
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const NotificationScreenNew());
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 8.w, right: 8.w),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                              // color: AppColors.white.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(30)),
                          child: LocalAssets(
                            imagePath: AppImageAssets.notificationNew,
                            height: 40.sp,
                            width: 40.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                homeScreenLeading: Padding(
                  padding: EdgeInsets.only(right: 40.w),
                  child: GestureDetector(
                    onTap: () {
                      // homeDrawerKey.currentState?.openDrawer();
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Container(
                      // margin: EdgeInsets.all(8.w),
                      // padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        // color: AppColors.white.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: LocalAssets(
                        imagePath: AppImageAssets.categoryIcon,
                        height: 40.sp,
                        width: 40.sp,
                      ),
                    ),
                  ),
                ),
                otherWidget: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizeConfig.sH15,
                    /// Check User Is Login Or Not
                    if (SharedPreferenceUtils.getIsLogin() == true)

                      /// If User Is Login Then Show This Text Other Wise Not Show
                      CustomText(
                        AppStrings.welcomeBack,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),

                    if (SharedPreferenceUtils.getIsLogin() == true)
                      CustomText(
                        // homeScreenViewModel.userData.value?.name ?? "",
                        '${AppStrings.hey.tr} ${homeScreenViewModel.userData.value?.name ?? ""} 💥',
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    SizeConfig.sH15,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: CustomText(
                        AppStrings.togetherWeLearn,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 32.sp,
                        letterSpacing: -1.sp,
                        height: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizeConfig.sH35,
                  ],
                ),
              ),
              SizeConfig.sH15,
              // Padding(
              //   padding:  EdgeInsets.symmetric(horizontal: 15.w),
              //   child: CustomText(AppStrings.myCourses,
              //     color: AppColors.black,
              //     fontWeight: FontWeight.w600,
              //     fontSize: 16.sp,
              // ),
              // SizeConfig.sH15,

              /// CAROUSAL SLIDER VIEW....
              MyCoursesWidget(),
              SizeConfig.sH20,
              // HomeSliderWidget(),
              //
              /// CATEGORIES VIEW
              // HomeCategoryWidget(),
              // SizeConfig.sH15,
              //
              /// RECOMMENDED
              const HomeRecommendedWidget(),
            ],
          ),
        ));
    /*  body: Obx(
            () => */ /*homeScreenViewModel.coursesResponseStatus.value ==
                  ResponseStatus.Completed
              ? _buildShimmerView(context)
              : homeScreenViewModel.coursesResponseStatus.value ==
                      ResponseStatus.Error
                  ?*/ /*

            */ /*  : homeScreenViewModel.coursesResponseStatus.value ==
                          ResponseStatus.Error
                      ? Center(
                          child: CustomText(
                            AppStrings.error,
                            fontSize: 20.sp,
                          ),
                        )
                      : const SizedBox(),*/ /*
            */ /*homeScreenViewModel.homeResponseStatus.value ==
                  ResponseStatus.Error
              ? CustomText(
                  AppStrings.error,
                  fontSize: 20.sp,
                )
              : homeScreenViewModel.homeResponseStatus.value ==
                      ResponseStatus.Completed
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonUpdateAppBar(
                            paddingLeft: 15.w,
                            context: context,
                            isHomeScreen: true,
                            isLogoRequired: true,
                            actionWidget: Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  homeScreenViewModel
                                              .homeResponseStatus.value ==
                                          ResponseStatus.Loading
                                      ? Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: LocalAssets(
                                            imagePath: AppImageAssets.infoIcon,
                                            height: 24.sp,
                                            width: 24.sp,
                                          ),
                                        )
                                      : LocalAssets(
                                          imagePath: AppImageAssets.infoIcon,
                                          height: 24.sp,
                                          width: 24.sp,
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => const NotificationScreenNew());
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 8.w, right: 8.w),
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                          // color: AppColors.white.withOpacity(0.20),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: LocalAssets(
                                        imagePath:
                                            AppImageAssets.notificationNew,
                                        height: 40.sp,
                                        width: 40.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            homeScreenLeading: Padding(
                              padding: EdgeInsets.only(right: 40.w),
                              child: GestureDetector(
                                onTap: () {
                                  // homeDrawerKey.currentState?.openDrawer();
                                  scaffoldKey.currentState?.openDrawer();
                                },
                                child: Container(
                                  // margin: EdgeInsets.all(8.w),
                                  // padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    // color: AppColors.white.withOpacity(0.20),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: LocalAssets(
                                    imagePath: AppImageAssets.categoryIcon,
                                    height: 40.sp,
                                    width: 40.sp,
                                  ),
                                ),
                              ),
                            ),
                            otherWidget: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizeConfig.sH15,
                                CustomText(
                                  AppStrings.welcomeBack,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                                CustomText(
                                  // homeScreenViewModel.userData.value?.name ?? "",
                                  '${AppStrings.hey.tr} ${homeScreenViewModel.userData.value?.name ?? ""} 💥',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                                SizeConfig.sH15,
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  child: CustomText(
                                    AppStrings.togetherWeLearn,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 32.sp,
                                    letterSpacing: -1.sp,
                                    height: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizeConfig.sH35,
                              ],
                            ),
                          ),
                          SizeConfig.sH15,
                          // Padding(
                          //   padding:  EdgeInsets.symmetric(horizontal: 15.w),
                          //   child: CustomText(AppStrings.myCourses,
                          //     color: AppColors.black,
                          //     fontWeight: FontWeight.w600,
                          //     fontSize: 16.sp,
                          // ),
                          // SizeConfig.sH15,

                          /// CAROUSAL SLIDER VIEW....
                          MyCoursesWidget(),
                          SizeConfig.sH20,
                          // HomeSliderWidget(),
                          //
                          /// CATEGORIES VIEW
                          HomeCategoryWidget(),
                          SizeConfig.sH15,
                          //
                          /// RECOMMENDED
                          const HomeRecommendedWidget(),
                        ],
                      ),
                    )
              :*/ /*

            ///
            // homeScreenViewModel.homeResponseStatus.value ==
            //     ResponseStatus.Completed ?_buildShimmerView(context): const SizedBox(),
            ));*/
  }
}

// Widget _buildShimmerView(BuildContext context) {
//   return SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Shimmer for App Bar
//         commonUpdateAppBar(
//           paddingLeft: 15.w,
//           context: context,
//           isHomeScreen: true,
//           isLogoRequired: true,
//           actionWidget: Padding(
//             padding: EdgeInsets.only(left: 15.w),
//             child: Row(
//               children: [
//                 _buildShimmerCircle(24.sp), // Placeholder for Info Icon
//                 SizedBox(width: 8.w),
//                 _buildShimmerCircle(40.sp), // Placeholder for Notification Icon
//               ],
//             ),
//           ),
//           homeScreenLeading: _buildShimmerCircle(40.sp), // Placeholder for Menu Icon
//           otherWidget: Column(
//             children: [
//               SizedBox(height: 20.h),
//               _buildShimmerLine(150.w, 12.sp), // Placeholder for Welcome Text
//               SizedBox(height: 10.h),
//               _buildShimmerLine(200.w, 14.sp), // Placeholder for User Name
//               SizedBox(height: 15.h),
//               _buildShimmerLine(250.w, 32.sp), // Placeholder for Main Title
//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//         SizeConfig.sH15,
//
//         /// Shimmer for My Courses Section
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildShimmerLine(100.w, 16.sp), // Placeholder for Section Title
//               SizeConfig.sH10,
//               SizedBox(
//                 height: 150.h,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 3, // Show 3 shimmer items
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 300.w,
//                       margin: EdgeInsets.only(right: 16.w),
//                       padding: EdgeInsets.all(16.w),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12.r),
//                         color: Colors.grey[300], // Placeholder color
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizeConfig.sH20,
//
//         /// Shimmer for Categories Section
//         SizedBox(
//           height: 49.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 5, // Show 5 shimmer items
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8.w),
//                 padding: EdgeInsets.symmetric(horizontal: 15.w),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30.sp),
//                   color: Colors.grey[300], // Placeholder color
//                 ),
//                 child: _buildShimmerLine(80.w, 14.sp), // Placeholder for Category Name
//               );
//             },
//           ),
//         ),
//         SizeConfig.sH20,
//
//         ///RECOMMENDED
//         buildShimmerEffect(),
//       ],
//     ),
//   );
// }
//
// /// Helper Methods for Shimmer Placeholders
Widget buildShimmerCircle(double size) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
    ),
  );
}

Widget buildShimmerLine(double width, double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: width,
      height: height,
      color: Colors.grey[300],
    ),
  );
}

Widget buildShimmerEffect() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      // Placeholder count
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h, top: 10.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 220.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildShimmerView(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// App Bar Shimmer
          commonUpdateAppBar(
            paddingLeft: 15.w,
            context: context,
            isHomeScreen: true,
            isLoading: true,
            isLogoRequired: true,
            actionWidget: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Row(
                children: [
                  buildShimmerCircle(24.sp),
                  // Placeholder for Info Icon
                  SizedBox(width: 8.w),
                  buildShimmerCircle(40.sp),
                  // Placeholder for Notification Icon
                ],
              ),
            ),
            homeScreenLeading: buildShimmerCircle(40.sp),
            // Placeholder for Menu Icon
            otherWidget: Column(
              children: [
                SizedBox(height: 20.h),
                buildShimmerLine(150.w, 12.sp), // Placeholder for Welcome Text
                SizedBox(height: 10.h),
                buildShimmerLine(200.w, 14.sp), // Placeholder for User Name
                SizedBox(height: 15.h),
                buildShimmerLine(250.w, 32.sp), // Placeholder for Main Title
                SizedBox(height: 20.h),
              ],
            ),
          ),
          SizeConfig.sH15,

          /// My Courses Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildShimmerLine(100.w, 16.sp), // Placeholder for Section Title
                SizeConfig.sH10,
                SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, // Show 3 shimmer items
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300.w,
                        margin: EdgeInsets.only(right: 16.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.grey[300], // Placeholder color
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizeConfig.sH20,

          /// Categories Section
          SizedBox(
            height: 49.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3, // Show 5 shimmer items
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14.sp,
                    width: 130.w,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.sp),
                      color: Colors.grey[300], // Placeholder color
                    ),
                  ),
                );
              },
            ),
          ),
          SizeConfig.sH20,

          /// Recommended Courses Section
          buildShimmerEffect(),
        ],
      ),
    ),
  );
}
