import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/view/homeScreen/sub_screens/description_screen.dart';
import 'package:sanademy/view/homeScreen/widget/common_recommended_container_widget.dart';
import 'package:sanademy/view/view_all_screen/view_all_screen.dart';
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
        () {
          return homeScreenViewModel.responseStatus.value ==
                ResponseStatus.Completed
            ?  Column(
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
                          onPressed: () {
                            Get.to(const ViewAllScreen());
                          },
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
                                .map((color) =>
                                    Color(int.parse(color, radix: 16))
                                        .withOpacity(1.0))
                                .toList();
                            return Padding(
                              padding: EdgeInsets.only(bottom: 15.h, top: 10.h),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => DescriptionScreen(
                                    courseId: courses.id.toString(),
                                    videoUrl: courses.videoUrl ?? '',
                                   /* description: homeScreenViewModel.courseDetailResModel.data![0].description ?? '',
                                    requirements: homeScreenViewModel.courseDetailResModel.data![0].requirements ?? '',
                                    whatWillYouLearn: homeScreenViewModel.courseDetailResModel.data![0].whatWillYouLearn!,
                                    whoThisCourseIsFor: homeScreenViewModel.courseDetailResModel.data![0].whoThisCourseIsFor!,
                                    teacherName: homeScreenViewModel.courseDetailResModel.data![0].teacher!.name!,
                                    teacherImage: homeScreenViewModel.courseDetailResModel.data![0].teacher!.image!,
                                    instructorDetail: homeScreenViewModel.courseDetailResModel.data![0].instructor!,
                                    // courseContents: homeScreenViewModel.courseDetailResModel.data![0].courseContents!,
                                    courseContentTitle: homeScreenViewModel.courseDetailResModel.data![0].courseContents![index].title!,
                                    courseContentLecture: homeScreenViewModel.courseDetailResModel.data![0].courseContents![index].numberOfLecture!,
                                    courseContentMinutes: homeScreenViewModel.courseDetailResModel.data![0].courseContents![index].minutes!,
                                    courseContentDescription: homeScreenViewModel.courseDetailResModel.data![0].courseContents![index].description!,*/
                                  ));
                                },
                                child: CommonContainerWidget(
                                  color: colors,
                                  title: courses.title!,
                                  numberOfLecture: courses.numberOfLecture!,
                                  hours:
                                  courses.hours!,
                                  minutes: courses.minutes!,
                                  teacherName: courses.teacher!.name!,
                                  teacherImage: courses.teacher!.image!,
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              )
            : const Material();}
      ),
    );
  }
}
