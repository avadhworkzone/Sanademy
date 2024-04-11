import 'package:get/get.dart';
import 'package:sanademy/view/homeScreen/home_screen.dart';
import 'package:sanademy/view/myProgressScreen/my_progress_screen.dart';
import 'package:sanademy/view/notificationScreen/notification_screen.dart';
import 'package:sanademy/view/my_certificate_screen/my_certificate_screen.dart';

class BottomBarViewModel extends GetxController {
  Rx<int> selectedBottomIndex = 0.obs;

  RxList screenList = [
    HomeScreen(),
    MyProgressScreen(),
    MyCertificateScreen(),
    NotificationScreen(),
  ].obs;
}
