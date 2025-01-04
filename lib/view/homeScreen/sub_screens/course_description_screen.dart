import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view/dialog/payment_option_dialog.dart';
import 'package:sanademy/view/homeScreen/sub_screens/lectures_videos_screen.dart';
import 'package:sanademy/view_model/bottom_bar_view_model.dart';
import 'package:sanademy/view_model/description_view_model.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';
import 'package:sanademy/view_model/lectures_videos_view_model.dart';

class CourseDescriptionScreen extends StatefulWidget {
  const CourseDescriptionScreen({
    super.key,
    required this.courseId,
    required this.videoUrl,
  });

  final String courseId;
  final String videoUrl;

  @override
  State<CourseDescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<CourseDescriptionScreen> {
  DescriptionViewModel descriptionViewModel = Get.put(DescriptionViewModel());
  BottomBarViewModel bottomBarViewModel = Get.find<BottomBarViewModel>();
  LecturesVideosViewModel lecturesVideosViewModel =
      Get.put(LecturesVideosViewModel());
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();

  @override
  void initState() {
    descriptionApiCall();
    super.initState();
  }

  descriptionApiCall() async {
    await descriptionViewModel.courseDetailViewModel(courseId: widget.courseId);
    descriptionViewModel.chewiePlayer(widget.videoUrl);
  }

  @override
  void dispose() {
    descriptionViewModel.videoPlayerController.dispose();
    descriptionViewModel.chewieControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(() => descriptionViewModel.courseDetailResponseStatus.value ==
              ResponseStatus.Completed
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImageAssets
                            .appLogo), // Replace with your image path
                        fit: BoxFit
                            .cover, // Adjusts how the image fits the container
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          descriptionViewModel.isLoader.value == true
                              ? const Center(
                                  child: SizedBox(
                                      // height: 50.h,
                                      // width: 50.h,
                                      child: LocalAssets(
                                    imagePath: AppImageAssets.sanademaylogo,
                                    imgColor: AppColors.primaryColor,
                                  )),
                                )
                              : SizedBox(
                                  // height: 300.h,
                                  // width: 430.w,
                                  child: AspectRatio(
                                    aspectRatio: descriptionViewModel
                                        .chewieControllers
                                        .videoPlayerController
                                        .value
                                        .aspectRatio,
                                    child: Chewie(
                                      controller: descriptionViewModel
                                          .chewieControllers,
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 13.w, vertical: 13.w),
                                    margin: EdgeInsets.only(left: 15.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.white
                                                .withOpacity(0.5))),
                                    child: Icon(
                                        weight: 10.w,
                                        size: 12.w,
                                        Icons.arrow_back_ios_new,
                                        color: AppColors.white),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 11.w, vertical: 11.w),
                                  // alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.white
                                              .withOpacity(0.5))),
                                  child: Icon(
                                      weight: 10.w,
                                      size: 15.w,
                                      Icons.more_vert_rounded,
                                      color: AppColors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  /// VIDEO VIEW
                  // Stack(
                  //   children: [
                  //     SizedBox(
                  //       height: Get.width * 0.7,
                  //       width: Get.width,
                  //       child: descriptionViewModel.isLoader.value == true
                  //           ? Center(
                  //         child: SizedBox(
                  //             height: 50.h,
                  //             width: 50.h,
                  //             child: const LocalAssets(
                  //               imagePath: AppImageAssets.sanademaylogo,
                  //               imgColor: AppColors.primaryColor,
                  //             )),
                  //       )
                  //           : SizedBox(
                  //         height: 300.h,
                  //         width: 430.w,
                  //         child: AspectRatio(
                  //           aspectRatio: descriptionViewModel
                  //               .chewieControllers.videoPlayerController.value.aspectRatio,
                  //           child: Stack(
                  //             alignment: Alignment.center,
                  //             children: [
                  //               Chewie(
                  //                 controller: descriptionViewModel.chewieControllers,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       child: GestureDetector(
                  //           onTap: () {
                  //             Get.back();
                  //           },
                  //           child: Container(
                  //             margin: EdgeInsets.only(left: 10.w, top: 10.w, right: 10.w),
                  //             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  //             decoration: BoxDecoration(
                  //                 color: AppColors.black.withOpacity(0.20),
                  //                 borderRadius: BorderRadius.circular(17)),
                  //             child: const Icon(
                  //               Icons.arrow_back,
                  //               color: AppColors.white,
                  //             ),
                  //           )),
                  //     ),
                  //   ],
                  // ),
                  SizeConfig.sH16,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomNewText(
                              'Artificial Intelligence \nCourse ',
                              color: AppColors.blue34,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '150,000', // Main amount
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColors.blue34,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' IQD', // Currency
                                        style: TextStyle(
                                          fontSize:
                                              16.sp, // Slightly smaller font
                                          color: AppColors
                                              .blue34, // Same color as the amount
                                          fontWeight: FontWeight
                                              .w400, // Normal weight for currency
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    CustomText('280,000 IQD',
                                        fontSize: 12.sp,
                                        color: AppColors.grey74),
                                    SizeConfig.sW5,
                                    CustomText('-40%',
                                        fontSize: 12.sp,
                                        color: AppColors.borderColor),
                                  ],
                                ),
                              ],
                            ),
                            SizeConfig.sH10,

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizeConfig.sH15,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.w),
                    decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: AppColors.borderColor),
                        color:
                        AppColors.borderColor.withOpacity(0.1)),
                    child: Row(
                      children: [
                      LocalAssets(imagePath: 'assets/images/doc_file_icon.png',scaleSize: 3.w,),
                        SizeConfig.sW10,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          CustomText('AI Course.doc',color: AppColors.blue34,fontWeight: FontWeight.w600,fontSize: 12.sp,),
                          CustomText('12.00 MB',color: AppColors.blue34,fontSize: 12.sp,),
                        ],),
                        Spacer(),
                        CircleAvatar(
                          radius: 15.w,
                          backgroundColor: AppColors.borderColor,
                          child: Icon(Icons.download,color: AppColors.white,size: 15.w,),),
                        SizeConfig.sW10,
                        CustomText('Download',color: AppColors.borderColor,fontSize: 12.sp,fontWeight: FontWeight.w600,)
                    ],),
                  )
                ],
              ),
            )
          : const Material()),
    );
  }
}

