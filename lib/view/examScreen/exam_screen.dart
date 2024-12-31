import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view/examScreen/questions_screen.dart';
import 'package:sanademy/view_model/bottom_bar_view_model.dart';
import 'package:sanademy/view_model/exam_view_model.dart';
import 'package:sanademy/view_model/question_answer_view_model.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({
    super.key,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  ExamViewModel examViewModel = Get.put(ExamViewModel());
  QuestionsAnswerViewModel questionsAnswerViewModel = Get.put(QuestionsAnswerViewModel());
  BottomBarViewModel bottomBarViewModel = Get.find<BottomBarViewModel>();

  @override
  void initState() {
    examViewModel.getExamData(courseId: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        bottomBarViewModel.selectedBottomIndex.value = 2;
        Get.offAll(() => const BottomBar());
        return Future.value(true);
      },
      child: SafeArea(
        child: Material(
          child: Obx(
            () => Column(
              children: [
                commonBackArrowAppBar(
                    titleTxt: AppStrings.exams,
                    actionWidget: false,
                    leadingWidget: true,
                    backOnTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      bottomBarViewModel.selectedBottomIndex.value = 2;
                      Get.offAll(() => const BottomBar());
                    }),
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
                      (examViewModel.examData.isNotEmpty)
                          ? ListView.builder(
                              itemCount: examViewModel.examData.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => QuestionsScreen(
                                          examTitle: examViewModel.examData[index].title.toString(),
                                          examId: examViewModel.examData[index].id.toString(),
                                        ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20.w),
                                    margin: EdgeInsets.symmetric(vertical: 10.w),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.greyEE, width: 1.sp),
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
                                              examViewModel.examData[index].title!,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.sp,
                                            ),
                                            SizeConfig.sH10,
                                            Row(
                                              children: [
                                                CustomText(
                                                  '${examViewModel.examData[index].questionsCount} ${AppStrings.questions}',
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black0E.withOpacity(0.80),
                                                ),
                                                SizeConfig.sW6,
                                                const CustomText('•',
                                                    fontWeight: FontWeight.w500, color: AppColors.black0E),
                                                SizeConfig.sW6,
                                                CustomText(
                                                  examViewModel.examData[index].subTitle ?? '',
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black0E.withOpacity(0.80),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppColors.color8B.withOpacity(0.20),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: AppColors.color8B,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    AppStrings.noExamAvailable,
                                    color: AppColors.black0E,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                  ),
                                  SizeConfig.sH10,
                                  CustomText(
                                    AppStrings.pleaseCompleteYourExamTxt,
                                    color: AppColors.black0E,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
