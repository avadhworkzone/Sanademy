import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
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
  void dispose() {
    descriptionViewModel.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// VIDEO VIEW
              Stack(
                children: [
                  Obx(
                    () => SizedBox(
                      height: Get.width * 0.7,
                      width: Get.width,
                      child: descriptionViewModel.isLoader.value == true
                          ? Center(
                              child: SizedBox(
                                  height: 50.h,
                                  width: 50.h,
                                  child: const CircularProgressIndicator()),
                            )
                          : AspectRatio(
                              aspectRatio: descriptionViewModel
                                  .videoPlayerController.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  VideoPlayer(descriptionViewModel
                                      .videoPlayerController),
                                  InkWell(
                                      onTap: () {
                                        descriptionViewModel.onTouch.value =
                                            true;

                                        if (descriptionViewModel
                                            .videoPlayerController
                                            .value
                                            .isPlaying) {
                                          descriptionViewModel
                                              .videoPlayerController
                                              .pause();
                                        } else {
                                          descriptionViewModel
                                              .videoPlayerController
                                              .play();
                                        }

                                        Future.delayed(
                                          const Duration(seconds: 2),
                                          () => descriptionViewModel
                                              .onTouch.value = false,
                                        );
                                        setState(() {});
                                      },
                                      child: descriptionViewModel
                                                      .onTouch.value ==
                                                  true &&
                                              descriptionViewModel
                                                      .videoPlayerController
                                                      .value
                                                      .isPlaying ==
                                                  true
                                          ? const Icon(
                                              Icons.pause_circle,
                                              size: 50,
                                              color: Colors.white,
                                            )
                                          : descriptionViewModel
                                                          .onTouch.value ==
                                                      true &&
                                                  descriptionViewModel
                                                          .videoPlayerController
                                                          .value
                                                          .isPlaying ==
                                                      false
                                              ? const Icon(Icons.play_circle,
                                                  size: 50, color: Colors.white)
                                              : Container())
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
                          margin: EdgeInsets.only(
                              left: 10.w, top: 10.w, right: 10.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.w),
                          decoration: BoxDecoration(
                              color: AppColors.whiteF5.withOpacity(0.20),
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
                    /// payment Option dialog
                      showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    AppStrings.paymentOption,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black0E,
                                  ),
                                  SizeConfig.sH16,
                                  CustomText(
                                    'Thank you for your interest in participating in “Course Name” this course is priced at 49,000 IQD you can make the payment through below options',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: AppColors.black0E,
                                  ),
                                  SizeConfig.sH30,
                                  Row(
                                    children: [
                                      CustomBtn(
                                        onTap: () {},
                                        width: 160.w,
                                        height: 56.h,
                                        title: null,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        bgColor: AppColors.pinkEE,
                                        widget: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w),
                                          child: Row(
                                            children: [
                                              LocalAssets(
                                                imagePath:
                                                    AppImageAssets.fastPayImg,
                                                height: 28.h,
                                                width: 28.w,
                                              ),
                                              SizeConfig.sW5,
                                              CustomText(
                                                AppStrings.fastPay,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.sp,
                                                color: AppColors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizeConfig.sW15,
                                      CustomBtn(
                                        onTap: () {},
                                        width: 160.w,
                                        height: 56.h,
                                        title: null,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        bgColor: AppColors.firstIraqiBankColor,
                                        widget: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            LocalAssets(
                                              imagePath: AppImageAssets
                                                  .firstIraqiBankImg,
                                              height: 30.h,
                                              width: 30.w,
                                            ),
                                            SizeConfig.sW5,
                                            CustomText(
                                              AppStrings.firstIraqiBank,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp,
                                              color: AppColors.white,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizeConfig.sH16,
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomBtn(
                                        onTap: () {},
                                        width: 160.w,
                                        height: 56.h,
                                        title: null,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        bgColor: AppColors.white,
                                        boxShadow: [
                                          const BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 1),
                                              blurRadius: 4.0)
                                        ],
                                        widget: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            LocalAssets(
                                              imagePath: AppImageAssets
                                                  .mobileBalanceIcn,
                                              height: 30.h,
                                              width: 30.w,
                                            ),
                                            SizeConfig.sW5,
                                            CustomText(
                                              AppStrings.mobileBalance,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp,
                                              color: AppColors.black02,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizeConfig.sW15,
                                      CustomBtn(
                                        onTap: () {},
                                        width: 160.w,
                                        height: 56.h,
                                        title: null,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        bgColor: AppColors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 1),
                                              blurRadius: 4.0)
                                        ],
                                        widget: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            LocalAssets(
                                              imagePath: AppImageAssets.visaIcn,
                                              height: 30.h,
                                              width: 50.w,
                                            ),
                                            SizeConfig.sW5,
                                            CustomText(
                                              AppStrings.creditCard,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp,
                                              color: AppColors.black02,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizeConfig.sH25,
                                  CustomText(
                                    AppStrings.youCantPayThisPrice,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: AppColors.black0E,
                                  ),
                                  SizeConfig.sH25,
                                  CustomBtn(
                                      onTap: () {
                                        descriptionViewModel
                                            .isPaySuccessfully.value = true;
                                      },
                                      title: AppStrings.sendMsgOnWhatsApp)
                                ],
                              ),
                            )
                          ]),
                    );

                    /// Enrollment successfully dialog
                    /*showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30.h, horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LocalAssets(
                                    imagePath:
                                        AppImageAssets.enrollSuccessfullyImg,
                                    height: 150.h,
                                    width: 150.w,
                                  ),
                                  CustomText(
                                    AppStrings.enrollSuccessfully,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black0E,
                                  ),
                                  SizeConfig.sH16,
                                  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: AppStrings
                                              .enrollSuccessfullyTxt.tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: AppColors.black0E),
                                          children: [
                                            TextSpan(
                                              text:
                                                  AppStrings.fundamentalTxt.tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                  color: AppColors.black0E),
                                            )
                                          ])),
                                ],
                              ),
                            )
                          ],
                        ),
                      );*/
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
                    SizeConfig.sH8,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomText(
                        'Lorem ipsum dolor sit amet consectetur. In eu vitae habitant neque maecenas et in. Sit etiam quis scelerisque nibh vel neque. Volutpat tortor dolor eleifend consequat. Lectus nulla eget tortor enim in ac faucibus nec sed. Risus est sed blandit enim nibh pellentesque dolor libero etiam. Cursus sed sed integer eu pellentesque aliquet.',
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.black0E,
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
                    ),
                    SizeConfig.sH25,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Theme(
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
                                      padding: EdgeInsets.only(bottom: 5.h),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.w),
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
                    ),
                    Divider(
                      color: AppColors.black0E.withOpacity(0.2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Theme(
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
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.w),
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
                    ),
                    Divider(
                      color: AppColors.black0E.withOpacity(0.2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                            tilePadding: EdgeInsets.only(left: 5.w),
                            // childrenPadding: EdgeInsets.only(left: 20.w),
                            title: CustomText(
                              AppStrings.whoThisCourseIsFor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black0E,
                            ),
                            children: List.generate(
                                requirementsList.length,
                                (index) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.w),
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
                    ),
                    Divider(
                      color: AppColors.black0E.withOpacity(0.2),
                    ),
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
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 4.0)
                            ],
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 10.h),
                                title: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 40.r,
                                      backgroundImage: const NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'),
                                    ),
                                    SizeConfig.sW8,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          'Maryam',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        color:
                                            AppColors.black0E.withOpacity(0.2),
                                      ),
                                      SizeConfig.sH20,
                                      RichText(
                                        text: TextSpan(
                                            text: AppStrings.yourExperience,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors.black0E,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: '10',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: AppColors.black0E,
                                                  ))
                                            ]),
                                      ),
                                      SizeConfig.sH10,
                                      RichText(
                                        text: TextSpan(
                                            text: AppStrings.expertIn,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors.black0E,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'Social media management, graphic design',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: AppColors.black0E,
                                                  ))
                                            ]),
                                      ),
                                      SizeConfig.sH10,
                                      RichText(
                                        text: TextSpan(
                                            text: AppStrings.noOfStudents,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors.black0E,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: '124',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: AppColors.black0E,
                                                  ))
                                            ]),
                                      ),
                                      SizeConfig.sH10,
                                      RichText(
                                        text: TextSpan(
                                            text: AppStrings.noOfCourses,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors.black0E,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: '3',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: AppColors.black0E,
                                                  ))
                                            ]),
                                      ),
                                      SizeConfig.sH10,
                                      CustomText(
                                        'Lorem ipsum dolor sit amet consectetur. Integer non facilisis non dignissim eget. Enim odio auctor convallis mauris rhoncus nisl. Senectus tincidunt aliquam vitae enim id. Leo praesent id at dignissim. Non tincidunt varius pellentesque pretium elit. Eu urna ligula augue arcu etiam odio hendrerit. Dignissim libero leo orci.',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: AppColors.black0E,
                                      ),
                                      SizeConfig.sH15,
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: courseList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      tilePadding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      title: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                courseList[index].title,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: AppColors.black,
                                              ),
                                              CustomText(
                                                courseList[index].duration,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: AppColors.black,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              courseList[index].subTitle,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.black0E,
                                            ),
                                            CustomText(
                                              '• ${courseList[index].description}',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: AppColors.black0E,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  if (index != courseList.length - 1)
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

  final List<CourseData> courseList = [
    CourseData(
      title: 'Introduction to Mathematics',
      duration: '3 Lectures • 20 mins',
      subTitle: 'What you’ll learn',
      description: 'Lorem ipsum dolor sit amet consectetur. ',
    ),
    CourseData(
      title: 'Introduction to Mathematics',
      duration: '3 Lectures • 20 mins',
      subTitle: 'What you’ll learn',
      description: 'Lorem ipsum dolor sit amet consectetur.',
    ),
    CourseData(
      title: 'Introduction to Mathematics',
      duration: '3 Lectures • 20 mins',
      subTitle: 'What you’ll learn',
      description: 'Lorem ipsum dolor sit amet consectetur. ',
    ),
  ];
}

class CourseData {
  final String title;
  final String subTitle;
  final String duration;
  final String description;

  CourseData({
    required this.title,
    required this.subTitle,
    required this.duration,
    required this.description,
  });
}
