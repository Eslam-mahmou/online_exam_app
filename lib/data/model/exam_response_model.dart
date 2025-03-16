import 'package:online_exam_app/domain/entity/exam_response_entity.dart';

class ExamResponseModel extends ExamResponseEntity {
  ExamResponseModel({
      super.message,
      super.exams,});

  ExamResponseModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['exams'] != null) {
      exams = [];
      json['exams'].forEach((v) {
        exams?.add(ExamsModel.fromJson(v));
      });
    }
  }

}

class ExamsModel extends ExamsEntity {
  ExamsModel({
      super.id,
      super.title,
      super.duration,
      super.subjectId,
      super.numberOfQuestions,
      super.active,
      });

  ExamsModel.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    duration = json['duration'];
    subjectId = json['subject'];
    numberOfQuestions = json['numberOfQuestions'];
    active = json['active'];
  }


}
