import 'package:chewie/chewie.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/common_container_dialog.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/view/homeScreen/sub_screens/course_description_screen.dart';
import 'package:sanademy/view_model/description_view_model.dart';
import 'package:sanademy/view_model/profile_screen_view_model.dart';

TextEditingController amountController = TextEditingController();

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  int? selectedPaymentMethod;
  TextEditingController couponCodeController = TextEditingController();

  // Example list of payment methods
  final List<Map<String, dynamic>> paymentMethods = [
    {'name': 'Fast Pay', 'icon': Icons.speed},
    {'name': 'FIB', 'icon': Icons.account_balance},
    {'name': 'Asia Pay', 'icon': Icons.payment},
    {'name': 'Zain Cash', 'icon': Icons.money},
    {'name': 'Nasswallet', 'icon': Icons.wallet},
    {'name': 'Qi Card', 'icon': Icons.credit_card},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        // bottomOpacity: 0.0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              // radius: 5,
              backgroundColor: AppColors.greyF7,
              child: Icon(
                // weight: 7,
                size: 18,
                Icons.arrow_back_ios_new,
                color: AppColors.blue34,
              ),
            ),
          ),
        ),

        title: CustomText(
          'Select Method'.tr,
          color: AppColors.blue34,
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
        ),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: CustomText(
      //     'Select Method',
      //     fontSize: 18,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.black,
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // Warning Box
              noteContainer(
                  title:
                      'Be careful. For handling payments through "Method" there is 10% fees, which will be deducted from the amount we received from you.'),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      // margin: const EdgeInsets.all(16),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.greyE0),
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 24.sp,
                            backgroundColor: AppColors.borderColor,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomText(
                              'Korek Balance',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blue34,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.greyE0,
                          ),
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 24.sp,
                              backgroundColor: AppColors.borderColor,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomText(
                                'AsiaCell Balance',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blue34,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Payment Methods List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.greyE0,
                          ),
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: AppColors.borderColor,
                            // child: Icon(paymentMethods[index]['icon'],
                            //     color: Colors.blue),
                          ),
                          title: CustomText(
                            paymentMethods[index]['name'],
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue34,
                          ),
                          trailing: Radio<int>(
                            value: index,
                            activeColor: AppColors.borderColor,
                            focusColor: AppColors.greyE0,
                            groupValue: selectedPaymentMethod,
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentMethod = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  );
                },
              ),
              SizedBox(height: 10.h),
              // Coupon Code Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Add Coupon Code',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey73,
                  ),
                  const SizedBox(height: 8),
                  CommonTextField(
                    hintText: 'Type/paste here...',
                    textEditController: couponCodeController,
                    fillColor: Colors.transparent,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.blue34,
                      fontWeight: FontWeight.w500,
                    ),
                    hintFontWeight: FontWeight.w500,
                    hintTextColor: AppColors.grey73,
                    hintFontSize: 16.sp,
                    readOnly: true,
                    isValidate: false,
                    validator: ValidationMethod.validateDate,
                    regularExpression: '',
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Need Assistance Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle assistance action here
                  },
                  child: CustomText(
                    'Need Assistant?',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.borderColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.borderColor,
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              // Continue Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomUpdateBtn(
                  onTap: () {
                    showPaymentProcessBottomSheet(context);
                    // showSendMessageDialog(context);
                  },
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  radius: 10,
                  title: "Continue",
                  // width: 150.w,
                ),
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}

