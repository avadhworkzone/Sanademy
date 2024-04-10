import 'package:get/get.dart';
import 'package:sanademy/localization/ar.dart';
import 'package:sanademy/localization/en_us.dart';


class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {"en_US": en, 'ar': ar};
}
