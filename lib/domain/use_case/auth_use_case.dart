import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/entity/profile_user_entity.dart';
import 'package:online_exam_app/domain/repository/auth_repository.dart';

import '../common/result.dart';
import '../entity/sign_up_request.dart';
import '../entity/sign_up_response.dart';

@injectable
class AuthUseCase {
 final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Result<LoginResponseEntity>> callLogin(
      String email, String password) async {
    return await _authRepository.login(email, password);
  }

  Future<Result<UserModel>> execute(SignUpRequest data) async {
    return await _authRepository.signUp(data);
  }

  Future<Result<ProfileUserEntity>> executeProfile(
      ProfileUserEntity updatedProfile) async {
    return await _authRepository.updateProfile(updatedProfile);
  }
}
