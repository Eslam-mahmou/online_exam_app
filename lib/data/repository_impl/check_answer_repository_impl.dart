import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/check_answer_remote_data_source.dart';
import 'package:online_exam_app/domain/common/result.dart';

import 'package:online_exam_app/domain/entity/check_answer_entity.dart';


import '../../core/api/Api_execute.dart';
import '../../domain/repository/check_answer_repository.dart';
import '../model/check_answer_model.dart';
@Injectable(as: CheckAnswerRepository)
class CheckAnswerRepositoryImpl implements CheckAnswerRepository {
 final CheckAnswerRemoteDataSource _checkAnswerRemoteDataSource;

  CheckAnswerRepositoryImpl(this._checkAnswerRemoteDataSource);
  @override
  Future<Result<CheckAnswerEntity>> checkAnswer() {
    return executeApi<CheckAnswerEntity>(
      () async{
      var response =await _checkAnswerRemoteDataSource.checkAnswer();
      log("response ${response.data}");
      var data = CheckAnswerModel.fromJson(response.data);
      log("Response data $data");
      return data;
      },
    );
  }
}