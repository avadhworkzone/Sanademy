import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/common_scrollable_appbar_widget.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_enum.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/profile_screen_view_model.dart';

class NewProfileScreen extends StatefulWidget {
  const NewProfileScreen({super.key});

  @override
  State<NewProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<NewProfileScreen> {
  ProfileScreenViewModel profileScreenViewModel =
      Get.put(ProfileScreenViewModel());
  final List<String> _genders = ['Male', 'Female', 'Other'];

  // Selected gender
  String? _selectedGender;

  @override
  void initState() {
    // getUserDataApiCall();
    super.initState();
  }

  getUserDataApiCall() async {
    await profileScreenViewModel.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: Get.height * 0.300,
            ),
            Stack(
              children: [
                commonUpdateAppBar(
                  isBack: true,
                  isLogoRequired: false,
                  replaceLogoText: "profile",
                  context: context,
                  paddingLeft: 18.w,
                  onTap: () {
                    Get.back();
                  },
                  actionWidget: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(
                              color: AppColors.white.withOpacity(0.5))),
                      child: CustomText("Log Out",
                          color: AppColors.red00,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  otherWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizeConfig.sH35,
                      const CommonScrollableAppbarWidget()
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: Get.width / 2.6,
              top: Get.height * 0.15,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: Get.width * 0.14,
                    backgroundColor: AppColors.yellow,
                    child: CircleAvatar(
                        radius: Get.width * 0.12,
                        backgroundColor: AppColors.white,
                        child: CircleAvatar(
                          radius: Get.width * 0.14,
                          // backgroundColor: ColorUtils.bgrey,
                          backgroundImage: const NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg'),
                        )),
                  ),
                  Positioned(
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 20.sp,
                        color: AppColors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizeConfig.sH10,
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: profileScreenViewModel.formKey.value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: AppStrings.profileCompletion,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                            TextSpan(
                              text: '75%',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.blue34,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///FULL NAME ENG
                    CustomText(
                      AppStrings.fullNameEng,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey73,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextField(
                      textEditController:
                          profileScreenViewModel.nameController.value,
                      validator: ValidationMethod.validateName,
                      regularExpression: RegularExpressionUtils.text,
                      hintText: AppStrings.enterYourName,
                      hintFontWeight: FontWeight.w400,
                      validationType: ValidationTypeEnum.name,
                      borderColor: AppColors.black.withOpacity(0.10),
                    ),
                    SizedBox(height: 12.h),

                    ///FULL NAME KUR
                    CustomText(
                      AppStrings.fullNameKur,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey73,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextField(
                      textEditController:
                          profileScreenViewModel.nameController.value,
                      validator: ValidationMethod.validateName,
                      regularExpression: RegularExpressionUtils.text,
                      hintText: AppStrings.enterYourName,
                      hintFontWeight: FontWeight.w400,
                      validationType: ValidationTypeEnum.name,
                      borderColor: AppColors.black.withOpacity(0.10),
                    ),
                    SizedBox(height: 12.h),

                    ///GENDER
                    CustomText(
                      AppStrings.gender,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey73,
                    ),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 17),
                        hintText: 'Select Gender',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.black12,
                          fontWeight: FontWeight.w400,
                        ),
                        // errorText: _selectedGender == null ? 'Please select a gender' : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.10)),
                        ),
                      ),
                      items: _genders.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(
                            gender,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 12.h),

                    ///BIRTH OF DATE
                    CustomText(
                      AppStrings.birthOfDate,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey73,
                    ),
                    SizedBox(height: 8.h),

                    TextFormField(
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
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(12),
                          child: LocalAssets(
                            imagePath: AppImageAssets.calendarIcon,
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
                    SizedBox(height: 12.h),

                    ///PHONE NUMBER
                    CustomText(
                      AppStrings.phoneNumber,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey73,
                    ),
                    SizedBox(height: 8.h),
                    IntlPhoneField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: profileScreenViewModel.phoneController.value,
                      initialCountryCode:
                          profileScreenViewModel.countryCode.value == ''
                              ? 'IQ'
                              : profileScreenViewModel.countryCode.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (val) {
                        if (val.toString().isNotEmpty) {
                          profileScreenViewModel.isValidate.value = false;
                          var countryCode =
                              profileScreenViewModel.countryCode.value == ''
                                  ? 'IQ'
                                  : profileScreenViewModel.countryCode.value;
                          if (countryCode == 'IQ') {
                            if (val.number.startsWith('0')) {
                              profileScreenViewModel.phoneController.value
                                  .text = val.number.replaceFirst('0', '');
                              // profileScreenViewModel.phoneController.value.selection =
                              // TextSelection.fromPosition(TextPosition(
                              // offset: profileScreenViewModel.phoneController.value.text.length));
                            }
                          }
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
                            (profileScreenViewModel.isValidate.value == true &&
                                    profileScreenViewModel
                                        .phoneController.value.text.isEmpty)
                                ? AppStrings.isRequired.tr
                                : null,
                        errorBorder:
                            (profileScreenViewModel.isValidate.value == true &&
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
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
