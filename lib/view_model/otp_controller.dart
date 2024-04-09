import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController{


  TextEditingController pinPutController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void verifyOnTap(){
    if(formKey.currentState!.validate()){
      print("asdfxgchj=======>");
    }
  }

  void goBackOnTap(){
   Get.back();
  }
}