import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

class OtpController extends GetxController{


  Rx<TextEditingController> pinPutController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  void verifyOnTap(){
    if(formKey.value.currentState!.validate()){
      Get.to(()=>BottomBar());
    }
  }

  void goBackOnTap(){
   Get.back();
  }
}