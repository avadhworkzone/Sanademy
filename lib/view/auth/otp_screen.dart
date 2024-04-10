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
import 'package:sanademy/view_model/otp_view_model.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';



class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  SignUpController signUpController = Get.find<SignUpController>();
  OtpController otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleTxt: AppStrings.titleTxt),
      body: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Form(
          key: otpController.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: CustomText(
                    AppStrings.otpTxt,
                    fontSize: 22.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: CustomText(
                    AppStrings.enterOtpTxt,
                    fontSize: 15.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CustomText(
                          signUpController.phoneController.text,
                          fontSize: 15.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomText(
                          AppStrings.enterFourDigitOtp,
                          fontSize: 15.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Pinput(
                          validator: (val) => ValidationMethod.validateOtp(val),
                           controller: otpController.pinPutController,
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
                        SizedBox(
                          height: 15.h,
                        ),
                        RichText(text: TextSpan(
                          text: AppStrings.didNotGetOtp,
                          style: TextStyle(
                            fontWeight:FontWeight.w400,
                            fontSize: 15.sp,
                            color: AppColors.black,
                          ),
                          children: [
                            TextSpan(
                              text: AppStrings.resendOtp,
                              style: TextStyle(
                                fontWeight:FontWeight.w600,
                                fontSize: 15.sp,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ]
                        )),
                        SizedBox(
                          height: 30.h,
                        ),
                        GetBuilder<OtpController>(
                          id: 'IsTap',
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(left: 15.w,right: 15.w),
                              child: CustomBtn(
                                onTap: ()=> otpController.verifyOnTap(),
                                fontSize: 18.sp,
                                radius: 10.r,
                                title: AppStrings.verify,
                                bgColor: AppColors.primaryColor,
                               // borderColor: AppColors.primaryColor,
                                textColor: AppColors.white,
                              ),
                            );
                          }
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GetBuilder<OtpController>(
                          id: 'IsTap',
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(left: 15.w,right: 15.w),
                              child: CustomBtn(
                                onTap: ()=> otpController.goBackOnTap(),
                                fontSize: 18.sp,
                                radius: 10.r,
                                bgColor: AppColors.white,
                                borderColor: AppColors.primaryColor,
                                title: AppStrings.goBack,
                                textColor: AppColors.primaryColor,
                              ),
                            );
                          }
                        )
                      ],
                    )
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
