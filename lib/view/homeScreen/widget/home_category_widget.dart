import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class HomeCategoryWidget extends StatefulWidget {
  const HomeCategoryWidget({super.key});

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  @override
  void initState() {
    // TODO: implement initState
    /// api calling
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomText(
            AppStrings.categories,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: AppColors.black0E,
          ),
        ),
        SizeConfig.sH15,
        SizedBox(
          width: Get.width,
          height: 40.h,
          child: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: ListView.builder(
              itemCount: categoriesList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  width: 139.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: categoriesList[index]['color']),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          categoriesList[index]['Icon'],
                          size: 20.h,
                          color: AppColors.white,
                        ),
                        /* Image.network(
                            _categoriesList[index]['Icon'],
                            fit: BoxFit.cover,
                          ),*/
                        SizeConfig.sW5,
                        CustomText(
                          categoriesList[index]['title'],
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizeConfig.sH15,
      ],
    );
  }
}
