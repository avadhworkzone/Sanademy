import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view_model/otp_view_model.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

void showLoginBottomSheet(BuildContext context) {
  SignUpViewModel signUpViewModel = Get.find();

  showModalBottomSheet(
    backgroundColor: AppColors.white,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) {
      return Obx(() {
        return WillPopScope(
          onWillPop: () async {
            return true; // Allow back button to close
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 20.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Prevent column from expanding
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                        child: CustomNewText(
                          AppStrings.loginOrRegisterToEnrollThisCourse,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue34,
                          letterSpacing: -1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        CustomNewText(
                          AppStrings.inputPhoneNumber,
                          fontSize: 14.sp,
                          color: AppColors.grey73,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomNewText(
                          "*",
                          color: AppColors.red2A,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    IntlPhoneField(
                      textInputAction: TextInputAction.done,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: signUpViewModel.signUpPhoneController.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      initialCountryCode: 'IQ',
                      showDropdownIcon: false,
                      flagsButtonPadding: EdgeInsets.only(left: 10.w),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 17.h),
                        hintText: AppStrings.enterYourPhoneNumber.tr,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: AppColors.black.withOpacity(0.10),
                            width: 1.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        signUpViewModel.isPhoneNumberValid.value =
                            value.isValidNumber();
                      },
                    ),
                    if (signUpViewModel.isPasswordFieldShow.value) ...[
                      Row(
                        children: [
                          CustomNewText(
                            AppStrings.password,
                            fontSize: 14.sp,
                            color: AppColors.grey73,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomNewText(
                            "*",
                            color: AppColors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Obx(
                        () {
                          return CommonTextField(
                            textInputAction: TextInputAction.done,
                            textEditController:
                                signUpViewModel.signUpPasswordController.value,
                            validator: ValidationMethod.validatePassword,
                            obscureValue: signUpViewModel.isPasswordVisible
                                .value, // Toggle visibility based on the value of isPasswordVisible
                            regularExpression:
                                RegularExpressionUtils.onlyNumbersPattern,
                            hintText: AppStrings.enterYourPassword,
                            maxLength: 6,
                            obscuringCharacter: '*',
                            hintFontWeight: FontWeight.w400,
                            sIcon: GestureDetector(
                              onTap: () {
                                print(
                                    "Toggling password visibility"); // Check if this is called

                                // Toggle password visibility
                                signUpViewModel.isPasswordVisible.value =
                                    !signUpViewModel.isPasswordVisible
                                        .value; // Toggle the value
                              },
                              child: Icon(
                                signUpViewModel.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.black.withOpacity(0.5),
                              ),
                            ),
                            keyBoardType: TextInputType.number,
                            borderColor: AppColors.black.withOpacity(0.10),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.black,
                              fontFamily: AppConstants.quicksand,
                              fontWeight: FontWeight.w400,
                            ),
                            onChange: (value) {
                              signUpViewModel.isPasswordValid.value =
                                  value.isNotEmpty; // Update password validity
                            },
                          );
                        },
                      ),
                      SizeConfig.sH20,
                    ],
                    SizedBox(
                      height: 260.h,
                    ),
                    CustomBtn(
                      onTap: (signUpViewModel.isPasswordFieldShow.value &&
                              signUpViewModel.isPasswordValid.value)
                          ? () {
                              showModalBottomSheet(
                                backgroundColor: AppColors.white,
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return Obx(() {
                                    return WillPopScope(
                                      onWillPop: () async {
                                        Get.offAll(() => const BottomBar());
                                        return false;
                                      },
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.75,
                                        child:
                                            otpVerifyWidget(context: context),
                                      ),
                                    );
                                  });
                                },
                              ).then((value) {
                                signUpViewModel.signUpPasswordController.value
                                    .clear();
                                signUpViewModel.signUpPhoneController.value
                                    .clear();
                                signUpViewModel.isPasswordFieldShow.value =
                                    false;
                                signUpViewModel.isPhoneNumberValid.value =
                                    false;
                                signUpViewModel.isPasswordValid.value = false;
                              });
                            }
                          : signUpViewModel.isPhoneNumberValid.value
                              ? () {
                                  signUpViewModel.isPasswordFieldShow.value =
                                      true;
                                }
                              : null,
                      fontSize: 16.sp,
                      radius: 12.r,
                      bgColor: signUpViewModel.isPhoneNumberValid.value ||
                              (signUpViewModel.isPasswordFieldShow.value &&
                                  signUpViewModel.isPasswordValid.value)
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withOpacity(0.6),
                      title: AppStrings.logIn,
                      fontWeight: FontWeight.w600,
                    ),
                    SizeConfig.sH30,
                  ],
                ),
              ),
            ),
          ),
        );
      });
    },
  ).then((value) {
    signUpViewModel.signUpPasswordController.value.clear();
    signUpViewModel.signUpPhoneController.value.clear();
    signUpViewModel.isPasswordFieldShow.value = false;
    signUpViewModel.isPhoneNumberValid.value = false;
    signUpViewModel.isPasswordValid.value = false;
  });
}

