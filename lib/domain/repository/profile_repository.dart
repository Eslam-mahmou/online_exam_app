import 'package:online_exam_app/domain/entity/profile_user_entity.dart';

import '../common/result.dart';

abstract class ProfileRepository {
  Future<Result<ProfileUserEntity>> getUserInfo();

  Future<Result<ProfileUserEntity>> updateProfile(
      ProfileUserEntity updatedProfile);
}