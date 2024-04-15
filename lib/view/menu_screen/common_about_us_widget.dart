import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class CommonAboutUsWidget extends StatelessWidget {
  const CommonAboutUsWidget({super.key, this.title, this.subTitle});

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            '• ${title}',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black0E,
          ),
          SizeConfig.sH10,
          CustomText(
            subTitle??'Lorem ipsum dolor sit amet consectetur. Elementum elementum turpis vestibulum arcu nullam. Ultrices pulvinar viverra leo tortor phasellus amet at turpis adipiscing. Tincidunt scelerisque proin amet eleifend cursus eget adipiscing. Tortor id enim fermentum ipsum at.',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black0E,
          ),
        ],
      ),
    );
  }
}
