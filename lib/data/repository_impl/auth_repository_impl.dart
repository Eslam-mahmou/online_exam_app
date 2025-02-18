import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/ApiExcuter.dart';
import 'package:online_exam_app/data/model/login_response_dto.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/repository/auth_repository.dart';

import '../../core/services/shared_preference_services.dart';
import '../../core/utils/constant_manager.dart';
import '../../domain/entity/profile_user_entity.dart';
import '../../domain/entity/sign_up_request.dart';
import '../../domain/entity/sign_up_response.dart';
import '../data_source/remote_data_source/auth_remote_data_source.dart';
import '../model/profile_user.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Result<LoginResponseEntity>> login(
      String email, String password) async {
    return executeApi<LoginResponseEntity>(
      () async {
        var response = await _authRemoteDataSource.login(email, password);
        log(response.toString());
        var data = LoginResponseDto.fromJson(response.data);
        log(data.token.toString());
        SharedPreferenceServices.saveToken(
           AppConstants.token, data.token.toString());
        return data;
      },
    );
  }

  @override
  Future<Result<UserModel>> signUp(SignUpRequest data) async {
    try {
      final response = await _authRemoteDataSource.signUp(data);

      if (response.statusCode == 200 && response.data["message"] == "success") {
        // SharedPreferenceServices.getToken(response.data['token']);
        final userResponse = UserResponse.fromJson(response.data);
        log(userResponse.token);
        SharedPreferenceServices.saveToken(
            AppConstants.token, userResponse.token);
        log(userResponse.token);
        final userModel = userResponse.user;
        return Success(userModel);
      } else {
        return Error(response.data["message"]);
      }
    } on DioException catch (dioException) {
      return Error(dioException.response?.data["message"] ?? "Unknown error");
    }
  }

  @override
  // Future<Result<ProfileUserEntity>> updateProfile(String lastName) async {
  //
  //   try {
  //     final response = await _authRemoteDataSource.updateProfile(lastName);
  //
  //     if (response.statusCode == 200 && response.data["message"] == "success") {
  //       // SharedPreferenceServices.getToken(response.data['token']);
  //       final userResponse = ProfileUserModel.fromJson(response.data);
  //       SharedPreferenceServices.getToken(response.data['token']);
  //       // SharedPreferenceServices.saveToken(
  //       //     AppConstants.token, userResponse.token.toString());
  //       return Success(userResponse);
  //     } else {
  //       return Error(response.data["message"]);
  //     }
  //   } on DioException catch (dioException) {
  //     return Error(dioException.response?.data["message"] ?? "Unknown error");
  //   }
  //
  //
  // }
  Future<Result<ProfileUserEntity>> updateProfile(String lastName) async {
    try {
      final response = await _authRemoteDataSource.updateProfile(lastName);

      log("Update Profile API Response: ${response.data}"); // 🔍 Log the response

      if (response.statusCode == 200 && response.data["message"] == "success") {
        final userResponse = ProfileUserModel.fromJson(response.data);
        return Success(userResponse);
      } else {
        return Error(response.data["message"]);
      }
    } on DioException catch (dioException) {
      return Error(dioException.response?.data["message"] ?? "Unknown error");
    }
  }
}
