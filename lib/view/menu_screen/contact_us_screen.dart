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
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/menu_screen/common_contact_us_widget.dart';
import 'package:sanademy/view_model/contact_us_view_model.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  ContactUsViewModel contactUsViewModel = Get.put(ContactUsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        centerTitle: false,
        appBarBackgroundColor: AppColors.white,
        titleWidget: commonBackArrowAppBar(
          horizontalPadding: 0.w,
            titleTxt: AppStrings.contactUs, actionWidget: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.sH15,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomText(
                AppStrings.getInTouch,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: AppColors.black1D,
              ),
            ),
            SizeConfig.sH10,
            CommonContactUsWidget(
              imagePath: AppImageAssets.locationIcn,
              titleTxt: AppStrings.location,
              subTitleTxt: '2118 Thornridge Cir. Syracuse, Connecticut',
            ),
            CommonContactUsWidget(
              imagePath: AppImageAssets.phoneNumberImg,
              titleTxt: AppStrings.phoneNumber,
              subTitleTxt: '+98 309 420 7045',
            ),
            CommonContactUsWidget(
              imagePath: AppImageAssets.emailAddressImg,
              titleTxt: AppStrings.emailAddress,
              subTitleTxt: 'Info@sanademy.net',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: CustomText(
                AppStrings.writeUsDirectly,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: AppColors.black1D,
              ),
            ),

            /// NAME TEXTFIELD
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CommonTextField(
                textEditController: contactUsViewModel.nameController.value,
                validator: ValidationMethod.validateName,
                regularExpression: RegularExpressionUtils.text,
                hintText: AppStrings.enterYourName,
                hintFontWeight: FontWeight.w400,
                pIcon: Icon(Icons.account_circle_rounded, size: 30.h),
                validationType: ValidationTypeEnum.name,
                borderColor: AppColors.black.withOpacity(0.10),
              ),
            ),

            /// PHONE NUMBER TEXTFIELD
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: IntlPhoneField(
                  controller: contactUsViewModel.phoneController.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (val) {
                    if (val.toString().isNotEmpty) {
                      contactUsViewModel.isValidate.value = false;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: AppColors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
                    hintText: AppStrings.enterYourPhoneNumber.tr,
                    hintStyle: TextStyle(
                      color: AppColors.black12,
                      fontSize: 14.sp,
                      fontFamily: AppConstants.quicksand,
                      fontWeight: FontWeight.w400,
                    ),
                    errorText: (contactUsViewModel.isValidate.value == true &&
                            contactUsViewModel
                                .phoneController.value.text.isEmpty)
                        ? '* Required'.tr
                        : null,
                    errorBorder: (contactUsViewModel.isValidate.value == true &&
                            contactUsViewModel
                                .phoneController.value.text.isEmpty)
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.red),
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
              ),
            ),

            /// WRITE MESSAGE TEXTFIELD

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                controller: contactUsViewModel.messageController.value,
                maxLines: 5,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                  hintText: AppStrings.writeMessage.tr,
                  fillColor: AppColors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: AppColors.black12,
                    fontSize: 14.sp,
                    fontFamily: AppConstants.quicksand,
                    fontWeight: FontWeight.w400,
                  ),
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
                    borderSide: BorderSide(width: 1.0, color: AppColors.black),
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
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: CustomBtn(
                onTap: () {},
                title: AppStrings.submit,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                bgColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
