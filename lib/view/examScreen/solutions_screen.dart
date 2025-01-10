import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/audio_wave_form.dart';
import 'package:sanademy/view_model/question_answer_view_model.dart';

class SolutionsScreen extends StatefulWidget {
  const SolutionsScreen(
      {super.key, required this.examId, required this.examTitle});

  final String examId;
  final String examTitle;

  @override
  State<SolutionsScreen> createState() => _SolutionsScreenState();
}

class _SolutionsScreenState extends State<SolutionsScreen> {
  QuestionsAnswerViewModel questionsAnswerViewModel = Get.find();

  @override
  void initState() {
    questionDetailAPiCall();
    super.initState();
  }

  questionDetailAPiCall() async {
    await questionsAnswerViewModel.getQuestionsViewModel(examId: widget.examId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child: Obx(
            () {
              if (questionsAnswerViewModel.responseStatus.value ==
                      ResponseStatus.Loading ||
                  questionsAnswerViewModel.responseStatus.value ==
                      ResponseStatus.INITIAL) {}
              if (questionsAnswerViewModel.responseStatus.value ==
                  ResponseStatus.Error) {
                return Center(child: CustomText("Something went wrong"));
              }
              final questionsDetail = questionsAnswerViewModel.questionsDetail;
              return Column(
                children: [
                  CustomText(
                    AppStrings.solution,
                    color: AppColors.black0E,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizeConfig.sH30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        "Mathematics Mastery",
                        // widget.examTitle ?? '',
                        color: AppColors.black0E,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  SizeConfig.sH25,
                  Expanded(
                    child: PageView(
                      controller:
                          questionsAnswerViewModel.solutionPageController.value,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(questionsDetail.length, (index) {
                        final question = questionsDetail[index];
                        print('question is =------>>> ${jsonEncode(question)}');
                        return Column(
                          children: [
                            Row(
                              children: [
                                SizeConfig.sW5,
                                InkWell(
                                  borderRadius: BorderRadius.circular(18.r),
                                  onTap: () {
                                    if (index > 0) {
                                      questionsAnswerViewModel
                                          .solutionPageController.value
                                          .previousPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 13.w, vertical: 13.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(18.r)),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizeConfig.sW15,
                                Expanded(
                                  child: CustomBtn(
                                    onTap: () {},
                                    title:
                                        '${AppStrings.questions} ${index + 1} ${AppStrings.ofText} ${questionsDetail.length}',
                                    textColor: AppColors.primaryColor,
                                    bgColor: AppColors.greyFD,
                                    borderColor: AppColors.primaryColor,
                                    radius: 10,
                                  ),
                                ),
                                SizeConfig.sW15,
                                InkWell(
                                  borderRadius: BorderRadius.circular(18.r),
                                  onTap: () {
                                    if (questionsDetail.length - 1 > index) {
                                      questionsAnswerViewModel
                                          .solutionPageController.value
                                          .nextPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease);
                                    } /* else if (index ==
                                        questionsDetail.length - 1) {
                                      Get.to(const CongratulationsScreen());
                                    }*/
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 13.w, vertical: 13.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(18.r)),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizeConfig.sW5,
                              ],
                            ),
                            SizeConfig.sH25,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                children: [
                                  CustomText(
                                    '${AppStrings.q}${index + 1}. ${question.title}',
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SizeConfig.sH10,
                                  question.type == "Audio"
                                      ? AudioWaveForm(
                                          videoUrl: questionsDetail[index]
                                              .audio
                                              .toString(),
                                          isSolutionScreen: true,
                                          index: index,
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 4,
                                          itemBuilder: (context, optionIndex) {
                                            final option = question.toJson()[
                                                'option_${optionIndex + 1}'];
                                            print('option is ${option}');
                                            int isCorrect = -1;
                                            int isFail = -1;
                                            if (question.selectedAnswer ==
                                                question.correctAns) {
                                              isCorrect =
                                                  question.correctAns == "null"
                                                      ? -1
                                                      : int.parse(
                                                          question.correctAns ??
                                                              '-1');
                                            } else {
                                              isCorrect =
                                                  question.correctAns == "null"
                                                      ? -1
                                                      : int.parse(
                                                          question.correctAns ??
                                                              '-1');
                                              isFail = question
                                                          .selectedAnswer ==
                                                      "null"
                                                  ? -1
                                                  : int.parse(
                                                      question.selectedAnswer ??
                                                          '-1');
                                            }

                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 15.w),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.w),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: isCorrect ==
                                                              (optionIndex + 1)
                                                          ? AppColors.green0B
                                                          : isFail ==
                                                                  (optionIndex +
                                                                      1)
                                                              ? AppColors.red
                                                              : AppColors
                                                                  .greyEE),
                                                  color: AppColors.greyFD,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    isCorrect ==
                                                            (optionIndex + 1)
                                                        ? Icons
                                                            .radio_button_checked
                                                        : isFail ==
                                                                (optionIndex +
                                                                    1)
                                                            ? Icons
                                                                .radio_button_checked
                                                            : Icons
                                                                .radio_button_off,
                                                    color: isCorrect ==
                                                            (optionIndex + 1)
                                                        ? AppColors.green0B
                                                        : isFail ==
                                                                (optionIndex +
                                                                    1)
                                                            ? AppColors.red
                                                            : AppColors.black0E,
                                                  ),
                                                  SizeConfig.sW10,
                                                  CustomText(
                                                    option,
                                                    fontWeight: FontWeight.w500,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ),
                            question.type == "Audio"
                                ? SizeConfig.sH30
                                : SizeConfig.sH10,
                            Row(
                              children: [
                                SizeConfig.sW5,
                                Expanded(
                                  child: CustomBtn(
                                    onTap: () {
                                      final containIndex =
                                          questionsAnswerViewModel
                                              .selectedAnswerList
                                              .indexWhere((element) =>
                                                  element['questionId'] ==
                                                  question.id);
                                      if (containIndex == -1) {
                                        questionsAnswerViewModel
                                            .selectedAnswerList
                                            .add({
                                          "questionId": question.id,
                                          "option": "",
                                        });
                                      }
                                      if (questionsDetail.length - 1 > index) {
                                        questionsAnswerViewModel
                                            .solutionPageController.value
                                            .nextPage(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.ease);
                                      } /*else if (index ==
                                          questionsDetail.length - 1) {
                                        Get.to(const CongratulationsScreen());
                                      }*/
                                    },
                                    title: AppStrings.skip,
                                    bgColor: AppColors.white,
                                    borderColor: AppColors.primaryColor,
                                    textColor: AppColors.primaryColor,
                                    radius: 10,
                                  ),
                                ),
                                SizeConfig.sW15,
                                Expanded(
                                  child: CustomBtn(
                                    onTap: () async {
                                      if (questionsDetail.length - 1 > index) {
                                        questionsAnswerViewModel
                                            .solutionPageController.value
                                            .nextPage(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.ease);
                                      } else if (index ==
                                          questionsDetail.length - 1) {}
                                    },
                                    title: AppStrings.next,
                                    bgColor: AppColors.primaryColor,
                                    borderColor: AppColors.white,
                                    textColor: AppColors.white,
                                    radius: 10,
                                  ),
                                ),
                                SizeConfig.sW5,
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
