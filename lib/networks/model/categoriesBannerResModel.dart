import 'dart:convert';
CategoriesBannerResModel categoriesBannerResModelFromJson(String str) => CategoriesBannerResModel.fromJson(json.decode(str));
String categoriesBannerResModelToJson(CategoriesBannerResModel data) => json.encode(data.toJson());
class CategoriesBannerResModel {
  CategoriesBannerResModel({
      this.success, 
      this.data, 
      this.message,});

  CategoriesBannerResModel.fromJson(dynamic json) {
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
      this.banners,});

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
  }
  List<Categories>? categories;
  List<Banners>? banners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (banners != null) {
      map['banners'] = banners?.map((v) => v.toJson()).toList();
    }
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