// void showPaymentProcessBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(12),
//       ),
//     ),
//     builder: (context) {
//       return FractionallySizedBox(
//         heightFactor: 0.9, // Adjust the height as needed
//         child: Center(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.90,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () => Navigator.of(context).pop(),
//                         child: const Icon(Icons.arrow_back),
//                       ),
//                       CustomText(
//                         "Payment Process",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       const SizedBox(width: 24), // Placeholder for symmetry
//                     ],
//                   ),
//                   SizedBox(height: 15.h),
//
//                   // Step 1
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 10.r,
//                         backgroundColor: AppColors.blue34,
//                       ),
//                       SizedBox(width: 10.w),
//                       CustomText(
//                         "Step 1",
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.grey73,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   CustomText(
//                     "Enter amount you want to add to your account",
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey73,
//                   ),
//                   SizedBox(height: 10.h),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 15.w),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: AppColors.greyE4),
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.white,
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "0.0",
//                               hintStyle: TextStyle(
//                                 fontSize: 14.sp,
//                                 color: AppColors.grey73,
//                               ),
//                             ),
//                             keyboardType: TextInputType.number,
//                           ),
//                         ),
//                         CustomText(
//                           "IQD",
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.blue34,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//
//                   // Step 2
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 10.r,
//                         backgroundColor: AppColors.blue34,
//                       ),
//                       SizedBox(width: 10.w),
//                       CustomText(
//                         "Step 2",
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.grey73,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   CustomText(
//                     "Send 150000 IQD to the following phone number.",
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey73,
//                   ),
//                   SizedBox(height: 10.h),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: AppColors.greyE4),
//                       color: AppColors.greyF7,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(Icons.phone, color: AppColors.blue34),
//                             SizedBox(width: 10.w),
//                             CustomText(
//                               "750 991 0444",
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.grey73,
//                             ),
//                           ],
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // Copy phone number to clipboard
//                           },
//                           child: const Icon(Icons.copy, color: AppColors.grey73),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//
//                   // Step 3
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 10.r,
//                         backgroundColor: AppColors.blue34,
//                       ),
//                       SizedBox(width: 10.w),
//                       CustomText(
//                         "Step 3",
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.grey73,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   CustomText(
//                     "Write the phone number you sent balance from",
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey73,
//                   ),
//                   SizedBox(height: 10.h),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: AppColors.greyE4),
//                       color: AppColors.greyF7,
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.flag, color: AppColors.blue34),
//                         SizedBox(width: 10.w),
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "+98 8788 7788 222",
//                               hintStyle: TextStyle(
//                                 fontSize: 14.sp,
//                                 color: AppColors.grey73,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//
//                   // Advertisement / Banner
//                   Container(
//                     padding: EdgeInsets.all(15.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: AppColors.greyF7,
//                     ),
//                     child: Row(
//                       children: [
//                         Image.asset(AppImageAssets.image1, height: 60.h),
//                         SizedBox(width: 10.w),
//                         Expanded(
//                           child: CustomText(
//                             "کۆرسی بەکارھێنان و کارکردن لەسەر ژیری دەستکرد",
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.grey73,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//
//                   // Submit Button
//                   CustomUpdateBtn(
//                     onTap: () {
//                       // Handle submission
//                     },
//                     title: "Submit Request",
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                     radius: 8,
//                   ),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

///
void showPaymentProcessBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CircleAvatar(
                        // radius: 5,
                        backgroundColor: AppColors.greyF7,
                        child: Icon(
                          // weight: 7,
                          size: 18,
                          Icons.arrow_back_ios_new,
                          color: AppColors.blue34,
                        ),
                      ),
                    ),
                    CustomText(
                      "Payment Process",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
                SizedBox(height: 15.h),

                // Vertical Stepper
                Column(
                  children: [
                    /// Step 1
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 10.sp,
                              backgroundColor: AppColors.borderColor,
                            ),
                            Container(
                              width: 5.w,
                              height: 80.h,
                              color: AppColors.greyF7,
                            ),
                          ],
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                "Step 1",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blue34,
                              ),
                              SizedBox(height: 8.h),
                              CustomText(
                                "Enter amount you want to add to your account",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blue34,
                              ),
                              SizedBox(height: 10.h),
                              // Container(
                              //   padding: EdgeInsets.symmetric(horizontal: 15.w),
                              //   decoration: BoxDecoration(
                              //     border: Border.all(color: AppColors.greyE4),
                              //     borderRadius: BorderRadius.circular(8),
                              //     color: Colors.white,
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: TextField(
                              //           decoration: InputDecoration(
                              //             border: InputBorder.none,
                              //             hintText: "0.0",
                              //             hintStyle: TextStyle(
                              //               fontSize: 14.sp,
                              //               color: AppColors.grey73,
                              //             ),
                              //           ),
                              //           keyboardType: TextInputType.number,
                              //         ),
                              //       ),
                              //       CustomText(
                              //         "IQD",
                              //         fontSize: 14.sp,
                              //         fontWeight: FontWeight.w600,
                              //         color: AppColors.blue34,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              CommonTextField(
                                textEditController: amountController,
                                // validator: ValidationMethod.validateName,
                                fillColor: Colors.transparent,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyBoardType: TextInputType.number,
                                cursorColor: AppColors.borderColor,
                                sIcon: CustomText(
                                  "IQD",
                                  height: 3.3.h,
                                  fontSize: 14.sp,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey73,
                                ),

                                regularExpression:
                                    RegularExpressionUtils.onlyNumbersPattern,
                                // hintText: AppStrings.enterYourName,
                                hintFontWeight: FontWeight.w400,
                                // validationType: ValidationTypeEnum.name,
                                borderColor: AppColors.black.withOpacity(0.10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),

                    /// Step 2
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 10.sp,
                              backgroundColor: AppColors.borderColor,
                              // child: Icon(Icons.check, size: 14.sp, color: Colors.white),
                            ),
                            Container(
                              width: 5.w,
                              height: 80.h,
                              color: AppColors.greyF7,
                            ),
                          ],
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                "Step 2",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blue34,
                              ),
                              SizedBox(height: 8.h),
                              CustomText(
                                "Send 150000 IQD to the following phone number.",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey73,
                              ),
                              SizedBox(height: 10.h),
                              contactUsMethod(
                                preIcon: AppImageAssets.callIcon,
                                preIconColor: AppColors.blue34,
                                title: "750 991 0444",
                                postIcon: AppImageAssets.copyIcon,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),

                    // Step 3
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 10.sp,
                          backgroundColor: AppColors.borderColor,
                          // child: Icon(Icons.check, size: 14.sp, color: Colors.white),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                "Step 3",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blue34,
                              ),
                              SizedBox(height: 8.h),
                              CustomText(
                                "Write the phone number you sent balance from",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blue34,
                              ),
                              SizedBox(height: 10.h),
                              // Container(
                              //   padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(8),
                              //     border: Border.all(color: AppColors.greyE4),
                              //     color: AppColors.greyF7,
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       const Icon(Icons.flag, color: AppColors.blue34),
                              //       SizedBox(width: 10.w),
                              //       Expanded(
                              //         child: TextField(
                              //           decoration: InputDecoration(
                              //             border: InputBorder.none,
                              //             hintText: "+98 8788 7788 222",
                              //             hintStyle: TextStyle(
                              //               fontSize: 14.sp,
                              //               color: AppColors.grey73,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppStrings.phoneNumber,
                                      // "Full Name (English) "
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.grey73,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              IntlPhoneField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: Get.put(ProfileScreenViewModel())
                                    .phoneController
                                    .value,
                                initialCountryCode:
                                    Get.put(ProfileScreenViewModel())
                                                .countryCode
                                                .value ==
                                            ''
                                        ? 'IQ'
                                        : Get.put(ProfileScreenViewModel())
                                            .countryCode
                                            .value,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (val) {
                                  if (val.toString().isNotEmpty) {
                                    Get.put(ProfileScreenViewModel())
                                        .isValidate
                                        .value = false;
                                    var countryCode =
                                        Get.put(ProfileScreenViewModel())
                                                    .countryCode
                                                    .value ==
                                                ''
                                            ? 'IQ'
                                            : Get.put(ProfileScreenViewModel())
                                                .countryCode
                                                .value;
                                    if (countryCode == 'IQ') {
                                      if (val.number.startsWith('0')) {
                                        Get.put(ProfileScreenViewModel())
                                                .phoneController
                                                .value
                                                .text =
                                            val.number.replaceFirst('0', '');
                                        // profileScreenViewModel.phoneController.value.selection =
                                        // TextSelection.fromPosition(TextPosition(
                                        // offset: profileScreenViewModel.phoneController.value.text.length));
                                      }
                                    }
                                  }
                                },
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400),
                                flagsButtonPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                dropdownIconPosition: IconPosition.trailing,
                                disableLengthCheck: true,
                                dropdownIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 17.h),
                                  hintText: AppStrings.enterYourPhoneNumber.tr,
                                  hintStyle: TextStyle(
                                    color: AppColors.black12,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  errorText: (Get.put(ProfileScreenViewModel())
                                                  .isValidate
                                                  .value ==
                                              true &&
                                          Get.put(ProfileScreenViewModel())
                                              .phoneController
                                              .value
                                              .text
                                              .isEmpty)
                                      ? AppStrings.isRequired.tr
                                      : null,
                                  errorBorder:
                                      (Get.put(ProfileScreenViewModel())
                                                      .isValidate
                                                      .value ==
                                                  true &&
                                              Get.put(ProfileScreenViewModel())
                                                  .phoneController
                                                  .value
                                                  .text
                                                  .isEmpty)
                                          ? OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppColors.red),
                                              borderRadius:
                                                  BorderRadius.circular(10.r))
                                          : OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: AppColors.black
                                                    .withOpacity(0.10),
                                              )),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.black.withOpacity(0.10),
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: AppColors.black.withOpacity(0.10),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0, color: AppColors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: AppColors.black.withOpacity(0.10),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Advertisement / Banner
                // VIDEO VIEW
                SizedBox(
                  height: Get.width * 0.5,
                  width: Get.width,
                  child: Get.find<DescriptionViewModel>().isLoader.value
                      ? Center(
                          child: SizedBox(
                            height: 50.h,
                            width: 50.h,
                            child: const LocalAssets(
                              imagePath: AppImageAssets.sanademaylogo,
                              imgColor: AppColors.primaryColor,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 300.h,
                          width: 430.w,
                          child: AspectRatio(
                            aspectRatio: Get.find<DescriptionViewModel>()
                                .chewieControllers!
                                .videoPlayerController
                                .value
                                .aspectRatio,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Chewie(
                                controller: Get.find<DescriptionViewModel>()
                                    .chewieControllers!,
                              ),
                            ),
                          ),
                        ),
                ),
                // SizedBox(height: 20.h),
                SizedBox(height: 20.h),

                // Submit Button
                CustomUpdateBtn(
                  onTap: () {
                    showSendMessageDialog(context);
                  },
                  title: "Submit Request",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  radius: 8,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget noteContainer({required String title}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.lightYellowD3,
      border: Border.all(color: AppColors.yellow),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalAssets(
          height: 24.sp,
          width: 24.sp,
          imagePath: AppImageAssets.infoIconShaped,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomText(
            title,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.coffee100,
          ),
        ),
      ],
    ),
  );
}

