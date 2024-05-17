import 'dart:convert';
GetQuestionResModel getQuestionResModelFromJson(String str) => GetQuestionResModel.fromJson(json.decode(str));
String getQuestionResModelToJson(GetQuestionResModel data) => json.encode(data.toJson());
class GetQuestionResModel {
  GetQuestionResModel({
      this.success, 
      this.data, 
      this.message,});

  GetQuestionResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(QuestionsDetail.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<QuestionsDetail>? data;
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

QuestionsDetail dataFromJson(String str) => QuestionsDetail.fromJson(json.decode(str));
String dataToJson(QuestionsDetail data) => json.encode(data.toJson());
class QuestionsDetail {
  QuestionsDetail({
      this.id, 
      this.examId, 
      this.title, 
      this.type, 
      this.option1, 
      this.option2, 
      this.option3, 
      this.option4, 
      this.correctAns, 
      this.audio, 
      this.createdAt, 
      this.updatedAt,});

  QuestionsDetail.fromJson(dynamic json) {
    id = json['id'];
    examId = json['exam_id'];
    title = json['title'];
    type = json['type'];
    option1 = json['option_1'];
    option2 = json['option_2'];
    option3 = json['option_3'];
    option4 = json['option_4'];
    correctAns = json['correct_ans'];
    audio = json['audio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? examId;
  String? title;
  String? type;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? correctAns;
  String? audio;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['exam_id'] = examId;
    map['title'] = title;
    map['type'] = type;
    map['option_1'] = option1;
    map['option_2'] = option2;
    map['option_3'] = option3;
    map['option_4'] = option4;
    map['correct_ans'] = correctAns;
    map['audio'] = audio;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}