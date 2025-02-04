import 'package:flutter/foundation.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_urls.dart';
import 'package:sanademy/networks/response_model.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_utils.dart';

class HomeDataService {
  Future<ResponseModel?> homeDataRepo(
      {required Map<String, dynamic> mapData}) async {
    final response = await ApiBaseHelper().postHTTP(
      ApiUrls.home,
      params: mapData,
      showProgress: (isCallApi.value) ? false : true,
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

  ///New APIS

  Future<ResponseModel?> homeScreenCoursesRepo() {
    final response = ApiBaseHelper().getHTTP(
      ApiUrls.courses,
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
