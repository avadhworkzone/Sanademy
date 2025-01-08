import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/view/homeScreen/widget/home_category_widget.dart';
import 'package:sanademy/view/homeScreen/widget/home_recommend_widget.dart';
import 'package:sanademy/view/homeScreen/widget/home_slider_widget.dart';
import 'package:sanademy/view/menu_screen/menu_screen.dart';
import 'package:sanademy/view/profile_screen/profile_screen.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

import '../../../utils/size_config_utils.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  HomeScreenViewModel homeScreenViewModel = Get.put(HomeScreenViewModel());
  GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey();

  @override
  void initState() {
    homeApiCall();
    isCallApi.value = true;
    super.initState();
  }

  homeApiCall() async {
    await homeScreenViewModel.homeViewModel(
        search: homeScreenViewModel.searchController.value.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: homeDrawerKey,
        backgroundColor: AppColors.whitef7,
        drawer: const Drawer(
          child: MenuScreen(
              /*   userMobileNumber: homeScreenViewModel.homeResModel.data!.user!.phoneNumber.toString(),
            userId:  homeScreenViewModel.homeResModel.data!.user!.id.toString(),*/
              ),
        ),
        // appBar: commonAppBar(
        //     titleTxt: AppStrings.titleTxt,
        //     leadingWidth: 80.w,
        //     leadingWidget: Row(
        //       children: [
        //         SizedBox(
        //           width: 8.w,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             homeDrawerKey.currentState?.openDrawer();
        //           },
        //           child: Container(
        //             margin: EdgeInsets.all(8.w),
        //             padding: EdgeInsets.all(10.w),
        //             decoration: BoxDecoration(
        //                 color: AppColors.white.withOpacity(0.20),
        //                 borderRadius: BorderRadius.circular(15)),
        //             child: const LocalAssets(
        //               imagePath: AppImageAssets.categoryIcon,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     actionWidget: Obx(
        //       () => GestureDetector(
        //         onTap: () {
        //           // SharedPreferenceUtils.getIsLogin() == true
        //           //     ?
        //           Get.to(const ProfileScreen());
        //           // : Get.to(() => const SignUpScreen());
        //         },
        //         child: Container(
        //             height: 50.h,
        //             width: 50.w,
        //             margin: EdgeInsets.all(7.w),
        //             decoration: BoxDecoration(
        //                 color: AppColors.white.withOpacity(0.20),
        //                 borderRadius: BorderRadius.circular(15)),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(15),
        //               child: (homeScreenViewModel.userImage.value.isNotEmpty)
        //                   ? Image(
        //                       image: NetworkImage(
        //                           homeScreenViewModel.userImage.value),
        //                       fit: BoxFit.cover,
        //                     )
        //                   : const LocalAssets(
        //                       imagePath: AppImageAssets.profileImage),
        //             )),
        //       ),
        //     ),
        //     bottom: PreferredSize(
        //       preferredSize: const Size.fromHeight(70),
        //       child: Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.w),
        //         child: CommonTextField(
        //           textEditController:
        //               Get.find<HomeScreenViewModel>().searchController.value,
        //           regularExpression: RegularExpressionUtils.alphabetPattern,
        //           hintText: AppStrings.searchHere.tr,
        //           style: TextStyle(
        //               fontSize: 14.sp,
        //               color: AppColors.white,
        //               fontFamily: AppConstants.quicksand,
        //               fontWeight: FontWeight.w400),
        //           cursorColor: AppColors.white,
        //           isValidate: false,
        //           underLineBorder: false,
        //           hintTextColor: AppColors.white,
        //           borderColor: AppColors.primaryColor,
        //           fillColor: AppColors.white.withOpacity(0.20),
        //           pIcon: Padding(
        //             padding: EdgeInsets.only(
        //                 left: 15.w, top: 15.w, bottom: 15.w, right: 7.w),
        //             child: LocalAssets(
        //               imagePath: AppImageAssets.searchIcon,
        //             ),
        //           ),
        //           onChange: (firstNameData) {
        //             homeScreenViewModel.homeViewModel(
        //                 search:
        //                     homeScreenViewModel.searchController.value.text);
        //           },
        //         ),
        //       ),
        //     )),
        body: Obx(
          () => homeScreenViewModel.responseStatus.value == ResponseStatus.Error
              ? CustomText(
                  AppStrings.error,
                  fontSize: 20.sp,
                )
              : homeScreenViewModel.responseStatus.value ==
                      ResponseStatus.Completed
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonUpdateAppBar(
                            // height: 100.h,
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
                                  LocalAssets(
                                    imagePath: AppImageAssets.infoIcon,
                                    height: 24.sp,
                                    width: 24.sp,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 8.w, right: 8.w),
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                        // color: AppColors.white.withOpacity(0.20),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: LocalAssets(
                                      imagePath: AppImageAssets.notificationNew,
                                      height: 40.sp,
                                      width: 40.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            homeScreenLeading: Padding(
                              padding: EdgeInsets.only(right: 40.w),
                              child: GestureDetector(
                                onTap: () {
                                  homeDrawerKey.currentState?.openDrawer();
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
                                  fontFamily: AppConstants.metropolis,
                                ),
                                CustomText(
                                  'Hey, Kuproy Jane 💥',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  fontFamily: AppConstants.metropolis,
                                ),
                                SizeConfig.sH15,
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 70.w),
                                  child: CustomText(
                                    AppStrings.whatDoYouWantToLearnToday,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 32.sp,
                                    letterSpacing: -1.sp,
                                    height: 1,
                                    textAlign: TextAlign.center,
                                    fontFamily: AppConstants.metropolis,
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
                          //     fontFamily: AppConstants.metropolis,),
                          // ),
                          // SizeConfig.sH15,

                          /// CAROUSAL SLIDER VIEW....
                          MyCoursesWidget(),
                          SizeConfig.sH20,
                          // HomeSliderWidget(),
                          //
                          /// CATEGORIES VIEW
                          const HomeCategoryWidget(),
                          SizeConfig.sH15,
                          //
                          /// RECOMMENDED
                          const HomeRecommendedWidget(),
                        ],
                      ),
                    )
                  : const Material(),
        ));
  }
}
