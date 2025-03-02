import '../common/result.dart';
import '../entity/exam_response_entity.dart';

abstract class ExamRepository{
  Future<Result<ExamResponseEntity>> getExamsOnSubject(String subjectId);
}