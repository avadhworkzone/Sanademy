import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/register_res_model.dart';
import 'package:sanademy/networks/services/apiService/sign_up_service.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/auth/otp_screen.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

class SignUpViewModel extends GetxController {
  /// TEXT EDITING CONTROLLER

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> signUpPhoneController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> signUpFormKey = GlobalKey<FormState>().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool signUpIsValidate = false.obs;
  RxString countryCode = ''.obs;

  // RxString userOtp = ''.obs;
  RxInt userOtp = 0.obs;

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

  String formatDate(String dateString) {
    List<String> dateComponents = dateString.split('/');
    int day = int.parse(dateComponents[1]);
    int month = int.parse(dateComponents[0]);
    int year = int.parse(dateComponents[2]);
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  ///Register API CALLING AND VALIDATION....
  Future<void> registerViewModel({
    required num step,
  }) async {
    if (nameController.value.text.isEmpty) {
      showErrorSnackBar(AppStrings.name, AppStrings.nameIsRequired);
      return;
    } else {
      unFocus();

      ///new....
      Map<String, dynamic> queryParams = {
        ApiKeys.name: nameController.value.text.trim(),
        ApiKeys.dateOfBirth: formatDate(dateController.value.text),
        ApiKeys.phoneCode: "+${countryCode.value}",
        ApiKeys.phoneNumber: signUpPhoneController.value.text,
        ApiKeys.step: step.toString(),
      };

      final response =
          await SignUpService().registrationRepo(mapData: queryParams);

      if (checkStatusCode(response!.statusCode ?? 0)) {
        RegisterResModel registerResModel =
            registerResModelFromJson(response.response.toString());
        if (registerResModel.success!) {
          if (registerResModel.data != null) {
            userOtp.value = registerResModel.data!.otp ?? 0;
            await showSussesSnackBar('', registerResModel.message ?? 'SUCCESS');
            if(step == 1){
              Get.to(() => const OtpScreen());
            }else{
              if(registerResModel.data!.token != null ){
                await SharedPreferenceUtils.setToken(registerResModel.data!.token ?? '');
                print('get token =====<.> ${SharedPreferenceUtils.getToken()}');
                Get.offAll(() => const BottomBar());
              }
            }
          }
        } else {
          showSussesSnackBar('', registerResModel.message ?? 'ERROR');
        }
      }
    }
  }
}
