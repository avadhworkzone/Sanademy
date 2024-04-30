import 'dart:convert';

LoginResModel loginResModelFromJson(String str) =>
    LoginResModel.fromJson(json.decode(str));
String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());

class LoginResModel {
  LoginResModel({
    this.success,
    this.data,
    this.message,
  });

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
    this.dateOfBirth,
    this.otp,
    this.phoneCode,
    this.phoneNumber,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    otp = json['otp'];
    phoneCode = json['phone_code'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }
  num? id;
  String? name;
  String? dateOfBirth;

  ///Only if step 1 pass in api
  int? otp;
  String? phoneCode;
  String? phoneNumber;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['date_of_birth'] = dateOfBirth;
    map['otp'] = otp;
    map['phone_code'] = phoneCode;
    map['phone_number'] = phoneNumber;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['token'] = token;
    return map;
  }
}
