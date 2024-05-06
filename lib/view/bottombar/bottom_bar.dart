import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/view_model/bottom_bar_view_model.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  BottomBarViewModel bottomBarViewModel = Get.put(BottomBarViewModel());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: false,
        body: bottomBarViewModel
            .screenList[bottomBarViewModel.selectedBottomIndex.value],
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 12.w),
          width: Get.width,
          decoration: BoxDecoration(color: AppColors.white,
              boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.10),
              blurRadius: 0.1,
              spreadRadius: 0.1,
            )
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              navItem(
                  index: 0,
                  icon: AppImageAssets.homeIcon,
                  selectedIcon: AppImageAssets.selectedHomeIcon,
                  title: AppStrings.home),
              navItem(
                  index: 1,
                  icon: AppImageAssets.myProgress,
                  selectedIcon: AppImageAssets.selectedProgressIcon,
                  title: AppStrings.myProgress),
              navItem(
                  index: 2,
                  icon: AppImageAssets.myCertificate,
                  selectedIcon: AppImageAssets.selectedCertificateIcon,
                  title: AppStrings.myCertificate),
              navItem(
                  index: 3,
                  icon: AppImageAssets.notification,
                  selectedIcon: AppImageAssets.selectedNotificationIcon,
                  title: AppStrings.notification),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(
      {required int index,
      required String icon,
      required String selectedIcon,
      required String title}) {
    return InkWell(
      onTap: () {
        bottomBarViewModel.selectedBottomIndex.value = index;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LocalAssets(
            imagePath: bottomBarViewModel.selectedBottomIndex.value == index
                ? selectedIcon
                : icon,
            height: 25.w,
            width: 25.w,
          ),
          CustomText(
            title,
            color: bottomBarViewModel.selectedBottomIndex.value == index
                ? AppColors.color9D
                : AppColors.black0E.withOpacity(0.30),
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
        ],
      ),
    );
  }
}
