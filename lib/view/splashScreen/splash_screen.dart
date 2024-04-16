import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
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
        () => SharedPreferenceUtils.getIsLogin() == true
            ? Get.to(() => const BottomBar())
            : Get.to(() => const SignUpScreen()));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Align(
            alignment: Alignment.center,
            child: LocalAssets(
              imagePath: AppImageAssets.splashImage,
              height: Get.width / 1.5,
            )));
  }
}
