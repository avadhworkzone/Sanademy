import 'dart:convert';

NotificationResModel notificationResModelFromJson(String str) =>
    NotificationResModel.fromJson(json.decode(str));

String notificationResModelToJson(NotificationResModel data) =>
    json.encode(data.toJson());

class NotificationResModel {
  NotificationResModel({
    this.success,
    this.data,
    this.message,
  });

  NotificationResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Notification.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<Notification>? data;
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

Notification dataFromJson(String str) =>
    Notification.fromJson(json.decode(str));
String dataToJson(Notification data) => json.encode(data.toJson());

class Notification {
  Notification({
    this.id,
    this.image,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Notification.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? image;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['title'] = title;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
