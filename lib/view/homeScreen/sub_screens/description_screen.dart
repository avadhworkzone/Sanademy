import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({
    super.key,
    required this.courseId,
    required this.videoUrl,

  });

  final String courseId;
  final String videoUrl;


  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  DescriptionViewModel descriptionViewModel = Get.put(DescriptionViewModel());
  BottomBarViewModel bottomBarViewModel = Get.find<BottomBarViewModel>();
  LecturesVideosViewModel lecturesVideosViewModel = Get.put(LecturesVideosViewModel());
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
    return SafeArea(
      child: Material(
        child: Obx(() => descriptionViewModel.courseDetailResponseStatus.value == ResponseStatus.Completed
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    /// VIDEO VIEW
                    Stack(
                      children: [
                        SizedBox(
                          height: Get.width * 0.7,
                          width: Get.width,
                          child: descriptionViewModel.isLoader.value == true
                              ? Center(
                                  child: SizedBox(
                                      height: 50.h,
                                      width: 50.h,
                                      child: const LocalAssets(
                                        imagePath: AppImageAssets.sanademaylogo,
                                        imgColor: AppColors.primaryColor,
                                      )),
                                )
                              : SizedBox(
                                  height: 300.h,
                                  width: 430.w,
                                  child: AspectRatio(
                                    aspectRatio: descriptionViewModel
                                        .chewieControllers.videoPlayerController.value.aspectRatio,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Chewie(
                                          controller: descriptionViewModel.chewieControllers,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10.w, top: 10.w, right: 10.w),
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                                decoration: BoxDecoration(
                                    color: AppColors.black.withOpacity(0.20),
                                    borderRadius: BorderRadius.circular(17)),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.white,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizeConfig.sH16,

                    /// ENROLL BUTTON
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: CustomBtn(
                        onTap: () {
                          SharedPreferenceUtils.getIsLogin() == true
                              ?
                              /// payment Option dialog
                              paymentOptionDialog(context: context,
                                  userMobileNumber: homeScreenViewModel.homeResModel.data!.user!.phoneNumber.toString(),
                                userPhoneCode: homeScreenViewModel.homeResModel.data!.user!.countryCode.toString(),
                                userId: homeScreenViewModel.homeResModel.data!.user!.id.toString()
                              )
                              : Get.offAll(() => const SignUpScreen());

                          /// Enrollment successfully dialog
                        },
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        radius: 10.r,
                        title: AppStrings.enrollNow,
                        bgColor: AppColors.primaryColor,
                        textColor: AppColors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// DESCRIPTION
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: CustomText(
                              AppStrings.description,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: AppColors.black0E,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Html(
                              data: descriptionViewModel.courseDetailResModel.data!.description ?? '',
                              shrinkWrap: true,
                            ),
                          ),
                          SizeConfig.sH25,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Row(
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
                                            '${descriptionViewModel.courseDetailResModel.data!.numberOfLecture} ${AppStrings.lectures}',
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
                                            descriptionViewModel.courseDetailResModel.data!.language ?? '',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                            color: AppColors.black0E,
                                          ),
                                        ],
                                      ),
                                      SizeConfig.sH8,
                                      if(descriptionViewModel.courseDetailResModel.data!.taskIncluded == 1)Row(
                                        children: [
                                          LocalAssets(
                                            imagePath: AppImageAssets.taskIcn,
                                            height: 24.h,
                                            width: 24.w,
                                          ),
                                          SizeConfig.sW8,
                                        CustomText(
                                           AppStrings.taskIncluded,
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
                                          SizeConfig.sW8,
                                          CustomText(
                                            '${descriptionViewModel.courseDetailResModel.data!.hours ?? ''} hours ${descriptionViewModel.courseDetailResModel.data!.minutes ?? ''} minutes',
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
                                      if(descriptionViewModel.courseDetailResModel.data!.certificate == 1)Row(
                                        children: [
                                          LocalAssets(
                                            imagePath: AppImageAssets.certificates,
                                            height: 24.h,
                                            width: 24.w,
                                          ),
                                          SizeConfig.sW8,
                                          CustomText(
                                            AppStrings.certificates,
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
                          ),
                          SizeConfig.sH25,

                          /// REQUIREMENTS
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  tilePadding: EdgeInsets.only(left: 5.w),
                                  title: CustomText(
                                    AppStrings.requirements,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black0E,
                                  ),
                                  children: [
                                    Html(
                                      data:
                                          descriptionViewModel.courseDetailResModel.data!.requirements ?? '',
                                      shrinkWrap: true,
                                    )
                                  ]),
                            ),
                          ),
                          Divider(
                            color: AppColors.black0E.withOpacity(0.2),
                          ),

                          /// WHAT WILL YOU LEARN
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  tilePadding: EdgeInsets.only(left: 5.w),
                                  //childrenPadding: EdgeInsets.only(left: 20.w),
                                  title: CustomText(
                                    AppStrings.whatWillYouLearn,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black0E,
                                  ),
                                  children: [
                                    Html(
                                      data:
                                          descriptionViewModel.courseDetailResModel.data!.whatWillYouLearn ??
                                              '',
                                      shrinkWrap: true,
                                    )
                                  ]),
                            ),
                          ),
                          Divider(
                            color: AppColors.black0E.withOpacity(0.2),
                          ),

                          /// WHO THIS COURSE IS FOR
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  tilePadding: EdgeInsets.only(left: 5.w),
                                  title: CustomText(
                                    AppStrings.whoThisCourseIsFor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black0E,
                                  ),
                                  children: [
                                    Html(
                                      shrinkWrap: true,
                                      data: descriptionViewModel
                                              .courseDetailResModel.data!.whoThisCourseIsFor ??
                                          '',
                                    )
                                  ]),
                            ),
                          ),
                          Divider(
                            color: AppColors.black0E.withOpacity(0.2),
                          ),

                          /// INSTRUCTOR DETAILS
                          SizeConfig.sH25,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: CustomText(
                              AppStrings.instructor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: AppColors.black0E,
                            ),
                          ),
                          SizeConfig.sH16,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 4.0)
                                  ],
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: Theme(
                                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                      tilePadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                                      title: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 40.r,
                                            backgroundImage: NetworkImage(descriptionViewModel
                                                    .courseDetailResModel.data!.teacher!.image ??
                                                ''),
                                          ),
                                          SizeConfig.sW8,
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                descriptionViewModel
                                                        .courseDetailResModel.data!.teacher!.name ??
                                                    '',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.sp,
                                                color: AppColors.black,
                                              ),
                                              CustomText(
                                                'Senior Mathematician',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15.sp,
                                                color: AppColors.black,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: AppColors.black0E.withOpacity(0.2),
                                            ),
                                            Html(
                                              data: descriptionViewModel
                                                      .courseDetailResModel.data!.teacher!.description ??
                                                  '',
                                              shrinkWrap: true,
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),

                          /// COURSE CONTENT DETAILS
                          SizeConfig.sH25,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: CustomText(
                              AppStrings.courseContent,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: AppColors.black0E,
                            ),
                          ),
                          SizeConfig.sH16,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 1),
                                    blurRadius: 4.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    descriptionViewModel.courseDetailResModel.data!.courseContents!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var courseContent =
                                      descriptionViewModel.courseDetailResModel.data!.courseContents![index];
                                  var courseId = descriptionViewModel.courseDetailResModel.data!.id;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Column(
                                      children: [
                                        Theme(
                                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            tilePadding:
                                                const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                            title: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      courseContent.title ?? '',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15,
                                                      color: AppColors.black,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Get.to(() => LecturesVideoScreen(
                                                                  lectureVideoUrls: courseContent.lectures!,
                                                                  contentId: courseContent.id.toString(),
                                                                  courseId: courseId.toString(),
                                                                ));
                                                          },
                                                          child: CustomText(
                                                            "${courseContent.numberOfLecture ?? ''} ${AppStrings.courseContentLectures}",
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 15,
                                                            color: AppColors.primaryColor,
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        ),
                                                        SizeConfig.sW10,
                                                        CustomText(
                                                          "• ${courseContent.minutes ?? ''} ${AppStrings.mins}",
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 15,
                                                          color: AppColors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            children: [
                                              Html(
                                                data: courseContent.description ?? '',
                                                shrinkWrap: true,
                                              )
                                            ],
                                          ),
                                        ),
                                        if (index !=
                                            descriptionViewModel
                                                    .courseDetailResModel.data!.courseContents!.length -
                                                1)
                                          Divider(
                                            color: AppColors.black0E.withOpacity(0.2),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const Material()),
      ),
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
