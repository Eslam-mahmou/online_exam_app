import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/ApiExcuter.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/exam_data_source.dart';
import 'package:online_exam_app/data/model/exam_response_model.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/exam_response_entity.dart';
import 'package:online_exam_app/domain/repository/exam_repository.dart';
@Injectable(as: ExamRepository)
class ExamRepositoryImpl implements ExamRepository {
  final BaseExamDataSource _baseExamDataSource;

  ExamRepositoryImpl(this._baseExamDataSource);

  @override
  Future<Result<ExamResponseEntity>> getExamsOnSubject(String subjectId) async {
    return executeApi(
      () async {
        var response = await _baseExamDataSource.getExamOnSubject(subjectId);
        log(response.toString());
        var data = ExamResponseModel.fromJson(response.data);
        return data;
      },
    );
  }
}
