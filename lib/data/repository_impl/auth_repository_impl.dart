import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:online_exam_app/data/model/forget_response_password_dto.dart';
import 'package:online_exam_app/data/model/login_response_dto.dart';
import 'package:online_exam_app/data/model/reset_password_response_dto.dart';
import 'package:online_exam_app/data/model/verify_email_response_dto.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/forget_response_password_entity.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/entity/reset_password_response_entity.dart';
import 'package:online_exam_app/domain/entity/verify_email_response_entity.dart';
import 'package:online_exam_app/domain/repository/auth_repository.dart';

import '../../core/api/Api_execute.dart';
import '../../core/services/shared_preference_services.dart';
import '../../core/utils/constant_manager.dart';
import '../../domain/entity/sign_up_request.dart';
import '../../domain/entity/sign_up_response.dart';

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
        SharedPreferenceServices.saveData(
           AppConstants.token, data.token.toString());

        return data;
      },
    );
  }

  @override
  Future<Result<ForgetResponsePasswordEntity>> forgetPassword(
      String email) async {
    return executeApi<ForgetResponsePasswordEntity>(
      () async {
        var response = await _authRemoteDataSource.forgetPassword(email);
        var data = ForgetResponsePasswordDto.fromJson(response.data);
        return data;
      },
    );
  }

  @override
  Future<Result<VerifyEmailResponseEntity>> verifyEmail(String code) {
    return executeApi<VerifyEmailResponseEntity>(
      () async {
        var response = await _authRemoteDataSource.verifyEmail(code);
        var data = VerifyEmailResponseDto.fromJson(response.data);
        return data;
      },
    );
  }

  @override
  Future<Result<ResetPasswordResponseEntity>> resetPassword(
      String email, String newPassword) {
    return executeApi<ResetPasswordResponseEntity>(
      () async {
        var response =
            await _authRemoteDataSource.resetPassword(email, newPassword);
        var data = ResetPasswordResponseDto.formJson(response.data);
        SharedPreferenceServices.saveData(AppConstants.token, data.token.toString());
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
        SharedPreferenceServices.saveData(
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

}