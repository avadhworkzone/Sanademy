import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

GetCoursesResModel getCoursesResModelFromJson(String str) =>
    GetCoursesResModel.fromJson(json.decode(str));
String getCoursesResModelToJson(GetCoursesResModel data) =>
    json.encode(data.toJson());

class GetCoursesResModel {
  GetCoursesResModel({
    this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  GetCoursesResModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['status_code'];
  }
  bool? success;
  Data? data;
  String? message;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    map['status_code'] = statusCode;
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.currentPage,
    this.courses,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      courses = [];
      json['data'].forEach((v) {
        courses?.add(HomeCourse.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  num? currentPage;
  List<HomeCourse>? courses;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  num? perPage;
  dynamic prevPageUrl;
  num? to;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (courses != null) {
      map['data'] = courses?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }
}

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());

class Links {
  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
  dynamic url;
  String? label;
  bool? active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['active'] = active;
    return map;
  }
}

// Data dataFromJson(String str) => Data.fromJson(json.decode(str));
// String dataToJson(Data data) => json.encode(data.toJson());

class HomeCourse {
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
    this.registrationForm,
    this.createdAt,
    this.updatedAt,
    this.teacher,
    this.category,
  });

  HomeCourse.fromJson(dynamic json) {
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
    registrationForm = json['registration_form'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
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
  dynamic language;
  num? price;
  dynamic taskIncluded;
  dynamic certificate;
  num? registrationForm;
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
    map['language'] = language;
    map['price'] = price;
    map['task_included'] = taskIncluded;
    map['certificate'] = certificate;
    map['registration_form'] = registrationForm;
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
    this.updatedAt,
  });

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
  dynamic colorCode;
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
    this.updatedAt,
  });

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
  dynamic description;
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

class HomeScreenCourseCache {
  final List<HomeCourse> courses;
  final DateTime lastUpdated;

  HomeScreenCourseCache({
    required this.courses,
    required this.lastUpdated,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'courses': courses.map((course) => course.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  // Convert from JSON with null checks
  factory HomeScreenCourseCache.fromJson(Map<String, dynamic> json) {
    return HomeScreenCourseCache(
      courses: (json['courses'] as List?)
              ?.map((courseJson) => HomeCourse.fromJson(courseJson))
              .toList() ??
          [], // Default to empty string if null
      lastUpdated: DateTime.parse(json['lastUpdated'] ??
          DateTime.now().toIso8601String()), // Default to current date if null
    );
  }

  // Save cache to SharedPreferences
  static Future<void> saveCache(HomeScreenCourseCache cache) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('home_screen_course_cache', jsonEncode(cache.toJson()));
  }

  // Load cache from SharedPreferences
  static Future<HomeScreenCourseCache?> loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = prefs.getString('home_screen_course_cache');
    if (cacheData != null) {
      return HomeScreenCourseCache.fromJson(jsonDecode(cacheData));
    }
    return null;
  }
}
