import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_profile_res_model.dart';
import 'package:sanademy/networks/services/apiService/profile_api_service.dart';
import 'package:sanademy/networks/services/apiService/update_profile_api_service.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class ProfileScreenViewModel extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isValidate = false.obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  ImagePicker picker = ImagePicker();
  Rx<File> imgFile = File('').obs;
  RxString phoneCode = ''.obs;
  RxString countryCode = ''.obs;

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
      imgFile.value = File(pickedFile.path);

      /// FOR HIDING BOTTOM SHEET
      Get.back();
    }
  }

  /// CAll API FOR GET AND SHOW DATA
  Future<void> getProfileList() async {
    final response = await ProfileService().profileRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetProfileResModel getProfileResModel =
          getProfileResModelFromJson(response.response.toString());
      if (getProfileResModel.data != null) {
        nameController.value.text = getProfileResModel.data!.name ?? '';
        phoneController.value.text = getProfileResModel.data!.phoneNumber ?? '';
        dateController.value.text = DateFormat('MM-dd-yyyy').format(DateTime.parse(getProfileResModel.data!.dateOfBirth.toString()));
        phoneCode.value = getProfileResModel.data?.phoneCode ?? '';
        countryCode.value = phoneCode.value.replaceAll('+', '');
        print('phoneCode.value==>${getProfileResModel.data?.phoneCode}');
        print('phoneCode.value==>${countryCode..value}');
        responseStatus.value = ResponseStatus.Completed;
      } else {
        showErrorSnackBar('', getProfileResModel.message.toString());
        responseStatus.value = ResponseStatus.Error;
      }
    }
  }

  /// FOR FORMATTED DATE
  String formatDate(String dateString) {
    List<String> dateComponents = dateString.split('/');
    int day = int.parse(dateComponents[1]);
    int month = int.parse(dateComponents[0]);
    int year = int.parse(dateComponents[2]);
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
  /// CALL API FOR UPDATE PROFILE
  void updateProfile(){
    unFocus();
    /// FOR PASS BODY
    Map<String, dynamic> queryParams = {
      ApiKeys.name: nameController.value.text.trim(),
      ApiKeys.dateOfBirth: formatDate(dateController.value.text),
      ApiKeys.phoneCode: "+${countryCode.value}",
      ApiKeys.phoneNumber: phoneController.value.text,
    };
  final response = UpdateProfileService().updateProfileRepo(mapData: queryParams);
    // if (checkStatusCode(response!.statusCode ?? 0)) {}
  // print(response);
}
}
