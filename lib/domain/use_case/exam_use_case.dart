import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/repository/exam_repository.dart';

import '../common/result.dart';
import '../entity/exam_response_entity.dart';
@injectable
class ExamUseCase {
  ExamRepository examRepository;

  ExamUseCase(this.examRepository);

  Future<Result<ExamResponseEntity>> invoke(
      String subjectId)async{
    return await examRepository.getExamsOnSubject(subjectId);
  }
}