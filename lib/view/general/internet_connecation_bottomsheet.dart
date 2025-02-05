import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart'; // For checking internet connectivity

void showConnectivityBottomSheet(BuildContext context) {
  int _counter = 5; // 5 seconds countdown
  bool _isDialogShown = false; // Whether the dialog is shown or not
  Timer? _timer; // Timer to count down

  // Function to check internet connection
  Future<void> _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // Handle no connection
      print("No internet connection");
    } else {
      // Handle internet connection
      print("Connected to the internet");
    }
  }

  // Start countdown timer
  void _startCountdown(Function updateState) {
    _counter = 5; // Reset counter to 5 seconds
    _timer?.cancel(); // Cancel any existing timer before starting a new one
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        updateState(() {
          _counter--;
        });
      } else {
        _checkConnection();
        _timer?.cancel();
        updateState(() {
          _counter = 5; // Reset counter to 5 seconds
        });
        _startCountdown(updateState); // Stop the timer
      }
    });
  }

  // Show the bottom sheet
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          // Start countdown when the bottom sheet opens
          if (!_isDialogShown) {
            _isDialogShown = true;
            _startCountdown((update) {
              setState(() {
                update();
              });
            });
          }

          return WillPopScope(
            onWillPop: () async {
              return true; // Allow back button to close the bottom sheet
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.70,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 20.h,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LocalAssets(
                      imagePath: AppImageAssets.wifiImage,
                      // height: 70.h,
                      scaleSize: 8.h,
                    ), // Custom icon (wifi image)
                    SizedBox(height: 50.h),
                    CustomText(
                      textAlign: TextAlign.center,
                      AppStrings.internetConnectionNotAvailable,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 150.h),
                    CustomText(
                      "${AppStrings.retryingIn} $_counter",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 20.h),
                    CustomUpdateBtn(
                      width: 400.w,
                      onTap: _checkConnection,
                      title: AppStrings.retryNow,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
