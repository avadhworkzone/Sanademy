import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_string.dart';

class RegularExpressionUtils {

  static String alphabetPattern = "[a-zA-Z]";
  static String text = "^[a-zA-Z ]*\$";


  /// capitalCase is used for one capital character is requiter in string
  var capitalCase = RegExp(r'[A-Z]');

  /// smallCase is used for one small character is requiter in string
  var smallCase = RegExp(r'[a-z]');


  /// atLeastOneNumber is used for one number is requiter in string
  var atLeastOneNumber = RegExp(r'[0-9]');

  /// specialCharacters is used for one special characters is requiter in string
  var specialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  static var isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,12}');

  /// minimum password validation
  static var passwordMinLength = 7;

  var whiteSpace = new RegExp("\\s+");
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

/// VALIDATION METHOD
class ValidationMethod {
  /// EMAIL VALIDATION METHOD
  static String? validateEmail(value) {
    bool regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value);
    if (value == null) {
      return AppStrings.emailIsRequired;
    } else if (regex == false) {
      return AppStrings.emailIsRequired;
    }

    return null;
  }

  static String? validateName(value) {
    bool regex = RegExp(RegularExpressionUtils.text).hasMatch(value);
    if (value == null) {
      return AppStrings.nameIsRequired;
    }else if (!regex) {
      return AppStrings.nameIsRequired;
    }
    return null;
  }

  static String? validateDate(value) {
    if (value == null || value.isEmpty) {
      return AppStrings.dateIsRequired;
    }
    return null;
  }

  static String? validatePhone(value) {
    print("sdasdas=====>$value");
    if (value == null || value.isEmpty) {
      return AppStrings.numberIsRequired;
    }
    return null;
  }

  static String? validateOtp(value){
    if(value.isEmpty || value == null){
      return AppStrings.pleaseEnterOtp;
    }if(value.length < 4){
      return AppStrings.pleaseEnterValidOtp;
    }
    return null;
  }


}