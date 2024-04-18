import 'package:get/get.dart';
import 'package:sanademy/view/general/no_internet_screen.dart';
import 'package:sanademy/view/homeScreen/home_screen.dart';
import 'package:sanademy/view/myProgressScreen/my_progress_screen.dart';
import 'package:sanademy/view/notificationScreen/notification_screen.dart';
import 'package:sanademy/view/my_certificate_screen/my_certificate_screen.dart';

class BottomBarViewModel extends GetxController {
  Rx<int> selectedBottomIndex = 0.obs;

  RxList screenList = [
    const HomeScreen(),
    const MyProgressScreen(),
    const MyCertificateScreen(),
    const NotificationScreen(),
    const NoInterNetScreen(),
  ].obs;
}
