import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/menu_screen/contact_us_screen.dart';
import 'package:sanademy/view_model/about_us_view_model.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  AboutUsViewModel aboutUsViewModel = Get.put(AboutUsViewModel());
  late ScrollController _scrollController;
  final double _scrollSpeed = 15.0;
  int selectedLanguage=0;
  void _startScrolling() {
    if (_scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController
              .animateTo(
            _scrollController.offset + _scrollSpeed,
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
          )
              .then((_) {
            // Reset when reaching the end
            if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent) {
              _scrollController.jumpTo(0);
            }
            _startScrolling();
          });
        }
      });
    }
  }

  // @override
  // void initState() {
  //   getAboutUsApiCall();
  //   super.initState();
  // }

  getAboutUsApiCall() async {
    await aboutUsViewModel.getAboutUsData();
  }
  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
    // _startScrolling();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: commonAppBar(
      //     centerTitle: false,
      //     // appBarBackgroundColor: AppColors.white,
      //     titleWidget: commonBackArrowAppBar(
      //       titleTxt: AppStrings.titleTxt,
      //       actionWidget: false,
      //       horizontalPadding: 5.w,
      //     ),
      //     bottom: PreferredSize(
      //       preferredSize: const Size.fromHeight(40),
      //       child: Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.w),
      //           child: CustomText(AppStrings.aboutUs)),
      //     )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonUpdateAppBar(
            isBack: true,
            context: context,
            paddingLeft: 18.w,
            actionWidget: SizeConfig.sW40,
            otherWidget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizeConfig.sH25,
                CustomText(
                  AppStrings.aboutUs,
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  fontFamily: AppConstants.metropolis,
                ),
                SizeConfig.sH35,
                SizedBox(
                  height: 39.w,
                  // color: AppColors.red,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LocalAssets(
                            imagePath: AppImageAssets.animationImage,
                            imgColor: AppColors.white.withOpacity(0.4),
                            boxFix: BoxFit.cover,
                            width: Get.width,
                            height: 28.h,
                          ),
                          const SizedBox(width: 0), // Optional spacing
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [CustomText(AppStrings.sanaAcademyAboutUsDes,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.blue34),
              SizedBox(height: 20.h),
              CustomText(AppStrings.contactUs,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: AppColors.blue34),
              SizedBox(height: 16.h),
              contactUsMethod(
                  preIcon: AppImageAssets.callIcon,
                  title: '750 991 0444',
                  postIcon: AppImageAssets.copyIcon),
              SizedBox(height: 8.h),
              contactUsMethod(
                  preIcon: AppImageAssets.callIcon,
                  title: '750 991 0444',
                  postIcon: AppImageAssets.copyIcon),
              SizedBox(height: 8.h),
              contactUsMethod(
                  preIcon: AppImageAssets.whatAppIcon,
                  title: 'WhatsApp',
                  postIcon: AppImageAssets.copyIcon),
              SizedBox(height: 8.h),
              contactUsMethod(
                  preIcon: AppImageAssets.telegramIcon,
                  title: 'Telegram',
                  postIcon: AppImageAssets.copyIcon),
              SizedBox(height: 16.h),],),
          )
        ],
      ),
      // body: Obx(
      //   () => SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         SizeConfig.sH10,
      //         Html(
      //           data: aboutUsViewModel.description.value,
      //           shrinkWrap: true,
      //         ),
      //         Padding(
      //           padding:
      //               EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      //           child: CustomBtn(
      //             onTap: () {
      //               Get.to(const ContactUsScreen());
      //             },
      //             title: AppStrings.contactUs,
      //             fontWeight: FontWeight.w600,
      //             fontSize: 14.sp,
      //             bgColor: AppColors.primaryColor,
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // )
    );
  }

  Container contactUsMethod(
      {required String preIcon,
        required String title,
        required String postIcon}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyE0),
          borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            CircleAvatar(
              child: LocalAssets(
                imagePath: preIcon,
                // imagePath: AppImageAssets.enrollSuccessfullyImg,
                height: 16.h,
                width: 16.w,
              ),
            ),
            SizedBox(width: 8.w),
            CustomText(title,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.blue34),
            const Spacer(),
            CircleAvatar(
              child: LocalAssets(
                imagePath: postIcon,
                // imagePath: AppImageAssets.enrollSuccessfullyImg,
                height: 16.h,
                width: 16.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
