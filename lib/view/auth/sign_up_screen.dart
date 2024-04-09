import 'package:flutter/material.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/i18n/i18n.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';

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
            hintText: AppStrings.enterYourName.i18n,
            isValidate: true,
            onChange: (firstNameData) {
              // createAccountController.isAllFieldInput();
            },
          ),
          InkWell(
              onTap: ()  {
                SharedPreferenceUtils.setLangCode('en');
                SharedPreferenceUtils.setLanguageDes('English');   Locale('en');
              },
              child: const Text('en')),
          const SizedBox(height: 50,),
          InkWell(
              onTap: ()  {
                 SharedPreferenceUtils.setLangCode('ku');
                 SharedPreferenceUtils.setLanguageDes('Kurdish');   Locale('ku');
                print('SharedPreferenceUtils=--->>${SharedPreferenceUtils.getLangCode()}');
              },
              child: const Text('ckb')),
        ],
      ),
    );
  }
}
