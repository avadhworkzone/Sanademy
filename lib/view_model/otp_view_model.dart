import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpViewModel extends GetxController {
  /// OTP FIELD CONTROLLER
  Rx<TextEditingController> pinPutController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  /// COUNT DOWN TIMER FOR OTP
  Rx<Duration> myDuration = const Duration(seconds: 60).obs;
  Timer? countdownTimer;

  @override
  void onInit() {
    super.onInit();
    // Initialize the controller if needed
    pinPutController.value = TextEditingController();
  }

  void startTimer() {
    /// Start a new timer only if it hasn't been started
    if (countdownTimer == null || !countdownTimer!.isActive) {
      countdownTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    }
  }

  void stopTimer() {
    countdownTimer?.cancel();
  }

  Future<void> resetTimer() async {
    stopTimer();
    myDuration.value = const Duration(seconds: 60); // Reset the timer duration
    startTimer();
  }

  void setCountDown() {
    int seconds = myDuration.value.inSeconds - 1;
    if (seconds < 0) {
      stopTimer(); // Stop the timer when it reaches 0
    } else {
      myDuration.value = Duration(seconds: seconds); // Update the duration
    }
  }

  // Helper to format digits like 01, 02, 03 etc.
  Rx<String> strDigits(int n) => n.toString().padLeft(2, '0').obs;
}
