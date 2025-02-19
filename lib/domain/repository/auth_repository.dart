import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/entity/profile_user_entity.dart';

import '../entity/change_password_response_entity.dart';
import '../entity/sign_up_request.dart';
import '../entity/sign_up_response.dart';

abstract class AuthRepository {
  Future<Result<LoginResponseEntity>> login(String email,String password);

  Future<Result<UserModel>> signUp(SignUpRequest data);

  Future<Result<ProfileUserEntity>> updateProfile(
      ProfileUserEntity updatedProfile);

  Future<Result<ChangePasswordResponseEntity>> changePassword(
      String oldPassword, String newPassword, String rePassword);
}
