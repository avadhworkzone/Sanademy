import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class ConnectivityViewModel extends GetxController {
  ///======================AppVersionRepo View Model=====================
  final Connectivity _connectivity = Connectivity();
  RxBool? isOnline = false.obs;
  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen(
      (
        ConnectivityResult result,
      ) async {
        if (result == ConnectivityResult.none) {
          isOnline!.value = false;
        } else {
          await _updateConnectionStatus().then(
            (bool isConnected) {
              isOnline!.value = isConnected;
            },
          );
        }
      },
    );
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
        isOnline!.value = false;
      } else {
        isOnline!.value = true;
      }
    } on PlatformException catch (e) {
      logs("PlatformException: $e");
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool? isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected!;
  }

  bool checkInternetConnection() {
    if (isOnline?.value == false) {
      Get.dialog(
          barrierDismissible: true,
          Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CustomText(
                      "No Internet Connection",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizeConfig.sH10,
                  // Image.asset(
                  //   AppImageAssets.noInternet,
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const CustomText(
                      "Please check your connection again,or connect to wi-fi.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ));
      return false;
    } else {
      return true;
    }
  }
}
