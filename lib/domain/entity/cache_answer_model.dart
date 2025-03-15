import 'package:hive/hive.dart';

part 'cache_answer_model.g.dart';


@HiveType(typeId: 0)
class AnswerModel extends HiveObject {
  @HiveField(0)
  String? questionId;

  @HiveField(1)
  String? correct;

  AnswerModel({ this.questionId,  this.correct});

  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "correct": correct,
    };
  }
}
@HiveType(typeId: 1)
class CachedAnswerData extends HiveObject {
  @HiveField(0)
  List<AnswerModel>? answers;
  CachedAnswerData({ this.answers});
  Map<String, dynamic> toJson() {
    return {
      "answers": answers?.map((answer) => answer.toJson()).toList() ?? [],
    };
  }
}