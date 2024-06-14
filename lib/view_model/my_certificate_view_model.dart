import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_my_certificate_res_model.dart';
import 'package:sanademy/networks/model/request_hard_copy_res_model.dart';
import 'package:sanademy/networks/services/apiService/my_certificate_api_service.dart';
import 'package:sanademy/networks/services/apiService/request_hard_copy_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class MyCertificateViewModel extends GetxController {
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  RxList<CertificateData> getCertificates = <CertificateData>[].obs;

  /// get certificate data
  Future<void> getCertificateData() async {
    final response = await MyCertificateService().certificateDataRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetMyCertificateResModel getMyCertificateResModel =
          getMyCertificateResModelFromJson(response.response.toString());
      if (getMyCertificateResModel.data != null) {
        getCertificates.value = getMyCertificateResModel.data!;
        responseStatus.value = ResponseStatus.Completed;
      } else {
        showErrorSnackBar('', getMyCertificateResModel.message.toString());
      }
    } else {
      showErrorSnackBar('', 'ERROR');
      responseStatus.value = ResponseStatus.Error;
    }
  }

  Rx<ResponseStatus> requestHardCopyResponseStatus = ResponseStatus.INITIAL.obs;
  RequestHardCopyResModel requestHardCopyResModel = RequestHardCopyResModel();

  /// request hard copy data
  Future<void> requestHardCopyViewModel({
    required String courseId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.courseId: courseId.toString(),
    };
    final response = await RequestHardCopyApiService()
        .requestHardCopyRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      requestHardCopyResModel =
          requestHardCopyResModelFromJson(response.response.toString());
      if (requestHardCopyResModel.success!) {
        if (requestHardCopyResModel.data != null) {
          requestHardCopyResponseStatus.value = ResponseStatus.Completed;
        } else {
          showErrorSnackBar('', requestHardCopyResModel.message ?? 'Error');
        }
      } else {
        showErrorSnackBar('', requestHardCopyResModel.message ?? 'Error');
        requestHardCopyResponseStatus.value = ResponseStatus.Error;
      }
    }
  }
}
