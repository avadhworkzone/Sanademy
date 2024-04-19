import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/view/homeScreen/sub_screens/description_screen.dart';
import 'package:sanademy/view/homeScreen/widget/common_recommended_container_widget.dart';

class HomeRecommendedWidget extends StatelessWidget {
  const HomeRecommendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
                // const Spacer(),
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
                itemCount: recommendedList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const DescriptionScreen());
                    },
                    child:
                        CommonContainerWidget(listData: recommendedList[index]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
