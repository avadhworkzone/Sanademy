import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

class CommonContainerWidget extends StatefulWidget {
  const CommonContainerWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.numberOfLecture,
      required this.hours,
      required this.minutes, required this.teacherImage, required this.teacherName});

  final String title;
  final String numberOfLecture;
  final String hours;
  final String minutes;
  final String teacherImage;
  final String teacherName;
  final List<Color> color;

  @override
  State<CommonContainerWidget> createState() => _CommonContainerWidgetState();
}

class _CommonContainerWidgetState extends State<CommonContainerWidget> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();

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
                gradient: LinearGradient(colors: widget.color),
                image: const DecorationImage(
                    image: AssetImage(AppImageAssets.recommendedBgImg),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 80.w),
                          child: CustomText(
                            widget.title ?? '',
                            fontSize: 20.sp,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black0E,
                          ),
                        ),
                        SizeConfig.sH8,
                        CustomText(
                          '${widget.numberOfLecture} Lectures',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black0E,
                        ),
                        SizeConfig.sH4,
                        CustomText(
                          '${widget.hours} hours ${widget.minutes} minutes',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black0E,
                        ),
                        SizeConfig.sH8,
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 2.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.black.withOpacity(0.20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35.h,
                                  width: 35.h,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: NetWorkOcToAssets(
                                      imgUrl: widget.teacherImage!,
                                      boxFit: BoxFit.contain,
                                    ),
                                  ),
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
                                        widget.teacherName!,
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
