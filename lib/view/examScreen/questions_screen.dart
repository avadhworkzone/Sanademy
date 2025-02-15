import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/audio_wave_form.dart';
import 'package:sanademy/view/examScreen/congratulations_screen.dart';
import 'package:sanademy/view_model/question_answer_view_model.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
      {super.key, required this.examTitle, required this.examId});

  final String examTitle;
  final String examId;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  QuestionsAnswerViewModel questionsAnswerViewModel = Get.find();
  bool isAnswer = false;
  bool isSelectedOption = false;

  @override
  void initState() {
    questionDetailAPiCall();
    questionsAnswerViewModel.initData(mounted);
    super.initState();
  }

  questionDetailAPiCall() async {
    await questionsAnswerViewModel.getQuestionsViewModel(
        examId: widget.examId, isFromQuestion: true);
  }

  @override
  void dispose() {
    questionsAnswerViewModel.duration.value = const Duration(seconds: 0);
    questionsAnswerViewModel.stopTimer();
    questionsAnswerViewModel.timer1?.value.cancel();
    for (var controller in questionsAnswerViewModel.controllers) {
      controller.dispose();
    }
    questionsAnswerViewModel.controllers.clear();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    questionsAnswerViewModel.duration.value = const Duration(seconds: 0);
    questionsAnswerViewModel.selectedAnswerList.clear();
    questionsAnswerViewModel.stopTimer();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Obx(() {
          if (questionsAnswerViewModel.responseStatus.value ==
                  ResponseStatus.Loading ||
              questionsAnswerViewModel.responseStatus.value ==
                  ResponseStatus.INITIAL) {}
          if (questionsAnswerViewModel.responseStatus.value ==
              ResponseStatus.Error) {
            return Center(child: CustomText(AppStrings.somethingWantWrong));
          }
          final questionsDetail = questionsAnswerViewModel.questionsDetail;
          return SafeArea(
            child: Material(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBtn(
                      onTap: () {
                        questionsAnswerViewModel.timer1?.value.cancel();
                        Get.to(() => CongratulationsScreen(
                              examTitle: widget.examTitle,
                            ));
                      },
                      title: AppStrings.finishExam,
                      bgColor: AppColors.white,
                      borderColor: AppColors.primaryColor,
                      textColor: AppColors.primaryColor,
                      radius: 10,
                    ),
                    SizeConfig.sH15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          widget.examTitle,
                          color: AppColors.black0E,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.w),
                          decoration: BoxDecoration(
                              color: AppColors.color8B.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(5.w)),
                          child: Row(
                            children: [
                              const LocalAssets(
                                  imagePath: AppImageAssets.clockIcon),
                              SizeConfig.sW5,
                              CustomText(
                                formatDuration(questionsAnswerViewModel
                                    .duration.value.inSeconds),
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizeConfig.sH25,
                    Expanded(
                      child: PageView(
                        controller:
                            questionsAnswerViewModel.pageController.value,
                        physics: const NeverScrollableScrollPhysics(),
                        children:
                            List.generate(questionsDetail.length, (index) {
                          final question = questionsDetail[index];
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
                                            .pageController.value
                                            .previousPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                        isSelectedOption = false;
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
                                    onTap: () async {
                                      if (isSelectedOption != true) {
                                        (question.type == 'Audio')
                                            ? showErrorSnackBar('',
                                                AppStrings.pleaseEnterAnswer)
                                            : showErrorSnackBar(
                                                '',
                                                AppStrings
                                                    .pleaseSelectAnyOption);
                                      } else {
                                        if (questionsDetail.length - 1 >
                                            index) {
                                          questionsAnswerViewModel
                                              .pageController.value
                                              .nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                          isSelectedOption = false;
                                        } else if (index ==
                                            questionsDetail.length - 1) {
                                          /// CALL SAVE QUESTIONS API
                                          List saveQuestionsIdList = [];
                                          List saveAnswerIdList = [];
                                          for (var item
                                              in questionsAnswerViewModel
                                                  .selectedAnswerList) {
                                            saveQuestionsIdList.add(
                                                item['questionId'].toString());
                                            saveAnswerIdList.add(
                                                item['answerId'].toString());
                                          }
                                          final formattedTime = formatDuration(
                                              questionsAnswerViewModel
                                                  .duration.value.inSeconds);
                                          await questionsAnswerViewModel
                                              .saveQuestionsViewModel(
                                                  widget.examTitle,
                                                  examId: widget.examId,
                                                  answers: saveAnswerIdList,
                                                  questionIds:
                                                      saveQuestionsIdList,
                                                  time: formattedTime);
                                        }
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
                                            videoUrl: question.audio.toString(),
                                            controller: questionsAnswerViewModel
                                                    .controllers.isNotEmpty
                                                ? questionsAnswerViewModel
                                                    .controllers[index]
                                                : null,
                                            onTap: questionsAnswerViewModel
                                                    .controllers.isEmpty
                                                ? () {
                                                    setState(() {
                                                      isAnswer = true;
                                                    });
                                                  }
                                                : null,
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 4,
                                            itemBuilder:
                                                (context, optionIndex) {
                                              bool isSelected = false;
                                              final option = question.toJson()[
                                                  'option_${optionIndex + 1}'];
                                              final containIndex =
                                                  questionsAnswerViewModel
                                                      .selectedAnswerList
                                                      .indexWhere((element) =>
                                                          element[
                                                              'questionId'] ==
                                                          question.id);

                                              if (containIndex > -1) {
                                                if (questionsAnswerViewModel
                                                            .selectedAnswerList[
                                                        containIndex]['option'] ==
                                                    option) {
                                                  isSelected = true;
                                                }
                                              }
                                              return GestureDetector(
                                                onTap: () {
                                                  if (containIndex == -1) {
                                                    questionsAnswerViewModel
                                                        .selectedAnswerList
                                                        .add({
                                                      "questionId": question.id,
                                                      "option": option,
                                                      "answerId":
                                                          optionIndex + 1,
                                                    });
                                                  } else {
                                                    questionsAnswerViewModel
                                                                .selectedAnswerList[
                                                            containIndex]
                                                        ['option'] = option;
                                                    questionsAnswerViewModel
                                                                    .selectedAnswerList[
                                                                containIndex]
                                                            ['answerId'] =
                                                        optionIndex + 1;
                                                  }
                                                  // onOptionSelected();
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 15.w),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.w),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: isSelected
                                                              ? AppColors
                                                                  .primaryColor
                                                              : AppColors
                                                                  .greyEE),
                                                      color: AppColors.greyFD,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        isSelected
                                                            ? Icons
                                                                .radio_button_checked
                                                            : Icons
                                                                .radio_button_off,
                                                        color: isSelected
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors.black,
                                                      ),
                                                      SizeConfig.sW10,
                                                      CustomText(
                                                        option,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: isSelected
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors.black,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ],
                                ),
                              ),
                              question.type == 'Audio'
                                  ? SizeConfig.sH30
                                  : SizeConfig.sH10,
                              Row(
                                children: [
                                  SizeConfig.sW5,
                                  Expanded(
                                    child: CustomBtn(
                                      onTap: () async {
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
                                        if (questionsDetail.length - 1 >
                                            index) {
                                          questionsAnswerViewModel
                                              .pageController.value
                                              .nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                        } else if (index ==
                                            questionsDetail.length - 1) {
                                          questionsAnswerViewModel.stopTimer();
                                          final formattedTime = formatDuration(
                                              questionsAnswerViewModel
                                                  .duration.value.inSeconds);

                                          /// CALL SAVE QUESTIONS API
                                          List saveQuestionsIdList = [];
                                          List saveAnswerIdList = [];
                                          for (var item
                                              in questionsAnswerViewModel
                                                  .selectedAnswerList) {
                                            saveQuestionsIdList.add(
                                                item['questionId'].toString());
                                            saveAnswerIdList.add(
                                                item['answerId'].toString());
                                          }

                                          await questionsAnswerViewModel
                                              .saveQuestionsViewModel(
                                                  widget.examTitle,
                                                  examId: widget.examId,
                                                  answers: saveAnswerIdList,
                                                  questionIds:
                                                      saveQuestionsIdList,
                                                  time: formattedTime);
                                        }
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
                                        if (question.type == 'Audio') {
                                          questionsAnswerViewModel
                                              .selectedAnswerList
                                              .add({
                                            "questionId": question.id,
                                            "answerId": questionsAnswerViewModel
                                                .controllers[index].text
                                          });
                                        }
                                        final indexIs = questionsAnswerViewModel
                                            .selectedAnswerList
                                            .indexWhere((element) =>
                                                element['questionId'] ==
                                                question.id);
                                        if (question.type == 'Option' &&
                                            indexIs == -1) {
                                          showErrorSnackBar('',
                                              AppStrings.pleaseSelectAnyOption);
                                        } else if (question.type == 'Audio' &&
                                            questionsAnswerViewModel
                                                .controllers[index]
                                                .text
                                                .isEmpty) {
                                          showErrorSnackBar(
                                              '', AppStrings.pleaseEnterAnswer);
                                        } else {
                                          if (questionsDetail.length - 1 >
                                              index) {
                                            questionsAnswerViewModel
                                                .pageController.value
                                                .nextPage(
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease);
                                          } else if (index ==
                                              questionsDetail.length - 1) {
                                            questionsAnswerViewModel
                                                .stopTimer();
                                            final formattedTime =
                                                formatDuration(
                                                    questionsAnswerViewModel
                                                        .duration
                                                        .value
                                                        .inSeconds);

                                            /// CALL SAVE QUESTIONS API
                                            List saveQuestionsIdList = [];
                                            List saveAnswerIdList = [];
                                            for (var item
                                                in questionsAnswerViewModel
                                                    .selectedAnswerList) {
                                              saveQuestionsIdList.add(
                                                  item['questionId']
                                                      .toString());
                                              saveAnswerIdList.add(
                                                  item['answerId'].toString());
                                            }
                                            isSelectedOption = false;
                                            await questionsAnswerViewModel
                                                .saveQuestionsViewModel(
                                                    widget.examTitle,
                                                    examId: widget.examId,
                                                    answers: saveAnswerIdList,
                                                    questionIds:
                                                        saveQuestionsIdList,
                                                    time: formattedTime);
                                          }
                                        }
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
                ),
              ),
            ),
          );
        })
        // :CircularProgressIndicator(),
        );
  }
}
