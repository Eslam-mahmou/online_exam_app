import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/repository/check_answer_repository.dart';

import '../common/result.dart';
import '../entity/check_answer_entity.dart';
import '../entity/solve_questions_model.dart';
@injectable
class CheckAnswerUseCase {
final  CheckAnswerRepository _checkAnswerRepository;

  CheckAnswerUseCase(this._checkAnswerRepository);

  Future<Result<CheckAnswerEntity>> call(
      List<SolveQuestionsModel> questions) async {
    return await _checkAnswerRepository.checkAnswer(questions);
  }
}
