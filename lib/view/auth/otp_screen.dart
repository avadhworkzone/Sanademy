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
  OtpViewModel otpViewModel = Get.put(OtpViewModel());

  SignUpViewModel signUpController = Get.find<SignUpViewModel>();

  @override
  void initState() {
    otpViewModel.startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    otpViewModel.stopTimer();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleTxt: AppStrings.titleTxt),
      body: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Form(
          key: otpViewModel.formKey.value,
          child: SingleChildScrollView(
            child: Center(
              child: Obx(() {
                return Column(
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
                      signUpController.signUpPhoneController.value.text.tr,
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

                    /// otp field
                    Pinput(
                      validator: (val) => ValidationMethod.validateOtp(val),
                      controller: otpViewModel.pinPutController.value,
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
                    if (int.parse(otpViewModel
                            .strDigits(otpViewModel.myDuration.value.inSeconds
                                .remainder(60))
                            .value) >
                        0)
                      CustomText(
                        '${otpViewModel.strDigits(otpViewModel.myDuration.value.inMinutes.remainder(60))}:${otpViewModel.strDigits(otpViewModel.myDuration.value.inSeconds.remainder(60))}',
                        fontWeight: FontWeight.w600,
                        color: AppColors.black0E,
                      ),
                    SizeConfig.sH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          AppStrings.didNotGetOtp.tr,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black12,
                        ),
                        SizeConfig.sW5,

                        /// resend button
                        int.parse(otpViewModel
                                    .strDigits(otpViewModel
                                        .myDuration.value.inSeconds
                                        .remainder(60))
                                    .value) >
                                0
                            ? CustomText(
                                AppStrings.resendOtp.tr,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor.withOpacity(0.4),
                              )
                            : InkWell(
                                onTap: () {
                                  otpViewModel.resetTimer();
                                },
                                child: CustomText(
                                  AppStrings.resendOtp.tr,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                      ],
                    ),
                    SizeConfig.sH30,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: CustomBtn(
                        onTap: () async {
                          if (otpViewModel.formKey.value.currentState!
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
                    ),
                    SizeConfig.sH20,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: CustomBtn(
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
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
