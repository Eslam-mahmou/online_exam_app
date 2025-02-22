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

  Future<Response> forgetPassword(String email);

  Future<Response> verifyEmail(String code);
  Future<Response> resetPassword(String email,String newPassword);
  Future<Response> signUp(SignUpRequest data);
  // Future<Response> updateProfile(ProfileUserEntity user);

  Future<Response> changePassword(
      String oldPassword, String newPassword, String rePassword);
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
  Future<Response> forgetPassword(String email) async {
    return await _apiManager
        .postData(EndPoints.forgetPassword, body: {"email": email});
  }

  @override
  Future<Response> verifyEmail(String code) async {
    return await _apiManager
        .postData(EndPoints.verifyEmail, body: {"resetCode": code});
  }

  @override
  Future<Response> resetPassword(String email, String newPassword)async {
    return await _apiManager.putData(EndPoints.resetPassword, {
      "email":email,
      "newPassword":newPassword
    },{

    });
  }

  @override
  Future<Response> signUp(SignUpRequest data) async {
    return await _apiManager.postData(
      EndPoints.signUpDomain, // تأكد أن المسار صحيح
      body: data.toJson(),
    );
  }

  // @override
  // Future<Response> updateProfile(ProfileUserEntity user) async {
  //   log("Headers: {'Content-Type': 'application/json', 'Token': '${SharedPreferenceServices.getToken(AppConstants.token.toString())}'}");
  //   return await _apiManager.putData(
  //     EndPoints.editProfile,
  //     {
  //       "username": user.username,
  //       "firstName": user.firstName,
  //       "lastName": user.lastName,
  //       "email": user.email,
  //       "phone": user.phone,
  //     },
  //     {
  //       "token":
  //           SharedPreferenceServices.getToken(AppConstants.token.toString())
  //     },
  //   );
  // }

  @override
  Future<Response> changePassword(
      String oldPassword, String newPassword, String rePassword) async {
    return await _apiManager.patchData(
      EndPoints.changePasswordDomain,
      body: {
        "oldPassword": oldPassword,
        "password": newPassword,
        "rePassword": rePassword,
      },
      headers: {
        "token":
            SharedPreferenceServices.getToken(AppConstants.token.toString()),
        "Content-Type": "application/json",
      },
    );
  }
}