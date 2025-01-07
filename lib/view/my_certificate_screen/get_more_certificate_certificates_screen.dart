import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view/examScreen/exam_screen.dart';
import 'package:sanademy/view_model/bottom_bar_view_model.dart';
import 'package:sanademy/view_model/my_certificate_view_model.dart';

class GetMoreCertificatesScreen extends StatefulWidget {
  const GetMoreCertificatesScreen({super.key});

  @override
  State<GetMoreCertificatesScreen> createState() =>
      _GetMoreCertificatesScreenState();
}

class _GetMoreCertificatesScreenState extends State<GetMoreCertificatesScreen> {
  final List<Map<String, String>> courses = [
    {
      "image": AppImageAssets.blankBackground, // Replace with your asset
      "title": "IELTS Mock Test",
      "questions": "20 Questions",
      "testType": "Listening Test",
    },
    {
      "image": AppImageAssets.blankBackground, // Replace with your asset
      "title": "English Language",
      "questions": "20 Questions",
      "testType": "Listening Test",
    },
    {
      "image": AppImageAssets.blankBackground, // Replace with your asset
      "title": "CCTV Installation",
      "questions": "20 Questions",
      "testType": "Listening Test",
    },
    {
      "image": AppImageAssets.blankBackground, // Replace with your asset
      "title": "HR Course",
      "questions": "20 Questions",
      "testType": "Listening Test",
    },
    {
      "image": AppImageAssets.blankBackground, // Replace with your asset
      "title": "Email Marketing",
      "questions": "20 Questions",
      "testType": "Listening Test",
    },{
      "image": AppImageAssets.blankBackground, // Replace with your asset
      "title": "MS Office",
      "questions": "20 Questions",
      "testType": "Listening Test",
    },{
      "image": AppImageAssets.blankBackground, // Replace with your asset
      "title": "Network Installation & ...",
      "questions": "20 Questions",
      "testType": "Listening Test",
    },
  ];

  /*@override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => const BottomBar());
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,

        body: SingleChildScrollView(
          child: Column(
            children: [
              commonOnlyTitleAppBar(
                isBack: true,
                paddingLeft: 18.w,
                context: context,
                isLogoRequired: false,
                actionWidget: SizeConfig.sW40,
                title: AppStrings.testsAndCertificates,
                otherWidget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizeConfig.sH10,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: CustomNewText(
                        AppStrings.inThisPageYouCanTestYourKnowledge,
                        fontSize: 14.sp,
                        color: AppColors.white,
                        textAlign: TextAlign.center,
                        letterSpacing: -1.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // SizeConfig.sH25,
                    SizeConfig.sH35,
                  ],
                ),
              ),
              SizeConfig.sH20,
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
    if (duration.inMinutes >= 60) {
      int hours = duration.inHours;
      int minutes = duration.inMinutes.remainder(60);
      return '$hours ${AppStrings.hours} $minutes ${AppStrings.minutes}';
    } else {
      return '${duration.inMinutes} ${AppStrings.minutes}';
    }
  }
}*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            commonOnlyTitleAppBar(
              isBack: true,
              paddingLeft: 18.w,
              context: context,
              isLogoRequired: false,
              actionWidget: SizeConfig.sW40,
              title: AppStrings.testsAndCertificates,
              otherWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizeConfig.sH10,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: CustomNewText(
                      AppStrings.inThisPageYouCanTestYourKnowledge,
                      fontSize: 14.sp,
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                      letterSpacing: -1.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // SizeConfig.sH25,
                  SizeConfig.sH35,
                ],
              ),
            ),
            SizeConfig.sH15,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.sp,vertical: 10.h),
              child: Column(
                children:
                    courses.map((course) => buildCourseCard(course)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseCard(Map<String, String> course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding:  EdgeInsets.symmetric(horizontal: 16.sp,vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              course["image"]!,
              height: 60.sp,
              width: 60.sp,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNewText(
                  course["title"] ?? "",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.1),
                        border: Border.all(color: AppColors.whitef7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: CustomNewText(
                        course["questions"] ?? "",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.1),
                        border: Border.all(color: AppColors.whitef7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: CustomNewText(
                        course["testType"] ?? "",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              showDisabledDialog(context, "IELTS Mock Test");

            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: LocalAssets(
                imagePath: AppImageAssets.playIcon,
                height: 32.sp,
                width: 32.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
void showDisabledDialog(BuildContext context, String courseTitle) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               // SizedBox(height: 10.h),
              // Close Icon
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              LocalAssets(
                imagePath: AppImageAssets.warning,
                height: 116.sp,
                width: 122.sp,
              ),
              const SizedBox(height: 16),
              // Title
              CustomNewText(
                "We are Sorry",
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Message
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: AppConstants.metropolis,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text: "Sorry for the Test & Certificate for ",
                    ),
                    TextSpan(
                      text: courseTitle,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: AppConstants.metropolis,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const TextSpan(
                      text:
                      " is disabled for now, it will come back soon.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

            ],
          ),
        ),
      );
    },
  );
}
