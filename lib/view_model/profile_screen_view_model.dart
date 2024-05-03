
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_profile_res_model.dart';
import 'package:sanademy/networks/model/update_profile_res_model.dart';
import 'package:sanademy/networks/services/apiService/profile_api_service.dart';
import 'package:sanademy/networks/services/apiService/update_profile_api_service.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/view/homeScreen/home_screen.dart';

class ProfileScreenViewModel extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isValidate = false.obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  Rx<File> imgFile = File('').obs;
  RxString phoneCode = ''.obs;
  RxString countryCode = ''.obs;
  RxString newImage = ''.obs;

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
      String date = "${picked.month}/${picked.day}/${picked.year}";
      dateController.value.text = date;
    }
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();

    /// FOR PIC IMAGE FROM GALLERY
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      newImage.value = pickedFile.path;
      imgFile.value=File(pickedFile.path);
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
      imgFile.value=File(pickedFile.path);
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
        dateController.value.text = DateFormat('MM-dd-yyyy').format(
            DateTime.parse(getProfileResModel.data!.dateOfBirth.toString()));
        addressController.value.text = getProfileResModel.data!.address ??'';
        newImage.value=getProfileResModel.data!.image??'';
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
    String? apiDateString =
        dateController.value.text;
    DateTime? apiDate = apiDateString != ''
        ? DateFormat('MM-dd-yyyy').parse(apiDateString)
        : null;
    String formattedDate =
    apiDate != null ? DateFormat('yyyy-MM-dd').format(apiDate):'';
    dio.MultipartFile? file;
   if(imgFile.value.path.isNotEmpty){
   file = await dio.MultipartFile.fromFile(
      newImage.value,
      filename: newImage.value
  );
}


    /// FOR PASS BODY
    Map<String, dynamic> queryParams = {
      ApiKeys.name: nameController.value.text.trim(),
      ApiKeys.dateOfBirth: formattedDate,
      ApiKeys.phoneCode: phoneCode.value,
      ApiKeys.countryCode: countryCode.value,
      ApiKeys.phoneNumber: phoneController.value.text,
      ApiKeys.address: addressController.value.text,
      ApiKeys.image: imgFile.value.path.isNotEmpty?file:null,
    //   dio.FormData.fromMap({
    // "file":
    //  dio.MultipartFile.fromFile(newImage.value, ),
    // })
      // dio.MultipartFile.fromFile(newImage.value),///File(newImage.value),///imgFile.value,
    };

    final response = await UpdateProfileService().updateProfileRepo(mapData: queryParams);

    if (checkStatusCode(response!.statusCode ?? 0)) {
      UpdateProfileResModel updateProfileResModel =
      updateProfileResModelFromJson(response.response.toString());
      if (updateProfileResModel.success!) {
        if (updateProfileResModel.data != null) {
          showSussesSnackBar('', updateProfileResModel.message ?? 'SUCCESS');
          Get.to(HomeScreen());
        }else {
          showSussesSnackBar('', updateProfileResModel.message ?? 'ERROR');
        }
      } else {
        showSussesSnackBar('', updateProfileResModel.message ?? 'ERROR');
      }
    }else {
      showSussesSnackBar('', 'Error updating profile');
    }
  }
}
