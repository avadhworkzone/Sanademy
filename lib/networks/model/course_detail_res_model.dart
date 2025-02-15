import 'dart:convert';
CourseDetailResModel courseDetailResModelFromJson(String str) => CourseDetailResModel.fromJson(json.decode(str));
String courseDetailResModelToJson(CourseDetailResModel data) => json.encode(data.toJson());
class CourseDetailResModel {
  CourseDetailResModel({
      this.success, 
      this.data, 
      this.message,});

  CourseDetailResModel.fromJson(dynamic json) {
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
      this.updatedAt, 
      this.teacher, 
      this.category, 
      this.courseContents,});

  Data.fromJson(dynamic json) {
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
    teacher = json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['course_contents'] != null) {
      courseContents = [];
      json['course_contents'].forEach((v) {
        courseContents?.add(CourseContents.fromJson(v));
      });
    }
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
  Teacher? teacher;
  Category? category;
  List<CourseContents>? courseContents;

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
    if (teacher != null) {
      map['teacher'] = teacher?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (courseContents != null) {
      map['course_contents'] = courseContents?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

CourseContents courseContentsFromJson(String str) => CourseContents.fromJson(json.decode(str));
String courseContentsToJson(CourseContents data) => json.encode(data.toJson());
class CourseContents {
  CourseContents({
      this.id, 
      this.courseId, 
      this.title, 
      this.numberOfLecture, 
      this.minutes, 
      this.description, 
      this.createdAt, 
      this.updatedAt, 
      this.lectures,});

  CourseContents.fromJson(dynamic json) {
    id = json['id'];
    courseId = json['course_id'];
    title = json['title'];
    numberOfLecture = json['number_of_lecture'];
    minutes = json['minutes'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['lectures'] != null) {
      lectures = [];
      json['lectures'].forEach((v) {
        lectures?.add(Lectures.fromJson(v));
      });
    }
  }
  num? id;
  num? courseId;
  String? title;
  String? numberOfLecture;
  String? minutes;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<Lectures>? lectures;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['course_id'] = courseId;
    map['title'] = title;
    map['number_of_lecture'] = numberOfLecture;
    map['minutes'] = minutes;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (lectures != null) {
      map['lectures'] = lectures?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Lectures lecturesFromJson(String str) => Lectures.fromJson(json.decode(str));
String lecturesToJson(Lectures data) => json.encode(data.toJson());
class Lectures {
  Lectures({
      this.id, 
      this.courseContentId, 
      this.title, 
      this.description, 
      this.videoUrl, 
      this.minutes, 
      this.createdAt, 
      this.updatedAt, 
      this.courseProgress,});

  Lectures.fromJson(dynamic json) {
    id = json['id'];
    courseContentId = json['course_content_id'];
    title = json['title'];
    description = json['description'];
    videoUrl = json['video_url'];
    minutes = json['minutes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    /*if (json['course_progress'] != null) {
      courseProgress = [];
      json['course_progress'].forEach((v) {
        courseProgress?.add(Dynamic.fromJson(v));
      });
    }*/
  }
  num? id;
  num? courseContentId;
  String? title;
  String? description;
  String? videoUrl;
  String? minutes;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? courseProgress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['course_content_id'] = courseContentId;
    map['title'] = title;
    map['description'] = description;
    map['video_url'] = videoUrl;
    map['minutes'] = minutes;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (courseProgress != null) {
      map['course_progress'] = courseProgress?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      this.id, 
      this.image, 
      this.name, 
      this.colorCode, 
      this.createdAt, 
      this.updatedAt,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    colorCode = json['color_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? image;
  String? name;
  String? colorCode;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    map['color_code'] = colorCode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));
String teacherToJson(Teacher data) => json.encode(data.toJson());
class Teacher {
  Teacher({
      this.id, 
      this.name, 
      this.mobileNumber, 
      this.image, 
      this.description, 
      this.createdAt, 
      this.updatedAt,});

  Teacher.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? mobileNumber;
  String? image;
  String? description;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile_number'] = mobileNumber;
    map['image'] = image;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}