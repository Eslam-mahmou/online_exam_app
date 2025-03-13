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
@HiveField(1)
  String? type;
  @HiveField(2)
  String? id;
  @HiveField(3)
  String? question;
  @HiveField(4)
  String? correct;
  @HiveField(5)
  Subject? subject;
  @HiveField(6)
  Exam? exam;
  @HiveField(7)
  String? createdAt;
  String? selectedAnswer;

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

class Answers extends Equatable {
  Answers({
    this.answer,
    this.key,
  });

  Answers.fromJson(dynamic json) {
    answer = json['answer'];
    key = json['key'];
  }

  String? answer;
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
