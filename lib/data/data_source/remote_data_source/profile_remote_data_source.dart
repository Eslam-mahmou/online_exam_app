import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/api_manager.dart';
import 'package:online_exam_app/core/services/shared_preference_services.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/utils/end_point.dart';

abstract class ProfileRemoteDataSource {
  Future<Response> getUserInfo();
}

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<Response> getUserInfo() async {
    return await _apiManager.getData(EndPoints.getUser, headers: {
      "token": SharedPreferenceServices.getToken(AppConstants.token).toString()
    });
  }
}
