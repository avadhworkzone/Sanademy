// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sanademy/commonWidget/commom_textfield.dart';
// import 'package:sanademy/utils/app_string.dart';
// import 'package:sanademy/utils/regex.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final firstNameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
//           CommonTextField(
//             textEditController: firstNameController,
//             regularExpression: RegularExpressionUtils.alphabetPattern,
//             hintText: AppStrings.enterYourName.tr,
//             isValidate: true,
//             onChange: (firstNameData) {
//               // createAccountController.isAllFieldInput();
//             },
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           InkWell(
//               onTap: () {
//                 Get.updateLocale(const Locale('en_US'));
//               },
//               child: const Text('english')),
//           const SizedBox(
//             height: 30,
//           ),
//           InkWell(
//               onTap: () {
//                 Get.updateLocale(const Locale('ar'));
//               },
//               child: const Text('arabian')),
//         ],
//       ),
//     );
//   }
// }
