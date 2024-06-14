import 'dart:convert';
LoginResModel loginResModelFromJson(String str) => LoginResModel.fromJson(json.decode(str));
String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());
class LoginResModel {
  LoginResModel({
      this.success, 
      this.data, 
      this.message,});

  LoginResModel.fromJson(dynamic json) {
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
      this.token,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    phoneCode = json['phone_code'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    address = json['address'];
    image = json['image'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }
  num? id;
  String? name;
  dynamic email;
  String? dateOfBirth;
  String? phoneCode;
  String? phoneNumber;
  String? countryCode;
  dynamic address;
  String? image;
  String? role;
  dynamic emailVerifiedAt;
  String? deviceType;
  String? deviceToken;
  String? createdAt;
  String? updatedAt;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['date_of_birth'] = dateOfBirth;
    map['phone_code'] = phoneCode;
    map['phone_number'] = phoneNumber;
    map['country_code'] = countryCode;
    map['address'] = address;
    map['image'] = image;
    map['role'] = role;
    map['email_verified_at'] = emailVerifiedAt;
    map['device_type'] = deviceType;
    map['device_token'] = deviceToken;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['token'] = token;
    return map;
  }

}