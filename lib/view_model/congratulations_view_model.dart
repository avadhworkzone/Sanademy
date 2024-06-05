
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/exam_result_res_model.dart';
import 'package:sanademy/networks/services/apiService/exam_result_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class CongratulationsScreenViewModel extends GetxController{
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  ExamResultResModel examResultResModel = ExamResultResModel();
  RxList<QuestionAnswers> questionAnswerDetail = <QuestionAnswers>[].obs;


  Future<void> examResultViewModel({
    required String examId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.examId: examId.toString(),
    };
    final response = await ExamResultApiService().examResultRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
       examResultResModel =
      examResultResModelFromJson(response.response.toString());
      if (examResultResModel.success!) {
        if (examResultResModel.data != null) {
            questionAnswerDetail.value = examResultResModel.data!.questionAnswers!;
          responseStatus.value = ResponseStatus.Completed;
        }else{
          showErrorSnackBar('', examResultResModel.message.toString());
        }
      }else{
        showErrorSnackBar('', examResultResModel.message.toString());
        responseStatus.value = ResponseStatus.Error;
      }
    }
  }

}