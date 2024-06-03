import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/size_config_utils.dart';
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
    return Scaffold(
      body: Column(
        children: [
          SizeConfig.sH40,
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
                          ));
                        },
                        child: CommonContainerWidget(
                          color: colors,
                          title:
                          courses.title!,
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
      ),
    );
  }
}
