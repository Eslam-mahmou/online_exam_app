
import 'package:hive/hive.dart';
part 'solve_questions_model.g.dart';
@HiveType(typeId: 0)
class SolveQuestionsModel extends HiveObject {
  @HiveField(0)
String? questionId;
  @HiveField(1)
  String? selectAnswer;
  SolveQuestionsModel(this.questionId, this.selectAnswer);
}