/// YOUTUBE PLAYER
/* : SizedBox(
                                  height: Get.width * 0.7,
                                  width: Get.width,
                                  child: YoutubePlayerBuilder(
                                    player: YoutubePlayer(
                                      controller: descriptionViewModel.youtubePlayerController!.value,
                                      showVideoProgressIndicator: true,
                                      onReady: () {
                                        descriptionViewModel.youtubePlayerController?.value.addListener(() {
                                          descriptionViewModel.onTouch.value = descriptionViewModel
                                                  .youtubePlayerController?.value.value.isPlaying ??
                                              false;
                                        });
                                      },
                                    ),
                                    builder: (context, player) => player,
                                  ),
                                ),*/

/// VIDEO PLAYER
/*     VideoPlayer(descriptionViewModel.videoPlayerController),
                                        InkWell(
                                          onTap: () {
                                            if (descriptionViewModel.videoPlayerController.value.isPlaying) {
                                              setState(() {
                                                descriptionViewModel.videoPlayerController.pause();
                                              });
                                            } else {
                                              setState(() {
                                                descriptionViewModel.videoPlayerController.play();
                                              });
                                            }
                                          },
                                          child: descriptionViewModel.videoPlayerController.value.isPlaying
                                              ? const Icon(Icons.pause_circle, size: 50, color: Colors.white)
                                              : const Icon(Icons.play_circle, size: 50, color: Colors.white),
                                        ),*/
