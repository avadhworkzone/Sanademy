import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/view/homeScreen/widget/home_category_widget.dart';
import 'package:sanademy/view/homeScreen/widget/home_recomand_widget.dart';
import 'package:sanademy/view/homeScreen/widget/home_slider_widget.dart';
import 'package:sanademy/view/menu_screen/menu_screen.dart';
import 'package:sanademy/view/profile_screen/profile_screen.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel homeScreenViewModel = Get.put(HomeScreenViewModel());
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const Drawer(child: MenuScreen()),
      appBar: commonAppBar(
          titleTxt: AppStrings.titleTxt.tr,
          leadingWidth: 80.w,
          leadingWidget: Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _drawerKey.currentState?.openDrawer();
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(8.w),
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(15)),
                  child: const LocalAssets(
                    imagePath: AppImageAssets.categoryIcon,
                  ),
                ),
              ),
            ],
          ),
          actionWidget: GestureDetector(
            onTap: (){
              Get.to(const ProfileScreen());
            },
            child: Container(
              margin: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const NetWorkOcToAssets(
                      imgUrl:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s')),
            ),
          )),
      body: const Column(
        children: [
          /// CAROSAL SLIDER VIEW....
          HomeSliderWidget(),

          /// CATEGORIES VIEW
          HomeCategoryWidget(),

          /// RECOMMENDED
          HomeRecommendedWidget(),
        ],
      ),
    );
  }
}
