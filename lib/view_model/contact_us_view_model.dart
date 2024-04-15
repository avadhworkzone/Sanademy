import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';

class ContactUsViewModel extends GetxController{

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> messageController = TextEditingController().obs;
  RxBool isValidate = false.obs;

}