import 'package:online_exam_app/domain/entity/exam_response_entity.dart';

sealed class ExamState {}
class LoadingExamState extends ExamState {}
class SuccessExamState extends ExamState {
  final List<ExamsEntity> exams;
  SuccessExamState(this.exams);
}
class ErrorExamState extends ExamState {
  final String? errMessage;
  ErrorExamState(this.errMessage);
}