Widget otpVerifyWidget({required BuildContext context}) {
  OtpViewModel otpViewModel = Get.put(OtpViewModel());
  SignUpViewModel signUpController = Get.find<SignUpViewModel>();

  /// Timer Will Start When You Come On This Screen
  WidgetsBinding.instance.addPostFrameCallback((_) {
    otpViewModel.startTimer();
  });

  return SingleChildScrollView(
    child: Form(
      key: otpViewModel.formKey.value,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10.h),
            CustomNewText(
              AppStrings.verifyYourPhone,
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              color: AppColors.blue34,
            ),
            SizedBox(height: 12.h),
            CustomNewText(
              AppStrings.otpHasBeenSetToYourPhone,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.blue34,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomNewText(
                  "(0000) ",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  color: AppColors.blue34,
                ),
                CustomNewText(
                  AppStrings.onWhatsApp,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Obx(() {
              return Column(
                children: [
                  SizeConfig.sH15,

                  /// otp field
                  Pinput(
                    validator: (val) => ValidationMethod.validateOtp(val),
                    controller: otpViewModel.pinPutController.value,
                    length: 5,
                    showCursor: true,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: PinTheme(
                      height: 48.h,
                      width: 48.w,
                      textStyle: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue34),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onChanged: (val) {
                      signUpController.code.value = val;
                    },
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
                      fontSize: 16.sp,
                      // decorationColor: AppColors.primaryColor,
                      decoration: TextDecoration.underline,
                      color: AppColors.blue34,
                    ),
                  SizeConfig.sH25,
                  int.parse(otpViewModel
                              .strDigits(otpViewModel.myDuration.value.inSeconds
                                  .remainder(60))
                              .value) >
                          0
                      ? CustomText(
                          AppStrings.resendOtp.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                          color: AppColors.primaryColor,
                        )
                      : InkWell(
                          onTap: () {
                            otpViewModel.resetTimer();
                          },
                          child: CustomText(
                            AppStrings.resendOtp.tr,
                            decorationColor: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                  SizeConfig.sH30,
                ],
              );
            }),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: CustomBtn(
                onTap: otpViewModel.pinPutController.value.text.length < 6
                    ? null
                    : () async {
                        // if (otpViewModel.formKey.value.currentState!
                        //     .validate()) {
                        //   await SharedPreferenceUtils.setIsLogin(true);
                        //   await signUpController.registerViewModel(
                        //       step: 2,
                        //       context: context,
                        //       verificationIDFinal: "0000");
                        // }
                      },
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                radius: 12.r,
                title: AppStrings.verifyYourPhone,
                bgColor: otpViewModel.pinPutController.value.text.length < 6
                    ? AppColors.primaryColor.withOpacity(0.5)
                    : AppColors.primaryColor,
                textColor: AppColors.white,
              ),
            ),
            SizeConfig.sH30,
          ],
        ),
      ),
    ),
  );
}
