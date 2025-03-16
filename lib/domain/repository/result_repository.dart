import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

abstract class ResultRepository {
  Future<List<Questions>> getLocalQuestions();
}