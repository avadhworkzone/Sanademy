import 'dart:convert';

UpdateProfileResModel updateProfileResModelFromJson(String str) => UpdateProfileResModel.fromJson(json.decode(str));
String updateProfileResModelToJson(UpdateProfileResModel data) => json.encode(data.toJson());
class UpdateProfileResModel {
  UpdateProfileResModel({
      this.success, 
      this.data, 
      this.message,});

  UpdateProfileResModel.fromJson(dynamic json) {
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
      this.phoneCode, 
      this.phoneNumber, 
      this.countryCode, 
      this.address, 
      this.image, 
      this.role, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    phoneCode = json['phone_code'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    address = json['address'];
    image = json['image'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? dateOfBirth;
  String? phoneCode;
  String? phoneNumber;
  dynamic countryCode;
  String? address;
  String? image;
  String? role;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['date_of_birth'] = dateOfBirth;
    map['phone_code'] = phoneCode;
    map['phone_number'] = phoneNumber;
    map['country_code'] = countryCode;
    map['address'] = address;
    map['role'] = role;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (image != null) {
      map['image'] = image;
    }
    return map;
  }

}