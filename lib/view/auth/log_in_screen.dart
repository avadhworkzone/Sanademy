import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view_model/otp_view_model.dart';
import 'package:sanademy/view_model/sign_in_view_model.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  SignInViewModel signInViewModel = Get.find();
  OtpViewModel otpViewModel = Get.put(OtpViewModel());

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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
        child: Form(
          key: signInViewModel.signInFormKey.value,
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    AppStrings.signIn,
                    fontSize: 20.sp,
                    color: AppColors.black0E,
                    fontWeight: FontWeight.w700,
                  ),
                  SizeConfig.sH25,

                  /// PHONE NUMBER TEXT FIELD
                  Obx(
                    () => SizedBox(
                      child: IntlPhoneField(
                        readOnly: signInViewModel.showContainer.value == true
                            ? true
                            : false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: signInViewModel.signInPhoneController.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialCountryCode: 'IQ',
                        onChanged: (val) {
                          if (val.toString().isNotEmpty) {
                            signInViewModel.signInIsValidate.value = false;
                          }
                        },
                        style: TextStyle(
                          color: signInViewModel.showContainer.value == true
                              ? AppColors.black.withOpacity(0.4)
                              : AppColors.black,
                          fontSize: 14.sp,
                          fontFamily: AppConstants.quicksand,
                          fontWeight: FontWeight.w400,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 17.h),
                          hintText: AppStrings.enterYourPhoneNumber.tr,
                          hintStyle: TextStyle(
                            color: AppColors.black12,
                            fontSize: 14.sp,
                            fontFamily: AppConstants.quicksand,
                            fontWeight: FontWeight.w400,
                          ),
                          errorText:
                              (signInViewModel.signInIsValidate.value == true &&
                                      signInViewModel.signInPhoneController
                                          .value.text.isEmpty)
                                  ? '* Required'.tr
                                  : null,
                          errorBorder: (signInViewModel
                                          .signInIsValidate.value ==
                                      true &&
                                  signInViewModel
                                      .signInPhoneController.value.text.isEmpty)
                              ? OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColors.red),
                                  borderRadius: BorderRadius.circular(10.r))
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.black.withOpacity(0.10),
                                  )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.black.withOpacity(0.10),
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.0,
                              color: AppColors.black.withOpacity(0.10),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: AppColors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.black.withOpacity(0.10),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizeConfig.sH30,
                  Visibility(
                      visible: signInViewModel.showContainer.value,
                      child: Column(
                        children: [
                          CustomText(
                            AppStrings.enterFourDigitOtp,
                            fontSize: 15.sp,
                            color: AppColors.black12,
                            fontWeight: FontWeight.w400,
                          ),
                          SizeConfig.sH15,

                          /// otp field
                          Pinput(
                            validator: (val) =>
                                ValidationMethod.validateOtp(val),
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
                                  .strDigits(otpViewModel
                                      .myDuration.value.inSeconds
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
                                  ? CustomText(AppStrings.resendOtp.tr,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor
                                          .withOpacity(0.4))
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
                        ],
                      )),

                  /// SUBMIT BUTTON
                  signInViewModel.showContainer.value == true
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22.w),
                          child: CustomBtn(
                            onTap: () async {
                              if (signInViewModel
                                  .signInFormKey.value.currentState!
                                  .validate()) {
                                await SharedPreferenceUtils.setIsLogin(true);
                                Get.offAll(() => const BottomBar());
                              }
                            },
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            radius: 10.r,
                            title: AppStrings.verify,
                            bgColor: AppColors.primaryColor,
                            textColor: AppColors.white,
                          ),
                        )
                      : CustomBtn(
                          onTap: () {
                            signInViewModel.signInIsValidate.value = true;
                            if (signInViewModel
                                    .signInFormKey.value.currentState!
                                    .validate() &&
                                signInViewModel.signInPhoneController.value.text
                                    .isNotEmpty) {
                              signInViewModel.showContainer.value = true;
                              FocusScope.of(context).requestFocus(FocusNode());
                              otpViewModel.startTimer();
                            }
                          },
                          fontSize: 14.sp,
                          radius: 10.r,
                          title: AppStrings.submit,
                          fontWeight: FontWeight.w700,
                        ),
                  SizeConfig.sH30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.w),
                        child: GestureDetector(
                          onTap: () {
                            signInViewModel.signInPhoneController.value.clear();
                            signInViewModel.signInIsValidate.value = false;
                            signInViewModel.showContainer.value = false;
                            Get.offAll(() => const SignUpScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                AppStrings.notHaveAccount,
                              ),
                              SizeConfig.sW5,
                              CustomText(
                                AppStrings.signUp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
