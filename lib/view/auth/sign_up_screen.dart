import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          CommonTextField(
            textEditController: firstNameController,
            regularExpression: RegularExpressionUtils.alphabetPattern,
            hintText: AppStrings.enterYourName.tr,
            isValidate: true,
            onChange: (firstNameData) {
              // createAccountController.isAllFieldInput();
            },
          ),
InkWell(
    onTap: (){
      Get.updateLocale(Locale('en_US'));
    },
    child: Text('english')),
InkWell(
    onTap: (){
      Get.updateLocale(Locale('ckb_KU'));
    },
    child: Text('kurdish')),

        ],
      ),
    );
  }
}
