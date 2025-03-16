import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
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
    final box = Hive.box<CachedAnswerData>(AppConstants.hiveBoxQuestionAnswer);
    CachedAnswerData? cachedData = box.get(AppConstants.hiveBoxAnswerKey);

    // Ensure data is retrieved properly
    if (cachedData == null ||
        cachedData.answers == null ||
        cachedData.answers!.isEmpty) {
      log('_**** No answers found in Hive before API call!');
    } else {
      log('_**** Answers Retrieved for API: ${cachedData.answers!.map((e) => e.toJson()).toList()}');
    }

    List<AnswerModel> answerList = cachedData?.answers ?? [];

    return await _apiManager.postData(
      EndPoints.checkAnswer,
      headers: {
        "token":
            SharedPreferenceServices.getData(AppConstants.token).toString()
      },
      body: {
        "answers": answerList.map((e) => e.toJson()).toList(),
      },
    );
  }
}
