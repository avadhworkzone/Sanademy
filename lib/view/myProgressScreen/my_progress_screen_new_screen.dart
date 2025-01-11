import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view/homeScreen/widget/home_slider_widget.dart';
import 'package:sanademy/view/myProgressScreen/progess_bottom_sheet.dart';
import 'package:sanademy/view_model/sign_up_view_model.dart';

class MyProgressNewScreen extends StatefulWidget {
  const MyProgressNewScreen({super.key});

  @override
  State<MyProgressNewScreen> createState() => _MyProgressNewScreenState();
}

class _MyProgressNewScreenState extends State<MyProgressNewScreen> {
  SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoginBottomSheet(context);
    });
    signUpViewModel.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.offAll(() => const BottomBar());
          return Future.value(true);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonOnlyTitleAppBar(
                isBackBtn: false,
                context: context,
                paddingLeft: 18.w,
                actionWidget: SizeConfig.sW40,
                title: AppStrings.myProgress,
                otherWidget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizeConfig.sH25,
                    SizeConfig.sH35,
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: ListView.builder(
                  itemCount: courses.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16.w),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                              // color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                              image: DecorationImage(
                                  image: AssetImage(AppImageAssets.appLogo),
                                  fit: BoxFit.cover)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      course["title"],
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.sp,
                                      fontSize: 16.sp,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 15.w),
                                  LocalAssets(
                                    imagePath: AppImageAssets.playIcon,
                                    height: 32.sp,
                                    width: 32.sp,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              // const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      LocalAssets(
                                        imagePath: AppImageAssets.bookIcon,
                                        height: 14.sp,
                                        width: 14.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      CustomText(
                                        "${course["completed"]}/${course["total"]}",
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 38.w,
                                        height: 38.w,
                                        child: CircularProgressIndicator(
                                          value: course["progress"] / 100,
                                          color: AppColors.yellow,
                                          backgroundColor: AppColors.white,
                                          strokeWidth: 4.w,
                                        ),
                                      ),
                                      CustomText(
                                        "${course["progress"]}%",
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.sp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 13.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: List.generate(10, (i) {
                                        bool isActiveSegment =
                                            i == course["completed"];
                                        return Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            height: 4.5.h,
                                            decoration: BoxDecoration(
                                              color: i < course["completed"]
                                                  ? AppColors.yellow
                                                  : AppColors.white,
                                              border: isActiveSegment
                                                  ? Border.all(
                                                      color: AppColors.yellow,
                                                      width: 1.5.w)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
