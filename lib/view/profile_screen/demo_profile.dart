import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';

class DemoProfile extends StatelessWidget {
  const DemoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular Progress Background (Outer Yellow Circle)
                SizedBox(
                  height: Get.width * 0.28, // Adjust size as needed
                  width: Get.width * 0.28,
                  child: CircularProgressIndicator(
                    value: 0.8, // 40% progress
                    strokeWidth: 8.w, // Adjust thickness
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.yellow),
                    backgroundColor: AppColors.white.withOpacity(0.3),
                  ),
                ),
                // Profile Image
                CircleAvatar(
                  radius: Get.width * 0.12,
                  backgroundColor: AppColors.white,
                  backgroundImage: const NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg',
                  ),
                ),
                // Camera Icon Positioned Bottom Right
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: LocalAssets(
                      imagePath: AppImageAssets.cameraIcon,
                      scaleSize: 3.w,
                    ),
                  ),
                ),
                // Profile Completion Percentage Text
                Positioned(
                  bottom: -20.h,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: AppStrings.profileCompletion,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: '80%',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.blue34,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
