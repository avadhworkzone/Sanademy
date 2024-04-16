import 'package:get/get.dart';
import 'package:sanademy/utils/app_string.dart';

class MenuScreenViewModel extends GetxController {
  RxList drawerData = [
    AppStrings.contactUs,
    AppStrings.aboutUs,
    AppStrings.logOut,
    AppStrings.logOut,
  ].obs;
}
