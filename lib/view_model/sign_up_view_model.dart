import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/register_res_model.dart';
import 'package:sanademy/networks/services/apiService/sign_up_api_service.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/loading_dialog.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

import '../view/auth/send_otp_method.dart';

class SignUpViewModel extends GetxController {
  /// TEXT EDITING CONTROLLER

  Rx<TextEditingController> signUpNameController = TextEditingController().obs;
  Rx<TextEditingController> signUpDateController = TextEditingController().obs;
  Rx<TextEditingController> signUpPhoneController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> signUpFormKey = GlobalKey<FormState>().obs;
  Rx<DateTime> signUpSelectedDate = DateTime.now().obs;
  RxBool signUpIsValidate = false.obs;
  RxString signUpPhoneCode = '964'.obs;
  RxString signUpCountryCode = 'IQ'.obs;
  RxInt signUpUserOtp = 0.obs;
  RxString code = ''.obs;
  String deviceToken = '';

  /// GET TOKEN
  void getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await messaging.getToken().then((token) {
        deviceToken = token!;
      });
      print('token is $deviceToken');
    }
  }


  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: signUpSelectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });

    if (picked != null && picked != signUpSelectedDate.value) {
      String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      signUpDateController.value.text = formattedDate;
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

 /* Future<void> verifyOtp(BuildContext context, String verificationIDFinal) async {
    try {
      showLoadingDialog(context: context);
      final FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verificationIDFinal, smsCode: code.value);
      await auth.signInWithCredential(credential);
      hideLoadingDialog(context: context);
      showSussesSnackBar('', 'Registration Successfully');
      Get.offAll(const BottomBar());
    } on FirebaseAuthException catch (e) {
      hideLoadingDialog(context: context);
      if (e.code == "invalid-verification-code") {
      } else {
        showErrorSnackBar('', e.toString());
      }
    }
  }*/

  ///Register API CALLING AND VALIDATION....
  Future<void> registerViewModel(
      {required num step, required BuildContext context, String verificationIDFinal = ''}) async {
    unFocus();

    ///new....
    Map<String, dynamic> queryParams = {
      ApiKeys.name: signUpNameController.value.text.trim(),
      ApiKeys.dateOfBirth: formatDate(signUpDateController.value.text),
      ApiKeys.phoneCode: "+${signUpPhoneCode.value}",
      ApiKeys.phoneNumber: signUpPhoneController.value.text,
      ApiKeys.countryCode: signUpCountryCode.value,
      ApiKeys.step: step.toString(),
      ApiKeys.deviceType: deviceToken,
      ApiKeys.deviceToken: Platform.isAndroid ? AppStrings.android : AppStrings.iPhone,
    };

    final response = await SignUpService().registrationRepo(mapData: queryParams);

    if (checkStatusCode(response!.statusCode ?? 0)) {
      RegisterResModel registerResModel = registerResModelFromJson(response.response.toString());
      if (registerResModel.success!) {
        if (registerResModel.data != null) {
          // signUpUserOtp.value = registerResModel.data!.otp ?? 0;
          // await showSussesSnackBar('', registerResModel.message ?? 'SUCCESS');
          if (step == 1) {
            sendOtp(
                phoneNumber: signUpPhoneController.value.text,
                context: context,
                countryCode: signUpPhoneCode.value,
                countryTxtCode: signUpCountryCode.value);
            // Get.to(() => const OtpScreen());
          } else {
            if (registerResModel.data!.token != null) {
              try {
                showLoadingDialog(context: context);
                final FirebaseAuth auth = FirebaseAuth.instance;
                PhoneAuthCredential credential =
                    PhoneAuthProvider.credential(verificationId: verificationIDFinal, smsCode: code.value);
                await auth.signInWithCredential(credential);
                hideLoadingDialog(context: context);
                showSussesSnackBar('', registerResModel.message.toString());
                await SharedPreferenceUtils.setToken(registerResModel.data!.token ?? '');
                Get.offAll(const BottomBar());
              } on FirebaseAuthException catch (e) {
                hideLoadingDialog(context: context);
                if (e.code == "invalid-verification-code") {
                } else {
                  showErrorSnackBar('', e.toString());
                }
              }
            }
          }
        }
      } else {
        showSussesSnackBar('', registerResModel.message ?? 'ERROR');
      }
    }
  }
}
