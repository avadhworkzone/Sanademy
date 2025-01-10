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
import 'package:sanademy/utils/app_constant.dart';
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

import 'select_payment_method_screen.dart';

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
    // await descriptionViewModel.courseDetailViewModel(courseId: widget.courseId);
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() =>
              // descriptionViewModel.courseDetailResponseStatus.value ==
              //         ResponseStatus.Completed
              //     ?
              SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 13.w, vertical: 13.w),
                                      margin: EdgeInsets.only(left: 15.w),
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.2),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.borderColor),
                          color: AppColors.borderColor.withOpacity(0.1)),
                      child: Row(
                        children: [
                          LocalAssets(
                            imagePath: 'assets/images/doc_file_icon.png',
                            scaleSize: 3.w,
                          ),
                          SizeConfig.sW10,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'AI Course.doc',
                                color: AppColors.blue34,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                              CustomText(
                                '12.00 MB',
                                color: AppColors.blue34,
                                fontSize: 12.sp,
                              ),
                            ],
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 15.w,
                            backgroundColor: AppColors.borderColor,
                            child: Icon(
                              Icons.download,
                              color: AppColors.white,
                              size: 15.w,
                            ),
                          ),
                          SizeConfig.sW10,
                          CustomText(
                            'Download',
                            color: AppColors.borderColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                    SizeConfig.sH15,
                    buildDescriptionSection(),
                    SizeConfig.sH15,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: AppColors.greyE0,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomNewText(
                              "The course includes:",
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            ),
                            SizedBox(height: 5.h),
                            _buildCourseDetailRow(AppImageAssets.videoPlay,
                                "8.5 hours on-demand video"),
                            SizedBox(height: 9.h),
                            _buildCourseDetailRow(
                                AppImageAssets.list, "2 articles"),
                            SizedBox(height: 9.h),
                            _buildCourseDetailRow(AppImageAssets.downloadCircle,
                                "1 downloadable resource"),
                            SizedBox(height: 9.h),
                            _buildCourseDetailRow(AppImageAssets.certificate,
                                "Certificate of completion"),
                            SizedBox(height: 9.h),
                            _buildCourseDetailRow(
                                AppImageAssets.tv, "Access on mobile and TV"),
                          ],
                        ),
                      ),
                    ),
                    SizeConfig.sH15,

                    /// Requirements Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.greyE0,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: _buildExpandableSection(
                                  title: "Requirements",
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildBulletPoint(
                                          "How to recognize the role of ChatGPT in ..."),
                                      _buildBulletPoint(
                                          "How to optimize daily marketing routine"),
                                      _buildBulletPoint(
                                          "How to optimize daily marketing routine"),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(color: AppColors.greyE0),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: _buildExpandableSection(
                                  title: "What will you learn?",
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildBulletPoint("Understand AI basics"),
                                      _buildBulletPoint(
                                          "Learn to use AI tools effectively"),
                                      _buildBulletPoint(
                                          "Build your own AI-powered applications"),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(color: AppColors.greyE0),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: _buildExpandableSection(
                                  title: "Who this course is for?",
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildBulletPoint(
                                          "Beginners who want to learn AI"),
                                      _buildBulletPoint(
                                          "Professionals looking to upskill"),
                                      _buildBulletPoint(
                                          "Anyone curious about AI applications"),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          )),
                    ),
                    SizeConfig.sH15,

                    /// Course Content Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomNewText(
                            "Course content",
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                          SizeConfig.sH10,
                          ListView.builder(
                            itemCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: AppColors.greyE0),
                                    ),
                                    child: Theme(
                                      data: Theme.of(Get.context!).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        initiallyExpanded: true,
                                        title: Padding(
                                          padding: EdgeInsets.only(bottom: 7.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomNewText(
                                                    "Introduction to Mathematics",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          LocalAssets(
                                                            imagePath:
                                                                AppImageAssets
                                                                    .bookOutlined,
                                                            height: 18.sp,
                                                            width: 18.sp,
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          CustomNewText(
                                                            "3 Lectures",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20.w),
                                                      Row(
                                                        children: [
                                                          LocalAssets(
                                                            imagePath:
                                                                AppImageAssets
                                                                    .clockIcon,
                                                            height: 18.sp,
                                                            width: 18.sp,
                                                            imgColor: AppColors
                                                                .blue34,
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          CustomNewText(
                                                            "15 Mins",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              CircularProgressWithText(
                                                progress: 0.6,
                                                size: 30.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                        children: [
                                          const Divider(
                                              color: AppColors.greyE0),
                                          ListView.separated(
                                            separatorBuilder: (context,
                                                    index) =>
                                                const Divider(
                                                    color: AppColors.greyE0),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              String icon;
                                              switch (index) {
                                                case 0:
                                                case 1:
                                                  icon =
                                                      AppImageAssets.checkmark;
                                                  break;
                                                case 2:
                                                  icon = AppImageAssets
                                                      .yellowPlay; // Yellow circle (play icon)
                                                  break;
                                                case 3:
                                                  icon = AppImageAssets
                                                      .lock; // Lock icon
                                                  break;
                                                default:
                                                  icon = AppImageAssets
                                                      .lock; // Default fallback
                                              }
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 9.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          icon,
                                                          height: 16.sp,
                                                          width: 16.sp,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        SizedBox(width: 10.w),
                                                        CustomNewText(
                                                          "Introduction to Mathematics",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        LocalAssets(
                                                          imagePath:
                                                              AppImageAssets
                                                                  .clockIcon,
                                                          height: 14.sp,
                                                          width: 14.sp,
                                                          imgColor:
                                                              AppColors.blue34,
                                                        ),
                                                        SizedBox(width: 5.w),
                                                        CustomNewText(
                                                          "5 Mins",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizeConfig.sH15,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomUpdateBtn(
                        onTap: () {
                          showEnrollmentDialog(context);
                        },
                        title: AppStrings.enrollTheCourse,
                        radius: 15,
                        fontSize: 16.sp,
                      ),
                    ),

                    SizeConfig.sH40,
                  ],
                ),
              )
          // : const Material()
          ),
    );
  }
}
void showEnrollmentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width:
            MediaQuery.of(context).size.width * 0.90, // Almost full width
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.w), // Adjust padding for consistency
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.close,
                          color: Colors.transparent,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: LocalAssets(
                            imagePath: AppImageAssets.image1,
                            height: 95.h,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Do you want to Enroll in AI course for ',
                            style: TextStyle(
                              color: AppColors.blue34,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstants.metropolis,
                            ),
                          ),
                          TextSpan(
                            text: '15000',
                            style: TextStyle(
                              color: AppColors.blue34,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstants.metropolis,
                            ),
                          ),
                          TextSpan(
                            text: ' IQD',
                            style: TextStyle(
                              color: AppColors.blue34,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstants.metropolis,
                            ),
                          ),
                          TextSpan(
                            text: ' amount?',
                            style: TextStyle(
                              color: AppColors.blue34,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstants.metropolis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                        color: AppColors.greyF7,
                        border: Border.all(color: AppColors.greyE4),
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonRowForEnrollDialog(
                            title: AppStrings.coursePrice,
                            amount: "280,000 IQD",
                          ),
                          SizedBox(height: 2.h),
                          dottedLine(),
                          SizedBox(height: 2.h),
                          commonRowForEnrollDialog(
                            title: "${AppStrings.discountOfCourse} (25%)",
                            amount: "-120,000 IQD",
                          ),
                          SizedBox(height: 2.h),
                          dottedLine(),
                          SizedBox(height: 2.h),
                          commonRowForEnrollDialog(
                            title: AppStrings.yourCurrentBalance,
                            amount: "-100,000 IQD",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: commonRowForEnrollDialog(
                        title: AppStrings.pendingToPay,
                        fontSizeTitle: 14.sp,
                        fontWeightTitle: FontWeight.w600,
                        titleColor: AppColors.grey73,
                        fontSizeAmount: 14.sp,
                        fontWeightAmount: FontWeight.w700,
                        amountColor: AppColors.blue34,
                        amount: "60,000 IQD",
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                color: AppColors.greyF7,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: CustomText(
                                  AppStrings.cancel,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blue34,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: CustomUpdateBtn(
                            onTap: () {
                              Get.to(const SelectPaymentMethodScreen());
                            },
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            radius: 10,
                            title: AppStrings.payNow,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}


// void showEnrollmentDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 10.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Icon(
//                     Icons.close,
//                     color: Colors.transparent,
//                   ),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: LocalAssets(
//                       imagePath: AppImageAssets.image1,
//                       height: 95.h,
//                     ),
//                   ),
//                   // SizedBox(width: 10.w),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Do you want to Enroll in AI course for ',
//                       style: TextStyle(
//                         color: AppColors.blue34,
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: AppConstants.metropolis,
//                       ),
//                     ),
//                     TextSpan(
//                       text: '15000',
//                       style: TextStyle(
//                         color: AppColors.blue34,
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: AppConstants.metropolis,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'IQD',
//                       style: TextStyle(
//                         color: AppColors.blue34,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: AppConstants.metropolis,
//                       ),
//                     ),
//                     TextSpan(
//                       text: ' amount?',
//                       style: TextStyle(
//                         color: AppColors.blue34,
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: AppConstants.metropolis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
//                 decoration: BoxDecoration(
//                   color: AppColors.greyF7,
//                   border: Border.all(color: AppColors.greyE4),
//                   borderRadius: BorderRadius.circular(12.sp),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     commonRowForEnrollDialog(
//                       title: AppStrings.coursePrice,
//                       amount: "280,000 IQD",
//                     ),
//                     SizedBox(height: 2.h),
//                     dottedLine(),
//                     SizedBox(height: 2.h),
//                     commonRowForEnrollDialog(
//                       title: "${AppStrings.discountOfCourse} (25%)",
//                       amount: "-120,000 IQD",
//                     ),
//                     SizedBox(height: 2.h),
//                     dottedLine(),
//                     SizedBox(height: 2.h),
//                     commonRowForEnrollDialog(
//                       title: AppStrings.yourCurrentBalance,
//                       amount: "-100,000 IQD",
//                     ),
//                     // SizedBox(height: 2.h),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: commonRowForEnrollDialog(
//                   title: AppStrings.pendingToPay,
//                   fontSizeTitle: 14.sp,
//                   fontWeightTitle: FontWeight.w600,
//                   titleColor: AppColors.grey73,
//                   fontSizeAmount: 14.sp,
//                   fontWeightAmount: FontWeight.w700,
//                   amountColor: AppColors.blue34,
//                   amount: "60,000 IQD",
//                 ),
//               ),
//               SizedBox(height: 30.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         width: 150.w,
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 30.w, vertical: 15.h),
//                         decoration: BoxDecoration(
//                           color: AppColors.greyF7,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: CustomText(
//                           AppStrings.cancel,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.blue34,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 15.w),
//                   Expanded(
//                     child: CustomUpdateBtn(
//                       onTap: () {
//                         Get.to(const SelectPaymentMethodScreen());
//                       },
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16.sp,
//                       radius: 10,
//                       title: AppStrings.payNow,
//                       width: 150.w,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

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

Widget dottedLine() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
      30,
      (index) => CustomText(
        '-',
        color: AppColors.greyE4,
      ),
    ),
  );
}

Widget commonRowForEnrollDialog({
  required String title,
  required String amount,
  Color? titleColor,
  Color? amountColor,
  double? fontSizeTitle,
  double? fontSizeAmount,
  FontWeight? fontWeightTitle,
  FontWeight? fontWeightAmount,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        title,
        fontSize: fontSizeTitle ?? 12.sp,
        fontWeight: fontWeightTitle ?? FontWeight.w500,
        color: titleColor ?? AppColors.grey73,
      ),
      CustomText(
        amount,
        fontSize: fontSizeAmount ?? 12.sp,
        fontWeight: fontWeightAmount ?? FontWeight.w600,
        color: amountColor ?? AppColors.blue34,
      )
    ],
  );
}

// Helper method to build course details rows
Widget _buildCourseDetailRow(String icon, String text) {
  return Row(
    children: [
      Image.asset(
        icon,
        height: 18.sp,
        width: 18.sp,
        fit: BoxFit.contain,
      ),
      SizedBox(width: 7.w),
      Expanded(
        child: CustomNewText(
          text,
          fontSize: 14.sp,
          color: AppColors.grey73,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

// Helper method to build expandable sections
Widget _buildExpandableSection(
    {required String title, required Widget content}) {
  return Theme(
    data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: EdgeInsets.zero,
      tilePadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      initiallyExpanded: true,
      title: CustomNewText(
        title,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),
      children: [
        content,
      ],
    ),
  );
}

// Helper method to build bullet points
Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.teal,
          radius: 3.sp,
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: CustomNewText(
            text,
            fontSize: 14.sp,
            color: AppColors.grey73,
          ),
        ),
      ],
    ),
  );
}

Widget buildDescriptionSection() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNewText(
          "Description",
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
        ),
        SizeConfig.sH4,
        CustomNewText(
          "Ultimate ChatGPT, MJ, Gemini course for digital marketers. Gain a grasp of AI to delegate your marketing activities.",
          fontSize: 14.sp,
          color: AppColors.grey73,
          fontWeight: FontWeight.w400,
        ),
        SizeConfig.sH10,
        Row(
          children: [
            CustomNewText(
              "Instructor : ",
              fontSize: 14.sp,
              color: AppColors.grey73,
              fontWeight: FontWeight.w400,
            ),
            SizeConfig.sW5,
            const CircleAvatar(
              radius: 12.0,
              backgroundImage: AssetImage(
                AppImageAssets.teacherImage,
              ), // Replace with your image path
            ),
            SizeConfig.sW3,
            CustomNewText(
              "Devid Jonson",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    ),
  );
}

class CircularProgressWithText extends StatelessWidget {
  final double progress; // Value between 0.0 and 1.0
  final double size; // Size of the progress indicator
  final TextStyle? textStyle; // Style for the percentage text

  const CircularProgressWithText({
    Key? key,
    required this.progress,
    this.size = 30.0, // Default size
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 3,
            color: AppColors.yellow,
            backgroundColor: AppColors.greyE0,
          ),
          CustomNewText(
            "${(progress * 100).toInt()}%",
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
            color: AppColors.grey73,
          ),
        ],
      ),
    );
  }
}
