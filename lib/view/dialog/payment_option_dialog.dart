import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void paymentOptionDialog({
  required BuildContext context,
  required String userMobileNumber,
  required String userPhoneCode,
  required String userId,
}) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(insetPadding: EdgeInsets.symmetric(horizontal: 15.w), children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              AppStrings.paymentOption,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black0E,
            ),
            SizeConfig.sH16,
            CustomText(
              '${AppStrings.thankYouTxt} 49,000 IQD ${AppStrings.thankYouTxt2}',
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.black0E,
            ),
            SizeConfig.sH30,
            Row(
              children: [
                CustomBtn(
                  onTap: () {},
                  width: 160.w,
                  height: 56.h,
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
                SizeConfig.sW15,
                CustomBtn(
                  onTap: () {},
                  width: 160.w,
                  height: 56.h,
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
                )
              ],
            ),
            SizeConfig.sH16,
            CustomBtn(
              onTap: () {},
              title: null,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              bgColor: AppColors.white,
              boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 4.0)],
              widget: InkWell(
                onTap: () {
                  SharedPreferenceUtils.getIsLogin() == true ?
                  launchWhatsApp(
                    '${AppStrings.reDirectOnWhatsAppMessage} $userId',
                    '$userMobileNumber',
                  ) : Get.to(const SignUpScreen());
                },
                child: Row(
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
            ),
            /* SizeConfig.sW15,
                    CustomBtn(
                      onTap: () {},
                      width: 160.w,
                      height: 56.h,
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
                    )*/
            SizeConfig.sH25,
            CustomText(
              AppStrings.youCantPayThisPrice,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.black0E,
            ),
            SizeConfig.sH25,
            CustomBtn(
                onTap: () {
                  SharedPreferenceUtils.getIsLogin() == true ?
                  launchWhatsApp(
                    '${AppStrings.reDirectOnWhatsAppMessage} $userId',
                    '$userMobileNumber',
                  ) : Get.to(const SignUpScreen());
                  /* Get.find<DescriptionViewModel>().isPaySuccessfully.value =
                          true;*/
                },
                title: AppStrings.sendMsgOnWhatsApp)
          ],
        ),
      )
    ]),
  );
}

void launchWhatsApp(String message, String number) async {
  final Uri url = Uri.parse('https://wa.me/$number?text=${Uri.encodeComponent(message)}');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
