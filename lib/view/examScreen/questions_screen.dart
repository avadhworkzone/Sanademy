import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
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
  PageController pageController = PageController();
  Timer? timer1;
  Duration duration = const Duration(seconds: 0);
  String timeIs = DateTime.now().toString();
  QuestionsAnswerViewModel questionsAnswerViewModel = Get.find();

  List<Map<String, dynamic>> selectedAnswerList = [];

  @override
  void initState() {
    initData();
    questionDetailAPiCall();
    super.initState();
  }

  questionDetailAPiCall() async {
    await questionsAnswerViewModel.getQuestionsViewModel(examId: widget.examId);
  }

  initData() {
    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var difference = DateTime.now().difference(DateTime.parse(timeIs));
      if (mounted) {
        setState(() {
          duration = Duration(seconds: difference.inSeconds);
        });
      }
    });
  }
  void stopTimer() {
    if (timer1 != null) {
      timer1!.cancel();
    }
  }
  void jumpToPage(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  @override
  void dispose() {
    timer1?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (questionsAnswerViewModel.responseStatus.value ==
              ResponseStatus.Loading ||
          questionsAnswerViewModel.responseStatus.value ==
              ResponseStatus.INITIAL) {}
      if (questionsAnswerViewModel.responseStatus.value ==
          ResponseStatus.Error) {
        return const Center(child: CustomText("Something went wrong"));
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
                    timer1?.cancel();
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
                            formatDuration(duration.inSeconds),
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
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(questionsDetail.length, (index) {
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
                                    pageController.previousPage(
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
                                      '${AppStrings.questions} ${index + 1} ${AppStrings.of} ${questionsDetail.length}',
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
                                    pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  } else if (index ==
                                      questionsDetail.length - 1) {
                                    /// CALL SAVE QUESTIONS API
                                    List saveQuestionsIdList = [];
                                    List saveAnswerIdList = [];
                                    for (var item in selectedAnswerList) {
                                      saveQuestionsIdList
                                          .add(item['questionId'].toString());
                                      saveAnswerIdList
                                          .add(item['answerId'].toString());
                                    }
                                    questionsAnswerViewModel
                                        .saveQuestionsViewModel(
                                            widget.examTitle,
                                            examId: widget.examId,
                                            answers: saveAnswerIdList,
                                            questionIds: saveQuestionsIdList,
                                            time: "15:00");
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
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 4,
                                        itemBuilder: (context, optionIndex) {
                                          final option = question.toJson()[
                                              'option_${optionIndex + 1}'];
                                          bool isSelected = false;
                                          final containIndex =
                                              selectedAnswerList.indexWhere(
                                                  (element) =>
                                                      element['questionId'] ==
                                                      question.id);

                                          if (containIndex > -1) {
                                            if (selectedAnswerList[containIndex]
                                                    ['option'] ==
                                                option) {
                                              isSelected = true;
                                            }
                                          }
                                          return GestureDetector(
                                            onTap: () {
                                              if (containIndex == -1) {
                                                selectedAnswerList.add({
                                                  "questionId": question.id,
                                                  "option": option,
                                                  "answerId": optionIndex + 1,
                                                });
                                                if (kDebugMode) {
                                                  print(
                                                      'selectedAnswerList<<<$selectedAnswerList>>>>');
                                                }
                                              } else {
                                                selectedAnswerList[containIndex]
                                                    ['option'] = option;
                                                selectedAnswerList[containIndex]
                                                        ['answerId'] =
                                                    optionIndex + 1;
                                              }
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
                                                          : AppColors.greyEE),
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
                                                        ? AppColors.primaryColor
                                                        : AppColors.black,
                                                  ),
                                                  SizeConfig.sW10,
                                                  CustomText(
                                                    option,
                                                    fontWeight: FontWeight.w500,
                                                    color: isSelected
                                                        ? AppColors.primaryColor
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
                                  onTap: () {
                                    final containIndex = selectedAnswerList
                                        .indexWhere((element) =>
                                            element['questionId'] ==
                                            question.id);
                                    if (containIndex == -1) {
                                      selectedAnswerList.add({
                                        "questionId": question.id,
                                        "option": "",
                                      });
                                    }
                                    if (questionsDetail.length - 1 > index) {
                                      pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    } else if (index ==
                                        questionsDetail.length - 1) {
                                      Get.to(CongratulationsScreen(
                                        examTitle: widget.examTitle,
                                      ));
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
                                    stopTimer();
                                    final formattedTime = formatDuration(duration.inSeconds);
                                    if (questionsDetail.length - 1 > index) {
                                      pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    } else if (index ==
                                        questionsDetail.length - 1) {
                                      /// CALL SAVE QUESTIONS API
                                      List saveQuestionsIdList = [];
                                      List saveAnswerIdList = [];
                                      for (var item in selectedAnswerList) {
                                        saveQuestionsIdList
                                            .add(item['questionId'].toString());
                                        saveAnswerIdList
                                            .add(item['answerId'].toString());
                                      }
                                      /* if (kDebugMode) {
                                        print(
                                            'saveQuestionsIdList---------->$saveQuestionsIdList');
                                      }
                                      if (kDebugMode) {
                                        print(
                                            'saveAnswerIdList=========>$saveAnswerIdList');
                                      }*/
                                      questionsAnswerViewModel
                                          .saveQuestionsViewModel(
                                              widget.examTitle,
                                              examId: widget.examId,
                                              answers: saveAnswerIdList,
                                              questionIds: saveQuestionsIdList,
                                              time: formattedTime);
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
    });
  }
}
