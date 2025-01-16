// To parse this JSON data, do
//
//     final getHomeScreenDataResModel = getHomeScreenDataResModelFromJson(jsonString);

import 'dart:convert';

GetHomeScreenDataResModel getHomeScreenDataResModelFromJson(String str) => GetHomeScreenDataResModel.fromJson(json.decode(str));

String getHomeScreenDataResModelToJson(GetHomeScreenDataResModel data) => json.encode(data.toJson());

class GetHomeScreenDataResModel {
  bool? success;
  HomeUser? user;
  List<dynamic>? myCourses;
  List<HomeCourse>? courses;
  List<HomeCategory>? categories;

  GetHomeScreenDataResModel({
    this.success,
    this.user,
    this.myCourses,
    this.courses,
    this.categories,
  });

  factory GetHomeScreenDataResModel.fromJson(Map<String, dynamic> json) => GetHomeScreenDataResModel(
    success: json["success"],
    user: json["user"] == null ? null : HomeUser.fromJson(json["user"]),
    myCourses: json["myCourses"] == null ? [] : List<dynamic>.from(json["myCourses"]!.map((x) => x)),
    courses: json["courses"] == null ? [] : List<HomeCourse>.from(json["courses"]!.map((x) => HomeCourse.fromJson(x))),
    categories: json["categories"] == null ? [] : List<HomeCategory>.from(json["categories"]!.map((x) => HomeCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user": user?.toJson(),
    "myCourses": myCourses == null ? [] : List<dynamic>.from(myCourses!.map((x) => x)),
    "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

class HomeCourse {
  int? id;
  int? categoryId;
  int? teacherId;
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
  dynamic language;
  int? price;
  int? taskIncluded;
  int? certificate;
  DateTime? createdAt;
  DateTime? updatedAt;

  HomeCourse({
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
  });

  factory HomeCourse.fromJson(Map<String, dynamic> json) => HomeCourse(
    id: json["id"],
    categoryId: json["category_id"],
    teacherId: json["teacher_id"],
    title: json["title"],
    videoUrl: json["video_url"],
    banner: json["banner"],
    hours: json["hours"],
    minutes: json["minutes"],
    numberOfLecture: json["number_of_lecture"],
    colorCode: json["color_code"],
    description: json["description"],
    requirements: json["requirements"],
    whatWillYouLearn: json["what_will_you_learn"],
    whoThisCourseIsFor: json["who_this_course_is_for"],
    instructor: json["instructor"],
    language: json["language"],
    price: json["price"],
    taskIncluded: json["task_included"],
    certificate: json["certificate"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "teacher_id": teacherId,
    "title": title,
    "video_url": videoUrl,
    "banner": banner,
    "hours": hours,
    "minutes": minutes,
    "number_of_lecture": numberOfLecture,
    "color_code": colorCode,
    "description": description,
    "requirements": requirements,
    "what_will_you_learn": whatWillYouLearn,
    "who_this_course_is_for": whoThisCourseIsFor,
    "instructor": instructor,
    "language": language,
    "price": price,
    "task_included": taskIncluded,
    "certificate": certificate,
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
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    phoneCode: json["phone_code"],
    phoneNumber: json["phone_number"],
    countryCode: json["country_code"],
    address: json["address"],
    image: json["image"],
    role: json["role"],
    emailVerifiedAt: json["email_verified_at"],
    deviceType: json["device_type"],
    deviceToken: json["device_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
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
