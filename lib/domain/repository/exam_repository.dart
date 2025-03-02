import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

import '../common/result.dart';
import '../entity/exam_response_entity.dart';

abstract class ExamRepository{
  Future<Result<ExamResponseEntity>> getExamsOnSubject(String subjectId);

  Future<Result<QuestionsOnExamEntity>> getQuestionOnExam(String examId);
}