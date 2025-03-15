import 'package:online_exam_app/domain/entity/check_answer_entity.dart';

import '../common/result.dart';

abstract class CheckAnswerRepository {
  Future <Result<CheckAnswerEntity>> checkAnswer();
}