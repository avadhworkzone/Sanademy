import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:sanademy/commonWidget/progrss_dialog.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/app_utils.dart';
import 'package:sanademy/utils/logger_utils.dart';

import 'api_urls.dart';
import 'response_model.dart';

bool checkStatusCode(int statusCode) {
  if (statusCode.toString().substring(0, 1) == "2") {
    return true;
  } else {
    return false;
  }
}

class ApiBaseHelper {
  static const String baseUrl = ApiUrls.baseURL;
  static bool showProgressDialog = true;

  static BaseOptions opts = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 45),
    receiveTimeout: const Duration(seconds: 45),
    sendTimeout: const Duration(seconds: 45),
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    ///For Print Logs
    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          error: true,
          responseHeader: true,
        ),
      );
    }

    ///For Show Hide Progress Dialog
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) {
            if (showProgressDialog) ProgressDialog.showProgressDialog(true);
            Logger.printLog(tag: '|---------------> ${options.method} JSON METHOD <---------------|\n\n REQUEST_URL :', printLog: '\n ${options.uri} \n\n REQUEST_HEADER : ${options.headers}  \n\n REQUEST_DATA : ${options.data.toString()}', logIcon: Logger.info);
            // ignore: void_checks
            return requestInterceptor(options, handler);
          },
          onResponse: (response, handler) {
            ProgressDialog.showProgressDialog(false);
            Get.delete<ProgressDialog>();
            showProgressDialog = true;

            if (response.statusCode! >= 100 && response.statusCode! <= 199) {
              Logger.printLog(tag: 'WARNING CODE ${response.statusCode} : ', printLog: response.data.toString(), logIcon: Logger.warning);
            } else {
              // Logger.printLog(tag: 'SUCCESS CODE ${response.statusCode} : ', printLog: response.data.toString(), logIcon: Logger.success);
              logs('SUCCESS CODE ${response.statusCode} :  ${response.data.toString()}');
            }

            /// change after upgrade
            return handler.next(response);
          },
          onError: (DioException e, handler) async {
            ProgressDialog.showProgressDialog(false);
            Get.delete<ProgressDialog>();
            showProgressDialog = true;

            Logger.printLog(
              tag: 'ERROR CODE ${e.response?.statusCode} : ',
            );

            return handler.next(e);
          },
        ),
      );
  }

  static dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    // Get your JWT token

    // TODO DK CHANGES (ADD CONDITION WHEN TOKEN IS STORE)
    // options.headers.addAll({
    //   "Authorization": "Bearer ABCD",
    // });

    return handler.next(options);
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  Future<ResponseModel> postHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.post(
        url,
        data: params,
        onSendProgress: onSendProgress,
      );

      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  Future<ResponseModel> postFileUploadHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.post(
        url,
        data: params,
        onSendProgress: onSendProgress,
      );
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  Future<ResponseModel> deleteHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.delete(
        url,
        data: params,
      );
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  Future<ResponseModel> getHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.get(url, queryParameters: params);

      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  Future<ResponseModel> putHTTP(
    String url, {
    dynamic data,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.put(url, data: data);
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  Future<ResponseModel> patchHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
    void Function(int count, int total)? onSendProgress,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.patch(
        url,
        data: params,
        onSendProgress: onSendProgress,
      );
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  handleResponse(
    Response response,
    Function(DioExceptions dioExceptions) onError,
    Function(ResponseModel res) onSuccess,
  ) {
    var successModel = ResponseModel(statusCode: response.statusCode, response: response);
    onSuccess(successModel);
    return successModel;
  }

  static handleError(
    DioException e,
    Function(DioExceptions dioExceptions) onError,
    Function(ResponseModel res) onSuccess,
  ) {
    switch (e.type) {
      case DioExceptionType.badResponse:
        var errorModel = ResponseModel(statusCode: e.response!.statusCode, response: e.response);
        onSuccess(errorModel);
        return ResponseModel(statusCode: e.response!.statusCode, response: e.response);
      default:
        onError(DioExceptions.fromDioError(e));
        Utils.validationCheck(message: DioExceptions.fromDioError(e).message, isError: true);
        throw DioExceptions.fromDioError(e).message!;
    }
  }
}

class DioExceptions implements Exception {
  String? message;

  DioExceptions.fromDioError(DioException? dioError) {
    switch (dioError!.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "No internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleResponseError(dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioException.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleResponseError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal Server Error. Please try again.';
      default:
        return 'Sorry, something went wrong. Please try again.';
    }
  }
}
