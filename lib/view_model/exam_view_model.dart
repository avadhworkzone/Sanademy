import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_exam_res_model.dart';
import 'package:sanademy/networks/services/apiService/exam_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class ExamViewModel extends GetxController{

  RxList<Data> examData = <Data>[].obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  Future<void> getExamData({
    required num courseId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.courseId : courseId.toString(),
    };
    final response = await ExamService().examDataRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetExamResModel getExamResModel = getExamResModelFromJson(response.response.toString());
      if (getExamResModel.success!) {
        if (getExamResModel.data != null) {
          examData.value = getExamResModel.data!;
          responseStatus.value = ResponseStatus.Completed;
        }else{
          showErrorSnackBar('', getExamResModel.message ?? 'Error');
        }
      }else{
        showErrorSnackBar('', getExamResModel.message ?? 'Error');
        responseStatus.value = ResponseStatus.Error;
      }
    }
  }

}