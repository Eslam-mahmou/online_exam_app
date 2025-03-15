class CheckAnswerEntity {
  CheckAnswerEntity({
      this.message, 
      this.correct, 
      this.wrong, 
      this.total, 
      this.wrongQuestions, 
      this.correctQuestions,});
  String? message;
  num? correct;
  num? wrong;
  String? total;
  List<WrongQuestionsEntity>? wrongQuestions;
  List<CorrectQuestionsEntity>? correctQuestions;
}

class CorrectQuestionsEntity {
  CorrectQuestionsEntity({
      this.questionId,
      this.question, 
      this.correctAnswer, 
      this.answers,});
  String? questionId;
  String? question;
  String? correctAnswer;
  dynamic answers;
}

class WrongQuestionsEntity {
  WrongQuestionsEntity({
      this.questionId,
      this.question, 
      this.inCorrectAnswer, 
      this.correctAnswer, 
      this.answers,});
  String? questionId;
  String? question;
  String? inCorrectAnswer;
  String? correctAnswer;
  dynamic answers;
}