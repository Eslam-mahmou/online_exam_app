import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/ApiExcuter.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/check_answer_remote_data_source.dart';
import 'package:online_exam_app/domain/common/result.dart';

import 'package:online_exam_app/domain/entity/check_answer_entity.dart';

import 'package:online_exam_app/domain/entity/solve_questions_model.dart';

import '../../domain/repository/check_answer_repository.dart';
import '../model/check_answer_model.dart';
@Injectable(as: CheckAnswerRepository)
class CheckAnswerRepositoryImpl implements CheckAnswerRepository {
 final CheckAnswerRemoteDataSource _checkAnswerRemoteDataSource;

  CheckAnswerRepositoryImpl(this._checkAnswerRemoteDataSource);
  @override
  Future<Result<CheckAnswerEntity>> checkAnswer(List<SolveQuestionsModel> questions) {
    return executeApi<CheckAnswerEntity>(
      () async{
      var response =await _checkAnswerRemoteDataSource.checkAnswer(questions);
      log("response ${response.data}");
      var data = CheckAnswerModel.fromJson(response.data);
      log("Response data $data");
      return data;
      },
    );
  }
}