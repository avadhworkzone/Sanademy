import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/model/get_about_us_res_model.dart';
import 'package:sanademy/networks/services/apiService/about_us_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class AboutUsViewModel extends GetxController {

  RxString description = ''.obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;

  Future<void> getAboutUsData() async {
    final response = await AboutUsService().aboutUsRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetAboutUsResModel getAboutUsResModel = getAboutUsResModelFromJson(response.response.toString());
      if (getAboutUsResModel.data != null) {
        description.value = getAboutUsResModel.data!.description!;
        responseStatus.value = ResponseStatus.Completed;
      }else{
        showErrorSnackBar('', getAboutUsResModel.message.toString());
      }
    }else{
      showErrorSnackBar('', 'ERROR');
      responseStatus.value = ResponseStatus.Error;
    }
  }
}
