import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/api_manager.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/utils/end_point.dart';

import '../../../core/services/shared_preference_services.dart';
import '../../../domain/entity/sign_up_request.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login(String email, String password);

  Future<Response> forgetPassword(String email);

  Future<Response> verifyEmail(String code);
  Future<Response> resetPassword(String email,String newPassword);
  Future<Response> signUp(SignUpRequest data);

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
      EndPoints.signUpDomain,
      body: data.toJson(),
    );
  }

  @override
  Future<Response> changePassword(
      String oldPassword, String newPassword, String rePassword) async {
    log("Headers: {'Content-Type': 'application/json', 'Token': '${SharedPreferenceServices.getToken(AppConstants.token.toString())}'}");

    String? token =
        SharedPreferenceServices.getToken(AppConstants.token.toString())
            .toString();

    // Check if the token is null or empty
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing or invalid");
    }

    // Proceed with the API request if token is valid
    return await _apiManager.patchData(
      EndPoints.changePasswordDomain,
      body: {
        "oldPassword": oldPassword,
        "password": newPassword,
        "rePassword": rePassword,
      },
      headers: {
        "token": token,
        "Content-Type": "application/json",
      },
    );
  }

  // @override
// Future<Response> changePassword(
//     String oldPassword, String newPassword, String rePassword) async {
//   return await _apiManager.patchData(
//     EndPoints.changePasswordDomain,
//     body: {
//       "oldPassword": oldPassword,
//       "password": newPassword,
//       "rePassword": rePassword,
  //     },
//     headers: {
  //       "token":
//           SharedPreferenceServices.getToken(AppConstants.token.toString()),
//       "Content-Type": "application/json",
  //     },
  //   );
  // }
}