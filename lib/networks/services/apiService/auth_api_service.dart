// import 'package:codestructuredemo/networks/api_base_helper.dart';
// import 'package:codestructuredemo/networks/api_keys.dart';
// import 'package:codestructuredemo/networks/api_urls.dart';
// import 'package:codestructuredemo/networks/response_model.dart';
// import 'package:codestructuredemo/utils/app_utils.dart';
// import 'package:flutter/foundation.dart';
//
// class AuthApiService {
//   Future<ResponseModel?> loginRepo(Map<String, String> mapData) async {
//     final response = await ApiBaseHelper().postHTTP(
//       ApiUrls.logIn,
//       params: mapData,
//       onError: (error) {
//         Utils.validationCheck(message: error.message);
//       },
//       onSuccess: (data) {
//         if (data.statusCode! >= 200 && data.statusCode! <= 299) {
//           if (kDebugMode) {
//             print('success ::: ${data.response?.data['message']}');
//           }
//         } else {
//           if (kDebugMode) {
//             print('error ::: ${data.response?.data['message']}');
//           }
//           Utils.validationCheck(message: data.response?.data['message'], isError: true);
//         }
//       },
//     );
//     return response;
//   }
// }
