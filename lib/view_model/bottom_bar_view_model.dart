import 'package:get/get.dart';
import 'package:sanademy/view/homeScreen/home_screen.dart';
import 'package:sanademy/view/my_progress_screen/my_progress_screen.dart';

class BottomBarViewModel extends GetxController{

  Rx<int> selectedBottomIndex = 0.obs;

  RxList screenList = [
    HomeScreen(),
    MyProgressScreen(),
    HomeScreen(),
    HomeScreen(),
  ].obs;
}