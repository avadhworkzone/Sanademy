import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/homeScreen/sub_screens/description_screen.dart';
import 'package:sanademy/view/homeScreen/widget/common_recommended_container_widget.dart';

import 'package:sanademy/view_model/home_screen_view_model.dart';

class CategoriesScreen extends StatefulWidget {
   CategoriesScreen({super.key,required this.categoryId, required this.categoryName});

  final String categoryId;
  final String categoryName;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();

  @override
  void initState() {
    callGetCourseByCategoryApi();
    super.initState();
  }

  callGetCourseByCategoryApi() async {
    await homeScreenViewModel.getCategoryWiseCourseData(categoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Obx(
          () => Column(
            children: [
              commonBackArrowAppBar(
                  titleTxt: widget.categoryName, actionWidget: false),
              SizeConfig.sH10,
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: homeScreenViewModel.categoryWiseCourseList.length,
                  itemBuilder: (context, index)  {
                    final courses = homeScreenViewModel.categoryWiseCourseList[index];
                    final List<Color> colors = courses.colorCode!
                        .split(',')
                        .map((color) => Color(int.parse(color, radix: 16)).withOpacity(1.0))
                        .toList();
                    return Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() =>  DescriptionScreen(
                          courseId: homeScreenViewModel.categoryWiseCourseList[index].id.toString(),
                          videoUrl: homeScreenViewModel.categoryWiseCourseList[index].videoUrl!,
                          description: homeScreenViewModel.categoryWiseCourseList[index].description!,
                          requirements: homeScreenViewModel.categoryWiseCourseList[index].requirements!,
                          whatWillYouLearn: homeScreenViewModel.categoryWiseCourseList[index].whatWillYouLearn!,
                          whoThisCourseIsFor: homeScreenViewModel.categoryWiseCourseList[index].whoThisCourseIsFor!,
                          teacherName: homeScreenViewModel.categoryWiseCourseList[index].teacher!.name!,
                          teacherImage: homeScreenViewModel.categoryWiseCourseList[index].teacher!.image!,
                          instructorDetail: homeScreenViewModel.categoryWiseCourseList[index].instructor!,
                        ));
                      },
                      child: CommonContainerWidget(
                      color: colors,
                        title: homeScreenViewModel.categoryWiseCourseList[index].title!,
                        numberOfLecture: homeScreenViewModel.categoryWiseCourseList[index].numberOfLecture!,
                        hours: homeScreenViewModel.categoryWiseCourseList[index].hours!,
                        minutes: homeScreenViewModel.categoryWiseCourseList[index].minutes!,
                        teacherImage: homeScreenViewModel.categoryWiseCourseList[index].teacher!.image!,
                        teacherName: homeScreenViewModel.categoryWiseCourseList[index].teacher!.name!,
                      ),
                    ),
                  );}
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
