import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/view/auth/otp_screen.dart';

class SignUpViewModel extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isValidate = false.obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1950, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      String date = "${picked.month}/${picked.day}/${picked.year}";
      dateController.value.text = date;
    }
  }

  void intlPhoneFiledOnChange(val) {
    update();
  }

  void submitOnTap() {
    isValidate.value = true;
    if (formKey.value.currentState!.validate() &&
        phoneController.value.text.isNotEmpty) {
      Get.to(const OtpScreen());
    }
    update();
  }
}
