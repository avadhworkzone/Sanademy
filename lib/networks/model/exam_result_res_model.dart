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
      this.completedExam, 
      this.questionAnswers,});

  Data.fromJson(dynamic json) {
    completedExam = json['CompletedExam'] != null ? CompletedExam.fromJson(json['CompletedExam']) : null;
    if (json['QuestionAnswers'] != null) {
      questionAnswers = [];
      json['QuestionAnswers'].forEach((v) {
        questionAnswers?.add(QuestionAnswers.fromJson(v));
      });
    }
  }
  CompletedExam? completedExam;
  List<QuestionAnswers>? questionAnswers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (completedExam != null) {
      map['CompletedExam'] = completedExam?.toJson();
    }
    if (questionAnswers != null) {
      map['QuestionAnswers'] = questionAnswers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

QuestionAnswers questionAnswersFromJson(String str) => QuestionAnswers.fromJson(json.decode(str));
String questionAnswersToJson(QuestionAnswers data) => json.encode(data.toJson());
class QuestionAnswers {
  QuestionAnswers({
      this.id, 
      this.userId, 
      this.examId, 
      this.questionId, 
      this.answer, 
      this.correct, 
      this.skip, 
      this.createdAt, 
      this.updatedAt,});

  QuestionAnswers.fromJson(dynamic json) {
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

CompletedExam completedExamFromJson(String str) => CompletedExam.fromJson(json.decode(str));
String completedExamToJson(CompletedExam data) => json.encode(data.toJson());
class CompletedExam {
  CompletedExam({
      this.id, 
      this.userId, 
      this.examId, 
      this.time, 
      this.score, 
      this.totalQuestion, 
      this.percentage, 
      this.createdAt, 
      this.updatedAt,});

  CompletedExam.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    examId = json['exam_id'];
    time = json['time'];
    score = json['score'];
    totalQuestion = json['total_question'];
    percentage = json['percentage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? userId;
  num? examId;
  dynamic time;
  num? score;
  num? totalQuestion;
  String? percentage;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['exam_id'] = examId;
    map['time'] = time;
    map['score'] = score;
    map['total_question'] = totalQuestion;
    map['percentage'] = percentage;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}