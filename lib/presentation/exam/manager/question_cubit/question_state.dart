import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/entity/cache_answer_model.dart';

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
class NextQuestionState extends QuestionState {
  int currentIndex ;
  NextQuestionState(this.currentIndex);
}

class PreviousQuestionState extends QuestionState {
  int currentIndex ;
  PreviousQuestionState(this.currentIndex);
}

class LastQuestionState extends QuestionState {
  final int currentIndex;

  LastQuestionState(this.currentIndex);
}

class QuestionTimerUpdated extends QuestionState {
  final int remainingSeconds;
  QuestionTimerUpdated(this.remainingSeconds);

}

class QuestionAnsweredState extends QuestionState {
  AnswerModel answerModel;
  QuestionAnsweredState(this.answerModel);
}
class RemoveQuestionAnswered extends QuestionState {}

class QuestionTimeUp extends QuestionState {}