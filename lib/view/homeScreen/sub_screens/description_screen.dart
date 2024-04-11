import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/description_view_model.dart';
import 'package:video_player/video_player.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  DescriptionViewModel descriptionViewModel = Get.put(DescriptionViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 328.66.h,
                  width: 430.w,
                  child: AspectRatio(
                    aspectRatio: descriptionViewModel.videoPlayerController.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(descriptionViewModel.videoPlayerController),
                        InkWell(
                            onTap: () {
                              setState(() {
                                descriptionViewModel.onTouch = true;
                              });
                              if (descriptionViewModel.videoPlayerController.value.isPlaying) {
                                descriptionViewModel.videoPlayerController.pause();
                              } else {
                                // If the video is paused, play it.
                                descriptionViewModel.videoPlayerController.play();
                              }
                              Future.delayed(
                                const Duration(seconds: 2),
                                    () => setState(() {
                                  descriptionViewModel.onTouch = false;
                                }),
                              );
                            },
                            child: descriptionViewModel.onTouch == true &&
                                descriptionViewModel.videoPlayerController.value.isPlaying == true
                                ? const Icon(Icons.pause_circle, size: 50,color: Colors.white,)
                                : descriptionViewModel.onTouch == true &&
                                descriptionViewModel.videoPlayerController.value.isPlaying ==
                                    false
                                ? const Icon(Icons.play_circle, size: 50,color: Colors.white)
                                :Container())
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20.w,
                  top: 20.h,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        height: 56.h,
                        width: 56.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.whiteF5,
                        ),
                        child: Center(
                            child: Icon(
                          Icons.arrow_back,
                          size: 20.h,
                          color: AppColors.black,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizeConfig.sH16,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomBtn(
                onTap: () {},
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                radius: 10.r,
                title: AppStrings.enrollNow,
                bgColor: AppColors.primaryColor,
                textColor: AppColors.white,
              ),
            ),
            SizeConfig.sH16,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    AppStrings.description,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: AppColors.black0E,
                  ),
                  SizeConfig.sH8,
                  CustomText(
                    'Lorem ipsum dolor sit amet consectetur. In eu vitae habitant neque maecenas et in. Sit etiam quis scelerisque nibh vel neque. Volutpat tortor dolor eleifend consequat. Lectus nulla eget tortor enim in ac faucibus nec sed. Risus est sed blandit enim nibh pellentesque dolor libero etiam. Cursus sed sed integer eu pellentesque aliquet.',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.black0E,
                  ),
                  SizeConfig.sH25,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                LocalAssets(
                                  imagePath: AppImageAssets.bookIcn,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizeConfig.sW8,
                                CustomText(
                                  '12 lectures',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.black0E,
                                ),
                              ],
                            ),
                            SizeConfig.sH8,
                            Row(
                              children: [
                                LocalAssets(
                                  imagePath: AppImageAssets.languageIcn,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizeConfig.sW8,
                                CustomText(
                                  'Taught in Kurdish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.black0E,
                                ),
                              ],
                            ),
                            SizeConfig.sH8,
                            Row(
                              children: [
                                LocalAssets(
                                  imagePath: AppImageAssets.taskIcn,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizeConfig.sW8,
                                CustomText(
                                  'Tasks Included',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.black0E,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later,
                                  color: AppColors.black,
                                  size: 20.h,
                                ),
                                // LocalAssets(
                                //   imagePath: AppImageAssets.bookIcn,
                                //   height: 24.h,
                                //   width: 24.w,
                                // ),
                                SizeConfig.sW8,
                                CustomText(
                                  '7 hours 40 minutes',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.black0E,
                                ),
                              ],
                            ),
                            SizeConfig.sH8,
                            Row(
                              children: [
                                LocalAssets(
                                  imagePath: AppImageAssets.educationIcn,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizeConfig.sW8,
                                CustomText(
                                  '1,324 enrollments',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.black0E,
                                ),
                              ],
                            ),
                            SizeConfig.sH8,
                            Row(
                              children: [
                                LocalAssets(
                                  imagePath: AppImageAssets.certificates,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizeConfig.sW8,
                                CustomText(
                                  'Certificates',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.black0E,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizeConfig.sH25,
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                        tilePadding: EdgeInsets.only(left: 5.w),
                       // childrenPadding: EdgeInsets.only(left: 20.w),
                        title: CustomText(
                          AppStrings.requirements,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black0E,
                        ),
                        children: List.generate(
                            requirementsList.length,
                            (index) => Padding(
                              padding:  EdgeInsets.only(bottom: 5.h),
                              child: Column(
                                children: [
                                  index==0? Divider():SizedBox(),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Row(
                                      children: [
                                        CustomText(
                                         "•",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.sp,
                                          color: AppColors.black0E,
                                        ),
                                        SizeConfig.sW5,
                                        CustomText(
                                          requirementsList[index],
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: AppColors.black0E,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                  ),
                  Divider(
                    color: AppColors.black0E.withOpacity(0.2),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                        tilePadding: EdgeInsets.only(left: 5.w),
                        //childrenPadding: EdgeInsets.only(left: 20.w),
                        title: CustomText(
                          AppStrings.whatWillYouLearn,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black0E,
                        ),
                        children: List.generate(
                            requirementsList.length,
                            (index) => Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Column(
                                    children: [
                                     index==0? Divider():SizedBox(),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Row(
                                          children: [
                                            CustomText(
                                              "•",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.sp,
                                              color: AppColors.black0E,
                                            ),
                                            SizeConfig.sW10,
                                            CustomText(
                                              requirementsList[index],
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: AppColors.black0E,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                  ),
                  Divider(
                    color: AppColors.black0E.withOpacity(0.2),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                        tilePadding: EdgeInsets.only(left: 5.w),
                       // childrenPadding: EdgeInsets.only(left: 20.w),
                        title: CustomText(
                          AppStrings.whatWillYouLearn,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black0E,
                        ),
                        children: List.generate(
                            requirementsList.length,
                            (index) => Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Column(
                                    children: [
                                      index==0? Divider():SizedBox(),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Row(
                                          children: [
                                            CustomText(
                                              "•",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.sp,
                                              color: AppColors.black0E,
                                            ),
                                            SizeConfig.sW5,
                                            CustomText(
                                              requirementsList[index],
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: AppColors.black0E,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                  ),
                  Divider(
                    color: AppColors.black0E.withOpacity(0.2),
                  ),
                  SizeConfig.sH25,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List requirementsList = [
    'requirements1',
    'requirements2',
    'requirements3',
    'requirements4',
  ];
}
