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
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/log_in_screen.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());

  @override
  void initState() {
    super.initState();
    logs("---INIT");
    logs("---${SharedPreferenceUtils.getIsLogin() == true}");

    // Delay showing the bottom sheet until after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logs("---BOTTOMSHEET");
      showLoginBottomSheet(context);
    });
    signUpViewModel.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleTxt: AppStrings.titleTxt),
      body: WillPopScope(
        onWillPop: () {
          Get.offAll(() => const BottomBar());
          return Future.value(true);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
          child: Form(
            key: signUpViewModel.signUpFormKey.value,
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
                  Text(AppStrings.enterYourName.tr),

                  /// NAME TEXT FIELD
                  CommonTextField(
                    textInputAction: TextInputAction.next,
                    textEditController:
                        signUpViewModel.signUpNameController.value,
                    validator: ValidationMethod.validateName,
                    regularExpression:
                        RegularExpressionUtils.alphabetSpacePattern,
                    hintText: AppStrings.enterYourName,
                    hintFontWeight: FontWeight.w400,
                    pIcon: const Padding(
                      padding: EdgeInsets.all(12),
                      child: LocalAssets(
                        imagePath: AppImageAssets.userImage,
                        boxFix: BoxFit.cover,
                      ),
                    ),
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
                    textInputAction: TextInputAction.next,
                    onTap: () => signUpViewModel.selectDate(context),
                    readOnly: true,
                    validator: ValidationMethod.validateDate,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.black,
                        fontFamily: AppConstants.quicksand,
                        fontWeight: FontWeight.w400),
                    controller: signUpViewModel.signUpDateController.value,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 17.h),
                      hintText: AppStrings.dateFormat.tr,
                      hintStyle: TextStyle(
                        color: AppColors.black12,
                        fontSize: 14.sp,
                        fontFamily: AppConstants.quicksand,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(12),
                        child: LocalAssets(
                          imagePath: AppImageAssets.calendarIcon,
                          boxFix: BoxFit.cover,
                        ),
                      ),
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
                  SizeConfig.sH25,

                  /// PHONE NUMBER TEXT FIELD
                  Obx(
                    () => SizedBox(
                      child: IntlPhoneField(
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: signUpViewModel.signUpPhoneController.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        initialCountryCode: 'IQ',
                        onCountryChanged: (country) {
                          signUpViewModel.signUpPhoneCode.value =
                              country.dialCode;
                          signUpViewModel.signUpCountryCode.value =
                              country.code;
                        },
                        onChanged: (val) {
                          if (val.toString().isNotEmpty) {
                            signUpViewModel.signUpIsValidate.value = false;
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
                          errorText:
                              (signUpViewModel.signUpIsValidate.value == true &&
                                      signUpViewModel.signUpPhoneController
                                          .value.text.isEmpty)
                                  ? AppStrings.isRequired.tr
                                  : null,
                          errorBorder: (signUpViewModel
                                          .signUpIsValidate.value ==
                                      true &&
                                  signUpViewModel
                                      .signUpPhoneController.value.text.isEmpty)
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
                    onTap: () async {
                      signUpViewModel.signUpIsValidate.value = true;
                      if (signUpViewModel.signUpFormKey.value.currentState!
                              .validate() &&
                          signUpViewModel
                              .signUpPhoneController.value.text.isNotEmpty) {
                        /// CALL API FOR SEND OTP
                        await signUpViewModel.registerViewModel(
                          step: 1,
                          context: context,
                        );
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
                            signUpViewModel.signUpDateController.value.clear();
                            signUpViewModel.signUpPhoneController.value.clear();
                            signUpViewModel.signUpIsValidate.value = false;
                            Get.to(() => const LogInScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                AppStrings.alreadyHaveAccount,
                              ),
                              SizeConfig.sW5,
                              CustomText(
                                AppStrings.signIn,
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 20.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  child: CustomNewText(
                    "Login or Register to enroll this course",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
          
                SizedBox(height: 30.h),
                Row(
                  children: [
                    CustomNewText(
                      "Input Phone Number ",
                      fontSize: 14.sp,
                      color: AppColors.grey73,
                      fontWeight: FontWeight.w500,
                    ),CustomNewText(
                      "*",
                      color: AppColors.red,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Obx(
                  () => SizedBox(
                    child: IntlPhoneField(
                      textInputAction: TextInputAction.done,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: signUpViewModel.signUpPhoneController.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      initialCountryCode: 'IQ',
                      showDropdownIcon: false,
                      flagsButtonPadding: EdgeInsets.only(left: 10.w),
                      // onCountryChanged: (country) {
                      //   signUpViewModel.signUpPhoneCode.value = country.dialCode;
                      //   signUpViewModel.signUpCountryCode.value = country.code;
                      // },
                      // onChanged: (val) {
                      //   if (val.toString().isNotEmpty) {
                      //     signUpViewModel.signUpIsValidate.value = false;
                      //   }
                      // },
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontFamily: AppConstants.metropolis,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 17.h),
                        hintText: AppStrings.enterYourPhoneNumber.tr,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppConstants.metropolis,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixStyle: TextStyle(
                          color: AppColors.grey73,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        // errorText:
                        //     (signUpViewModel.signUpIsValidate.value == true &&
                        //             signUpViewModel
                        //                 .signUpPhoneController.value.text.isEmpty)
                        //         ? AppStrings.isRequired.tr
                        //         : null,
                        // errorBorder:
                        //     (signUpViewModel.signUpIsValidate.value == true &&
                        //             signUpViewModel
                        //                 .signUpPhoneController.value.text.isEmpty)
                        //         ? OutlineInputBorder(
                        //             borderSide:
                        //                 const BorderSide(color: AppColors.red),
                        //             borderRadius: BorderRadius.circular(10.r))
                        //         : OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(10),
                        //             borderSide: BorderSide(
                        //               color: AppColors.black.withOpacity(0.10),
                        //             )),
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
                SizedBox(height: 350.h),
          
                /// SUBMIT BUTTON
          
                CustomBtn(
                  onTap: () async {
                    // signUpViewModel.signUpIsValidate.value = true;
                    // if (signUpViewModel.signUpFormKey.value.currentState!
                    //         .validate() &&
                    //     signUpViewModel
                    //         .signUpPhoneController.value.text.isNotEmpty) {
                    //   /// CALL API FOR SEND OTP
                    //   await signUpViewModel.registerViewModel(
                    //     step: 1,
                    //     context: context,
                    //   );
                    // }
                  },
                  fontSize: 16.sp,
                  radius: 10.r,
                  title: AppStrings.logIn,
                  fontWeight: FontWeight.w600,
                ),
                SizeConfig.sH30,
              ],
            ),
          ),
        );
      },
    );
  }
}
