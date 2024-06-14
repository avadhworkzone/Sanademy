import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view/examScreen/exam_screen.dart';
import 'package:sanademy/view_model/bottom_bar_view_model.dart';
import 'package:sanademy/view_model/my_certificate_view_model.dart';

class MyCertificateScreen extends StatefulWidget {
  const MyCertificateScreen({super.key});

  @override
  State<MyCertificateScreen> createState() => _MyCertificateScreenState();
}

class _MyCertificateScreenState extends State<MyCertificateScreen> {
  BottomBarViewModel bottomBarViewModel = Get.find();
  MyCertificateViewModel myCertificateViewModel =
      Get.put(MyCertificateViewModel());

  @override
  void initState() {
    getCertificateApiCall();
    // TODO: implement initState
    super.initState();
  }

  getCertificateApiCall() async {
    await myCertificateViewModel.getCertificateData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomBarViewModel.selectedBottomIndex.value = 0;
        Get.offAll(() => const BottomBar());
        return Future.value(true);
      },
      child: SafeArea(
        child: Material(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: Column(
              children: [
                CustomText(
                  AppStrings.myCertificate,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black0E,
                ),
                SizeConfig.sH25,
                SizedBox(
                  child: CustomText(
                    AppStrings.certificateScreenTxt,
                    color: AppColors.black0E.withOpacity(0.8),
                  ),
                ),
                SizeConfig.sH30,
                CustomBtn(
                  onTap: () {
                    SharedPreferenceUtils.getIsLogin() == true
                        ? Get.to(() => const ExamScreen())
                        : Get.to(() => const SignUpScreen());
                  },
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  radius: 10.r,
                  title: AppStrings.getMoreCertificate,
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                ),
                SizeConfig.sH20,
                Obx(() {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: myCertificateViewModel.getCertificates.length,
                      itemBuilder: (context, index) {
                        final certificates =
                            myCertificateViewModel.getCertificates[index];
                        final List<Color> colors = certificates
                            .course!.colorCode!
                            .split(',')
                            .map((color) => Color(int.parse(color, radix: 16))
                                .withOpacity(0.8))
                            .toList();
                        return Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              gradient: LinearGradient(colors: colors),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      AppImageAssets.recommendedBgImg))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                certificates.course!.title ?? '',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black0E,
                              ),
                              SizeConfig.sH8,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    certificates.course!.numberOfLecture ?? '',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black0E,
                                  ),
                                  SizeConfig.sW6,
                                  CustomText(
                                    "•",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.sp,
                                    color: AppColors.black0E,
                                  ),
                                  SizeConfig.sW6,
                                  CustomText(
                                    '${'${certificates.course!.hours} ${AppStrings.hours}'} ${'${certificates.course!.minutes} ${AppStrings.minutes}'}',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black0E,
                                  ),
                                ],
                              ),
                              SizeConfig.sH15,
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      FileDownloader.downloadFile(
                                          url: certificates.certificate ?? '',
                                          onDownloadError: (String error) {
                                            if (kDebugMode) {
                                              print('Download error : $error');
                                            }
                                          },
                                          onDownloadCompleted: (path) {
                                            final File file = File(path);
                                            showSussesSnackBar('',
                                                'Pdf Download Successfully');
                                            print(file);
                                          },
                                          onProgress: (fileName, progress) {
                                            setState(() {
                                              progress = progress;
                                            });
                                          });
                                    },
                                    child: Container(
                                      width: Get.width / 2.7,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: AppColors.white),
                                      child: Center(
                                          child: CustomText(
                                        AppStrings.downloadPDF,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: AppColors.black02,
                                      )),
                                    ),
                                  ),
                                  SizeConfig.sW20,
                                  InkWell(
                                    onTap: () async {
                                      await myCertificateViewModel
                                          .requestHardCopyViewModel(
                                              courseId:
                                                  certificates.courseId == null
                                                      ? ''
                                                      : certificates.courseId
                                                          .toString());
                                    },
                                    child: Container(
                                      width: Get.width / 2.7,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: AppColors.white),
                                      child: Center(
                                          child: CustomText(
                                        AppStrings.requestHartCopy,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: AppColors.black02,
                                      )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
