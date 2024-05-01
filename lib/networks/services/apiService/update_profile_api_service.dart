import 'package:flutter/foundation.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_urls.dart';
import 'package:sanademy/networks/response_model.dart';
import 'package:sanademy/utils/app_utils.dart';

class UpdateProfileService {
  Future<ResponseModel> updateProfileRepo(
      {required Map<String, dynamic> mapData}) {
    final response = ApiBaseHelper().postHTTP(
      ApiUrls.updateProfile,
      params: mapData,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (data) {
        if (data.statusCode! >= 200 && data.statusCode! <= 299) {
          if (kDebugMode) {
            print('success ::: ${data.response?.data['message']}');
          }
        } else {
          if (kDebugMode) {
            print('error ::: ${data.response?.data['message']}');
          }
          Utils.validationCheck(
              message: data.response?.data['message'], isError: true);
        }
      },
    );
    return response;
  }
}
