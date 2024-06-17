import 'package:get/get.dart';
import 'package:sanademy/utils/app_string.dart';
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
}