// void showSendMessageDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         // contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.9, // Adjust width
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//           // width: double.maxFinite,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10.h),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Icon(
//                         Icons.close,
//                         size: 24.sp,
//                         color: Colors.black,
//                       )),
//                 ),
//                 SizedBox(height: 10.h),
//                 noteContainer(
//                     title:
//                     "If you need assistance, you can watch the video. Incase having issues, please use the following options to contact us:"),
//                 SizedBox(height: 10.h),
//                 /// VIDEO VIEW
//                 SizedBox(
//                   height: Get.width * 0.5,
//                   width: Get.width,
//                   child: Get.find<DescriptionViewModel>().isLoader.value ==
//                           true
//                       ? Center(
//                           child: SizedBox(
//                               height: 50.h,
//                               width: 50.h,
//                               child: const LocalAssets(
//                                 imagePath: AppImageAssets.sanademaylogo,
//                                 imgColor: AppColors.primaryColor,
//                               )),
//                         )
//                       : SizedBox(
//                           height: 300.h,
//                           width: 430.w,
//                           child: AspectRatio(
//                             aspectRatio: Get.find<DescriptionViewModel>()
//                                 .chewieControllers
//                                 .videoPlayerController
//                                 .value
//                                 .aspectRatio,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Chewie(
//                                 controller:
//                                     Get.find<DescriptionViewModel>()
//                                         .chewieControllers,
//                               ),
//                             ),
//                           ),
//                         ),
//                 ),
//                 SizedBox(height: 20.h),
//                 CustomText("Send Message", fontWeight: FontWeight.w600,fontSize: 20.sp,),
//                 SizedBox(height: 10.h),
//                 contactUsMethod(
//                     preIcon: AppImageAssets.whatAppIcon,
//                     title: AppStrings.whatsApp,
//                     postIcon: AppImageAssets.copyIcon,
//                     ),
//                 SizedBox(height: 10.h),
//                 contactUsMethod(
//                   preIcon: AppImageAssets.telegramIcon,
//                   title: AppStrings.telegram,
//                   postIcon: AppImageAssets.copyIcon,
//                 ),
//                 SizedBox(height: 20.h),
//                 CustomText("Contact us", fontWeight: FontWeight.w600,fontSize: 20.sp,),
//                 SizedBox(height: 10.h),
//                 contactUsMethod(
//                   preIcon: AppImageAssets.callIcon,
//                   preIconColor: AppColors.blue34,
//                   title: "750 991 0444",
//                   postIcon: AppImageAssets.copyIcon,
//                 ),
//                 SizedBox(height: 10.h),
//                 contactUsMethod(
//                   preIcon: AppImageAssets.callIcon,
//                   preIconColor: AppColors.blue34,
//                   title: "750 991 0444",
//                   postIcon: AppImageAssets.copyIcon,
//                 ),
//                 SizedBox(height: 30.h),
//
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
void showSendMessageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        // Ensures no extra padding around the dialog
        child: Center(
          child: Container(
            width:
                MediaQuery.of(context).size.width * 0.90, // Almost full width
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        size: 24.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  noteContainer(
                    title:
                        "If you need assistance, you can watch the video. Incase having issues, please use the following options to contact us:",
                  ),
                  SizedBox(height: 10.h),
                  // VIDEO VIEW
                  SizedBox(
                    height: Get.width * 0.5,
                    width: Get.width,
                    child: Get.find<DescriptionViewModel>().isLoader.value
                        ? Center(
                            child: SizedBox(
                              height: 50.h,
                              width: 50.h,
                              child: const LocalAssets(
                                imagePath: AppImageAssets.sanademaylogo,
                                imgColor: AppColors.primaryColor,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 300.h,
                            width: 430.w,
                            child: AspectRatio(
                              aspectRatio: Get.find<DescriptionViewModel>()
                                  .chewieControllers!
                                  .videoPlayerController
                                  .value
                                  .aspectRatio,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Chewie(
                                  controller: Get.find<DescriptionViewModel>()
                                      .chewieControllers!,
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    "Send Message",
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 10.h),
                  contactUsMethod(
                    preIcon: AppImageAssets.whatAppIcon,
                    title: AppStrings.whatsApp,
                    postIcon: AppImageAssets.copyIcon,
                  ),
                  SizedBox(height: 10.h),
                  contactUsMethod(
                    preIcon: AppImageAssets.telegramIcon,
                    title: AppStrings.telegram,
                    postIcon: AppImageAssets.copyIcon,
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    "Contact us",
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 10.h),
                  contactUsMethod(
                    preIcon: AppImageAssets.callIcon,
                    preIconColor: AppColors.blue34,
                    title: "750 991 0444",
                    postIcon: AppImageAssets.copyIcon,
                  ),
                  SizedBox(height: 10.h),
                  contactUsMethod(
                    preIcon: AppImageAssets.callIcon,
                    preIconColor: AppColors.blue34,
                    title: "750 991 0444",
                    postIcon: AppImageAssets.copyIcon,
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
