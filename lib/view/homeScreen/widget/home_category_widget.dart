import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/homeScreen/sub_screens/categories_screen.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

// class HomeCategoryWidget extends StatefulWidget {
//   const HomeCategoryWidget({super.key});
//
//   @override
//   State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
// }
//
// class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
//   HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Padding(
//         //   padding: EdgeInsets.symmetric(horizontal: 20.w),
//         //   child: CustomText(
//         //     AppStrings.categories,
//         //     fontWeight: FontWeight.w700,
//         //     fontSize: 20.sp,
//         //     color: AppColors.black0E,
//         //   ),
//         // ),
//         SizeConfig.sH25,
//         Obx(
//           () => homeScreenViewModel.responseStatus.value ==
//                   ResponseStatus.Completed
//               ? SizedBox(
//                   width: Get.width,
//                   height: 40.h,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 15.w),
//                     child: ListView.builder(
//                         itemCount: homeScreenViewModel.categoriesData.length,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           final category =
//                               homeScreenViewModel.categoriesData[index];
//                           final List<Color> colors = category.colorCode!
//                               .split(',')
//                               .map((color) => Color(int.parse(color, radix: 16))
//                                   .withOpacity(1.0))
//                               .toList();
//                           return GestureDetector(
//                             onTap: () {
//                               Get.to(() => CategoriesScreen(
//                                     categoryId: homeScreenViewModel
//                                         .categoriesData[index].id
//                                         .toString(),
//                                     categoryName: homeScreenViewModel
//                                         .categoriesData[index].name
//                                         .toString(),
//                                   ));
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 5.w),
//                               child: Container(
//                                 width: 139.w,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(30),
//                                     gradient: LinearGradient(colors: colors)),
//                                 child: Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 10.w),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         height: 24.h,
//                                         width: 24.w,
//                                         child: NetWorkOcToAssets(
//                                           imgUrl: homeScreenViewModel
//                                               .categoriesData[index].image,
//                                         ),
//                                       ),
//                                       SizeConfig.sW5,
//                                       Flexible(
//                                         child: CustomText(
//                                           homeScreenViewModel
//                                               .categoriesData[index].name
//                                               .toString(),
//                                           fontSize: 13.sp,
//                                           fontWeight: FontWeight.w500,
//                                           color: AppColors.white,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                 )
//               : const Material(),
//         ),
//         SizeConfig.sH15,
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class HomeCategoryWidget extends StatefulWidget {
  const HomeCategoryWidget({super.key});

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  int selectedIndex = 0; // To track the selected category

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Featured",
      "icon": AppImageAssets.featured,
      "isSelected": true,
    },
    {
      "name": "Technology",
      "icon":AppImageAssets.technology,
    },
    {
      "name": "Media & Arts",
      "icon": AppImageAssets.mediaArts,
    },
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49.h,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.yellow // Selected background
                    : AppColors.white, // Unselected background
                borderRadius: BorderRadius.circular(30.sp),
                // border: Border.all(
                //   color: isSelected ? Colors.transparent : Colors.grey,
                // ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:  isSelected ? AppColors.yellow700 : AppColors.whitef7,
                    ),
                    child: Image.asset(
                      category["icon"],
                      height: 20.sp,
                      width: 20.sp,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    category["name"],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConstants.metropolis,
                    color:
                    isSelected ? AppColors.blue34 : AppColors.blue34, // Text color
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
