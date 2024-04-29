import 'dart:convert';

RegisterResModel registerResModelFromJson(String str) =>
    RegisterResModel.fromJson(json.decode(str));
String registerResModelToJson(RegisterResModel data) =>
    json.encode(data.toJson());

class RegisterResModel {
  RegisterResModel({
    this.success,
    this.data,
    this.message,
  });

  RegisterResModel.fromJson(dynamic json) {
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
    this.name,
    this.dateOfBirth,
    this.phoneCode,
    this.phoneNumber,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.otp,
    this.token,
  });

  Data.fromJson(dynamic json) {
    name = json['name'] ?? '';
    dateOfBirth = json['date_of_birth'];
    phoneCode = json['phone_code'];
    phoneNumber = json['phone_number'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    otp = json['otp'];
    token = json['token'];
  }
  String? name;
  String? dateOfBirth;
  String? phoneCode;
  String? phoneNumber;
  String? updatedAt;
  String? createdAt;
  num? id;

  ///Only if step 1 pass in api
  int? otp;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['date_of_birth'] = dateOfBirth;
    map['phone_code'] = phoneCode;
    map['phone_number'] = phoneNumber;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    map['otp'] = otp;
    map['token'] = token;
    return map;
  }
}
