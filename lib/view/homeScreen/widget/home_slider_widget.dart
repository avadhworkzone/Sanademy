import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
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
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 180.w,
          margin: EdgeInsets.only(bottom: 80.h),
          color: AppColors.primaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.w),
            child: CommonTextField(
              textEditController:
                  Get.find<HomeScreenViewModel>().searchController.value,
              regularExpression: RegularExpressionUtils.alphabetPattern,
              hintText: AppStrings.searchHere.tr,
              style: const TextStyle(color: AppColors.white),
              underLineBorder: false,
              cursorColor: AppColors.white,
              isValidate: false,
              hintTextColor: AppColors.white,
              borderColor: AppColors.primaryColor,
              fillColor: AppColors.white.withOpacity(0.20),
              pIcon: Padding(
                padding: EdgeInsets.only(
                    left: 15.w, top: 15.w, bottom: 15.w, right: 7.w),
                child: LocalAssets(
                  imagePath: AppImageAssets.searchIcon,
                ),
              ),
              onChange: (firstNameData) {
                // createAccountController.isAllFieldInput();
              },
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Stack(
            children: [
              SizedBox(
                height: 150.w,
                width: 380.w,
                child: PageView.builder(
                  itemCount: images.length,
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
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
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
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < images.length; i++) {
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
