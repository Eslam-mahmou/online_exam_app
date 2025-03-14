import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'QuestionsOnExamEntity.g.dart';
class QuestionsOnExamEntity {
  QuestionsOnExamEntity({
    this.message,
    this.questions,
  });

  String? message;
  List<Questions>? questions;

}
@HiveType(typeId: 2)
class Questions extends HiveObject with EquatableMixin {
  Questions({
    this.answers,
    this.type,
    this.id,
    this.question,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
    this.selectedAnswer
  });
@HiveField(0)
  List<Answers>? answers;
  String? type;
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? question;
  @HiveField(3)
  String? correct;
  Subject? subject;
  Exam? exam;
  String? createdAt;
  String? selectedAnswer;

  Questions copyWith({
    List<Answers>? answers,
    String? type,
    String? id,
    String? question,
    String? correct,
    Subject? subject,
    Exam? exam,
    String? createdAt,
    String? selectedAnswer,
  }) {
    return Questions(
      answers: answers ?? this.answers,
      type: type ?? this.type,
      id: id ?? this.id,
      question: question ?? this.question,
      correct: correct ?? this.correct,
      subject: subject ?? this.subject,
      exam: exam ?? this.exam,
      createdAt: createdAt ?? this.createdAt,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, question];
}


class Exam extends Equatable {
  Exam({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  String? id;
  String? title;
  num? duration;
  String? subject;
  num? numberOfQuestions;
  bool? active;
  String? createdAt;


  @override
  // TODO: implement props
  List<Object?> get props => [id, title];
}

class Subject extends Equatable {
  Subject({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
  });

  Subject.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    icon = json['icon'];
    createdAt = json['createdAt'];
  }

  String? id;
  String? name;
  String? icon;
  String? createdAt;


  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
@HiveType(typeId: 3)
class Answers extends Equatable {
  Answers({
    this.answer,
    this.key,
  });

  Answers.fromJson(dynamic json) {
    answer = json['answer'];
    key = json['key'];
  }
@HiveField(0)
  String? answer;
  @HiveField(1)
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer'] = answer;
    map['key'] = key;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        answer,
      ];
}
