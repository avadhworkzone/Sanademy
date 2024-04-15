import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/menu_screen_view_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  MenuScreenViewModel menuScreenViewModel = Get.put(MenuScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          color: AppColors.primaryColor,
          child: Padding(
            padding: EdgeInsets.only(
                top: 50.h, right: 10.w, left: 10.w, bottom: 20.h),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 23.h, horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        AppStrings.currentBalance,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        color: AppColors.black,
                      ),
                      SizeConfig.sH5,
                      CustomText(
                        '20,000 IQD',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                        color: AppColors.black,
                      ),
                      Divider(
                        color: AppColors.black.withOpacity(0.2),
                      ),
                      CustomText(
                        AppStrings.topUpYourBalance,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.black,
                      ),
                      SizeConfig.sH12,
                      CustomBtn(
                        onTap: () {},
                        title: null,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        bgColor: AppColors.pinkEE,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            children: [
                              LocalAssets(
                                imagePath: AppImageAssets.fastPayImg,
                                height: 28.h,
                                width: 28.w,
                              ),
                              SizeConfig.sW5,
                              CustomText(
                                AppStrings.fastPay,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizeConfig.sH12,
                      CustomBtn(
                        onTap: () {},
                        title: null,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        bgColor: AppColors.firstIraqiBankColor,
                        widget: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LocalAssets(
                              imagePath: AppImageAssets.firstIraqiBankImg,
                              height: 30.h,
                              width: 30.w,
                            ),
                            SizeConfig.sW5,
                            CustomText(
                              AppStrings.firstIraqiBank,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                      SizeConfig.sH12,
                      CustomBtn(
                        onTap: () {},
                        title: null,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        bgColor: AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              blurRadius: 4.0)
                        ],
                        widget: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LocalAssets(
                              imagePath: AppImageAssets.mobileBalanceIcn,
                              height: 30.h,
                              width: 30.w,
                            ),
                            SizeConfig.sW5,
                            CustomText(
                              AppStrings.mobileBalance,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: AppColors.black02,
                            ),
                          ],
                        ),
                      ),
                      SizeConfig.sH12,
                      CustomBtn(
                        onTap: () {},
                        title: null,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        bgColor: AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              blurRadius: 4.0)
                        ],
                        widget: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LocalAssets(
                              imagePath: AppImageAssets.visaIcn,
                              height: 30.h,
                              width: 50.w,
                            ),
                            SizeConfig.sW5,
                            CustomText(
                              AppStrings.creditCard,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: AppColors.black02,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: menuScreenViewModel.drawerData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          index == 2
                              ? InkWell(
                                  onTap: () {},
                                  child: CustomText(
                                    menuScreenViewModel.drawerData[index],
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.red90,
                                  ),
                                )
                              : CustomText(
                                  menuScreenViewModel.drawerData[index],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: AppColors.black13,
                                ),
                          index == 2
                              ? const SizedBox()
                              : const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                        ],
                      ),
                    ),
                    index == 2
                        ? const SizedBox()
                        : Divider(
                            color: AppColors.black.withOpacity(0.2),
                          ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
