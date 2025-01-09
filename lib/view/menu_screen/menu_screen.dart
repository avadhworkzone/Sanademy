import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_container_dialog.dart';
import 'package:sanademy/commonWidget/common_scrollable_appbar_widget.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view/menu_screen/about_us_screen.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';
import 'package:sanademy/view_model/menu_screen_view_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  MenuScreenViewModel menuScreenViewModel = Get.put(MenuScreenViewModel());
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();

  Future<void> fastPlay() async {
    // FastpayResult fastPayResult = await FastPayRequest(
    //   storeID: "1234",
    //   storePassword: "123456",
    //   amount: "450",
    //   orderID: DateTime
    //       .now()
    //       .microsecondsSinceEpoch
    //       .toString(),
    //   isProduction: false,
    //   callback: (status, message) {
    //     debugPrint("CALLBACK...................$message");
    //     //_showToast(context,message);
    //   },
    //   callbackUri: "sdk://fastpay-sdk.com/callback",
    // );
    // if (fastPayResult.isSuccess ?? false) {
    if (kDebugMode) {
      print('......................................transaction success');
    }
    // } else {
    if (kDebugMode) {
      print('......................................transaction failed');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 36.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(AppStrings.myBalance,
                  fontWeight: FontWeight.w600, fontSize: 20.sp),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Icon(Icons.close),
                ),
              )
            ],
          ),
          SizedBox(height: 27.h),
          Container(
            // height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                    image: AssetImage(AppImageAssets.appLogo),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                const CommonScrollableAppbarWidget(),
                SizedBox(height: 14.h),
                CustomText(
                  AppStrings.currentBalance,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                SizedBox(height: 8.h),
                CustomText("980,000.00 IQD",
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    fontSize: 28.sp),
                SizedBox(height: 22.h),
                const CommonScrollableAppbarWidget(),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          CustomBtn(
              onTap: () {},
              title: AppStrings.addBalance,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: const Divider(color: AppColors.blackE0),
          ),
          contactUsMethod(
              preIconBgColor: AppColors.primaryColor,
              preIcon: AppImageAssets.emailIdIcon,
              title: AppStrings.transactionHistory,
              postIcon: AppImageAssets.arrowRightIcon,
              onTap: () {}),
          SizedBox(height: 12.h),
          contactUsMethod(
              preIconBgColor: AppColors.yellow00,
              preIcon: AppImageAssets.emailIdIcon,
              title: AppStrings.aboutUs,
              postIcon: AppImageAssets.arrowRightIcon,
              onTap: () {
                Get.to(() => const AboutUsScreen());
              }),
        ],
      ),
    );
  }

  Future<void> logout() async {
    await SharedPreferenceUtils.clearPreference();
    Get.offAll(() => const SignUpScreen());
  }
}
