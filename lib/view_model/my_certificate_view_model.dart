import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/model/get_my_certificate_res_model.dart';
import 'package:sanademy/networks/services/apiService/my_certificate_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class MyCertificateViewModel extends GetxController {
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  RxList<CertificateData> getCertificates = <CertificateData>[].obs;

  Future<void> getCertificateData() async {
    final response = await MyCertificateService().certificateDataRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetMyCertificateResModel getMyCertificateResModel =
          getMyCertificateResModelFromJson(response.response.toString());
      if (getMyCertificateResModel.data != null) {
        getCertificates.value = getMyCertificateResModel.data!;
        // description.value = getAboutUsResModel.data!.description!;
        responseStatus.value = ResponseStatus.Completed;
      } else {
        showErrorSnackBar('', getMyCertificateResModel.message.toString());
      }
    } else {
      showErrorSnackBar('', 'ERROR');
      responseStatus.value = ResponseStatus.Error;
    }
  }
}
