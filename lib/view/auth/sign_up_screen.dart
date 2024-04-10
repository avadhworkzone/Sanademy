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
import 'package:sanademy/view_model/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel signUpController = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleTxt: AppStrings.titleTxt),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 30.h),
        child: Form(
          key: signUpController.formKey.value,
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
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  AppStrings.registerYourAccount,
                  fontSize: 14.sp,
                  color: AppColors.black0E,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: CommonTextField(
                    textEditController: signUpController.nameController.value,
                    validator: ValidationMethod.validateName,
                    regularExpression: RegularExpressionUtils.text,
                    hintText: AppStrings.enterYourName,
                    hintFontWeight: FontWeight.w400,
                    pIcon: Icon(Icons.account_circle_rounded, size: 30.h),
                    validationType: ValidationTypeEnum.name,
                    borderColor: AppColors.black.withOpacity(0.10),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: SizedBox(
                      child: TextFormField(
                        onTap: () => signUpController.selectDate(context),
                        readOnly: true,
                        validator: ValidationMethod.validateDate,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: signUpController.dateController.value,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 12.h),
                          hintText: AppStrings.dateFormat,
                          hintStyle: TextStyle(
                            color: AppColors.black12,
                            fontSize: 14.sp,
                            fontFamily: AppConstants.quicksand,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon:
                              Icon(Icons.calendar_month_rounded, size: 30.h),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.red),
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
                    )),
                SizedBox(
                  height: 25.h,
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: SizedBox(
                      height: 75.h,
                      child: IntlPhoneField(
                        controller: signUpController.phoneController.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (val)=> signUpController.intlPhoneFiledOnChange(val),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 12.h),
                          hintText: AppStrings.enterYourPhoneNumber,
                          hintStyle: TextStyle(
                            color: AppColors.black12,
                            fontSize: 14.sp,
                            fontFamily: AppConstants.quicksand,
                            fontWeight: FontWeight.w400,
                          ),
                          errorText: (signUpController.isValidate.value == true && signUpController.phoneController.value.text.isEmpty)
                              ? '* Required'
                              : null,
                          errorBorder: (signUpController.isValidate.value == true && signUpController.phoneController.value.text.isEmpty)
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
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: CustomBtn(
                    onTap: () => signUpController.submitOnTap(),
                    fontSize: 14.sp,
                    radius: 10.r,
                    title: AppStrings.submit,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
