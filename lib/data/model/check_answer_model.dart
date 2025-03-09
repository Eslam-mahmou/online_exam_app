import '../../domain/entity/check_answer_entity.dart';

class CheckAnswerModel extends CheckAnswerEntity {
  CheckAnswerModel({
      super.message,
      super.correct,
      super.wrong,
      super.total,
      super.wrongQuestions,
      super.correctQuestions,});

  CheckAnswerModel.fromJson(dynamic json) {
    message = json['message'];
    correct = json['correct'];
    wrong = json['wrong'];
    total = json['total'];
    if (json['WrongQuestions'] != null) {
      wrongQuestions = [];
      json['WrongQuestions'].forEach((v) {
        wrongQuestions?.add(WrongQuestionsModel.fromJson(v));
      });
    }
    if (json['correctQuestions'] != null) {
      correctQuestions = [];
      json['correctQuestions'].forEach((v) {
        correctQuestions?.add(CorrectQuestionsModel.fromJson(v));
      });
    }
  }
}

class CorrectQuestionsModel extends CorrectQuestionsEntity{
  CorrectQuestionsModel({
      super.questionId,
      super.question,
      super.correctAnswer,
      super.answers,});

  CorrectQuestionsModel.fromJson(dynamic json) {
    questionId = json['QID'];
    question = json['Question'];
    correctAnswer = json['correctAnswer'];
    answers = json['answers'];
  }


}

class WrongQuestionsModel  extends WrongQuestionsEntity{
  WrongQuestionsModel({
      super.questionId,
      super.question,
      super.inCorrectAnswer,
      super.correctAnswer,
      super.answers,});

  WrongQuestionsModel.fromJson(dynamic json) {
    questionId = json['QID'];
    question = json['Question'];
    inCorrectAnswer = json['inCorrectAnswer'];
    correctAnswer = json['correctAnswer'];
    answers = json['answers'];
  }


}