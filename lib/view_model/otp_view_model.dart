import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

class OtpController extends GetxController{


  TextEditingController pinPutController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void verifyOnTap(){
    if(formKey.currentState!.validate()){
      Get.to(()=>BottomBar());
      print("asdfxgchj=======>");
    }
  }

  void goBackOnTap(){
   Get.back();
  }
}