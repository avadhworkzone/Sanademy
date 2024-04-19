import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_enum.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/profile_screen_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenViewModel profileScreenViewModel =
      Get.put(ProfileScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          titleWidget: commonBackArrowAppBar(
            titleTxt: AppStrings.profile,
            titleWidgetColor: AppColors.white,
            actionWidget: true,
            horizontalPadding: 5.w,
            actionTitle: AppStrings.save,
            actionTextOnTap: () {
              profileScreenViewModel.isValidate.value = true;
              if (profileScreenViewModel.formKey.value.currentState!
                      .validate() &&
                  profileScreenViewModel
                      .phoneController.value.text.isNotEmpty) {
                Get.back();
              }
            },
            actionWidgetColor: AppColors.white,
            actionWidgetFontWeight: FontWeight.w600,
            actionFontSize: 15.sp,
          ),
          centerTitle: false),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 120.h,
                margin: EdgeInsets.only(bottom: 60.h),
                color: AppColors.primaryColor,
              ),
              Container(
                height: 120.h,
                width: 120.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.white, width: 4.w),
                ),
                child: const NetWorkOcToAssets(
                  imgUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s',
                  boxFit: BoxFit.cover,
                ),
              )
            ],
          ),
          SizeConfig.sH30,
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: profileScreenViewModel.formKey.value,
                child: Column(
                  children: [
                    /// NAME TEXT FIELD
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CommonTextField(
                        textEditController:
                            profileScreenViewModel.nameController.value,
                        validator: ValidationMethod.validateName,
                        regularExpression: RegularExpressionUtils.text,
                        hintText: AppStrings.enterYourName,
                        hintFontWeight: FontWeight.w400,
                        pIcon: Icon(Icons.account_circle_rounded, size: 30.h),
                        validationType: ValidationTypeEnum.name,
                        borderColor: AppColors.black.withOpacity(0.10),
                      ),
                    ),
                    SizeConfig.sH16,

                    /// DATE TEXT FIELD
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextFormField(
                        onTap: () => profileScreenViewModel.selectDate(context),
                        readOnly: true,
                        validator: ValidationMethod.validateDate,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: profileScreenViewModel.dateController.value,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.black,
                            fontFamily: AppConstants.quicksand,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 16.h),
                          filled: true,
                          fillColor: AppColors.white,
                          hintText: AppStrings.dateFormat.tr,
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
                    ),
                    SizeConfig.sH16,

                    /// PHONE NUMBER TEXTFIELD
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: IntlPhoneField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller:
                              profileScreenViewModel.phoneController.value,
                          initialCountryCode: 'IQ',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (val) {
                            if (val.toString().isNotEmpty) {
                              profileScreenViewModel.isValidate.value = false;
                            }
                          },
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.black,
                              fontFamily: AppConstants.quicksand,
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            fillColor: AppColors.white,
                            filled: true,
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
                                (profileScreenViewModel.isValidate.value ==
                                            true &&
                                        profileScreenViewModel
                                            .phoneController.value.text.isEmpty)
                                    ? '* Required'.tr
                                    : null,
                            errorBorder: (profileScreenViewModel
                                            .isValidate.value ==
                                        true &&
                                    profileScreenViewModel
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
                              borderSide: BorderSide(
                                  width: 1.0, color: AppColors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                    SizeConfig.sH10,

                    /// Address TextFiled
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CommonTextField(
                        textEditController:
                            profileScreenViewModel.addressController.value,
                        validator: ValidationMethod.validateAddress,
                        regularExpression: RegularExpressionUtils.address,
                        hintText: AppStrings.enterAddress,
                        hintFontWeight: FontWeight.w400,
                        pIcon: Icon(Icons.location_on_sharp, size: 30.h),
                        validationType: ValidationTypeEnum.address,
                        borderColor: AppColors.black.withOpacity(0.10),
                      ),
                    ),
                    SizeConfig.sH16,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomBtn(
                        onTap: () {},
                        title: null,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        bgColor: AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              blurRadius: 4.0)
                        ],
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizeConfig.sW10,
                            LocalAssets(
                              imagePath: AppImageAssets.facebookIcn,
                              height: 30.h,
                              width: 50.w,
                            ),
                            SizeConfig.sW10,
                            CustomText(
                              AppStrings.connectWithFaceBook,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: AppColors.black02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizeConfig.sH16,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomBtn(
                        onTap: () {},
                        title: null,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        bgColor: AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              blurRadius: 4.0)
                        ],
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizeConfig.sW10,
                            LocalAssets(
                              imagePath: AppImageAssets.instagramIcn,
                              height: 30.h,
                              width: 50.w,
                            ),
                            SizeConfig.sW10,
                            CustomText(
                              AppStrings.connectWithInstagram,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: AppColors.black02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizeConfig.sH16,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
