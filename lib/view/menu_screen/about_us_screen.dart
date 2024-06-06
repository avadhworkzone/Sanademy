import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
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

  @override
  void initState() {
    getAboutUsApiCall();
    super.initState();
  }

  getAboutUsApiCall() async {
    await aboutUsViewModel.getAboutUsData();
  }

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
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                SizeConfig.sH10,
                Html(
                  data: aboutUsViewModel.description.value,
                  shrinkWrap: true,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                  child: CustomBtn(
                    onTap: () {
                      Get.to(const ContactUsScreen());
                    },
                    title: AppStrings.contactUs,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    bgColor: AppColors.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
