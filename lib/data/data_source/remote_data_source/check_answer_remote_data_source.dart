import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/utils/end_point.dart';
import 'package:online_exam_app/domain/entity/cache_answer_model.dart';

import '../../../core/api/api_manager.dart';
import '../../../core/services/shared_preference_services.dart';
import '../../../core/utils/constant_manager.dart';

abstract class CheckAnswerRemoteDataSource {
  Future<Response> checkAnswer();
}
@Injectable(as: CheckAnswerRemoteDataSource)
class CheckAnswerRemoteDataSourceImpl implements CheckAnswerRemoteDataSource {
  CheckAnswerRemoteDataSourceImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<Response> checkAnswer() async {
    return await _apiManager.postData(EndPoints.checkAnswer, headers: {
      "token": SharedPreferenceServices.getToken(AppConstants.token).toString()
    }, body: {
      "answers": CachedAnswerData().toJson(),
    });
  }
}
