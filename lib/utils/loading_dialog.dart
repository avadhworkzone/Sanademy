import 'package:flutter/material.dart';
import 'package:sanademy/utils/app_colors.dart';

void showLoadingDialog({
  @required BuildContext? context,
  Color? barrierColor,
}) {
  Future.delayed(Duration(seconds: 0), () {
    showDialog(
        context: context!,
// barrierColor: barrierColor ?? AppColors.textColorWhite.withOpacity(0.50),
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
        });
  });
}

void hideLoadingDialog({BuildContext? context}) {
  Navigator.pop(context!, false);
}
