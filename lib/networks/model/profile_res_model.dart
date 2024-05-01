
import 'dart:convert';

ProfileResModel profileResModelFromJson(String str) => ProfileResModel.fromJson(json.decode(str));

String profileResModelToJson(ProfileResModel data) => json.encode(data.toJson());

class ProfileResModel {
  bool? success;
  ProfileData? data;
  String? message;

  ProfileResModel({
    this.success,
    this.data,
    this.message,
  });

  factory ProfileResModel.fromJson(Map<String, dynamic> json) => ProfileResModel(
    success: json["success"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class ProfileData {
  int? id;
  String? name;
  DateTime? dateOfBirth;
  String? phoneCode;
  String? phoneNumber;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileData({
    this.id,
    this.name,
    this.dateOfBirth,
    this.phoneCode,
    this.phoneNumber,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    name: json["name"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    phoneCode: json["phone_code"],
    phoneNumber: json["phone_number"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "phone_code": phoneCode,
    "phone_number": phoneNumber,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
