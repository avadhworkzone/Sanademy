import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/loading_dialog.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

class OtpViewModel extends GetxController {
  /// OTP FIELD CONTROLLER
  Rx<TextEditingController> pinPutController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  // RxString code = ''.obs;

  ///COUNT DOWN TIMER FOR OTP
  Rx<Timer?>? countdownTimer =
      Timer.periodic(const Duration(seconds: 1), (timer) {}).obs;
  Rx<Duration> myDuration = const Duration(seconds: 60).obs;

  void startTimer() {
    countdownTimer!.value =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    countdownTimer!.value!.cancel();
  }

  Future<void> resetTimer() async {
    stopTimer();
    myDuration.value = const Duration(seconds: 60);
    startTimer();
  }

  void setCountDown() {
    int seconds = myDuration.value.inSeconds - 1;
    if (seconds < 0) {
      stopTimer();
    } else {
      myDuration.value = Duration(seconds: seconds);
    }
  }

  // Future<void> verifyOtp(BuildContext context,String verificationIDFinal) async {
  //   try{
  //     showLoadingDialog(context: context);
  //     final FirebaseAuth auth = FirebaseAuth.instance;
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationIDFinal, smsCode: code.value);
  //     await auth.signInWithCredential(credential);
  //     hideLoadingDialog(context: context);
  //     showSussesSnackBar('', 'Registration Successfully');
  //     Get.offAll(const BottomBar());
  //   }on FirebaseAuthException catch (e) {
  //     hideLoadingDialog(context: context);
  //     if (e.code == "invalid-verification-code") {
  //     } else {
  //       showErrorSnackBar('', e.toString());
  //     }
  //   }
  // }
 /* void setCountDown() {
    Rx<int> reduceSecondsBy = 1.obs;

    Rx<int> seconds1 = (myDuration.value.inSeconds - reduceSecondsBy.value).obs;
    if (seconds1 < 0) {
      countdownTimer!.value!.cancel();
    } else {
      myDuration.value = Duration(seconds: seconds1.value);
    }
  }*/

  Rx<String> strDigits(int n) => n.toString().padLeft(2, '0').obs;

}


