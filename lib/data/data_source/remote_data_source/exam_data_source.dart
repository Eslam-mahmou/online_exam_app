import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/api_manager.dart';
import 'package:online_exam_app/core/services/shared_preference_services.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/utils/end_point.dart';

abstract class BaseExamDataSource {
  Future<Response> getExamOnSubject(String subjectId);

  Future<Response> getQuestionOnExam(String examId);
}
@Injectable(as: BaseExamDataSource)
class BaseExamDataSourceImpl implements BaseExamDataSource {
 final ApiManager _apiManager;
  BaseExamDataSourceImpl(this._apiManager);

  @override
  Future<Response> getExamOnSubject(String subjectId)async {
    return await _apiManager.getData(EndPoints.getExam,queryParameters: {
      "subject":subjectId
    },
    headers: {
      "token":SharedPreferenceServices.getData(AppConstants.token).toString()
    });
  }

  @override
  Future<Response> getQuestionOnExam(String examId) async {
    return await _apiManager
        .getData(EndPoints.getQuestionOnExam, queryParameters: {
      "exam": examId
    }, headers: {
      "token": SharedPreferenceServices.getData(AppConstants.token).toString()
    });
  }
}