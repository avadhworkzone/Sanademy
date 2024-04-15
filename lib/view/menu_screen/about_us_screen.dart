import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/menu_screen/common_about_us_widget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
          centerTitle: false,
          appBarBackgroundColor: AppColors.white,
          titleWidget: commonBackArrowAppBar(
            titleTxt: AppStrings.aboutUs,
            actionWidget: false,
            horizontalPadding: 5.w,
          ),
        ),
        body: Column(
          children: [
            SizeConfig.sH10,
            CommonAboutUsWidget(
              title: AppStrings.aboutUs,
            ),
            SizeConfig.sH16,
            CommonAboutUsWidget(
              title: AppStrings.ourMission,
            ),
            SizeConfig.sH16,
            CommonAboutUsWidget(
              title: AppStrings.ourVision,
            ),
            SizeConfig.sH30,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomBtn(
                onTap: () {},
                title: AppStrings.contactUs,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                bgColor: AppColors.primaryColor,
              ),
            )
          ],
        ));
  }
}
