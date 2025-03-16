// import 'package:hive/hive.dart';
// import 'package:injectable/injectable.dart';
// import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
//
// import '../../../core/utils/constant_manager.dart';
//
// abstract class GetQuestionsLocalDataSource {
//
//
//   void setQuestions(List<Questions> questions);
// }
// @Injectable(as: GetQuestionsLocalDataSource)
// class GetQuestionsLocalDataSourceImpl implements GetQuestionsLocalDataSource {
//   @override
//   void setQuestions(List<Questions> questions) async{
//     var box = Hive.box<Questions>(AppConstants.hiveBoxQuestion);
//     box.clear();
//     for (var i = 0; i < questions.length; i++) {
//      await box.put(questions[i].id, questions[i]);
//     }
//   }
// }
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

import '../../../core/utils/constant_manager.dart';

abstract class GetQuestionsLocalDataSource {
  void setQuestions(List<Questions> questions);
}

@Injectable(as: GetQuestionsLocalDataSource)
class GetQuestionsLocalDataSourceImpl implements GetQuestionsLocalDataSource {
  @override
  void setQuestions(List<Questions> questions) async {
    var box = Hive.box<Questions>(AppConstants.hiveBoxQuestion);
    await box.clear();
    for (var question in questions) {
      await box.put(question.id, question);
    }
  }
}

