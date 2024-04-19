import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsViewModel extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> messageController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  RxBool isValidate = false.obs;
}
