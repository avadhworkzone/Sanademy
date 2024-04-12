import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/homeScreen/common_home_widget.dart';
import 'package:sanademy/view/homeScreen/sub_screens/description_screen.dart';

class MathematicsScreen extends StatefulWidget {
  const MathematicsScreen({super.key});

  @override
  State<MathematicsScreen> createState() => _MathematicsScreenState();
}

class _MathematicsScreenState extends State<MathematicsScreen> {
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
                itemCount: _recommendedList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const DescriptionScreen());
                    },
                    child: CommonContainerWidget(
                      listData: _recommendedList[index],
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
      'color': Colors.green,
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '14 lectures',
      'time': '8 hours 30 minutes',
      'color': Colors.orangeAccent.shade200,
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '12 lectures',
      'time': '7 hours 40 minutes',
      'color': Colors.blue.shade300,
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '14 lectures',
      'time': '8 hours 30 minutes',
      'color': Colors.pink.shade200,
    },
  ];
}
