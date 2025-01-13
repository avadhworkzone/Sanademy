import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_profile_res_model.dart';
import 'package:sanademy/networks/model/update_profile_res_model.dart';
import 'package:sanademy/networks/services/apiService/profile_api_service.dart';
import 'package:sanademy/networks/services/apiService/update_profile_api_service.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

class ProfileScreenViewModel extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> nameKurdishController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;

  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  HomeScreenViewModel homeScreenViewModel = Get.find();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isValidate = false.obs;
  Rx<double> completionPercentage = 0.0.obs;
  Rx<File> imgFile = File('').obs;
  RxString phoneCode = ''.obs;
  RxString countryCode = ''.obs;
  RxString newImage = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedCity = ''.obs;
  RxString selectedProvince = ''.obs;
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);

  void updateCompletion() {
    double totalPercentage = 0;

    if (nameController.value.text.isNotEmpty) totalPercentage += 10;
    if (nameKurdishController.value.text.isNotEmpty) totalPercentage += 10;
    if (selectedGender.isNotEmpty) totalPercentage += 5;
    if (dateController.value.text.isNotEmpty) totalPercentage += 5;
    if (phoneController.value.text.isNotEmpty) totalPercentage += 20;
    if (selectedCity.value.isNotEmpty && selectedProvince.value.isNotEmpty) totalPercentage += 25;
    if (selectedImage.value != null) totalPercentage += 25;

    // Ensure the total percentage doesn't exceed 100
    totalPercentage = totalPercentage > 100 ? 100 : totalPercentage;

    completionPercentage.value = totalPercentage;

  }

  Future<void> showImagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title:  CustomText(AppStrings.takeAPhoto),
                onTap: () async {
                  final XFile? image = await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    selectedImage.value = image;
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title:  CustomText(AppStrings.chooseFromGallery),
                onTap: () async {
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    selectedImage.value = image;
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  const ColorScheme.light(primary: AppColors.primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate.value) {
      // String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      String formattedDate = DateFormat('yyyy/MM/dd').format(picked);
      dateController.value.text = formattedDate;
      /* String date = "${picked.month}/${picked.day}/${picked.year}";
      dateController.value.text = date;*/
    }
  }

  Future<void> showCupertinoDatePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 300, // Adjust height for the picker
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: CustomText(
                      'Cancel',
                      color: AppColors.borderColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Format the selected date and set it to the controller
                      dateController.value.text =
                          DateFormat(AppStrings.yyyyMMdd).format(
                              selectedDate.value);
                    },
                    child: CustomText(
                      'Done',
                      color: AppColors.borderColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate.value,
                  minimumDate: DateTime(1950, 8),
                  maximumDate: DateTime.now(),
                  dateOrder: DatePickerDateOrder.ymd,
                  onDateTimeChanged: (DateTime date) {
                    selectedDate.value = date;
                  },
                ),
              ),


            ],
          ),
        );
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();

    /// FOR PIC IMAGE FROM GALLERY
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      newImage.value = pickedFile.path;
      imgFile.value = File(pickedFile.path);

      /// FOR HIDING BOTTOM SHEET
      Get.back();
    }
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();

    /// FOR PIC IMAGE FROM CAMERA
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      newImage.value = pickedFile.path;
      imgFile.value = File(pickedFile.path);

      /// FOR HIDING BOTTOM SHEET
      Get.back();
    }
  }

  /// CAll API FOR GET AND SHOW DATA
  Future<void> getProfileData() async {
    final response = await ProfileService().profileRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetProfileResModel getProfileResModel =
          getProfileResModelFromJson(response.response.toString());
      if (getProfileResModel.data != null) {
        nameController.value.text = getProfileResModel.data!.name ?? '';
        phoneController.value.text = getProfileResModel.data!.phoneNumber ?? '';
        dateController.value.text = DateFormat('MM/dd/yyyy').format(
            DateTime.parse(getProfileResModel.data!.dateOfBirth.toString()));
        addressController.value.text = getProfileResModel.data!.address ?? '';
        newImage.value = getProfileResModel.data!.image ?? '';
        await SharedPreferenceUtils.setImage(newImage.value);
        logs(
            'SharedPreferenceUtils.getImage()======${SharedPreferenceUtils.getImage()}');

        phoneCode.value = '';
        phoneCode.value = getProfileResModel.data!.phoneCode ?? '';
        countryCode.value = '';
        countryCode.value = getProfileResModel.data!.countryCode ?? '';
        responseStatus.value = ResponseStatus.Completed;
      } else {
        showErrorSnackBar('', getProfileResModel.message.toString());
        responseStatus.value = ResponseStatus.Error;
      }
    }
  }

  /// CALL API FOR UPDATE PROFILE
  Future<void> updateProfile() async {
    unFocus();
    String? apiDateString = dateController.value.text;
    DateTime? apiDate = apiDateString != ''
        ? DateFormat('MM/dd/yyyy').parse(apiDateString)
        : null;
    String formattedDate =
        apiDate != null ? DateFormat('yyyy/MM/dd').format(apiDate) : '';
    dio.MultipartFile? file;
    if (imgFile.value.path.isNotEmpty) {
      file = await dio.MultipartFile.fromFile(newImage.value,
          filename: newImage.value);
    }

    /// FOR PASS BODY
    Map<String, dynamic> queryParams = {
      ApiKeys.name: nameController.value.text.trim(),
      ApiKeys.dateOfBirth: formattedDate,
      ApiKeys.phoneCode: phoneCode.value,
      ApiKeys.countryCode: countryCode.value,
      ApiKeys.phoneNumber: phoneController.value.text,
      ApiKeys.address: addressController.value.text,
      ApiKeys.image: imgFile.value.path.isNotEmpty ? file : null,
    };

    final response =
        await UpdateProfileService().updateProfileRepo(mapData: queryParams);

    if (checkStatusCode(response!.statusCode ?? 0)) {
      UpdateProfileResModel updateProfileResModel =
          updateProfileResModelFromJson(response.response.toString());
      if (updateProfileResModel.success!) {
        if (updateProfileResModel.data != null) {
          showSussesSnackBar('', updateProfileResModel.message ?? 'SUCCESS');
          // SharedPreferenceUtils.setImage(updateProfileResModel.data!.image.toString());
          homeScreenViewModel
              .updateUserImage(updateProfileResModel.data!.image.toString());
          Get.to(const BottomBar());
        } else {
          showErrorSnackBar('', updateProfileResModel.message ?? 'ERROR');
        }
      } else {
        showErrorSnackBar('', updateProfileResModel.message ?? 'ERROR');
      }
    } else {
      showErrorSnackBar('', 'Error updating profile');
    }
  }
}
