import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/model/delete_user_api_response.dart';
import 'package:sanademy/networks/services/apiService/delete_user_api_sevice.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/view/auth/sign_up_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreenViewModel extends GetxController {
  RxList drawerData = [
    AppStrings.contactUs,
    AppStrings.aboutUs,
    AppStrings.logOut,
    AppStrings.deleteAccount,
  ].obs;

  void launchWhatsApp(String message, String number) async {
    final Uri url = Uri.parse('https://wa.me/$number?text=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// CALL DELETE USER ACCOUNT API
  Rx<ResponseStatus> deleteUserResponseStatus = ResponseStatus.INITIAL.obs;

  Future<void> deleteUserAccountViewModel() async {
    unFocus();
    final response = await DeleteUserApiService().deleteUserRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      DeleteUserApiResponse deleteUserApiResponse = deleteUserApiResponseFromJson(response.response.toString());
    if(deleteUserApiResponse.success!){
      Get.off(const SignUpScreen());
      deleteUserResponseStatus.value = ResponseStatus.Completed;
      showSussesSnackBar('', deleteUserApiResponse.message.toString());
    }else{
      showErrorSnackBar('', deleteUserApiResponse.message.toString());
      deleteUserResponseStatus.value = ResponseStatus.Error;
    }
    }
  }
}
