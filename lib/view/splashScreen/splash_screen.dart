import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 5),
        () =>
            // SharedPreferenceUtils.getIsLogin() == true
            //     ?
            Get.offAll(() => const BottomBar())
        // : Get.offAll(() => const SignUpScreen())
        );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: commonAppBar(
            appBarBackgroundColor: AppColors.primaryColor,
            sizedBox: const SizedBox(),
            titleTxt: ''),
        body: Align(
            alignment: Alignment.center,
            child: LocalAssets(
              imagePath: AppImageAssets.splashImage,
              height: Get.width / 1.5,
            )));
  }
}
