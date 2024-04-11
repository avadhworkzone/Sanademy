import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view_model/otp_view_model.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpController otpController = Get.put(OtpController());
  SignUpViewModel signUpController = Get.find<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleTxt: AppStrings.titleTxt),
      body: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Form(
          key: otpController.formKey.value,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 22.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        AppStrings.otpTxt,
                        fontSize: 20.sp,
                        color: AppColors.black12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizeConfig.sH10,
                  CustomText(
                    AppStrings.enterOtpTxt,
                    fontSize: 14.sp,
                    color: AppColors.black12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizeConfig.sH30,
                  CustomText(
                    signUpController.phoneController.value.text.tr,
                    fontSize: 14.sp,
                    color: AppColors.black12,
                    fontWeight: FontWeight.w700,
                  ),
                  SizeConfig.sH10,
                  CustomText(
                    AppStrings.enterFourDigitOtp,
                    fontSize: 15.sp,
                    color: AppColors.black12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizeConfig.sH15,
                  Pinput(
                    validator: (val) => ValidationMethod.validateOtp(val),
                    controller: otpController.pinPutController.value,
                    length: 4,
                    showCursor: true,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: PinTheme(
                        height: 50.h,
                        width: 50.w,
                        textStyle: TextStyle(fontSize: 15.sp),
                        decoration: BoxDecoration(
                            color: AppColors.pinputColor,
                            borderRadius: BorderRadius.circular(10.r))),
                    onChanged: (val) {},
                  ),
                  SizeConfig.sH15,
                  RichText(
                      text: TextSpan(
                          text: AppStrings.didNotGetOtp.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.black12,
                          ),
                          children: [
                        TextSpan(
                          text: AppStrings.resendOtp.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ])),
                  SizeConfig.sH30,
                  CustomBtn(
                    onTap: () async {
                      if (otpController.formKey.value.currentState!
                          .validate()) {
                        await SharedPreferenceUtils.setIsLogin(true);
                        Get.to(() => const BottomBar());
                      }
                    },
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    radius: 10.r,
                    title: AppStrings.verify,
                    bgColor: AppColors.primaryColor,
                    textColor: AppColors.white,
                  ),
                  SizeConfig.sH20,
                  CustomBtn(
                    onTap: () {
                      Get.back();
                    },
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    radius: 10.r,
                    bgColor: AppColors.white,
                    borderColor: AppColors.primaryColor,
                    title: AppStrings.goBack,
                    textColor: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
