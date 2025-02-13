import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/myProgressScreen/progess_bottom_sheet.dart';
import 'package:sanademy/view_model/profile_screen_view_model.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

class NewProfileScreen extends StatefulWidget {
  const NewProfileScreen({super.key});

  @override
  State<NewProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<NewProfileScreen> {
  ProfileScreenViewModel profileScreenViewModel =
      Get.put(ProfileScreenViewModel());
  final List<String> _genders = ['Male', 'Female', 'Other'];
  SignUpViewModel signUpViewModel = Get.find();

  // Selected gender

  @override
  void initState() {
    getUserDataApiCall();
    super.initState();

    /// Check User Is Login Or Not
    if (SharedPreferenceUtils.getIsLogin() == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        /// Open The Register Dialog
        showLoginBottomSheet(context);
      });
    }

    /// Get Token Api Call
    signUpViewModel.getToken();
  }

  getUserDataApiCall() async {
    // await profileScreenViewModel.getProfileData();
  }

  @override
  void dispose() {
    profileScreenViewModel.nameController.value.clear();
    profileScreenViewModel.nameKurdishController.value.clear();
    profileScreenViewModel.selectedGender.value = "";
    profileScreenViewModel.dateController.value.clear();
    profileScreenViewModel.phoneController.value.clear();
    profileScreenViewModel.selectedCity.value = "";
    profileScreenViewModel.selectedProvince.value = "";
    profileScreenViewModel.completionPercentage.value = 0.0;
    profileScreenViewModel.selectedImage.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.white,
      body: Obx(
        () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Container(height: Get.height * 0.300),

                  ///AppBar Common
                  Padding(
                    padding: EdgeInsets.only(bottom: 70.h),
                    child: commonUpdateAppBar(
                      isBack: false,
                      isLogoRequired: false,
                      replaceLogoText: AppStrings.profile,
                      context: context,
                      paddingLeft: 18.w,
                      onTap: () {
                        Get.back();
                      },
                      actionWidget: Padding(
                        padding: EdgeInsets.only(
                            right: 18.w, left: 8.w, bottom: 10.h),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.w),
                            // alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.24),
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(
                                    color: AppColors.white.withOpacity(0.24))),
                            child: !SharedPreferenceUtils.getIsLogin() == false
                                ? CustomText(
                                    AppStrings.logOut,
                                    color: AppColors.red00,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  )
                                : CustomText(
                                    AppStrings.logIn,
                                    color: AppColors.red00,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                      ),
                      otherWidget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizeConfig.sH40,
                          SizeConfig.sH10,
                          const CommonScrollableAppbarWidget()
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    // left: Get.width / 2.6,
                    // top: 0,
                    top: Get.height * 0.13,
                    // top: Get.height * 0.15,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircularPercentIndicator(
                            radius: 65.0,
                            lineWidth: 10.0,
                            percent: profileScreenViewModel
                                    .completionPercentage.value /
                                100,
                            center: CircleAvatar(
                              radius: 58,
                              // Image radius
                              // backgroundImage: NetworkImage(
                              //     'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg'),
                              backgroundImage:
                                  profileScreenViewModel.selectedImage.value !=
                                          null
                                      ? FileImage(File(profileScreenViewModel
                                          .selectedImage
                                          .value!
                                          .path)) // Display selected image
                                      : const NetworkImage(
                                          'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg',
                                        ) as ImageProvider,
                            ),
                            backgroundColor: AppColors.white,
                            curve: Curves.easeIn,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: AppColors.yellow,
                          ),
                          Positioned(
                            // right: Get.width * 0,
                            right: 0,
                            // top: 0,
                            bottom: Get.width * 0.004,
                            // bottom: 44,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: InkWell(
                                onTap: () async {
                                  await profileScreenViewModel
                                      .showImagePicker(context);
                                  profileScreenViewModel.updateCompletion();
                                },
                                child: Container(
                                  // height: 35.h,
                                  // width: 35.w,
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.borderColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.white),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: LocalAssets(
                                    imagePath: AppImageAssets.cameraIcon,
                                    // ,
                                    scaleSize: 3.5.w,
                                    // color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blue34,
                                      fontFamily: getFontFamily(),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " ${profileScreenViewModel.completionPercentage.value.toStringAsFixed(0)}%",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.blue34,
                                      fontFamily: getFontFamily(),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          ///FULL NAME ENG
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.fullNameEng,
                                  // "Full Name (English) "
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey73,
                                    fontFamily: getFontFamily(),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontFamily: getFontFamily(),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CommonTextField(
                            textEditController:
                                profileScreenViewModel.nameController.value,
                            fillColor: Colors.transparent,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: getFontFamily(),
                            ),
                            onChange: (value) {
                              profileScreenViewModel.updateCompletion();
                            },
                            validator: ValidationMethod.validateName,
                            regularExpression: RegularExpressionUtils.text,
                            hintText: AppStrings.enterYourName,
                            hintFontWeight: FontWeight.w400,
                            validationType: ValidationTypeEnum.name,
                            borderColor: AppColors.black.withOpacity(0.10),
                          ),
                          SizedBox(height: 12.h),

                          ///FULL NAME KUR
                          // CustomText(
                          //   AppStrings.fullNameKur,
                          //   fontWeight: FontWeight.w500,
                          //   color: AppColors.grey73,
                          // ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.fullNameKur,
                                  // "Full Name (English) "
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey73,
                                    fontFamily: getFontFamily(),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontFamily: getFontFamily(),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CommonTextField(
                            textEditController: profileScreenViewModel
                                .nameKurdishController.value,
                            validator: ValidationMethod.validateName,
                            fillColor: Colors.transparent,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: getFontFamily(),
                            ),
                            onChange: (value) {
                              profileScreenViewModel.updateCompletion();
                            },
                            regularExpression: RegularExpressionUtils.text,
                            hintText: AppStrings.enterYourName,
                            hintFontWeight: FontWeight.w400,
                            validationType: ValidationTypeEnum.name,
                            borderColor: AppColors.black.withOpacity(0.10),
                          ),
                          SizedBox(height: 12.h),

                          ///GENDER
                          // CustomText(
                          //   AppStrings.gender,
                          //   fontWeight: FontWeight.w500,
                          //   color: AppColors.grey73,
                          // ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.gender,
                                  // "Full Name (English) "
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: getFontFamily(),
                                    color: AppColors.grey73,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontFamily: getFontFamily(),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          DropdownButtonFormField<String>(
                            value: _genders.contains(
                                    profileScreenViewModel.selectedGender.value)
                                ? profileScreenViewModel.selectedGender.value
                                : null,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                  bottom: 17, left: 15, right: 15, top: 15),
                              hintText: AppStrings.selectGender.tr,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.black12,
                                fontFamily: getFontFamily(),
                                fontWeight: FontWeight.w400,
                              ),
                              hintTextDirection: TextDirection.ltr,
                              // errorText: _selectedGender == null ? 'Please select a gender' : null,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.10)),
                              ),
                            ),
                            items: _genders.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: CustomText(
                                  gender,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue?.isNotEmpty ?? false) {
                                profileScreenViewModel.selectedGender.value =
                                    newValue!;
                              }
                              profileScreenViewModel.updateCompletion();
                            },
                          ),
                          SizedBox(height: 12.h),

                          ///BIRTH OF DATE
                          CustomText(
                            AppStrings.birthOfDate,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColors.grey73,
                          ),
                          SizedBox(height: 8.h),
                          CommonTextField(
                            onTap: () {
                              profileScreenViewModel
                                  .showCupertinoDatePicker(context);
                            },
                            sIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: LocalAssets(
                                height: 20.sp,
                                width: 20.sp,
                                imagePath: AppImageAssets.calenderIcon,
                              ),
                            ),
                            onChange: (value) {
                              profileScreenViewModel.updateCompletion();
                            },

                            hintText: AppStrings.yyyyMMdd,
                            textEditController:
                                profileScreenViewModel.dateController.value,
                            fillColor: Colors.transparent,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.blue34,
                              fontFamily: getFontFamily(),
                              fontWeight: FontWeight.w500,
                            ),
                            // onTap: () => profileScreenViewModel.selectDate(context),
                            readOnly: true,
                            isValidate: false,
                            validator: ValidationMethod.validateDate,
                            regularExpression: '',
                          ),
                          SizedBox(height: 12.h),

                          ///PHONE NUMBER
                          // CustomText(
                          //   AppStrings.phoneNumber,
                          //   fontWeight: FontWeight.w500,
                          //   color: AppColors.grey73,
                          // ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.phoneNumber,
                                  // "Full Name (English) "
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey73,
                                    fontFamily: getFontFamily(),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontFamily: getFontFamily(),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          IntlPhoneField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller:
                                profileScreenViewModel.phoneController.value,
                            initialCountryCode:
                                profileScreenViewModel.countryCode.value == ''
                                    ? 'IQ'
                                    : profileScreenViewModel.countryCode.value,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (val) {
                              if (val.toString().isNotEmpty) {
                                profileScreenViewModel.isValidate.value = false;
                                var countryCode = profileScreenViewModel
                                            .countryCode.value ==
                                        ''
                                    ? 'IQ'
                                    : profileScreenViewModel.countryCode.value;
                                if (countryCode == 'IQ') {
                                  if (val.number.startsWith('0')) {
                                    profileScreenViewModel
                                            .phoneController.value.text =
                                        val.number.replaceFirst('0', '');
                                    // profileScreenViewModel.phoneController.value.selection =
                                    // TextSelection.fromPosition(TextPosition(
                                    // offset: profileScreenViewModel.phoneController.value.text.length));
                                  }
                                }
                              }
                              profileScreenViewModel.updateCompletion();
                            },
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.black,
                                fontFamily: getFontFamily(),
                                fontWeight: FontWeight.w400),
                            flagsButtonPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            dropdownIconPosition: IconPosition.trailing,
                            disableLengthCheck: true,
                            dropdownIcon:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 17.h),
                              hintText: AppStrings.enterYourPhoneNumber.tr,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(12),
                                child: LocalAssets(
                                  height: 20.h,
                                  width: 20.w,
                                  imagePath: AppImageAssets.edit,
                                  imgColor: AppColors.blue34,
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: AppColors.black12,
                                fontSize: 14.sp,
                                fontFamily: getFontFamily(),
                                fontWeight: FontWeight.w400,
                              ),
                              errorText:
                                  (profileScreenViewModel.isValidate.value ==
                                              true &&
                                          profileScreenViewModel.phoneController
                                              .value.text.isEmpty)
                                      ? AppStrings.isRequired.tr
                                      : null,
                              errorBorder: (profileScreenViewModel
                                              .isValidate.value ==
                                          true &&
                                      profileScreenViewModel
                                          .phoneController.value.text.isEmpty)
                                  ? OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.red),
                                      borderRadius: BorderRadius.circular(12.r))
                                  : OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.black.withOpacity(0.10),
                                      )),
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
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // City Dropdown
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      AppStrings.city,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: AppColors.grey73,
                                    ),
                                    SizedBox(height: 8.h),
                                    DropdownButtonFormField<String>(
                                      value: profileScreenViewModel
                                              .selectedCity.value.isEmpty
                                          ? null // Or set it to a valid initial city like 'City 1'
                                          : profileScreenViewModel
                                              .selectedCity.value,
                                      icon: const SizedBox.shrink(),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 14.h),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: LocalAssets(
                                            height: 20.sp,
                                            width: 20.sp,
                                            imagePath:
                                                AppImageAssets.dropDownIcon,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: AppColors.greyE0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: AppColors.greyE0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                      hint: CustomText(
                                        AppStrings.select,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: AppColors.grey73,
                                      ),
                                      items: ['City 1', 'City 2', 'City 3']
                                          .map(
                                            (city) => DropdownMenuItem<String>(
                                              value: city,
                                              child: CustomText(
                                                city,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue?.isNotEmpty ?? false) {
                                          profileScreenViewModel
                                              .selectedCity.value = newValue!;
                                        }
                                        profileScreenViewModel
                                            .updateCompletion();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.w),
                              // Spacing between City and Province
                              // Province Dropdown
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      AppStrings.province,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: AppColors.grey73,
                                    ),
                                    SizedBox(height: 8.h),
                                    DropdownButtonFormField<String>(
                                      value: profileScreenViewModel
                                              .selectedProvince.value.isEmpty
                                          ? null
                                          : profileScreenViewModel
                                              .selectedProvince.value,
                                      icon: const SizedBox.shrink(),
                                      decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: LocalAssets(
                                            height: 20.sp,
                                            width: 20.sp,
                                            imagePath:
                                                AppImageAssets.dropDownIcon,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 14.h),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: AppColors.greyE0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: AppColors.greyE0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                      hint: CustomText(
                                        AppStrings.select,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: AppColors.grey73,
                                      ),
                                      items: [
                                        'Province 1',
                                        'Province 2',
                                        'Province 3'
                                      ]
                                          .map(
                                            (province) =>
                                                DropdownMenuItem<String>(
                                              value: province,
                                              child: CustomText(
                                                province,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue?.isNotEmpty ?? false) {
                                          profileScreenViewModel
                                              .selectedProvince
                                              .value = newValue!;
                                        }
                                        profileScreenViewModel
                                            .updateCompletion();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.h),
                          CustomUpdateBtn(
                            onTap: () {},
                            title: AppStrings.saveDetails,
                            radius: 12.sp,
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
