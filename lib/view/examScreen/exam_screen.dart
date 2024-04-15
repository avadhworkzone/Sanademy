import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/examScreen/questions_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            commonBackArrowAppBar(
                titleTxt: AppStrings.exams,
                actionWidget: false,
                leadingWidget: true),
            SizeConfig.sH10,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    child: CustomText(
                      AppStrings.examsScreenTxt,
                      color: AppColors.black0E.withOpacity(0.8),
                    ),
                  ),
                  SizeConfig.sH10,
                  ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => const QuestionsScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          margin: EdgeInsets.symmetric(vertical: 10.w),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.greyEE, width: 1.sp),
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyFD),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    index.isOdd
                                        ? 'Language Lab'
                                        : 'Mathematics Mastery',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                  ),
                                  SizeConfig.sH10,
                                  Row(
                                    children: [
                                      CustomText(
                                        '20 Questions',
                                        fontWeight: FontWeight.w500,
                                        color:
                                            AppColors.black0E.withOpacity(0.80),
                                      ),
                                      SizeConfig.sW6,
                                      const CustomText('•',
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black0E),
                                      SizeConfig.sW6,
                                      CustomText(
                                        index.isOdd
                                            ? 'Listening Test'
                                            : 'Problem Solving Test',
                                        fontWeight: FontWeight.w500,
                                        color:
                                            AppColors.black0E.withOpacity(0.80),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        AppColors.color8B.withOpacity(0.20),
                                    child: const Icon(Icons.play_arrow,
                                        color: AppColors.color8B),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
