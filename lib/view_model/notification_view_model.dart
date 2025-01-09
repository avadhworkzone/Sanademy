import 'package:get/get.dart';
import 'package:sanademy/networks/model/notification_res_model.dart';
import 'package:sanademy/networks/services/apiService/notification_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

import '../networks/api_base_helper.dart';

class NotificationViewModel extends GetxController {
  // Status of the API call
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;

  // List to store notifications
  RxList<Notification> notifications = <Notification>[].obs;

  // Fetch notification data from API
  Future<void> getNotificationData() async {
    try {
      // Update status to loading
      responseStatus.value = ResponseStatus.Loading;

      // API call
      final response = await NotificationService().notificationDataRepo();

      // Check response status
      if (response != null && checkStatusCode(response.statusCode ?? 0)) {
        // Parse response data
        NotificationResModel notificationResModel =
            notificationResModelFromJson(response.response.toString());

        // Update notifications if data exists
        if (notificationResModel.data != null) {
          notifications.value = notificationResModel.data!;
          responseStatus.value = ResponseStatus.Completed;
        } else {
          // Show error if data is null
          showErrorSnackBar(
              'Error', notificationResModel.message ?? 'No data available');
          responseStatus.value = ResponseStatus.Error;
        }
      } else {
        // Handle non-success status codes
        showErrorSnackBar('Error', 'Failed to fetch notifications');
        responseStatus.value = ResponseStatus.Error;
      }
    } catch (e) {
      // Handle exceptions
      showErrorSnackBar('Error', e.toString());
      responseStatus.value = ResponseStatus.Error;
    }
  }
}
