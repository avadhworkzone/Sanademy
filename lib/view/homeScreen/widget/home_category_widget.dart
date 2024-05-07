import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/homeScreen/sub_screens/categories_screen.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

class HomeCategoryWidget extends StatefulWidget {
  const HomeCategoryWidget({super.key});

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {

  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();


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
        Obx(
          () => SizedBox(
            width: Get.width,
            height: 40.h,
            child: Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: ListView.builder(
                itemCount: homeScreenViewModel.categoriesData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const CategoriesScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          width: 139.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: categoriesList[index]['color'],
                              gradient: LinearGradient(
                                  colors: gradientColor[index])
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: NetWorkOcToAssets(
                                    imgUrl:  homeScreenViewModel.categoriesData[index].image,
                                  ),
                                ),
                                SizeConfig.sW5,
                                Flexible(
                                  child: CustomText(
                                    homeScreenViewModel.categoriesData[index].name
                                        .toString(),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
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
