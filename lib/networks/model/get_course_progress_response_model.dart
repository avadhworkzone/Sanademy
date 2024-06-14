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
      this.courseId, 
      this.completedMinutes, 
      this.remainingMinutes, 
      this.course,});

  Data.fromJson(dynamic json) {
    courseId = json['course_id'];
    completedMinutes = json['completed_minutes'];
    remainingMinutes = json['remaining_minutes'];
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
  }
  num? courseId;
  num? completedMinutes;
  num? remainingMinutes;
  Course? course;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['course_id'] = courseId;
    map['completed_minutes'] = completedMinutes;
    map['remaining_minutes'] = remainingMinutes;
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
      this.language, 
      this.price, 
      this.taskIncluded, 
      this.certificate, 
      this.createdAt, 
      this.updatedAt,});

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
    language = json['language'];
    price = json['price'];
    taskIncluded = json['task_included'];
    certificate = json['certificate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? categoryId;
  num? teacherId;
  String? title;
  String? videoUrl;
  String? banner;
  dynamic hours;
  String? minutes;
  String? numberOfLecture;
  String? colorCode;
  String? description;
  String? requirements;
  String? whatWillYouLearn;
  String? whoThisCourseIsFor;
  String? instructor;
  String? language;
  num? price;
  num? taskIncluded;
  num? certificate;
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
    map['language'] = language;
    map['price'] = price;
    map['task_included'] = taskIncluded;
    map['certificate'] = certificate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}