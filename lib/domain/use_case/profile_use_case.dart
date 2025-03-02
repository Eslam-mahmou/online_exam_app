import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/profile_user_entity.dart';
import 'package:online_exam_app/domain/repository/profile_repository.dart';

import '../common/result.dart';
import '../entity/change_password_response_entity.dart';

@injectable
class ProfileUseCase {
  ProfileUseCase(this._profileRepository);
 final ProfileRepository _profileRepository;
  Future<Result<ProfileUserEntity>> callUser()async{
    return await _profileRepository.getUserInfo();
  }

  Future<Result<ProfileUserEntity>> executeProfile(
      ProfileUserEntity updatedProfile) async {
    return await _profileRepository.updateProfile(updatedProfile);
  }

  Future<Result<ChangePasswordResponseEntity>> callChangePassword(
      String oldPassword, String newPassword, String rePassword) async {
    return await _profileRepository.changePassword(
        oldPassword, newPassword, rePassword);
  }
}