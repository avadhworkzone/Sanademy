import 'dart:convert';
HomeResModel homeResModelFromJson(String str) => HomeResModel.fromJson(json.decode(str));
String homeResModelToJson(HomeResModel data) => json.encode(data.toJson());
class HomeResModel {
  HomeResModel({
      this.success, 
      this.data, 
      this.message,});

  HomeResModel.fromJson(dynamic json) {
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
      this.categories, 
      this.banners, 
      this.courses,});

  Data.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners?.add(Banners.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = [];
      json['courses'].forEach((v) {
        courses?.add(HomeCoursesData.fromJson(v));
      });
    }
  }
  List<Categories>? categories;
  List<Banners>? banners;
  List<HomeCoursesData>? courses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (banners != null) {
      map['banners'] = banners?.map((v) => v.toJson()).toList();
    }
    if (courses != null) {
      map['courses'] = courses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

HomeCoursesData coursesFromJson(String str) => HomeCoursesData.fromJson(json.decode(str));
String coursesToJson(HomeCoursesData data) => json.encode(data.toJson());
class HomeCoursesData {
  HomeCoursesData({
      this.id, 
      this.categoryId, 
      this.title, 
      this.videoUrl, 
      this.banner, 
      this.hours, 
      this.minutes, 
      this.description, 
      this.createdAt, 
      this.updatedAt, 
      this.category,});

  HomeCoursesData.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    videoUrl = json['video_url'];
    banner = json['banner'];
    hours = json['hours'];
    minutes = json['minutes'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  num? id;
  num? categoryId;
  String? title;
  String? videoUrl;
  String? banner;
  String? hours;
  String? minutes;
  String? description;
  String? createdAt;
  String? updatedAt;
  Category? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['title'] = title;
    map['video_url'] = videoUrl;
    map['banner'] = banner;
    map['hours'] = hours;
    map['minutes'] = minutes;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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

Banners bannersFromJson(String str) => Banners.fromJson(json.decode(str));
String bannersToJson(Banners data) => json.encode(data.toJson());
class Banners {
  Banners({
      this.id, 
      this.image, 
      this.title, 
      this.createdAt, 
      this.updatedAt,});

  Banners.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? image;
  String? title;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['title'] = title;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));
String categoriesToJson(Categories data) => json.encode(data.toJson());
class Categories {
  Categories({
      this.id, 
      this.image, 
      this.name, 
      this.colorCode, 
      this.createdAt, 
      this.updatedAt,});

  Categories.fromJson(dynamic json) {
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