import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/view_model/home_screen_view_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeScreenViewModel homeScreenViewModel = Get.put(HomeScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          titleTxt: AppStrings.titleTxt.tr,
          leadingWidth: 70.w,
          leadingWidget: Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              Container(
                margin: EdgeInsets.all(8.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(15)),
                child: const LocalAssets(
                  imagePath: AppImageAssets.categoryIcon,
                ),
              ),
            ],
          ),
          actionWidget: Container(
            margin: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.20),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const NetWorkOcToAssets(
                    imgUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s')),
          )),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 250.h,
            margin: EdgeInsets.only(bottom: 80.h),
            color: AppColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.w),
              child: CommonTextField(
                textEditController: homeScreenViewModel.searchController.value,
                regularExpression: RegularExpressionUtils.alphabetPattern,
                hintText: AppStrings.searchHere.tr,
                isValidate: true,
                hintTextColor: AppColors.white,
                borderColor: AppColors.primaryColor,
                fillColor: AppColors.white.withOpacity(0.20),
                pIcon: Padding(
                  padding: EdgeInsets.only(left:15.w,top: 15.w,bottom: 15.w,right: 7.w),
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
        bottom: 0,
        child: Stack(
          children: [
            SizedBox(
              height: 150.w,
              width: 350.w,
              child: PageView.builder(
                itemCount: _images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius:  BorderRadius.circular(20),
                    child: Image.network(
                      _images[index],
                      fit: BoxFit.cover,
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
      ),
    );
  }


  final List<String> _images = [
    "https://via.placeholder.com/300",
    "https://via.placeholder.com/300",
    "https://via.placeholder.com/300",
    "https://via.placeholder.com/300"
  ];

  int _currentIndex = 0;
  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < _images.length; i++) {
      indicators.add(_buildIndicator(i == _currentIndex));
    }
    return indicators;
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: isActive?20:8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}

