import 'dart:convert';
GetCourseProgressResponseModel getCourseProgressResponseModelFromJson(String str) => GetCourseProgressResponseModel.fromJson(json.decode(str));
String getCourseProgressResponseModelToJson(GetCourseProgressResponseModel data) => json.encode(data.toJson());
class GetCourseProgressResponseModel {
  GetCourseProgressResponseModel({
      this.success, 
      this.data, 
      this.message,});

  GetCourseProgressResponseModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? CourseDetail.fromJson(json['data']) : null;
    message = json['message'];
  }
  bool? success;
  CourseDetail? data;
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

CourseDetail dataFromJson(String str) => CourseDetail.fromJson(json.decode(str));
String dataToJson(CourseDetail data) => json.encode(data.toJson());
class CourseDetail {
  CourseDetail({
      this.id, 
      this.userId, 
      this.courseId, 
      this.completedHour, 
      this.completedMinute, 
      this.remainingHour, 
      this.remainingMinute, 
      this.createdAt, 
      this.updatedAt,});

  CourseDetail.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    completedHour = json['completed_hour'];
    completedMinute = json['completed_minute'];
    remainingHour = json['remaining_hour'];
    remainingMinute = json['remaining_minute'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? userId;
  num? courseId;
  String? completedHour;
  String? completedMinute;
  String? remainingHour;
  String? remainingMinute;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['course_id'] = courseId;
    map['completed_hour'] = completedHour;
    map['completed_minute'] = completedMinute;
    map['remaining_hour'] = remainingHour;
    map['remaining_minute'] = remainingMinute;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}