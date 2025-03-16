import 'package:online_exam_app/domain/entity/profile_user_entity.dart';

import '../common/result.dart';
import '../entity/change_password_response_entity.dart';

abstract class ProfileRepository {
  Future<Result<ProfileUserEntity>> getUserInfo();

  Future<Result<ProfileUserEntity>> updateProfile(
      ProfileUserEntity updatedProfile);

  Future<Result<ChangePasswordResponseEntity>> changePassword(
      String oldPassword, String newPassword, String rePassword);

}