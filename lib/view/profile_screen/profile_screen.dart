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
import 'package:sanademy/utils/enum_utils.dart';
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
                  profileScreenViewModel.updateProfile();
                }
              },
              actionWidgetColor: AppColors.white,
              actionWidgetFontWeight: FontWeight.w600,
              actionFontSize: 15.sp,
            ),
            centerTitle: false),
        body:
            // Obx(() => profileScreenViewModel.responseStatus.value ==
            //         ResponseStatus.Error
            //     ?  Center(
            //         child: Text(AppStrings.error),
            //       )
            //     : profileScreenViewModel.responseStatus.value ==
            //             ResponseStatus.Completed
            //         ?
            Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 100.h,
                  margin: EdgeInsets.only(bottom: 60.h),
                  color: AppColors.primaryColor,
                ),
                GestureDetector(
                  onTap: () => showBottomSheet(context),
                  child: Container(
                      height: 120.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.white, width: 4.w),
                      ),
                      child: profileScreenViewModel
                              .imgFile.value.path.isNotEmpty
                          ? Image(
                              image: FileImage(
                                  profileScreenViewModel.imgFile.value),
                              fit: BoxFit.cover,
                            )
                          : NetWorkOcToAssets(
                              imgUrl: profileScreenViewModel.newImage.value)),
                ),
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
                          pIcon: const Padding(
                            padding: EdgeInsets.all(12),
                            child: LocalAssets(
                              imagePath: AppImageAssets.userImage,
                            ),
                          ),
                          validationType: ValidationTypeEnum.name,
                          borderColor: AppColors.black.withOpacity(0.10),
                        ),
                      ),
                      SizeConfig.sH16,

                      /// DATE TEXT FIELD
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: TextFormField(
                          onTap: () =>
                              profileScreenViewModel.selectDate(context),
                          readOnly: true,
                          validator: ValidationMethod.validateDate,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:
                              profileScreenViewModel.dateController.value,
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
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(12),
                              child: LocalAssets(
                                imagePath: AppImageAssets.calendarIcon,
                              ),
                            ),
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
                      SizeConfig.sH16,

                      /// PHONE NUMBER TEXTFIELD
                      Padding(
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
                                      : profileScreenViewModel
                                          .countryCode.value;
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
                                (profileScreenViewModel.isValidate.value ==
                                            true &&
                                        profileScreenViewModel
                                            .phoneController.value.text.isEmpty)
                                    ? AppStrings.isRequired.tr
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

                      SizeConfig.sH10,
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          child: DropdownButtonFormField<String>(
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
                                borderSide: BorderSide(color: Colors.red),
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
                                child: Text(
                                  gender,
                                  style: TextStyle(
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
                          )),
                      SizeConfig.sH16,

                      /// Address TextFiled
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CommonTextField(
                          textEditController:
                              profileScreenViewModel.addressController.value,
                          validator: ValidationMethod.validateAddress,
                          regularExpression: RegularExpressionUtils.address,
                          hintText: AppStrings.enterAddress,
                          isValidate: false,
                          hintFontWeight: FontWeight.w400,
                          pIcon: Icon(Icons.location_on_sharp,
                              color: AppColors.black, size: 30.h),
                          // validationType: ValidationTypeEnum.address,
                          borderColor: AppColors.black.withOpacity(0.10),
                        ),
                      ),
                      SizeConfig.sH16,
                      // Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 20.w),
                      //   child: CustomBtn(
                      //     onTap: () {},
                      //     title: null,
                      //     fontSize: 14.sp,
                      //     fontWeight: FontWeight.w700,
                      //     bgColor: AppColors.white,
                      //     boxShadow: const [
                      //       BoxShadow(
                      //           color: Colors.black26,
                      //           offset: Offset(0, 1),
                      //           blurRadius: 4.0)
                      //     ],
                      //     widget: Row(
                      //       mainAxisAlignment:
                      //           MainAxisAlignment.start,
                      //       children: [
                      //         SizeConfig.sW10,
                      //         LocalAssets(
                      //           imagePath: AppImageAssets.facebookIcn,
                      //           height: 30.h,
                      //           width: 50.w,
                      //         ),
                      //         SizeConfig.sW10,
                      //         CustomText(
                      //           AppStrings.connectWithFaceBook,
                      //           fontWeight: FontWeight.w700,
                      //           fontSize: 15.sp,
                      //           color: AppColors.black02,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizeConfig.sH16,
                      // Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 20.w),
                      //   child: CustomBtn(
                      //     onTap: () {},
                      //     title: null,
                      //     fontSize: 14.sp,
                      //     fontWeight: FontWeight.w700,
                      //     bgColor: AppColors.white,
                      //     boxShadow: const [
                      //       BoxShadow(
                      //           color: Colors.black26,
                      //           offset: Offset(0, 1),
                      //           blurRadius: 4.0)
                      //     ],
                      //     widget: Row(
                      //       mainAxisAlignment:
                      //           MainAxisAlignment.start,
                      //       children: [
                      //         SizeConfig.sW10,
                      //         LocalAssets(
                      //           imagePath:
                      //               AppImageAssets.instagramIcn,
                      //           height: 30.h,
                      //           width: 50.w,
                      //         ),
                      //         SizeConfig.sW10,
                      //         CustomText(
                      //           AppStrings.connectWithInstagram,
                      //           fontWeight: FontWeight.w700,
                      //           fontSize: 15.sp,
                      //           color: AppColors.black02,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizeConfig.sH16,
                    ],
                  ),
                ),
              ),
            )
          ],
        )
        // : Material();
        );
  }

  /// bottom sheet for picking a profile picture for user

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: Get.height * .03, bottom: Get.height * .05),
            children: [
              Text(AppStrings.pickProfilePicture,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height * .02),

              /// Buttons
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  children: [
                    /// FOR PIC IMAGE FROM CAMERA
                    Row(
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                        ),
                        SizeConfig.sW10,
                        InkWell(
                          onTap: () =>
                              profileScreenViewModel.pickImageFromGallery(),
                          child: CustomText(
                            AppStrings.pickFromGallery,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    SizeConfig.sH20,

                    /// FOR PIC IMAGE FROM GALLERY
                    Row(
                      children: [
                        LocalAssets(
                          imagePath: AppImageAssets.galleryImg,
                          height: 30.h,
                          width: 30.w,
                        ),
                        SizeConfig.sW15,
                        InkWell(
                          onTap: () =>
                              profileScreenViewModel.pickImageFromCamera(),
                          child: CustomText(
                            AppStrings.pickFromCamera,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
