import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_urls.dart';
import 'package:sanademy/utils/app_utils.dart';

class UpdateProfileService {
  void updateProfileService({required Map<String, dynamic> mapData}) {
    final response = ApiBaseHelper().postHTTP(
      ApiUrls.updateProfile,
      params: mapData,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },

    );
  }
}
