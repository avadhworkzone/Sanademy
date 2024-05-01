// To parse this JSON data, do
//
//     final commonErrorResModel = commonErrorResModelFromJson(jsonString);

import 'dart:convert';

CommonErrorResModel commonErrorResModelFromJson(String str) => CommonErrorResModel.fromJson(json.decode(str));

String commonErrorResModelToJson(CommonErrorResModel data) => json.encode(data.toJson());

class CommonErrorResModel {
  bool? success;
  String? message;
  String? data;

  CommonErrorResModel({
    this.success,
    this.message,
    this.data,
  });

  factory CommonErrorResModel.fromJson(Map<String, dynamic> json) => CommonErrorResModel(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
