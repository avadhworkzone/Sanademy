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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
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
      body: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
              child: CommonTextField(
                textEditController: searchController,
                regularExpression: RegularExpressionUtils.alphabetPattern,
                hintText: AppStrings.searchHere.tr,
                isValidate: true,
                hintTextColor: AppColors.white,
                borderColor: AppColors.primaryColor,
                fillColor: AppColors.white.withOpacity(0.20),
                pIcon: Padding(
                  padding: EdgeInsets.all(15.w),
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
        ],
      ),
    );
  }
}
