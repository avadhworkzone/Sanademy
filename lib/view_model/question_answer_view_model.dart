import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_question_res_model.dart';
import 'package:sanademy/networks/model/save_questions_res_model.dart';
import 'package:sanademy/networks/services/apiService/get_question_api_service.dart';
import 'package:sanademy/networks/services/apiService/save_questions_api_sevice.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/view/examScreen/congratulations_screen.dart';

class QuestionsAnswerViewModel extends GetxController {
  Rx<TextEditingController> audioAnswerController = TextEditingController().obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  RxList<QuestionsDetail> questionsDetail = <QuestionsDetail>[].obs;
  GetQuestionResModel getQuestionResModel = GetQuestionResModel();
  Rx<PageController> pageController = PageController().obs;
  Rx<Timer>? timer1;
  Rx<Duration> duration = const Duration(seconds: 0).obs;
  String timeIs = DateTime.now().toString();
  List<Map<String, dynamic>> selectedAnswerList = [];


  initData(bool mounted) {
    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var difference = DateTime.now().difference(DateTime.parse(timeIs));
      if (mounted) {
          duration.value = Duration(seconds: difference.inSeconds);
      }
    }).obs;
  }

  void stopTimer() {
    if (timer1 != null) {
      timer1!.value.cancel();
    }
  }

  void jumpToPage(int pageIndex) {
    pageController.value.jumpToPage(pageIndex);
  }

  Future<void> getQuestionsViewModel({
    required String examId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.examId: examId.toString(),
    };
    final response =
        await GetQuestionApiService().getQuestionRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      getQuestionResModel =
          getQuestionResModelFromJson(response.response.toString());
      if (getQuestionResModel.success!) {
        if (getQuestionResModel.data != null) {
          questionsDetail.value = getQuestionResModel.data!;
          responseStatus.value = ResponseStatus.Completed;
        } else {
          showErrorSnackBar('', getQuestionResModel.message ?? 'Error');
        }
      } else {
        showErrorSnackBar('', getQuestionResModel.message ?? 'Error');
        responseStatus.value = ResponseStatus.Error;
      }
    }
  }

  Rx<ResponseStatus> saveQuestionsResponseStatus = ResponseStatus.INITIAL.obs;

  Future<void> saveQuestionsViewModel(String examTitle,
      {required String examId,
      required List questionIds,
      required List answers,
      required String time}) async {
    unFocus();
    Map<String, dynamic> queryParams = {
      ApiKeys.examId: examId.toString(),
      ApiKeys.questionIds: questionIds,
      ApiKeys.answers: answers,
      ApiKeys.time:time
    };

    final response = await SaveQuestionApiService()
        .saveQuestionApiRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      SaveQuestionsResModel saveQuestionsResModel =
          saveQuestionsResModelFromJson(response.response.toString());
      if (saveQuestionsResModel.success!) {
        if (saveQuestionsResModel.data != null) {

          saveQuestionsResponseStatus.value = ResponseStatus.Completed;
          showSussesSnackBar('', saveQuestionsResModel.message.toString());
        } else {
          showErrorSnackBar('', saveQuestionsResModel.message ?? 'Error');
        }
        Get.to(() => CongratulationsScreen(
              examId: examId,
              examTitle: examTitle,
            ));
      } else {
        showErrorSnackBar('', saveQuestionsResModel.message ?? 'Error');
        responseStatus.value = ResponseStatus.Error;
      }
    }
  }
}
