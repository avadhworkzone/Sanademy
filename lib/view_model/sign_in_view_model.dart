import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/login_res_model.dart';
import 'package:sanademy/networks/services/apiService/sign_in_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

class SignInViewModel extends GetxController {
  Rx<TextEditingController> signInPhoneController = TextEditingController().obs;
  RxBool showContainer = false.obs;
  final Rx<GlobalKey<FormState>> signInFormKey = GlobalKey<FormState>().obs;
  RxBool signInIsValidate = false.obs;
  RxString countryLoginCode = '964'.obs;
  RxString phoneLoginCode = 'IQ'.obs;
  RxInt userLoginOtp = 0.obs;

  ///LOGIN API CALLING AND VALIDATION....
  Future<void> loginViewModel({
    required num step,
  }) async {
    unFocus();

    ///new....
    Map<String, String> queryParams = {
      ApiKeys.phoneCode: "+${phoneLoginCode.value}",
      ApiKeys.countryCode: countryLoginCode.value,
      ApiKeys.phoneNumber: signInPhoneController.value.text,
      ApiKeys.step: step.toString(),
    };

    final response = await SignInService().loginRepo(mapData: queryParams);

    if (checkStatusCode(response!.statusCode ?? 0)) {
      LoginResModel loginResModel =
          loginResModelFromJson(response.response.toString());
      if (loginResModel.success == true) {
        if (loginResModel.data != null) {
          userLoginOtp.value = loginResModel.data!.otp ?? 0;
          showSussesSnackBar('', loginResModel.message ?? 'SUCCESS');

          if(step == 1){
            showContainer.value = true;
          }else{
            if(loginResModel.data?.token != null && loginResModel.data?.token.isNotEmpty){
             await SharedPreferenceUtils.setToken(loginResModel.data?.token);
            }
            Get.offAll(() => const BottomBar());
          }
        }
      } else {
        showErrorSnackBar('', loginResModel.message ?? 'ERROR');
      }

    }

  }

}
