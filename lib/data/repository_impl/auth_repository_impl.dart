import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/ApiExcuter.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:online_exam_app/data/model/login_response_dto.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/repository/auth_repository.dart';

import '../../core/services/shared_preference_services.dart';
import '../../core/utils/constant_manager.dart';

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
}
