import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/exam_data_source.dart';
import 'package:online_exam_app/data/model/exam_response_model.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/entity/exam_response_entity.dart';
import 'package:online_exam_app/domain/repository/exam_repository.dart';

import '../../core/api/Api_execute.dart';
import '../data_source/local_data_source/get_questions_local_data_source.dart';
import '../model/QuestionsOnExamDTO.dart';

@Injectable(as: ExamRepository)
class ExamRepositoryImpl implements ExamRepository {
  final BaseExamDataSource _baseExamDataSource;
  final GetQuestionsLocalDataSource _getQuestionsLocalDataSource ;

  ExamRepositoryImpl(this._baseExamDataSource,this._getQuestionsLocalDataSource);

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

  @override
  Future<Result<QuestionsOnExamEntity>> getQuestionOnExam(String examId) {
    return executeApi(
      () async {
        var response = await _baseExamDataSource.getQuestionOnExam(examId);
        log(response.toString());
        var data = QuestionsOnExamDTO.fromJson(response.data);
        if(data.questions!.isNotEmpty){
          _getQuestionsLocalDataSource.setQuestions(data.questions!);
        }

        log("data ${data.message}");
        return data;
      },
    );
  }
}
