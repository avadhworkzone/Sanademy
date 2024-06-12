import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/dialog/log_out_dialog.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/menu_screen/about_us_screen.dart';
import 'package:sanademy/view/menu_screen/contact_us_screen.dart';
import 'package:sanademy/view_model/menu_screen_view_model.dart';
import 'package:fastpay_merchant/fastPayRequests.dart';
import 'package:url_launcher/url_launcher.dart';

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
                        widget: InkWell(
                          onTap: () async {
                            FastpayResult _fastpayResult = await FastPayRequest(
                              storeID: "1234",
                              storePassword: "123456",
                              amount: "450",
                              orderID: DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString(),
                              isProduction: false,
                              callback: (status, message) {
                                debugPrint(
                                    "CALLBACK...................$message");
                                //_showToast(context,message);
                              },
                              callbackUri: "sdk://fastpay-sdk.com/callback",
                            );
                            if (_fastpayResult.isSuccess ?? false) {
                              // transaction success
                              // _showToast(context, "transaction success");
                              print(
                                  '......................................transaction success');
                            } else {
                              // transaction failed
                              //_showToast(context, "transaction failed");
                              print(
                                  '......................................transaction failed');
                            }
                            setState(() {});
                          },
                          child: Padding(
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
                        onTap: () async {},
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
                        widget: InkWell(
                          onTap: () async {
                            String phoneNumber = '9313343685';
                            String encodedMessage =
                                Uri.encodeComponent('userId');
                            var whatsappUrl = Uri.parse(
                                'whatsapp://send?phone=$phoneNumber&text=$encodedMessage');

                            /// Launch the WhatsApp URL
                            try {
                              /// send as url
                              await launchUrl(whatsappUrl);
                            } catch (e) {
                              if (kDebugMode) {
                                print('Error launching WhatsApp: $e');
                              }
                            }
                          },
                          child: Row(
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
                    ListTile(
                      onTap: () {
                        if (index == 0) {
                          Get.to(const ContactUsScreen());
                        } else if (index == 1) {
                          Get.to(const AboutUsScreen());
                        } else if (index == 2) {
                          logoutDialog(context);
                        } else {}
                      },
                      title:

                          /// FOR SHOW LOGOUT AND DELETE BUTTON
                          index == 2 || index == 3
                              ? CustomText(
                                  SharedPreferenceUtils.getIsLogin() == true
                                      ? menuScreenViewModel.drawerData[index]
                                      : '',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.red90,
                                )
                              : CustomText(
                                  menuScreenViewModel.drawerData[index],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: AppColors.black13,
                                ),
                      trailing: index == 2 || index == 3
                          ? const SizedBox()
                          : const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                    ),

                    ///IF USER LOG IN THAN SHOW EXTRA DIVIDER FOR LOGIN AND DELETE OPTION
                    index == 3
                        ? const SizedBox()
                        : index == 2 &&
                                SharedPreferenceUtils.getIsLogin() == false
                            ? const SizedBox()
                            : Divider(
                                color: AppColors.black.withOpacity(0.2),
                                height: 0.1,
                              ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
