import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_course_progress_response_model.dart';
import 'package:sanademy/networks/services/apiService/get_course_progress_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class MyProgressViewModel extends GetxController {

  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  GetCourseProgressResponseModel getCourseProgressResponseModel = GetCourseProgressResponseModel();
  Future<void> getCourseProgressViewModel() async {
    unFocus();
    final response =
    await GetCourseProgressApi().getCourseProgressRepo(/*mapData: queryParams*/);
    if (checkStatusCode(response!.statusCode ?? 0)) {
       getCourseProgressResponseModel =
      getCourseProgressResponseModelFromJson(response.response.toString());
      if (getCourseProgressResponseModel.success!) {
        if (getCourseProgressResponseModel.data != null) {
          responseStatus.value = ResponseStatus.Completed;
        }else {
          showErrorSnackBar('', getCourseProgressResponseModel.message ?? 'Error');
        }
      }else {
        showErrorSnackBar('', getCourseProgressResponseModel.message ?? 'Error');
        responseStatus.value = ResponseStatus.Error;
      }
    }
  }

}