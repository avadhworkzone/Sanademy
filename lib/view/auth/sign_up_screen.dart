
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
import 'package:sanademy/view_model/sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = Get.find<SignUpController>();

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleTxt: AppStrings.titleTxt),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 30.h),
        child: Form(
          key: signUpController.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  AppStrings.register,
                  fontSize: 22.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  AppStrings.registerYourAccount,
                  fontSize: 15.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: CommonTextField(
                    textEditController: signUpController.nameController,
                    validator: ValidationMethod.validateName,
                    regularExpression: RegularExpressionUtils.text,
                    hintText: AppStrings.enterYourName,
                    pIcon: Icon(Icons.account_circle, size: 30.h),
                    validationType: ValidationTypeEnum.name,
                    borderColor: AppColors.black.withOpacity(0.10),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: SizedBox(
                      child: TextFormField(
                        onTap: () => signUpController.selectDate(context),
                        readOnly: true,
                        validator: ValidationMethod.validateDate,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: signUpController.dateController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                          hintText: AppStrings.dateFormat,
                            hintStyle: TextStyle(
                              color: AppColors.black12,
                              fontSize: 14.sp,
                              fontFamily: AppConstants.quicksand,
                              fontWeight: FontWeight.normal,
                            ),
                          prefixIcon:  Icon(Icons.calendar_month,size: 30.h),
                          errorBorder:  const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.red)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                               BorderSide(color: AppColors.black.withOpacity(0.10),)),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                                width:  1.0,
                                color: AppColors.black.withOpacity(0.10),),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width:  1.0,
                                color: AppColors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color:  AppColors.black.withOpacity(0.10),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    )
                    /* CommonTextField(
                    textEditController: signUpController.dateController,
                    regularExpression: RegularExpressionUtils.text,
                    hintText: AppStrings.dateFormat,
                    pIcon: Icon(Icons.calendar_month,size: 30.h),
                    //validationType: ValidationTypeEnum.name,
                    borderColor: AppColors.black,
                    obscureValue: false,
                    readOnly: true,
                    onTap: ()=> signUpController.selectDate(context),
                  ),*/
                    ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: SizedBox(
                    height: 75.h,
                    child: IntlPhoneField(
                      focusNode: focusNode,
                      controller: signUpController.phoneController,
                      // validator: (val){
                      //   print('val${val}');
                      //   if(val.toString().isEmpty || val == null){
                      //     return "Please enter ";
                      //   }
                      //   return null;
                      // },
                          //(val)=> ValidationMethod.validatePhone(val),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                        hintText: AppStrings.enterYourPhoneNumber,
                        hintStyle: TextStyle(
                          color: AppColors.black12,
                          fontSize: 14.sp,
                          fontFamily: AppConstants.quicksand,
                          fontWeight: FontWeight.normal,
                        ),
                        errorBorder:   OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                             BorderSide(color: AppColors.black.withOpacity(0.10),)),
                        focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(
                              width:  1.0,
                              color: AppColors.black.withOpacity(0.10),),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width:  1.0,
                              color: AppColors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color:  AppColors.black.withOpacity(0.10),
                            width: 1.0,
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
                    onTap: ()=> signUpController.submitOnTap(),
                    fontSize: 18.sp,
                    radius: 10.r,
                    title: AppStrings.submit,
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