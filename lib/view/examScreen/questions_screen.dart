import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/networks/model/get_question_res_model.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/audio_wave_form.dart';
import 'package:sanademy/view/examScreen/congratulations_screen.dart';
import 'package:sanademy/view_model/question_answer_view_model.dart';

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen({super.key, this.examTitle});

  String? examTitle;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int selectedOption = -1;
  String? selectedOptionValue;
  Timer? timer1;
  Duration duration = const Duration(seconds: 0);
  String timeIs = DateTime.now().toString();
  int questionNumber1 = 1;
  int indexIs = -1;
  int selectedAnswerIndex = -1;

  QuestionsAnswerViewModel questionsAnswerViewModel = Get.find();

  List<Map<dynamic, dynamic>> answer = [
    {
      'question':
          'If a rectangle has a length of 8 units and a width of 5 units, what is its area?',
      'questionNumber': 1,
      'questionType': 'options',
      'answer': [
        {
          'id': '1',
          'title': '13 square units',
        },
        {
          'id': '2',
          'title': '24 square units',
        },
        {
          'id': '3',
          'title': '32 square units',
        },
        {
          'id': '4',
          'title': '43 square units',
        }
      ]
    },
    {
      'question': '50 times of 8 is equal to:',
      'questionNumber': 2,
      'questionType': 'options',
      'answer': [
        {
          'id': '1',
          'title': '80',
        },
        {
          'id': '2',
          'title': '400',
        },
        {
          'id': '3',
          'title': '800',
        },
        {
          'id': '4',
          'title': '4000',
        }
      ]
    },
    {
      'question': 'What is the sum of 130+125+191?',
      'questionNumber': 3,
      'questionType': 'audio',
      'answer': [
        {
          'id': '1',
          'title': '335',
        },
        {
          'id': '2',
          'title': '456',
        },
        {
          'id': '3',
          'title': '446',
        },
        {
          'id': '4',
          'title': '426',
        }
      ]
    },
    {
      'question': 'What is the sum of the angles in a triangle?',
      'questionNumber': 4,
      'questionType': 'options',
      'answer': [
        {
          'id': '1',
          'title': '180 degrees',
        },
        {
          'id': '2',
          'title': '90 degrees',
        },
        {
          'id': '3',
          'title': '360 degrees',
        },
        {
          'id': '4',
          'title': '270 degrees',
        }
      ]
    },
  ];

  List<Map<String, dynamic>> selectedAnswerList = [];

  @override
  void initState() {
    initData();
    questionShowFilter();
    questionDetailAPiCall();
    super.initState();
  }

  questionDetailAPiCall() async {
   await  questionsAnswerViewModel.getQuestionsViewModel(examId: "1");
  }
  questionShowFilter() {
    indexIs = answer
        .indexWhere((element) => element['questionNumber'] == questionNumber1);
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

  @override
  void dispose() {
    timer1?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child:
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBtn(
                  onTap: () {
                    timer1?.cancel();
                    Get.to(() => const CongratulationsScreen());
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
                      widget.examTitle ?? '',
                      color: AppColors.black0E,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                      decoration: BoxDecoration(
                          color: AppColors.color8B.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: Row(
                        children: [
                          const LocalAssets(imagePath: AppImageAssets.clockIcon),
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
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(18.r),
                      onTap: () {
                        if (questionNumber1 == 1) {
                        } else {
                          questionNumber1 -= 1;
                          indexIs = answer.indexWhere((element) =>
                              element['questionNumber'] == questionNumber1);
                          selectedAnswerIndex = selectedAnswerList.indexWhere(
                              (element) =>
                                  element['questionNumber'] ==
                                  answer[indexIs]['questionNumber']);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 13.w, vertical: 13.w),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(18.r)),
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
                            'Question ${answer[indexIs]['questionNumber']} of ${answer.length}',
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
                        questionNumber1 += 1;
                        if (questionNumber1 >= answer.length + 1) {
                          questionsAnswerViewModel.commentController.value
                              .clear();
                          Get.off(() => const CongratulationsScreen());
                        } else {
                          indexIs = answer.indexWhere((element) =>
                              element['questionNumber'] == questionNumber1);
                          selectedAnswerIndex = selectedAnswerList.indexWhere(
                              (element) =>
                                  element['questionNumber'] ==
                                  answer[indexIs]['questionNumber']);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 13.w, vertical: 13.w),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(18.r)),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizeConfig.sH25,
                answer[indexIs]['questionType'] == 'audio'
                    ? const AudioWaveForm()
                    : Column(
                        children: [
                          CustomText(
                            indexIs != -1
                                ? 'Q${answer[indexIs]['questionNumber']}. ${answer[indexIs]['question']}'
                              : '',
                            // 'Q${questionsAnswerViewModel.questionsDetail[indexIs].id}. ${questionsAnswerViewModel.questionsDetail[indexIs].title}',
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          SizeConfig.sH10,
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: answer[indexIs]['answer'].length,
                            itemBuilder: (context, answerIndex) {
                              final data = answer[indexIs]['answer'];
                              return GestureDetector(
                                onTap: () {
                                  print('GestureDetector ma call thay che');
                                  setState(() {
                                    selectedOptionValue = data[answerIndex]['id'];
                                    bool alreadyExists = selectedAnswerList.any(
                                        (data) =>
                                            data['questionNumber'] ==
                                            answer[indexIs]['questionNumber']);

                                    if (!alreadyExists) {
                                      print('===== aama jay che =====');
                                      selectedAnswerList.add({
                                        'questionNumber': answer[indexIs]
                                            ['questionNumber'],
                                        'answerId': data[answerIndex]['id']
                                      });
                                    } else {
                                      final updateDataIndex =
                                          selectedAnswerList.where((element) =>
                                              element['questionNumber'] ==
                                              answer[indexIs]['questionNumber']);
                                      if (updateDataIndex.isNotEmpty) {
                                        var itemToUpdate = updateDataIndex.first;
                                        itemToUpdate["answerId"] =
                                            data[answerIndex]['id'];
                                      }
                                    }
                                    print(
                                        'selectedAnswerList ---===> ${selectedAnswerList}');
                                    selectedAnswerIndex =
                                        selectedAnswerList.indexWhere((element) =>
                                            element['answerId'] ==
                                            selectedOptionValue);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.w),
                                  margin: EdgeInsets.symmetric(vertical: 10.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: selectedAnswerList.every(
                                                  (element) =>
                                                      element['questionNumber'] !=
                                                      answer[indexIs]
                                                          ['questionNumber'])
                                              ? AppColors.greyEE
                                              : selectedAnswerIndex == -1
                                                  ? AppColors.greyEE
                                                  : selectedAnswerList[
                                                                  selectedAnswerIndex]
                                                              ['answerId'] ==
                                                          data[answerIndex]['id']
                                                      ? AppColors.primaryColor
                                                      : AppColors.greyEE),
                                      color: AppColors.greyFD,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.5,
                                        child: Radio<String>(
                                          activeColor: AppColors.primaryColor,
                                          value: selectedAnswerList.every(
                                                  (element) =>
                                                      element['questionNumber'] !=
                                                      answer[indexIs]
                                                          ['questionNumber'])
                                              ? ''
                                              : selectedAnswerIndex == -1
                                                  ? ''
                                                  : selectedAnswerList[
                                                          selectedAnswerIndex]
                                                      ['answerId'],

                                          ///selectedOptionValue ?? '',
                                          groupValue: data[answerIndex]['id'],
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOptionValue =
                                                  data[answerIndex]['id'];
                                              bool alreadyExists =
                                                  selectedAnswerList.any((data) =>
                                                      data['questionNumber'] ==
                                                      answer[indexIs]
                                                          ['questionNumber']);
                                              if (!alreadyExists) {
                                                print('===== aama jay che =====');
                                                selectedAnswerList.add({
                                                  'questionNumber':
                                                      answer[indexIs]
                                                          ['questionNumber'],
                                                  'answerId': data[answerIndex]
                                                      ['id']
                                                });
                                              } else {
                                                final updateDataIndex =
                                                    selectedAnswerList.where(
                                                        (element) =>
                                                            element[
                                                                'questionNumber'] ==
                                                            answer[indexIs][
                                                                'questionNumber']);
                                                if (updateDataIndex.isNotEmpty) {
                                                  var itemToUpdate =
                                                      updateDataIndex.first;
                                                  itemToUpdate["answerId"] =
                                                      data[answerIndex]['id'];
                                                }
                                              }
                                              // selectedAnswerList.add({
                                              //   'questionNumber': answer[indexIs]
                                              //       ['questionNumber'],
                                              //   'answerId': data[answerIndex]
                                              //       ['id']
                                              // });

                                              selectedAnswerIndex =
                                                  selectedAnswerList
                                                      .indexWhere((element) =>
                                                          element['answerId'] ==
                                                          selectedOptionValue);
                                              print(
                                                  'selectedAnswerIndex is $selectedAnswerIndex');
                                              print(
                                                  'selectedAnswerIndex is ${selectedAnswerList}');
                                            });
                                          },
                                        ),
                                      ),
                                      CustomText(
                                        data[answerIndex]['title'],
                                        fontWeight: FontWeight.w500,
                                        color: selectedAnswerList.every(
                                                (element) =>
                                                    element['questionNumber'] !=
                                                    answer[indexIs]
                                                        ['questionNumber'])
                                            ? AppColors.black
                                            : selectedAnswerIndex == -1
                                                ? AppColors.black
                                                : selectedAnswerList[
                                                                selectedAnswerIndex]
                                                            ['answerId'] ==
                                                        data[answerIndex]['id']
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
                answer[indexIs]['questionType'] == 'audio'
                    ? SizeConfig.sH30
                    : SizeConfig.sH10,
                Row(
                  children: [
                    Expanded(
                      child: CustomBtn(
                        onTap: () {
                          questionNumber1 += 1;
                          if (questionNumber1 >= answer.length + 1) {
                            questionsAnswerViewModel.commentController.value
                                .clear();
                            Get.off(() => const CongratulationsScreen());
                          } else {
                            indexIs = answer.indexWhere((element) =>
                                element['questionNumber'] == questionNumber1);
                            selectedAnswerIndex = selectedAnswerList.indexWhere(
                                (element) =>
                                    element['questionNumber'] ==
                                    answer[indexIs]['questionNumber']);
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
                        onTap: () {
                          questionNumber1 += 1;
                          if (questionNumber1 >= answer.length + 1) {
                            questionsAnswerViewModel.commentController.value
                                .clear();
                            Get.off(() => const CongratulationsScreen());
                          } else {
                            indexIs = answer.indexWhere((element) =>
                                element['questionNumber'] == questionNumber1);
                            selectedAnswerIndex = selectedAnswerList.indexWhere(
                                (element) =>
                                    element['questionNumber'] ==
                                    answer[indexIs]['questionNumber']);
                          }
                        },
                        title: AppStrings.next,
                        bgColor: AppColors.primaryColor,
                        borderColor: AppColors.white,
                        textColor: AppColors.white,
                        radius: 10,
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
