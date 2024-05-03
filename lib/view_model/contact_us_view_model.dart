import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/model/get_contact_us_res_model.dart';
import 'package:sanademy/networks/services/apiService/contact_us_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class ContactUsViewModel extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> messageController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  RxBool isValidate = false.obs;
  RxString location = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString email = ''.obs;
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
}
