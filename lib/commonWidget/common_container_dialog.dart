import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_snackbar.dart';

Container contactUsMethod(
    {required String preIcon,
    required String title,
    String? postIcon1,
    String? postIcon2,
    VoidCallback? onTap,
    Color? preIconBgColor,
    Color? preIconColor,
    String? postIcon}) {
  Future<void> launchWhatsApp(
      {required String phone,
      required String urlString,
      required String subTitleMsg}) async {
    final url = "$urlString/$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      commonSnackBar(title: 'Error', subTitle: subTitleMsg);
    }
  }

  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyE0),
        borderRadius: BorderRadius.circular(12.r)),
    child: Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: preIconBgColor ?? AppColors.whitef7,
            child: LocalAssets(
              imagePath: preIcon,
              height: 20.h,
              width: 20.w,
              imgColor: preIconColor ?? AppColors.white,
            ),
          ),
          SizedBox(width: 8.w),
          CustomNewText(title,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.blue34),
          const Spacer(),
          Row(
            children: [
              if (postIcon1 != null)
                GestureDetector(
                  onTap: () {
                    launchWhatsApp(
                        phone: title,
                        urlString: 'https://wa.me',
                        subTitleMsg: 'Could not launch WhatsApp');
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.whitef7,
                    child: LocalAssets(
                      imagePath: postIcon1,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ),
              SizedBox(width: 5.w),
              if (postIcon2 != null)
                GestureDetector(
                  onTap: () {
                    launchWhatsApp(
                        urlString: 'https://t.me',
                        phone: "+91$title",
                        subTitleMsg: 'Could not launch Telegram');
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.whitef7,
                    child: LocalAssets(
                      imagePath: postIcon2,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ),
              SizedBox(width: 5.w),
              InkWell(
                onTap: onTap ??
                    () {
                      Clipboard.setData(ClipboardData(text: title));
                      commonSnackBar(
                          title: 'Copied!',
                          subTitle: '$title copied to clipboard');
                    },
                child: CircleAvatar(
                  backgroundColor: AppColors.whitef7,
                  child: LocalAssets(
                    imagePath: postIcon ?? AppImageAssets.copyIcon,
                    // imagePath: AppImageAssets.enrollSuccessfullyImg,
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
