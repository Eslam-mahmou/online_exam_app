import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

sealed class QuestionState {}

class LoadingQuestionState extends QuestionState {}

class SuccessQuestionState extends QuestionState {
  final List<Questions> question;

  SuccessQuestionState(this.question);
}

class ErrorQuestionState extends QuestionState {
  final String? errMessage;

  ErrorQuestionState(this.errMessage);
}
