import 'dart:convert';
GetCategoryByCourseResModel getCategoryByCourseResModelFromJson(String str) => GetCategoryByCourseResModel.fromJson(json.decode(str));
String getCategoryByCourseResModelToJson(GetCategoryByCourseResModel data) => json.encode(data.toJson());
class GetCategoryByCourseResModel {
  GetCategoryByCourseResModel({
      this.success, 
      this.data, 
      this.message,});

  GetCategoryByCourseResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryWiseCourse.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<CategoryWiseCourse>? data;
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

CategoryWiseCourse dataFromJson(String str) => CategoryWiseCourse.fromJson(json.decode(str));
String dataToJson(CategoryWiseCourse data) => json.encode(data.toJson());
class CategoryWiseCourse {
  CategoryWiseCourse({
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
      this.teacher, 
      this.category,});

  CategoryWiseCourse.fromJson(dynamic json) {
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
    teacher = json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
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
  Teacher? teacher;
  Category? category;

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
    if (teacher != null) {
      map['teacher'] = teacher?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
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
      this.createdAt, 
      this.updatedAt,});

  Teacher.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? mobileNumber;
  String? image;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile_number'] = mobileNumber;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}