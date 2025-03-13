import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/repository/result_repository.dart';
@injectable
class ResultUseCase {
  final ResultRepository _resultRepository;

  ResultUseCase(this._resultRepository);

  Future<List<Questions>> getResult() async {
    return await _resultRepository.getLocalQuestions();
  }
}
