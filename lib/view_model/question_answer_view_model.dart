import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_question_res_model.dart';
import 'package:sanademy/networks/services/apiService/get_question_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class QuestionsAnswerViewModel extends GetxController {
  Rx<TextEditingController> commentController = TextEditingController().obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  RxList<QuestionsDetail> questionsDetail = <QuestionsDetail>[].obs;
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
      GetQuestionResModel  getQuestionResModel =
      getQuestionResModelFromJson(response.response.toString());
      if (getQuestionResModel.success!) {
        if (getQuestionResModel.data != null) {
          questionsDetail.value  = getQuestionResModel.data!;
          responseStatus.value = ResponseStatus.Completed;
        }else {
          showErrorSnackBar('', getQuestionResModel.message ?? 'Error');
        }
      }else {
        showErrorSnackBar('', getQuestionResModel.message ?? 'Error');
        responseStatus.value = ResponseStatus.Error;
      }
    }
  }
}
