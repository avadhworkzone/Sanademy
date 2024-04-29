// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_colors.dart';

class ProgressDialog {
  static var isOpen = false;

  static showProgressDialog(bool showDialog) {
    if (showDialog) {
      isOpen = true;
      if (kDebugMode) {
        print('|--------------->🕙️ Loader start 🕑️<---------------|');
      }

      Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(true),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),
        barrierDismissible: false, /*useRootNavigator: false*/
      );
    } else if (Get.isDialogOpen == true) {
      if (kDebugMode) {
        print('|--------------->🕙️ Loader end 🕑️<---------------|');
      }
      Get.back();
      isOpen = false;
    }
  }
}
