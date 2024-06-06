import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/model/notification_res_model.dart';
import 'package:sanademy/networks/services/apiService/notification_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class NotificationViewModel extends GetxController {
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  RxList<Notification> getNotifications = <Notification>[].obs;

  Future<void> getNotificationData() async {
    final response = await NotificationService().notificationDataRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      NotificationResModel getNotificationResModel =
          notificationResModelFromJson(response.response.toString());
      if (getNotificationResModel.data != null) {
        getNotifications.value = getNotificationResModel.data!;
        // description.value = getAboutUsResModel.data!.description!;
        responseStatus.value = ResponseStatus.Completed;
      } else {
        showErrorSnackBar('', getNotificationResModel.message.toString());
      }
    } else {
      showErrorSnackBar('', 'ERROR');
      responseStatus.value = ResponseStatus.Error;
    }
  }
}
