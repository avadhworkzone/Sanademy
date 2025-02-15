import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/loading_dialog.dart';
import 'package:sanademy/view/auth/log_in_screen.dart';
import 'package:sanademy/view/auth/otp_screen.dart';

Future<bool?> sendOtp({
  required String phoneNumber,
  required BuildContext context,
  required String countryCode,
  required String countryTxtCode,
}) async {
  showLoadingDialog(context: context);
  FirebaseAuth auth = FirebaseAuth.instance;
  phoneCodeSent(String verificationID, [int? forceResendInToken]) {
    hideLoadingDialog(context: context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => OtpScreen(
                verificationIDFinal: verificationID,
                countryTxtCode: countryTxtCode,
                phoneNumber: phoneNumber,
                countryCode: countryCode,
              )),
    );
  }

  try {
    await auth.verifyPhoneNumber(
        phoneNumber: "+$countryCode $phoneNumber",
        timeout: const Duration(seconds: 59),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException exception) {},
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {});
  } catch (e) {
    showErrorSnackBar('', AppStrings.somethingWantWrong);
  }
  return null;
}

Future<bool?> loginSendOtp({
  required String phoneNumber,
  required BuildContext context,
  required String countryCode,
  required String countryTxtCode,
}) async {
  showLoadingDialog(context: context);
  FirebaseAuth auth = FirebaseAuth.instance;
  phoneCodeSent(String verificationID, [int? forceResendInToken]) {
    hideLoadingDialog(context: context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LogInScreen(
                verificationIDFinal: verificationID,
                isSendOtp: true,
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                countryTxtCode: countryTxtCode,
              )),
    );
  }

  try {
    await auth.verifyPhoneNumber(
        phoneNumber: "+$countryCode $phoneNumber",
        timeout: const Duration(seconds: 59),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException exception) {
        },
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {});
  } catch (e) {
    showErrorSnackBar('', AppStrings.somethingWantWrong);
  }
  return null;
}
