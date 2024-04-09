import 'package:get/get.dart';
import 'package:sanademy/utils/app_snackbar.dart';

/// NOTES : Refer utils class and extension functions for common resource uses

class Logger {
  static var tag = '';
  static var cloud = '☁️';
  static var success = '✅️';
  static var info = '💡';
  static var warning = '🃏️';
  static var error = '💔';

  static var logIcon = '✏️';

  static void printLog({var tag = 'indicator', var printLog = '', var logIcon = 'ℹ️️'}) {
    if (true) {
      Logger.logIcon = logIcon;
      Logger.tag = tag;
      print('${Logger.logIcon}----------------------${Logger.logIcon}');
      print(tag + '\t : ' + printLog);
      print('------------------------------------------------------------------');
    }
  }
}

class Toast {
  static void successMessage(message, {var title = "Success"}) {
    if (!Get.isSnackbarOpen) showErrorSnackBar(title, message);
  }

  static void warningMessage(message) {
    if (!Get.isSnackbarOpen) showErrorSnackBar("Warning!", message);
  }

  // static void errorMessage(message) {
  //   if (!Get.isSnackbarOpen) Get.snackbar("Error", message, backgroundColor: AppColors().errorMessage, colorText: AppColors().kPrimaryTextColor);
  // }

  static void errorMessage(message) {
    // if (!Get.isSnackbarOpen) Get.dialog(LoadingProgressBar(source: ERROR),barrierDismissible: false);
  }
}
