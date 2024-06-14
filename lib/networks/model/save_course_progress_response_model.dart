import 'dart:convert';
SaveCourseProgressResponseModel saveCourseProgressResponseModelFromJson(String str) => SaveCourseProgressResponseModel.fromJson(json.decode(str));
String saveCourseProgressResponseModelToJson(SaveCourseProgressResponseModel data) => json.encode(data.toJson());
class SaveCourseProgressResponseModel {
  SaveCourseProgressResponseModel({
      this.success, 
      this.data, 
      this.message,});

  SaveCourseProgressResponseModel.fromJson(dynamic json) {
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
      this.courseContentId, 
      this.lectureId, 
      this.completedMinute, 
      this.remainingMinute, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    courseId = json['course_id'];
    courseContentId = json['course_content_id'];
    lectureId = json['lecture_id'];
    completedMinute = json['completed_minute'];
    remainingMinute = json['remaining_minute'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  num? userId;
  String? courseId;
  String? courseContentId;
  String? lectureId;
  String? completedMinute;
  String? remainingMinute;
  String? updatedAt;
  String? createdAt;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['course_id'] = courseId;
    map['course_content_id'] = courseContentId;
    map['lecture_id'] = lectureId;
    map['completed_minute'] = completedMinute;
    map['remaining_minute'] = remainingMinute;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}