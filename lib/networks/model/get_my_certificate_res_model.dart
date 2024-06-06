import 'dart:convert';

GetMyCertificateResModel getMyCertificateResModelFromJson(String str) =>
    GetMyCertificateResModel.fromJson(json.decode(str));

String getMyCertificateResModelToJson(GetMyCertificateResModel data) =>
    json.encode(data.toJson());

class GetMyCertificateResModel {
  GetMyCertificateResModel({
    this.success,
    this.data,
    this.message,
  });

  GetMyCertificateResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CertificateData.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<CertificateData>? data;
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

CertificateData dataFromJson(String str) =>
    CertificateData.fromJson(json.decode(str));
String dataToJson(CertificateData data) => json.encode(data.toJson());

class CertificateData {
  CertificateData({
    this.id,
    this.userId,
    this.courseId,
    this.completedHour,
    this.completedMinute,
    this.remainingHour,
    this.remainingMinute,
    this.createdAt,
    this.updatedAt,
    this.certificate,
    this.course,
  });

  CertificateData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    completedHour = json['completed_hour'];
    completedMinute = json['completed_minute'];
    remainingHour = json['remaining_hour'];
    remainingMinute = json['remaining_minute'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    certificate = json['certificate'];
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
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
  String? certificate;
  Course? course;

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
    map['certificate'] = certificate;
    if (course != null) {
      map['course'] = course?.toJson();
    }
    return map;
  }
}

Course courseFromJson(String str) => Course.fromJson(json.decode(str));
String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  Course({
    this.id,
    this.categoryId,
    this.teacherId,
    this.title,
    this.videoUrl,
    this.banner,
    this.hours,
    this.minutes,
    this.numberOfLecture,
    this.colorCode,
    this.description,
    this.requirements,
    this.whatWillYouLearn,
    this.whoThisCourseIsFor,
    this.instructor,
    this.createdAt,
    this.updatedAt,
  });

  Course.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    teacherId = json['teacher_id'];
    title = json['title'];
    videoUrl = json['video_url'];
    banner = json['banner'];
    hours = json['hours'];
    minutes = json['minutes'];
    numberOfLecture = json['number_of_lecture'];
    colorCode = json['color_code'];
    description = json['description'];
    requirements = json['requirements'];
    whatWillYouLearn = json['what_will_you_learn'];
    whoThisCourseIsFor = json['who_this_course_is_for'];
    instructor = json['instructor'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? categoryId;
  num? teacherId;
  String? title;
  String? videoUrl;
  String? banner;
  String? hours;
  String? minutes;
  String? numberOfLecture;
  String? colorCode;
  String? description;
  String? requirements;
  String? whatWillYouLearn;
  String? whoThisCourseIsFor;
  String? instructor;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['teacher_id'] = teacherId;
    map['title'] = title;
    map['video_url'] = videoUrl;
    map['banner'] = banner;
    map['hours'] = hours;
    map['minutes'] = minutes;
    map['number_of_lecture'] = numberOfLecture;
    map['color_code'] = colorCode;
    map['description'] = description;
    map['requirements'] = requirements;
    map['what_will_you_learn'] = whatWillYouLearn;
    map['who_this_course_is_for'] = whoThisCourseIsFor;
    map['instructor'] = instructor;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
