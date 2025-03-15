import 'package:equatable/equatable.dart';

class ExamResponseEntity {
  ExamResponseEntity({
      this.message,
      this.exams,});

  String? message;
  List<ExamsEntity>? exams;
}

class ExamsEntity extends Equatable{
  ExamsEntity({
      this.id, 
      this.title, 
      this.duration, 
      this.subjectId,
      this.numberOfQuestions, 
      this.active,});
  String? id;
  String? title;
  num? duration;
  String? subjectId;
  num? numberOfQuestions;
  bool? active;

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title
  ];
}