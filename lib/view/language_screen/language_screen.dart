import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/common_scrollable_appbar_widget.dart';
import 'package:sanademy/commonWidget/common_snackbar.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedLanguage = -1;

  List<LanguageSelection> languageList = [
    LanguageSelection(
        image: AppImageAssets.englishLanguageLogo,
        name: AppStrings.english,
        subName: 'English'),
    LanguageSelection(
        image: AppImageAssets.kurdishLanguageLogo,
        name: AppStrings.kurdish,
        subName: 'کوردی'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 30.w),
        child: CustomUpdateBtn(
          onTap: () async {
            if(selectedLanguage==-1){
              showSussesSnackBar('','Please Select Your Language\nتکایە زمانەکەت هەڵبژێرە');
            }else {
              setState(()  {
                if (selectedLanguage == 0) {
                  Get.updateLocale(const Locale('en', 'US'));
                    SharedPreferenceUtils.setLangCode('en');
                } else if (selectedLanguage == 1) {
                  Get.updateLocale(const Locale('ar'));

                  // Get.updateLocale(const Locale('ckb'));
                }
              });
             await SharedPreferenceUtils.setLangCode(selectedLanguage == 0?'en':'ar');
              Get.offAll(() => const BottomBar());
            }

          },
          title: AppStrings.continues,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          commonUpdateAppBar(
            isBack: true,
            context: context,
            paddingLeft: 18.w,
            actionWidget: SizeConfig.sW40,
            otherWidget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizeConfig.sH25,
                CustomNewText(
                  AppStrings.languageSelection,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                CustomNewText(
                  'حەزدەکەی بە کامە زمان ئەپەکە بەکاربهێنی؟',
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                SizeConfig.sH35,
                const CommonScrollableAppbarWidget()
              ],
            ),
          ),
          SizeConfig.sH15,
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: languageList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  selectedLanguage = index;
                  setState(() {});
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 19.w, vertical: 10.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedLanguage == index
                              ? AppColors.borderColor
                              : AppColors.blackE0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      LocalAssets(
                        imagePath: languageList[index].image,
                        height: 35.w,
                        width: 35.w,
                      ),
                      SizeConfig.sW10,
                      CustomNewText(
                        languageList[index].name,
                        color: AppColors.blue34,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      CustomNewText(
                        '(${languageList[index].subName})',
                        color: AppColors.black73,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizeConfig.sW10,
                      selectedLanguage == index
                          ? CircleAvatar(
                              radius: 8.w,
                              backgroundColor: AppColors.borderColor,
                              child: Icon(
                                Icons.done,
                                color: AppColors.white,
                                size: 10.w,
                                weight: 100.w,
                              ),
                            )
                          : Container(
                              height: 16.w,
                              width: 16.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.blackE0, width: 2),
                                  shape: BoxShape.circle),
                            )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class LanguageSelection {
  String image;
  String name;
  String subName;

  LanguageSelection(
      {required this.image, required this.name, required this.subName});
}
