import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/WriteUsDirectlyResModel.dart';
import 'package:sanademy/networks/model/get_contact_us_res_model.dart';
import 'package:sanademy/networks/services/apiService/contact_us_api_service.dart';
import 'package:sanademy/networks/services/apiService/write_us_directly_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:sanademy/view/homeScreen/home_screen.dart';

class ContactUsViewModel extends GetxController {
  Rx<TextEditingController> contactUsNameController = TextEditingController().obs;
  Rx<TextEditingController> contactUsPhoneController = TextEditingController().obs;
  Rx<TextEditingController> contactUsMessageController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  RxBool isValidate = false.obs;
  RxString location = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString email = ''.obs;
  RxString contactUsPhoneCode = '964'.obs;
  RxString contactUsCountryCode = 'IQ'.obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;

  Future<void> getContactData() async {
    final response = await ContactUsService().contactUsRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetContactUsResModel getContactUsResModel =
          getContactUsResModelFromJson(response.response.toString());
      if(getContactUsResModel.data != null){
        location.value = getContactUsResModel.data!.location!;
        phoneNumber.value = getContactUsResModel.data!.phoneNumber!;
        email.value = getContactUsResModel.data!.email!;
        responseStatus.value = ResponseStatus.Completed;
      }else{
        showErrorSnackBar('', getContactUsResModel.message.toString());
      }
    }else{
      showErrorSnackBar('', 'ERROR');
      responseStatus.value = ResponseStatus.Error;
    }
  }

  Future<void> writeUsDirectlyData() async {

    unFocus();
    Map<String, dynamic> queryParams = {
      ApiKeys.name: contactUsNameController.value.text.trim(),
      ApiKeys.phoneCode: "+${contactUsPhoneCode.value}",
      ApiKeys.countryCode: "+${contactUsCountryCode.value}",
      ApiKeys.phoneNumber: contactUsPhoneController.value.text,
      ApiKeys.message: contactUsMessageController.value.text,
    };
    final response = await WriteUsDirectlyService().writeUsDirectlyRepo(mapData:queryParams );
    if (checkStatusCode(response!.statusCode ?? 0)) {
      WriteUsDirectlyResModel writeUsDirectlyResModel = writeUsDirectlyResModelFromJson(response.response.toString());
      if (writeUsDirectlyResModel.success!) {
        if (writeUsDirectlyResModel.data != null) {
          await showSussesSnackBar('', writeUsDirectlyResModel.message ?? 'SUCCESS');
          Get.to(()=>const HomeScreen());
        }else {
          showSussesSnackBar('', writeUsDirectlyResModel.message ?? 'ERROR');
        }
      }else {
        showSussesSnackBar('', writeUsDirectlyResModel.message ?? 'ERROR');
      }
    }
  }
}
