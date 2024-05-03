import 'dart:convert';

GetContactUsResModel getContactUsResModelFromJson(String str) => GetContactUsResModel.fromJson(json.decode(str));
String getContactUsResModelToJson(GetContactUsResModel data) => json.encode(data.toJson());
class GetContactUsResModel {
  GetContactUsResModel({
      this.success, 
      this.data, 
      this.message,});

  GetContactUsResModel.fromJson(dynamic json) {
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
      this.location, 
      this.phoneNumber, 
      this.email, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    location = json['location'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? location;
  String? phoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['location'] = location;
    map['phone_number'] = phoneNumber;
    map['email'] = email;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}