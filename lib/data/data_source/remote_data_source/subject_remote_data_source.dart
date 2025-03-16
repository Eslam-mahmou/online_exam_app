import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_manager.dart';
import '../../../core/services/shared_preference_services.dart';
import '../../../core/utils/constant_manager.dart';
import '../../../core/utils/end_point.dart';

abstract class SubjectRemoteDataSource {
  Future<Response> getAllSubject();
}

@Injectable(as: SubjectRemoteDataSource)
class SubjectRemoteDataSourceImpl implements SubjectRemoteDataSource {
  SubjectRemoteDataSourceImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<Response> getAllSubject() async {
    return await _apiManager.getData(EndPoints.getAllSubject, headers: {
      "token": SharedPreferenceServices.getData(AppConstants.token).toString()
    });
  }
}
