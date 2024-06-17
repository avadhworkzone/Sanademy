import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:sanademy/view/homeScreen/sub_screens/description_screen.dart';
import 'package:sanademy/view/homeScreen/widget/common_recommended_container_widget.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            commonBackArrowAppBar(
              titleTxt: AppStrings.recommended,
              actionWidget: false,
            ),
            SizeConfig.sH10,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.builder(
                    itemCount: homeScreenViewModel.courses.length,
                    itemBuilder: (context, index) {
                      final courses = homeScreenViewModel.courses[index];
                      final List<Color> colors = courses.colorCode!
                          .split(',')
                          .map((color) => Color(int.parse(color, radix: 16))
                              .withOpacity(1.0))
                          .toList();
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h, top: 10.h),
                        child: GestureDetector(
                          onTap: () {
                            SharedPreferenceUtils.getIsLogin() == true
                                ? Get.to(() => DescriptionScreen(
                              courseId: courses.id.toString(),
                              videoUrl: courses.videoUrl ?? '',
                            ))
                                : Get.to(() => const SignUpScreen());

                          },
                          child:  CommonContainerWidget(
                            color: colors,
                            title: courses.title ?? '',
                            numberOfLecture: courses.numberOfLecture ?? '',
                            minutes: (courses.minutes == null)?0:int.parse(courses.minutes.toString()),
                            teacherName: courses.teacher!.name ?? '',
                            teacherImage: courses.teacher!.image ?? '',
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
