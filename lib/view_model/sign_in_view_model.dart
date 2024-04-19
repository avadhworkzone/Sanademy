import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInViewModel extends GetxController {
  Rx<TextEditingController> signInPhoneController = TextEditingController().obs;
  RxBool showContainer = false.obs;
  final Rx<GlobalKey<FormState>> signInFormKey = GlobalKey<FormState>().obs;
  RxBool signInIsValidate = false.obs;
}
