import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/view/homeScreen/sub_screens/description_screen.dart';
import 'package:sanademy/view/homeScreen/widget/common_recommended_container_widget.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

class HomeRecommendedWidget extends StatefulWidget {
   const HomeRecommendedWidget({super.key});

  @override
  State<HomeRecommendedWidget> createState() => _HomeRecommendedWidgetState();
}

class _HomeRecommendedWidgetState extends State<HomeRecommendedWidget> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => homeScreenViewModel.responseStatus.value ==
            ResponseStatus.Completed?Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    AppStrings.recommended,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: AppColors.black0E,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: CustomText(
                      AppStrings.viewAll,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: AppColors.color8B,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.builder(
                  itemCount: homeScreenViewModel.courses.length,
                  itemBuilder: (context, index) {
                    final courses = homeScreenViewModel.courses[index];
                    final List<Color> colors = courses.colorCode!
                        .split(',')
                        .map((color) => Color(int.parse(color, radix: 16)).withOpacity(1.0))
                        .toList();
                    return Padding(
                    padding: EdgeInsets.only(bottom: 15.h,top: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() =>  DescriptionScreen(
                          courseId: homeScreenViewModel.courses[index].id.toString(),
                          videoUrl: homeScreenViewModel.courses[index].videoUrl!,
                          description: homeScreenViewModel.courses[index].description!,
                          requirements: homeScreenViewModel.courses[index].requirements!,
                          whatWillYouLearn: homeScreenViewModel.courses[index].whatWillYouLearn!,
                          whoThisCourseIsFor: homeScreenViewModel.courses[index].whoThisCourseIsFor!,
                          teacherName: homeScreenViewModel.courses[index].teacher!.name!,
                          teacherImage: homeScreenViewModel.courses[index].teacher!.image!,
                        instructorDetail: homeScreenViewModel.courses[index].instructor!,
                        ));
                      },
                      child:
                          CommonContainerWidget(
                              color: colors,
                            title: homeScreenViewModel.courses[index].title!,
                            numberOfLecture: homeScreenViewModel.courses[index].numberOfLecture!,
                            hours: homeScreenViewModel.courses[index].hours!,
                            minutes: homeScreenViewModel.courses[index].minutes!,
                            teacherName: homeScreenViewModel.courses[index].teacher!.name!,
                            teacherImage: homeScreenViewModel.courses[index].teacher!.image!,
                          ),
                    ),
                  ); }
                ),
              ),
            )
          ],
        ):const Material(),
      ),
    );
  }
}
