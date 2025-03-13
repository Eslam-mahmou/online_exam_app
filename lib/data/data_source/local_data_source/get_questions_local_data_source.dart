import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

import '../../../core/utils/constant_manager.dart';

abstract class GetQuestionsLocalDataSource {
  Future<List<Questions>> getQuestions();

  void setQuestions(List<Questions> questions);
}
@Injectable(as: GetQuestionsLocalDataSource)
class GetQuestionsLocalDataSourceImpl implements GetQuestionsLocalDataSource {
  @override
  Future<List<Questions>> getQuestions() {
    var box = Hive.box<Questions>(AppConstants.hiveBoxQuestion);
    return Future.value(box.values.toList());
  }

  @override
  void setQuestions(List<Questions> questions) {
    var box = Hive.box<Questions>(AppConstants.hiveBoxQuestion);
    box.clear();
    for (var i = 0; i < questions.length; i++) {
      box.put(AppConstants.hiveBoxQuestionKey, questions[i]);
    }
    box.close();
  }
}
