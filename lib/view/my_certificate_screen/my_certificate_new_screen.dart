import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view/myProgressScreen/progess_bottom_sheet.dart';
import 'package:sanademy/view/my_certificate_screen/get_more_certificate_certificates_screen.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

class MyCertificateNewScreen extends StatefulWidget {
  const MyCertificateNewScreen({super.key});

  @override
  State<MyCertificateNewScreen> createState() => _MyCertificateNewScreenState();
}

class _MyCertificateNewScreenState extends State<MyCertificateNewScreen> {
  SignUpViewModel signUpViewModel = Get.find();

  @override
  void initState() {
    super.initState();

    /// Check User Is Login Or Not
    if (SharedPreferenceUtils.getIsLogin() == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        /// Open The Register Dialog
        showLoginBottomSheet(context);
      });
    }

    /// Get Token Api Call
    signUpViewModel.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => const BottomBar());
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.w),
          child: CustomUpdateBtn(
            onTap: () {
              Get.to(const GetMoreCertificatesScreen());
              // Get.offAll(() => const BottomBar());
            },
            title: AppStrings.getMoreCertificate,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              commonOnlyTitleAppBar(
                paddingLeft: 18.w,
                context: context,
                isLogoRequired: false,
                actionWidget: SizeConfig.sW40,
                title: AppStrings.testCertificate,
                otherWidget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizeConfig.sH10,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: CustomNewText(
                        AppStrings.inThisPageYouCanSeeAllCertificates,
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
              SizedBox(
                height: 200.h,
              ),
              CustomText(AppStrings.noDataFound)
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w),
              //   child: ListView.builder(
              //     itemCount: 4,
              //     shrinkWrap: true,
              //     padding: EdgeInsets.zero,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           Container(
              //             // height: 300.h,
              //             decoration: BoxDecoration(
              //               color: AppColors.white,
              //               border: Border.all(color: AppColors.greyE0),
              //               borderRadius: BorderRadius.circular(16),
              //             ),
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 12.h, vertical: 12.h),
              //               child: Column(
              //                 children: [
              //                   Container(
              //                     decoration: BoxDecoration(
              //                       // color: AppColors.primaryColor,
              //                       image: DecorationImage(
              //                         image: AssetImage(AppImageAssets.appLogo),
              //                         // Replace with your image path
              //                         fit: BoxFit
              //                             .cover, // Adjusts how the image fits the container
              //                       ),
              //                       // border: Border.all(color: AppColors.greyE0),
              //                       borderRadius: BorderRadius.circular(16),
              //                     ),
              //                     child: Column(
              //                       children: [
              //                         SizedBox(
              //                           height: 39.w,
              //                           // color: AppColors.red,
              //                           child: ListView.builder(
              //                             // controller: _scrollController,
              //                             shrinkWrap: true,
              //                             scrollDirection: Axis.horizontal,
              //                             physics:
              //                                 const NeverScrollableScrollPhysics(),
              //                             itemBuilder: (context, index) {
              //                               return Row(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 children: [
              //                                   LocalAssets(
              //                                     imagePath: AppImageAssets
              //                                         .animationImage,
              //                                     imgColor: AppColors.white
              //                                         .withOpacity(0.4),
              //                                     boxFix: BoxFit.cover,
              //                                     width: Get.width,
              //                                     height: 28.h,
              //                                   ),
              //                                   const SizedBox(width: 0),
              //                                   // Optional spacing
              //                                 ],
              //                               );
              //                             },
              //                           ),
              //                         ),
              //                         Padding(
              //                             padding: EdgeInsets.symmetric(
              //                                 vertical: 30.h, horizontal: 10.w),
              //                             child: RichText(
              //                               textAlign: TextAlign.center,
              //                               text: TextSpan(
              //                                 text: 'This Certificate goes to ',
              //                                 style: TextStyle(
              //                                   color: AppColors.white,
              //                                   fontSize: 14.sp,
              //                                   fontWeight: FontWeight.w600,
              //                                 ),
              //                                 children: [
              //                                   TextSpan(
              //                                     text: '“Name”',
              //                                     style: TextStyle(
              //                                       color: AppColors.white,
              //                                       fontSize: 18.sp,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                   TextSpan(
              //                                     text: ' for completing the ',
              //                                     style: TextStyle(
              //                                       color: AppColors.white,
              //                                       fontSize: 14.sp,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                   TextSpan(
              //                                     text: '“English Language”',
              //                                     style: TextStyle(
              //                                       color: AppColors.white,
              //                                       fontSize: 18.sp,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                   TextSpan(
              //                                     text: ' course.',
              //                                     style: TextStyle(
              //                                       color: AppColors.white,
              //                                       fontSize: 14.sp,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             )),
              //                         SizedBox(
              //                           height: 39.w,
              //                           // color: AppColors.red,
              //                           child: ListView.builder(
              //                             // controller: _scrollController,
              //                             shrinkWrap: true,
              //                             scrollDirection: Axis.horizontal,
              //                             physics:
              //                                 const NeverScrollableScrollPhysics(),
              //                             itemBuilder: (context, index) {
              //                               return Row(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 children: [
              //                                   LocalAssets(
              //                                     imagePath: AppImageAssets
              //                                         .animationImage,
              //                                     imgColor: AppColors.white
              //                                         .withOpacity(0.4),
              //                                     boxFix: BoxFit.cover,
              //                                     width: Get.width,
              //                                     height: 28.h,
              //                                   ),
              //                                   const SizedBox(width: 0),
              //                                   // Optional spacing
              //                                 ],
              //                               );
              //                             },
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   SizedBox(height: 20.h),
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Expanded(
              //                         child: Container(
              //                           padding: EdgeInsets.symmetric(
              //                               horizontal: 10.w, vertical: 10.h),
              //                           decoration: BoxDecoration(
              //                             color: AppColors.white,
              //                             border: Border.all(
              //                                 color: AppColors.primaryColor),
              //                             borderRadius:
              //                                 BorderRadius.circular(16),
              //                           ),
              //                           child: Row(
              //                             children: [
              //                               Image.asset(
              //                                 AppImageAssets.requestHardCopy,
              //                                 height: 25.sp,
              //                                 width: 25.sp,
              //                                 fit: BoxFit.contain,
              //                               ),
              //                               // SizedBox(width: 5.w),
              //                               Expanded(
              //                                 child: CustomNewText(
              //                                   AppStrings.reqHardCopy,
              //                                   fontSize: 12.sp,
              //                                   color: AppColors.primaryColor,
              //                                   textAlign: TextAlign.center,
              //                                   fontWeight: FontWeight.w600,
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                       SizedBox(width: 10.w),
              //                       Expanded(
              //                         child: Container(
              //                           padding: EdgeInsets.symmetric(
              //                               horizontal: 10.w, vertical: 10.h),
              //                           decoration: BoxDecoration(
              //                             color: AppColors.white,
              //                             border: Border.all(
              //                                 color: AppColors.primaryColor),
              //                             borderRadius:
              //                                 BorderRadius.circular(16),
              //                           ),
              //                           child: Row(
              //                             children: [
              //                               Image.asset(
              //                                 AppImageAssets
              //                                     .downloadCircleFilled,
              //                                 height: 25.sp,
              //                                 width: 25.sp,
              //                                 fit: BoxFit.contain,
              //                               ),
              //                               // SizedBox(width: 5.w),
              //                               Expanded(
              //                                 child: CustomNewText(
              //                                   AppStrings.downloadPDF,
              //                                   fontSize: 12.sp,
              //                                   color: AppColors.primaryColor,
              //                                   textAlign: TextAlign.center,
              //                                   fontWeight: FontWeight.w600,
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(height: 10.h),
              //                 ],
              //               ),
              //             ),
              //           ),
              //           SizedBox(height: 15.h),
              //         ],
              //       );
              //     },
              //   ),
              // )
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
}
