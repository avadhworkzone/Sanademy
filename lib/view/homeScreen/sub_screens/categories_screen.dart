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
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            commonBackArrowAppBar(
                titleTxt: AppStrings.mathematics, actionWidget: false),
            SizeConfig.sH10,
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: homeScreenViewModel.courses.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const DescriptionScreen());
                    },
                    child: CommonContainerWidget(
                      listData: homeScreenViewModel.courses[index],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _recommendedList = [
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '12 lectures',
      'time': '7 hours 40 minutes',
      'color': [
        Color(0xff9BEE42),
        Color(0xff9BEE42),
      ],
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '14 lectures',
      'time': '8 hours 30 minutes',
      'color':  [
        Color(0xffE9984E),
        Color(0xffDD6E07),
      ],
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '12 lectures',
      'time': '7 hours 40 minutes',
      'color':  [
        Color(0xff6998F4),
        Color(0xff3F6EC9
        ),
      ],
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '14 lectures',
      'time': '8 hours 30 minutes',
      'color':  [
        Color(0xff9BEE42),
        Color(0xff9BEE42),
      ],
    },
  ];
}
