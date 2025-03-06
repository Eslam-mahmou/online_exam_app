class AnswerBody {
  AnswerBody({
      this.answers, 
      this.time,});

  AnswerBody.fromJson(dynamic json) {
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers?.add(Answers.fromJson(v));
      });
    }
    time = json['time'];
  }
  List<Answers>? answers;
  num? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (answers != null) {
      map['answers'] = answers?.map((v) => v.toJson()).toList();
    }
    map['time'] = time;
    return map;
  }

}

class Answers {
  Answers({
      this.questionId, 
      this.correct,});

  Answers.fromJson(dynamic json) {
    questionId = json['questionId'];
    correct = json['correct'];
  }
  String? questionId;
  String? correct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = questionId;
    map['correct'] = correct;
    return map;
  }

}