import 'dart:convert';

RequestHardCopyResModel requestHardCopyResModelFromJson(String str) =>
    RequestHardCopyResModel.fromJson(json.decode(str));

String requestHardCopyResModelToJson(RequestHardCopyResModel data) =>
    json.encode(data.toJson());

class RequestHardCopyResModel {
  RequestHardCopyResModel({
    this.success,
    this.data,
    this.message,
  });

  RequestHardCopyResModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
  bool? success;
  Data? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.userId,
    this.courseId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    courseId = json['course_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  num? userId;
  String? courseId;
  String? updatedAt;
  String? createdAt;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['course_id'] = courseId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }
}
