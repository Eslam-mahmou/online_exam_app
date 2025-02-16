import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/ApiExcuter.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:online_exam_app/data/model/login_response_dto.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/repository/auth_repository.dart';

import '../../core/services/shared_preference_services.dart';
import '../../core/utils/constant_manager.dart';
import '../../domain/entity/sign_up_request.dart';
import '../../domain/entity/sign_up_response.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  // final BaseAuthDataSource _authDataSource;
  // AuthRepositoryImp(this._authDataSource);

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
  Future<Result<UserModel>> signUp1(SignUpRequest data) async {
    return executeApi<UserModel>(
      () async {
        var response = await _authRemoteDataSource.signUp(data);
        log(response.toString());

        var userResponse = UserResponse.fromJson(response.data);
        log(userResponse.token.toString());
        SharedPreferenceServices.saveToken(
            AppConstants.token, userResponse.token.toString());

        return userResponse.user; // Return the extracted UserModel
      },
    );
  }

// Future<Result<UserModel>> signUp(SignUpRequest data) async {
//     try {
//       final response = await _authRemoteDataSource.signUp(data);
//       if (response.statusCode == 201) { // Successful signup
//         SharedPreferenceServices.getToken(response.data['token']); // Save token
//         // Convert JSON response to UserResponse
//         final userResponse = UserResponse.fromJson(response.data);
//         final userModel = userResponse.user; // Extract UserModel
//         return Success(userModel);
//         // if (response.statusCode == 200 && response.data["message"] == "success") {
//         //   return Success(UserModel.fromJson(response.data));// Return UserModel instead of `true`
//
//       } else {
//         return Error(response.data["message"],);
//       }
//
//     } on DioException catch (dioException) {
//       return Error(dioException.response!.data["message"],);
//     }
//   }
  ///
  // Future<Result<UserModel>> signUp(SignUpRequest data) async {
  //   try {
  //     print("Signing up...");
  //
  //     final response = await _authRemoteDataSource.signUp(data);
  //
  //     print("Response received: ${response.statusCode}");
  //
  //     if (response.statusCode == 201) {
  //       print("Success: ${response.data}");
  //       SharedPreferenceServices.getToken(response.data['token']);
  //       final userResponse = UserResponse.fromJson(response.data);
  //       return Success(userResponse.user);
  //     } else {
  //       print("SignUp failed: ${response.data}");
  //       return Error(response.data["message"]);
  //     }
  //   } on DioException catch (e) {
  //     print("DioException: ${e.response?.data}");
  //     return Error(e.response?.data?["message"] ?? "Unknown error");
  //   }
  // }
  ///
  // Future<Result<UserModel>> signUp(SignUpRequest data) async {
  //   try {
  //     print("Starting SignUp...");
  //
  //     final response = await _authRemoteDataSource.signUp(data);
  //
  //     print("Response Received: ${response.statusCode}");
  //
  //     if (response.statusCode == 201) {
  //       print("SignUp Success: ${response.data}");
  //       SharedPreferenceServices.getToken(response.data['token']);
  //       final userResponse = UserResponse.fromJson(response.data);
  //       return Success(userResponse.user);
  //     } else {
  //       print("SignUp Failed: ${response.data}");
  //       return Error(response.data["message"]);
  //     }
  //   } on DioException catch (e) {
  //     print("DioException: ${e.response?.data}");
  //     return Error(e.response?.data?["message"] ?? "Unknown error");
  //   }
  // }
  Future<Result<UserModel>> signUp(SignUpRequest data) async {
    try {
      final response = await _authRemoteDataSource.signUp(data);

      if (response.statusCode == 200 && response.data["message"] == "success") {
        SharedPreferenceServices.getToken(response.data['token']); // Save token

        // Convert JSON response to UserResponse
        final userResponse = UserResponse.fromJson(response.data);
        final userModel = userResponse.user; // Extract UserModel
        return Success(userModel);
      } else {
        return Error(
            response.data["message"]); // Return error if not successful
      }
    } on DioException catch (dioException) {
      return Error(dioException.response?.data["message"] ?? "Unknown error");
    }
  }
}
