import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view/homeScreen/widget/home_category_widget.dart';
import 'package:sanademy/view/homeScreen/widget/home_recommend_widget.dart';
import 'package:sanademy/view/homeScreen/widget/home_slider_widget.dart';
import 'package:sanademy/view/menu_screen/menu_screen.dart';
import 'package:sanademy/view/profile_screen/profile_screen.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

/*
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel homeScreenViewModel = Get.put(HomeScreenViewModel());
  ProfileScreenViewModel profileScreenViewModel =
  Get.put(ProfileScreenViewModel());
  GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey();

  @override
  void initState() {
    homeApiCall();
    super.initState();
  }

  homeApiCall() async {
    await homeScreenViewModel.homeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeDrawerKey,
      drawer: const Drawer(child: MenuScreen()),
      appBar: commonAppBar(
        titleTxt: AppStrings.titleTxt.tr,
        leadingWidth: 80.w,
        leadingWidget: Row(
          children: [
            SizedBox(
              width: 8.w,
            ),
            GestureDetector(
              onTap: () {
                homeDrawerKey.currentState?.openDrawer();
              },
              child: Container(
                margin: EdgeInsets.all(8.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(15)),
                child: const LocalAssets(
                  imagePath: AppImageAssets.categoryIcon,
                ),
              ),
            ),
          ],
        ),
        actionWidget: Obx(() {
          if (homeScreenViewModel.responseStatus.value == ResponseStatus.Error) {
            return CustomText(
              'Error',
              fontSize: 20.sp,
            );
          } else if (homeScreenViewModel.responseStatus.value ==
              ResponseStatus.Loading) {
            return const CircularProgressIndicator();
          } else if (homeScreenViewModel.responseStatus.value ==
              ResponseStatus.Completed) {
            final userImage = homeScreenViewModel.homeResModel.data?.user?.image;
            return GestureDetector(
              onTap: () {
                SharedPreferenceUtils.getIsLogin() == true
                    ? Get.to(const ProfileScreen())
                    : Get.to(() => const SignUpScreen());
              },
              child: Container(
                height: 50.h,
                width: 50.w,
                margin: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: userImage != null && userImage.isNotEmpty
                      ? Image.network(
                    userImage,
                    fit: BoxFit.cover,
                  )
                      : const LocalAssets(
                      imagePath: AppImageAssets.profileImage),
                ),
              ),
            );
          } else {
            return const Material();
          }
        }),
      ),
      body: Obx(() {
        if (homeScreenViewModel.responseStatus.value == ResponseStatus.Error) {
          return CustomText(
            'Error',
            fontSize: 20.sp,
          );
        } else if (homeScreenViewModel.responseStatus.value ==
            ResponseStatus.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (homeScreenViewModel.responseStatus.value ==
            ResponseStatus.Completed) {
          return const Column(
            children: [
              /// CAROUSAL SLIDER VIEW....
              HomeSliderWidget(),

              /// CATEGORIES VIEW
              HomeCategoryWidget(),

              /// RECOMMENDED
              HomeRecommendedWidget(),
            ],
          );
        } else {
          return Container(); // or some other placeholder
        }
      }),
    );
  }
}*/

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel homeScreenViewModel = Get.put(HomeScreenViewModel());
  GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey();

  @override
  void initState() {
    homeApiCall();
    super.initState();
  }

  homeApiCall() async {
    await homeScreenViewModel.homeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: homeDrawerKey,
        drawer: const Drawer(child: MenuScreen()),
        appBar: commonAppBar(
            titleTxt: AppStrings.titleTxt,
            leadingWidth: 80.w,
            leadingWidget: Row(
              children: [
                SizedBox(
                  width: 8.w,
                ),
                GestureDetector(
                  onTap: () {
                    homeDrawerKey.currentState?.openDrawer();
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.w),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(15)),
                    child: const LocalAssets(
                      imagePath: AppImageAssets.categoryIcon,
                    ),
                  ),
                ),
              ],
            ),
            actionWidget: Obx(() => GestureDetector(
                      onTap: () {
                        SharedPreferenceUtils.getIsLogin() == true
                            ? Get.to(const ProfileScreen())
                            : Get.to(() => const SignUpScreen());
                      },
                      child: Container(
                          height: 50.h,
                          width: 50.w,
                          margin: EdgeInsets.all(7.w),
                          decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child:
                                (homeScreenViewModel.userImage.value.isNotEmpty)
                                    ? Image(
                                        image:
                                            // NetworkImage(SharedPreferenceUtils.getImage()),
                                            NetworkImage(homeScreenViewModel
                                                .userImage.value),
                                        fit: BoxFit.cover,
                                      )
                                    : const LocalAssets(
                                        imagePath: AppImageAssets.profileImage),
                          )),
                    )
                /*(homeScreenViewModel.responseStatus.value ==
                      ResponseStatus.Completed)
                  ? GestureDetector(
                      onTap: () {
                        SharedPreferenceUtils.getIsLogin() == true
                            ? Get.to(const ProfileScreen())
                            : Get.to(() => const SignUpScreen());
                      },
                      child: Container(
                          height: 50.h,
                          width: 50.w,
                          margin: EdgeInsets.all(7.w),
                          decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: (homeScreenViewModel.userImage.value.isNotEmpty)
                                ? Image(
                                    image:
                                        // NetworkImage(SharedPreferenceUtils.getImage()),
                                        NetworkImage(homeScreenViewModel.userImage.value),
                                    fit: BoxFit.cover,
                                  )
                                : const LocalAssets(
                                    imagePath: AppImageAssets.profileImage),
                          )),
                    )
                  : const Material(),*/
                )),
        body: Obx(
          () => homeScreenViewModel.responseStatus.value == ResponseStatus.Error
              ? CustomText(
                  AppStrings.error,
                  fontSize: 20.sp,
                )
              : homeScreenViewModel.responseStatus.value ==
                      ResponseStatus.Completed
                  ? const Column(
                      children: [
                        /// CAROUSAL SLIDER VIEW....
                        HomeSliderWidget(),

                        /// CATEGORIES VIEW
                        HomeCategoryWidget(),

                        /// RECOMMENDED
                        HomeRecommendedWidget(),
                      ],
                    )
                  : const Material(),
        ));
  }
}
