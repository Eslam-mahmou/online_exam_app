import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/ApiExcuter.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:online_exam_app/data/model/profile_user.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/profile_user_entity.dart';
import 'package:online_exam_app/domain/repository/profile_repository.dart';
@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository{
  ProfileRepositoryImpl(this._profile);
 final ProfileRemoteDataSource _profile;
  @override
  Future<Result<ProfileUserEntity>> getUserInfo() {
    return executeApi<ProfileUserEntity>(
      ()async {
        var response=await _profile.getUserInfo();
        var data=ProfileUserModel.fromJson(response.data);
        return data;
      },
    );
  }

  @override
  Future<Result<ProfileUserEntity>> updateProfile(
      ProfileUserEntity user) async {
    try {
      final response = await _profile.updateProfile(user);
      log("Update Profile API Response: ${response.data}");

      if (response.statusCode == 200 && response.data["message"] == "success") {
        final userResponse = ProfileUserModel.fromJson(response.data);
        // return Success(userResponse as ProfileUserEntity?);
        return Success(userResponse);
      } else {
        return Error(response.data["message"]);
      }
    } on DioException catch (dioException) {
      return Error(dioException.response?.data["message"] ?? "Unknown error");
    }
  }
}