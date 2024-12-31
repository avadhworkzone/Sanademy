import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/login_res_model.dart';
import 'package:sanademy/networks/services/apiService/sign_in_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/loading_dialog.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/auth/send_otp_method.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

class SignInViewModel extends GetxController {
  Rx<TextEditingController> signInPhoneController = TextEditingController().obs;
  RxBool showContainer = false.obs;
  final Rx<GlobalKey<FormState>> signInFormKey = GlobalKey<FormState>().obs;
  RxBool signInIsValidate = false.obs;
  RxString countryLoginCode = '964'.obs;
  RxString phoneLoginCode = 'IQ'.obs;
  RxInt userLoginOtp = 0.obs;
  RxString code = ''.obs;


  ///LOGIN API CALLING AND VALIDATION....
  Future<void> loginViewModel({
    required num step,
    required BuildContext context,
    String verificationIDFinal = ''
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
          if(step == 1){
            showContainer.value = true;
            loginSendOtp(
                context: context,
                countryCode: phoneLoginCode.value,
                phoneNumber: signInPhoneController.value.text,
              countryTxtCode: countryLoginCode.value
            );
          }else{
            if (loginResModel.data!.token != null) {
              try {
                showLoadingDialog(context: context);
                final FirebaseAuth auth = FirebaseAuth.instance;
                PhoneAuthCredential credential =
                PhoneAuthProvider.credential(verificationId: verificationIDFinal, smsCode: code.value);
                await auth.signInWithCredential(credential);
                hideLoadingDialog(context: context);
                showSussesSnackBar('', loginResModel.message ?? 'SUCCESS');
                await SharedPreferenceUtils.setToken(loginResModel.data!.token ?? '');
                Get.offAll(const BottomBar());
              } on FirebaseAuthException catch (e) {
                hideLoadingDialog(context: context);
              }
            }

          }
        }
      } else {
        showErrorSnackBar('', loginResModel.message ?? 'ERROR');
      }

    }

  }

}
