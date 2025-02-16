import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/api_manager.dart';
import 'package:online_exam_app/core/utils/end_point.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login(String email, String password);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiManager _apiManager;

  AuthRemoteDataSourceImpl(this._apiManager);

  @override
  Future<Response> login(String email, String password) async {
    return await _apiManager.postData(EndPoints.login,
        body: {"email": email, "password": password});
  }
}
