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
import 'package:sanademy/view/auth/send_otp_method.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view_model/otp_view_model.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.verificationIDFinal,
    this.phoneNumber = '',
    this.countryCode = '',
    this.countryTxtCode = '',
  });

  final String verificationIDFinal;
  final String phoneNumber;
  final String countryCode;
  final String countryTxtCode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpViewModel otpViewModel = Get.put(OtpViewModel());
  SignUpViewModel signUpController = Get.find<SignUpViewModel>();

  @override
  void initState() {
    otpViewModel.startTimer();
    super.initState();
  }

  @override
  void dispose() {
    otpViewModel.pinPutController.value.clear();
    otpViewModel.stopTimer();
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
                    /*
                    signUpController.signUpUserOtp.value != 0
                        ? CustomText(
                            "Your Otp is: ${signUpController.signUpUserOtp.value.toString()}",
                            fontSize: 14.sp,
                            color: AppColors.black12,
                            fontWeight: FontWeight.w700,
                          )
                        : SizeConfig.sH2,
                    SizeConfig.sH10,*/
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
                      length: 6,
                      showCursor: true,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: PinTheme(
                          height: 50.h,
                          width: 50.w,
                          textStyle: TextStyle(fontSize: 15.sp),
                          decoration: BoxDecoration(
                              color: AppColors.pinputColor, borderRadius: BorderRadius.circular(10.r))),
                      onChanged: (val) {
                        signUpController.code.value = val;
                      },
                    ),
                    SizeConfig.sH15,
                    if (int.parse(otpViewModel
                            .strDigits(otpViewModel.myDuration.value.inSeconds.remainder(60))
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
                                    .strDigits(otpViewModel.myDuration.value.inSeconds.remainder(60))
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
                                  sendOtp(
                                    phoneNumber: widget.phoneNumber,
                                    context: context,
                                    countryCode: widget.countryCode,
                                    countryTxtCode: widget.countryTxtCode,
                                  );
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
                        onTap: otpViewModel.pinPutController.value.text.length < 6
                            ? null
                            : () async {
                                if (otpViewModel.formKey.value.currentState!.validate()) {
                                  await SharedPreferenceUtils.setIsLogin(true);
                                  await signUpController.registerViewModel(
                                      step: 2,
                                      context: context,
                                      verificationIDFinal: widget.verificationIDFinal);
                                }
                              },
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        radius: 10.r,
                        title: AppStrings.verify,
                        bgColor: otpViewModel.pinPutController.value.text.length < 6
                            ? AppColors.primaryColor.withOpacity(0.5)
                            : AppColors.primaryColor,
                        textColor: AppColors.white,
                      ),
                    ),
                    SizeConfig.sH20,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: CustomBtn(
                        onTap: () {
                          Get.to(const SignUpScreen());
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
