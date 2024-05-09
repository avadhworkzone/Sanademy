import 'dart:convert';
WriteUsDirectlyResModel writeUsDirectlyResModelFromJson(String str) => WriteUsDirectlyResModel.fromJson(json.decode(str));
String writeUsDirectlyResModelToJson(WriteUsDirectlyResModel data) => json.encode(data.toJson());
class WriteUsDirectlyResModel {
  WriteUsDirectlyResModel({
      this.success, 
      this.data, 
      this.message,});

  WriteUsDirectlyResModel.fromJson(dynamic json) {
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
      this.phoneCode, 
      this.countryCode,
      this.phoneNumber,
      this.message,
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    phoneCode = json['phone_code'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    message = json['message'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? name;
  String? phoneCode;
  String? countryCode;
  String? phoneNumber;
  String? message;
  String? updatedAt;
  String? createdAt;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone_code'] = phoneCode;
    map['country_code'] = countryCode;
    map['phone_number'] = phoneNumber;
    map['message'] = message;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}