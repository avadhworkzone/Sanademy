import 'dart:convert';
SaveQuestionsResModel saveQuestionsResModelFromJson(String str) => SaveQuestionsResModel.fromJson(json.decode(str));
String saveQuestionsResModelToJson(SaveQuestionsResModel data) => json.encode(data.toJson());
class SaveQuestionsResModel {
  SaveQuestionsResModel({
      this.success, 
      this.data, 
      this.message,});

  SaveQuestionsResModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }
  bool? success;
  dynamic data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    return map;
  }

}