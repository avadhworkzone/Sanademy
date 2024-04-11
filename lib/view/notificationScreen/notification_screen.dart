import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          child: Column(
        children: [
          commonBackArrowAppBar(
              titleTxt: AppStrings.notification,
              actionTitle: AppStrings.clearAll,
              leadingWidget: false),
          SizeConfig.sH10,
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 22.w),
                      color: index.isOdd
                          ? AppColors.white
                          : AppColors.color8B.withOpacity(0.3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 25.w,
                                backgroundColor: AppColors.colorA8,
                                child: LocalAssets(
                                    imagePath: index.isOdd
                                        ? AppImageAssets.updateIcon
                                        : AppImageAssets.alertIcon),
                              )
                            ],
                          ),
                          SizeConfig.sW20,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  index.isOdd
                                      ? 'App Update Available'
                                      : 'Assignment Due Date Reminder',
                                  color: AppColors.black13,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.sp,
                                ),
                                SizeConfig.sH6,
                                CustomText(
                                  index.isOdd
                                      ? 'Update your app! New version now available with enhanced features and improvements.'
                                      : 'Don\'t forget! Your math assignment is due tomorrow. Finish up and submit to stay on track',
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black0E.withOpacity(0.80),
                                ),
                                SizeConfig.sH6,
                                CustomText(
                                  '11 Feb, 2024 - 9:30 PM',
                                  fontSize: 12.sp,
                                  color: AppColors.black0E,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 0.0,
                      color: AppColors.black.withOpacity(0.20),
                    )
                  ],
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
