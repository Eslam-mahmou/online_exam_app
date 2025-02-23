import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/api_manager.dart';
import 'package:online_exam_app/core/services/shared_preference_services.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/utils/end_point.dart';

import '../../../domain/entity/profile_user_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<Response> getUserInfo();

  Future<Response> updateProfile(ProfileUserEntity user);
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

  @override
  Future<Response> updateProfile(ProfileUserEntity user) async {
    log("Headers: {'Content-Type': 'application/json', 'Token': '${SharedPreferenceServices.getToken(AppConstants.token.toString())}'}");
    return await _apiManager.putData(
      EndPoints.editProfile,
      {
        "username": user.user?.username,
        "firstName": user.user?.firstName,
        "lastName": user.user?.lastName,
        "email": user.user?.email,
        "phone": user.user?.phone,
      },
      {
        "token":
            SharedPreferenceServices.getToken(AppConstants.token.toString())
      },
    );
  }
}
