import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/api_manager.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/utils/end_point.dart';
import 'package:online_exam_app/domain/entity/profile_user_entity.dart';

import '../../../core/services/shared_preference_services.dart';
import '../../../domain/entity/sign_up_request.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login(String email, String password);

  Future<Response> signUp(SignUpRequest data);

  Future<Response> updateProfile(ProfileUserEntity user);
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

  @override
  Future<Response> signUp(SignUpRequest data) async {
    return await _apiManager.postData(
      EndPoints.signUpDomain,
      body: data.toJson(),
    );
  }

  @override
  // Future<Response> updateProfile(String lastName) async {
  //
  //   log("Headers: {'Content-Type': 'application/json', 'Token': '${SharedPreferenceServices.getToken(AppConstants.token.toString())}'}"); // Add this line to log the token value
  //
  //   return await _apiManager.putData(
  //       EndPoints.editProfile,
  //       {
  //         "lastName": lastName
  //       },
  //       {
  //         "token": SharedPreferenceServices.getToken(AppConstants.token.toString())
  //       }
  //       );
  //
  // }
  Future<Response> updateProfile(ProfileUserEntity user) async {
    log("Headers: {'Content-Type': 'application/json', 'Token': '${SharedPreferenceServices.getToken(AppConstants.token.toString())}'}");

    return await _apiManager.putData(
      EndPoints.editProfile,
      {
        "username": user.username,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "phone": user.phone,
      },
      {
        "token":
            SharedPreferenceServices.getToken(AppConstants.token.toString())
      },
    );
  }
}
