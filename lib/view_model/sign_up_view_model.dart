import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_colors.dart';

class SignUpViewModel extends GetxController {
  /// TEXT EDITING CONTROLLER

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> signUpPhoneController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> signUpFormKey = GlobalKey<FormState>().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool signUpIsValidate = false.obs;

  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  const ColorScheme.light(primary: AppColors.primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });

    if (picked != null && picked != selectedDate.value) {
      String date = "${picked.month}/${picked.day}/${picked.year}";
      dateController.value.text = date;
    }
  }
}
