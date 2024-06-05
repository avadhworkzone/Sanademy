import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';

class HomeSliderWidget extends StatefulWidget {
  const HomeSliderWidget({super.key});

  @override
  State<HomeSliderWidget> createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  HomeScreenViewModel homeScreenViewModel = Get.find<HomeScreenViewModel>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100.w,
            margin: EdgeInsets.only(bottom: 80.h),
            color: AppColors.primaryColor,
          ),
          Positioned(
            bottom: 20,
            child: Stack(
              children: [
                SizedBox(
                  height: 150.w,
                  width: 380.w,
                  child: PageView.builder(
                    itemCount: homeScreenViewModel.bannerData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: NetWorkOcToAssets(
                              imgUrl: homeScreenViewModel.bannerData[index].image,
                              boxFit: BoxFit.cover,
                            )),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 15,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildIndicators(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < homeScreenViewModel.bannerData.length; i++) {
      indicators.add(buildIndicator(i == _currentIndex));
    }
    return indicators;
  }

  int _currentIndex = 0;

  Widget buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: isActive ? 20 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
