import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{


  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
 bool isValidate = true;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      String date = "${picked.month}/${picked.day}/${picked.year}";
      dateController.text = date;
    }
  }

  void submitOnTap(){
    if(formKey.currentState!.validate()){
      print("move Otp Page===========>");
    }
  }

}