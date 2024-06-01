import 'dart:convert';
ExamResultResModel examResultResModelFromJson(String str) => ExamResultResModel.fromJson(json.decode(str));
String examResultResModelToJson(ExamResultResModel data) => json.encode(data.toJson());
class ExamResultResModel {
  ExamResultResModel({
      this.success, 
      this.data, 
      this.message,});

  ExamResultResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<Data>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
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
      this.userId, 
      this.examId, 
      this.questionId, 
      this.answer, 
      this.correct, 
      this.skip, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    examId = json['exam_id'];
    questionId = json['question_id'];
    answer = json['answer'];
    correct = json['correct'];
    skip = json['skip'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? userId;
  num? examId;
  num? questionId;
  String? answer;
  num? correct;
  num? skip;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['exam_id'] = examId;
    map['question_id'] = questionId;
    map['answer'] = answer;
    map['correct'] = correct;
    map['skip'] = skip;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}