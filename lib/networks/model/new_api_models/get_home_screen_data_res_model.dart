// To parse this JSON data, do
//
//     final getHomeScreenDataResModel = getHomeScreenDataResModelFromJson(jsonString);

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

GetHomeScreenDataResModel getHomeScreenDataResModelFromJson(String str) =>
    GetHomeScreenDataResModel.fromJson(json.decode(str));

String getHomeScreenDataResModelToJson(GetHomeScreenDataResModel data) =>
    json.encode(data.toJson());

class GetHomeScreenDataResModel {
  bool? success;
  HomeUser? user;
  List<dynamic>? myCourses;
  // List<HomeCourse>? courses;
  List<HomeCategory>? categories;

  GetHomeScreenDataResModel({
    this.success,
    this.user,
    this.myCourses,
    // this.courses,
    this.categories,
  });

  factory GetHomeScreenDataResModel.fromJson(Map<String, dynamic> json) =>
      GetHomeScreenDataResModel(
        success: json["success"],
        user: json["user"] == null ? null : HomeUser.fromJson(json["user"]),
        myCourses: json["myCourses"] == null
            ? []
            : List<dynamic>.from(json["myCourses"]!.map((x) => x)),
        // courses: json["courses"] == null
        //     ? []
        //     : List<HomeCourse>.from(
        //         json["courses"]!.map((x) => HomeCourse.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<HomeCategory>.from(
                json["categories"]!.map((x) => HomeCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user?.toJson(),
        "myCourses": myCourses == null
            ? []
            : List<dynamic>.from(myCourses!.map((x) => x)),
        // "courses": courses == null
        //     ? []
        //     : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class HomeCategory {
  int? id;
  String? image;
  String? name;
  dynamic colorCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  HomeCategory({
    this.id,
    this.image,
    this.name,
    this.colorCode,
    this.createdAt,
    this.updatedAt,
  });

  factory HomeCategory.fromJson(Map<String, dynamic> json) => HomeCategory(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        colorCode: json["color_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "color_code": colorCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class HomeUser {
  int? id;
  String? name;
  dynamic email;
  DateTime? dateOfBirth;
  String? phoneCode;
  String? phoneNumber;
  dynamic countryCode;
  dynamic address;
  String? image;
  String? role;
  dynamic emailVerifiedAt;
  dynamic deviceType;
  dynamic deviceToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  HomeUser({
    this.id,
    this.name,
    this.email,
    this.dateOfBirth,
    this.phoneCode,
    this.phoneNumber,
    this.countryCode,
    this.address,
    this.image,
    this.role,
    this.emailVerifiedAt,
    this.deviceType,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
  });

  factory HomeUser.fromJson(Map<String, dynamic> json) => HomeUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
        address: json["address"],
        image: json["image"],
        role: json["role"],
        emailVerifiedAt: json["email_verified_at"],
        deviceType: json["device_type"],
        deviceToken: json["device_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "address": address,
        "image": image,
        "role": role,
        "email_verified_at": emailVerifiedAt,
        "device_type": deviceType,
        "device_token": deviceToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class HomeScreenCache {
  final List<HomeCategory> categories;
  final HomeUser userData;
  // final List<HomeCourse> courses;
  final String userImage;
  final DateTime lastUpdated;

  HomeScreenCache({
    required this.categories,
    required this.userData,
    // required this.courses,
    required this.userImage,
    required this.lastUpdated,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((category) => category.toJson()).toList(),
      'userData': userData.toJson(),
      // 'courses': courses.map((course) => course.toJson()).toList(),
      'userImage': userImage,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  // Convert from JSON with null checks
  factory HomeScreenCache.fromJson(Map<String, dynamic> json) {
    return HomeScreenCache(
      categories: (json['categories'] as List?)
              ?.map((categoryJson) => HomeCategory.fromJson(categoryJson))
              .toList() ??
          [], // Default to empty list if null
      userData: HomeUser.fromJson(json['userData'] ?? {}),
      // courses: (json['courses'] as List?)
      //         ?.map((courseJson) => HomeCourse.fromJson(courseJson))
      //         .toList() ??
      //     [], // Default to empty list if null
      userImage: json['userImage'] ?? '', // Default to empty string if null
      lastUpdated: DateTime.parse(json['lastUpdated'] ??
          DateTime.now().toIso8601String()), // Default to current date if null
    );
  }

  // Save cache to SharedPreferences
  static Future<void> saveCache(HomeScreenCache cache) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('home_screen_cache', jsonEncode(cache.toJson()));
  }

  // Load cache from SharedPreferences
  static Future<HomeScreenCache?> loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = prefs.getString('home_screen_cache');
    if (cacheData != null) {
      return HomeScreenCache.fromJson(jsonDecode(cacheData));
    }
    return null;
  }
}
