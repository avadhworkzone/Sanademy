import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpViewModel extends GetxController {
  /// OTP FIELD CONTROLLER
  Rx<TextEditingController> pinPutController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  ///COUNT DOWN TIMER FOR OTP
  Rx<Timer?>? countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {}).obs;
  Rx<Duration> myDuration = const Duration(seconds: 60).obs;

  void startTimer() {
    countdownTimer!.value = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
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

  Rx<String> strDigits(int n) => n.toString().padLeft(2, '0').obs;
}
