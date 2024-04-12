import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/commom_textfield.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_imgae_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/regex.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/homeScreen/common_home_widget.dart';
import 'package:sanademy/view/homeScreen/sub_screens/mathematics_screen.dart';
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
          leadingWidth: 80.w,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP VIEW
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 180.h,
                margin: EdgeInsets.only(bottom: 80.h),
                color: AppColors.primaryColor,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.w),
                  child: CommonTextField(
                    textEditController:
                        homeScreenViewModel.searchController.value,
                    regularExpression: RegularExpressionUtils.alphabetPattern,
                    hintText: AppStrings.searchHere.tr,
                    style: const TextStyle(color: AppColors.white),
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
                        itemCount: _images.length,
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
                                _images[index],
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
          ),

          /// CATEGORIES VIEW
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
                itemCount: _categoriesList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                    width: 139.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: _categoriesList[index]['color']),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _categoriesList[index]['Icon'],
                            size: 20.h,
                            color: AppColors.white,
                          ),
                          /* Image.network(
                            _categoriesList[index]['Icon'],
                            fit: BoxFit.cover,
                          ),*/
                          SizeConfig.sW5,
                          CustomText(
                            _categoriesList[index]['title'],
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

          /// RECOMMENDED
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                CustomText(
                  AppStrings.recommended,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: AppColors.black0E,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: CustomText(
                    AppStrings.viewAll,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: AppColors.viewAllColor,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView.builder(
                itemCount: _recommendedList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const MathematicsScreen());
                    },
                    child: CommonContainerWidget(
                        listData: _recommendedList[index]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  final List<String> _images = [
    "https://media.istockphoto.com/id/1149476751/vector/online-education-banner.jpg?s=612x612&w=0&k=20&c=P-6QFVRk4UGYTEqAyWWXI5BknkoKX6YxrmCKrPfE2vw=",
    "https://www.shutterstock.com/image-vector/student-character-study-computer-can-260nw-1399290638.jpg",
    "https://img.freepik.com/free-psd/e-learning-landing-page-template_23-2149113642.jpg?size=626&ext=jpg&ga=GA1.1.632798143.1705363200&semt=ais",
    "https://t3.ftcdn.net/jpg/03/46/60/00/360_F_346600043_sz6HF3HBXBBSwKLaJ3B7R9PWuFsHTLRB.jpg",
  ];

  final List<Map<String, dynamic>> _categoriesList = [
    {
      'Icon': Icons.calculate_outlined,
      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdiA84YFxMVbMQyDPQ8-YLpyyvPXX75lQpdDm6SML0va5Qw7fCm046Hzu5eHsa1PbZLTk&usqp=CAU",
      'title': 'Mathematics',
      'color': AppColors.primaryColor,
    },
    {
      'Icon': Icons.language,
      //  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4FRrhI0Cg69MEC53yw1Q7X5oEyqR8apZY1Pf-r4AVZA&s",
      'title': 'Language',
      'color': AppColors.red,
    },
    {
      'Icon': Icons.color_lens_outlined,
      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBVmxXi3m-Oj3WDPGz1UkrbHL9h0ggjH9TVa-HKl0O_g&s",
      'title': 'Arts',
      'color': AppColors.color9D,
    }
  ];

  final List<Map<String, dynamic>> _recommendedList = [
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '12 lectures',
      'time': '7 hours 40 minutes',
      'color': Colors.green,
    },
    {
      'titleTxt': 'Exploring the Beauty of Mathematical Structures',
      'lectures': '14 lectures',
      'time': '8 hours 30 minutes',
      'color': Colors.green.shade400,
    },
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
