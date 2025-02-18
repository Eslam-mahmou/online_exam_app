import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/api_manager.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/utils/end_point.dart';

import '../../../core/services/shared_preference_services.dart';
import '../../../domain/entity/sign_up_request.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login(String email,String password);

  Future<Response> signUp(SignUpRequest data);

  Future<Response> updateProfile(String lastName);
}

@ Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
 final ApiManager _apiManager;
  AuthRemoteDataSourceImpl(this._apiManager);

  @override
  Future<Response> login(String email, String password)async {
     return await _apiManager.postData(EndPoints.login,
     body: {
       "email":email,
       "password":password
     });
  }

  @override
  Future<Response> signUp(SignUpRequest data) async {
    return await _apiManager.postData(
      EndPoints.signUpDomain,
      body: data.toJson(),
    );
  }

  @override
  Future<Response> updateProfile(String lastName) async {
    var token = SharedPreferenceServices.getToken(AppConstants.token);
    log("Token: $token");
    log("Headers: {'Content-Type': 'application/json', 'Authorization': '$token'}"); // Add this line to log the token value
    if (token == null) {
      log("Token is null or empty");
    }
    return await _apiManager.putData(
      EndPoints.editProfile,
      {"lastName": lastName}, // Body parameter
      {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      }, // Headers parameter
    );
  }
// return await _apiManager.putData(

// EndPoints.editProfile,
// options: Options(
//   headers: headers,
//   validateStatus: (status) => true,
// )
//
// headers:  {'Content-Type': 'application/json'},
// body:  {"lastName": lastName},
//      if (response.statusCode == 200) {
//    final jsonData = jsonDecode(response.body);
//    return UserModel.fromJson(jsonData["user"]);
//  } else {
// throw Exception('Failed to update profile');
// }

// );
}
