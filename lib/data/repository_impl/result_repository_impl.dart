import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/repository/result_repository.dart';

@Injectable(as: ResultRepository)
class ResultRepositoryImpl implements ResultRepository {
  @override
  Future<List<Questions>> getLocalQuestions() async {
    try {
      var box = Hive.box<Questions>(AppConstants.hiveBoxQuestion);
      return box.values.toList();
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch questions: $e");
    }
  }
}
