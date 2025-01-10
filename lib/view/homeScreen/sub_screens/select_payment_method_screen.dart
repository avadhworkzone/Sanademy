import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
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
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //     color: AppColors.lightYellowD3,
              //     border: Border.all(color: AppColors.yellow),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       LocalAssets(
              //         height: 24.sp,
              //         width: 24.sp,
              //         imagePath: AppImageAssets.infoIconShaped,
              //       ),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: CustomText(
              //           'Be careful. For handling payments through "Method" there is 10% fees, which will be deducted from the amount we received from you.',
              //           fontSize: 13.sp,
              //           fontWeight: FontWeight.w500,
              //           color: AppColors.coffee100,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
                      fontFamily: AppConstants.metropolis,
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
                    showSendMessageDialog(context);
                    // Get.to(const SelectPaymentMethodScreen());
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

void showSendMessageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
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
                      )),
                ),
                SizedBox(height: 10.h),

                /// VIDEO VIEW
                Stack(
                  children: [
                    SizedBox(
                      height: Get.width * 0.7,
                      width: Get.width,
                      child: Get.find<DescriptionViewModel>().isLoader.value ==
                              true
                          ? Center(
                              child: SizedBox(
                                  height: 50.h,
                                  width: 50.h,
                                  child: const LocalAssets(
                                    imagePath: AppImageAssets.sanademaylogo,
                                    imgColor: AppColors.primaryColor,
                                  )),
                            )
                          : SizedBox(
                              height: 300.h,
                              width: 430.w,
                              child: AspectRatio(
                                aspectRatio: Get.find<DescriptionViewModel>()
                                    .chewieControllers
                                    .videoPlayerController
                                    .value
                                    .aspectRatio,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Chewie(
                                      controller:
                                          Get.find<DescriptionViewModel>()
                                              .chewieControllers,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10.w, top: 10.w, right: 10.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.w),
                            decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.20),
                                borderRadius: BorderRadius.circular(17)),
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppColors.white,
                            ),
                          )),
                    ),
                  ],
                ),
                noteContainer(
                    title:
                        "If you need assistance, you can watch the video. Incase having issues, please use the following options to contact us:"),
                SizedBox(height: 20.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Do you want to Enroll in AI course for ',
                        style: TextStyle(
                          color: AppColors.blue34,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.metropolis,
                        ),
                      ),
                      TextSpan(
                        text: '15000',
                        style: TextStyle(
                          color: AppColors.blue34,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.metropolis,
                        ),
                      ),
                      TextSpan(
                        text: 'IQD',
                        style: TextStyle(
                          color: AppColors.blue34,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.metropolis,
                        ),
                      ),
                      TextSpan(
                        text: ' amount?',
                        style: TextStyle(
                          color: AppColors.blue34,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.metropolis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: AppColors.greyF7,
                    border: Border.all(color: AppColors.greyE4),
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonRowForEnrollDialog(
                        title: AppStrings.coursePrice,
                        amount: "280,000 IQD",
                      ),
                      SizedBox(height: 2.h),
                      dottedLine(),
                      SizedBox(height: 2.h),
                      commonRowForEnrollDialog(
                        title: "${AppStrings.discountOfCourse} (25%)",
                        amount: "-120,000 IQD",
                      ),
                      SizedBox(height: 2.h),
                      dottedLine(),
                      SizedBox(height: 2.h),
                      commonRowForEnrollDialog(
                        title: AppStrings.yourCurrentBalance,
                        amount: "-100,000 IQD",
                      ),
                      // SizedBox(height: 2.h),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: commonRowForEnrollDialog(
                    title: AppStrings.pendingToPay,
                    fontSizeTitle: 14.sp,
                    fontWeightTitle: FontWeight.w600,
                    titleColor: AppColors.grey73,
                    fontSizeAmount: 14.sp,
                    fontWeightAmount: FontWeight.w700,
                    amountColor: AppColors.blue34,
                    amount: "60,000 IQD",
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 150.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            color: AppColors.greyF7,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            AppStrings.cancel,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue34,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: CustomUpdateBtn(
                        onTap: () {
                          Get.to(const SelectPaymentMethodScreen());
                        },
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        radius: 10,
                        title: AppStrings.payNow,
                        width: 150.w,
                      ),
                    ),
                  ],
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
