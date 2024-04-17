import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_enum.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/log_in_screen.dart';
import 'package:sanademy/view/auth/otp_screen.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleTxt: AppStrings.titleTxt),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
        child: Form(
          key: signUpViewModel.formKey.value,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  AppStrings.register,
                  fontSize: 20.sp,
                  color: AppColors.black0E,
                  fontWeight: FontWeight.w700,
                ),
                SizeConfig.sH10,
                CustomText(
                  AppStrings.registerYourAccount,
                  fontSize: 14.sp,
                  color: AppColors.black0E,
                  fontWeight: FontWeight.w400,
                ),
                SizeConfig.sH25,

                /// NAME TEXT FIELD
                CommonTextField(
                  textEditController: signUpViewModel.nameController.value,
                  validator: ValidationMethod.validateName,
                  regularExpression:
                      RegularExpressionUtils.alphabetSpacePattern,
                  hintText: AppStrings.enterYourName,
                  hintFontWeight: FontWeight.w400,
                  pIcon: Icon(Icons.account_circle_rounded, size: 30.h),
                  validationType: ValidationTypeEnum.name,
                  borderColor: AppColors.black.withOpacity(0.10),
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontFamily: AppConstants.quicksand,
                      fontWeight: FontWeight.w400),
                ),
                SizeConfig.sH20,

                /// DATE TEXT FIELD
                TextFormField(
                  onTap: () => signUpViewModel.selectDate(context),
                  readOnly: true,
                  validator: ValidationMethod.validateDate,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontFamily: AppConstants.quicksand,
                      fontWeight: FontWeight.w400),
                  controller: signUpViewModel.dateController.value,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
                    hintText: AppStrings.dateFormat.tr,
                    hintStyle: TextStyle(
                      color: AppColors.black12,
                      fontSize: 14.sp,
                      fontFamily: AppConstants.quicksand,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(Icons.calendar_month_rounded, size: 30.h),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.red),
                        borderRadius: BorderRadius.circular(10.r)),
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.0, color: AppColors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: AppColors.black.withOpacity(0.10),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizeConfig.sH25,

                /// PHONE NUMBER TEXT FIELD
                Obx(
                  () => SizedBox(
                    child: IntlPhoneField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: signUpViewModel.phoneController.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      initialCountryCode: 'IQ',
                      onCountryChanged: (value) {
                        print('country change ==> ${value.code}');
                      },
                      onChanged: (val) {
                        if (val.toString().isNotEmpty) {
                          signUpViewModel.isValidate.value = false;
                        }
                      },
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontFamily: AppConstants.quicksand,
                        fontWeight: FontWeight.w400,
                      ),
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
                        errorText: (signUpViewModel.isValidate.value == true &&
                                signUpViewModel
                                    .phoneController.value.text.isEmpty)
                            ? '* Required'.tr
                            : null,
                        errorBorder:
                            (signUpViewModel.isValidate.value == true &&
                                    signUpViewModel
                                        .phoneController.value.text.isEmpty)
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

                /// SUBMIT BUTTON
                CustomBtn(
                  onTap: () {
                    signUpViewModel.isValidate.value = true;
                    if (signUpViewModel.formKey.value.currentState!
                            .validate() &&
                        signUpViewModel.phoneController.value.text.isNotEmpty) {
                      Get.to(() => const OtpScreen());
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
                          Get.offAll(() => const LogInScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              AppStrings.alreadyHaveAccount,
                            ),
                            CustomText(
                              AppStrings.signIn,
                              color: AppColors.color9D,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_enum.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/otp_screen.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleTxt: AppStrings.titleTxt),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
        child: Form(
          key: signUpViewModel.formKey.value,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  AppStrings.register,
                  fontSize: 20.sp,
                  color: AppColors.black0E,
                  fontWeight: FontWeight.w700,
                ),
                SizeConfig.sH10,
                CustomText(
                  AppStrings.registerYourAccount,
                  fontSize: 14.sp,
                  color: AppColors.black0E,
                  fontWeight: FontWeight.w400,
                ),
                SizeConfig.sH25,

                /// NAME TEXT FIELD
                CommonTextField(
                  textEditController: signUpViewModel.nameController.value,
                  validator: ValidationMethod.validateName,
                  regularExpression:
                      RegularExpressionUtils.alphabetSpacePattern,
                  hintText: AppStrings.enterYourName,
                  hintFontWeight: FontWeight.w400,
                  pIcon: Icon(Icons.account_circle_rounded, size: 30.h),
                  validationType: ValidationTypeEnum.name,
                  borderColor: AppColors.black.withOpacity(0.10),
                ),
                SizeConfig.sH20,

                /// DATE TEXT FIELD
                TextFormField(
                  onTap: () => signUpViewModel.selectDate(context),
                  readOnly: true,
                  validator: ValidationMethod.validateDate,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontFamily: AppConstants.quicksand,
                      fontWeight: FontWeight.w400),
                  controller: signUpViewModel.dateController.value,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
                    hintText: AppStrings.dateFormat.tr,
                    hintStyle: TextStyle(
                      color: AppColors.black12,
                      fontSize: 14.sp,
                      fontFamily: AppConstants.quicksand,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(Icons.calendar_month_rounded, size: 30.h),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.red),
                        borderRadius: BorderRadius.circular(10.r)),
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.0, color: AppColors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: AppColors.black.withOpacity(0.10),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizeConfig.sH25,

                /// PHONE NUMBER TEXT FIELD
                Obx(
                  () => SizedBox(
                    child: IntlPhoneField(
                      controller: signUpViewModel.phoneController.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialCountryCode: 'AE',
                      keyboardType: TextInputType.number,
                      onCountryChanged: (value) {},
                      onChanged: (val) {
                        if (val.toString().isNotEmpty) {
                          signUpViewModel.isValidate.value = false;
                        }
                      },
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontFamily: AppConstants.quicksand,
                        fontWeight: FontWeight.w400,
                      ),
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
                        errorText: (signUpViewModel.isValidate.value == true &&
                                signUpViewModel
                                    .phoneController.value.text.isEmpty)
                            ? '* Required'.tr
                            : null,
                        errorBorder:
                            (signUpViewModel.isValidate.value == true &&
                                    signUpViewModel
                                        .phoneController.value.text.isEmpty)
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

                /// SUBMIT BUTTON
                CustomBtn(
                  onTap: () {
                    signUpViewModel.isValidate.value = true;
                    if (signUpViewModel.formKey.value.currentState!
                            .validate() &&
                        signUpViewModel.phoneController.value.text.isNotEmpty) {
                      Get.to(() => const OtpScreen());
                    }
                  },
                  fontSize: 14.sp,
                  radius: 10.r,
                  title: AppStrings.submit,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
