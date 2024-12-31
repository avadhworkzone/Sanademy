import 'dart:convert';
RegisterResModel registerResModelFromJson(String str) => RegisterResModel.fromJson(json.decode(str));
String registerResModelToJson(RegisterResModel data) => json.encode(data.toJson());
class RegisterResModel {
  RegisterResModel({
      this.success, 
      this.data, 
      this.message,});

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
      this.countryCode, 
      this.deviceType, 
      this.deviceToken, 
      this.updatedAt, 
      this.createdAt, 
      this.id, 
      this.token,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    phoneCode = json['phone_code'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }
  String? name;
  String? dateOfBirth;
  String? phoneCode;
  String? phoneNumber;
  String? countryCode;
  String? deviceType;
  String? deviceToken;
  String? updatedAt;
  String? createdAt;
  num? id;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['date_of_birth'] = dateOfBirth;
    map['phone_code'] = phoneCode;
    map['phone_number'] = phoneNumber;
    map['country_code'] = countryCode;
    map['device_type'] = deviceType;
    map['device_token'] = deviceToken;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    map['token'] = token;
    return map;
  }

}