import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/forget_response_password_entity.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/entity/reset_password_response_entity.dart';
import 'package:online_exam_app/domain/repository/auth_repository.dart';

import '../common/result.dart';
import '../entity/sign_up_request.dart';
import '../entity/sign_up_response.dart';
import '../entity/verify_email_response_entity.dart';

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

  Future<Result<ForgetResponsePasswordEntity>> callForgetPassword(
      String email) async {
    return await _authRepository.forgetPassword(email);
  }

  Future<Result<VerifyEmailResponseEntity>> callVerifyEmail(String code) async {
    return await _authRepository.verifyEmail(code);
  }
  Future<Result<ResetPasswordResponseEntity>> callResetPassword(String email ,String newPassword)async{
    return await _authRepository.resetPassword(email, newPassword);
  }
}
