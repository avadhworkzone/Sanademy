import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class CommonContainerWidget extends StatelessWidget {
  const CommonContainerWidget({super.key, required this.listData});

  final listData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: listData['color']),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment:
                //     MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 80.w),
                          child: CustomText(
                            listData['titleTxt'],
                            fontSize: 20.sp,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black0E,
                          ),
                        ),
                        SizeConfig.sH8,
                        CustomText(
                          listData['lectures'],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black0E,
                        ),
                        SizeConfig.sH4,
                        CustomText(
                          listData['time'],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black0E,
                        ),
                        SizeConfig.sH8,
                        Container(
                            // height: 50.h,
                            // width: 137.39.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 2.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.greenAccent,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 17.r,
                                  backgroundImage: const NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'),
                                ),
                                SizeConfig.sW10,
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7.h),
                                  child: Column(
                                    children: [
                                      CustomText(
                                        'Instructor',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: AppColors.black0E,
                                      ),
                                      SizeConfig.sH3,
                                      CustomText(
                                        'John Doe',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp,
                                        color: AppColors.black0E,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            right: 0,
            child: LocalAssets(
              imagePath: AppImageAssets.teacherImg,
              height: Get.width * 0.5,
            ))
      ],
    );
  }
}
