import 'dart:convert';
GetExamResModel getExamResModelFromJson(String str) => GetExamResModel.fromJson(json.decode(str));
String getExamResModelToJson(GetExamResModel data) => json.encode(data.toJson());
class GetExamResModel {
  GetExamResModel({
      this.success, 
      this.data, 
      this.message,});

  GetExamResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<Data>? data;
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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.courseId, 
      this.title, 
      this.subTitle, 
      this.createdAt, 
      this.updatedAt, 
      this.questionsCount,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    courseId = json['course_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionsCount = json['questions_count'];
  }
  num? id;
  num? courseId;
  String? title;
  String? subTitle;
  String? createdAt;
  String? updatedAt;
  num? questionsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['course_id'] = courseId;
    map['title'] = title;
    map['sub_title'] = subTitle;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['questions_count'] = questionsCount;
    return map;
  }

}