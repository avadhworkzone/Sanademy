import 'dart:convert';
DeleteUserApiResponse deleteUserApiResponseFromJson(String str) => DeleteUserApiResponse.fromJson(json.decode(str));
String deleteUserApiResponseToJson(DeleteUserApiResponse data) => json.encode(data.toJson());
class DeleteUserApiResponse {
  DeleteUserApiResponse({
      this.success, 
      this.data, 
      this.message,});

  DeleteUserApiResponse.fromJson(dynamic json) {
    success = json['success'];
   /* if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Dynamic.fromJson(v));
      });
    }*/
    message = json['message'];
  }
  bool? success;
  List<dynamic>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}