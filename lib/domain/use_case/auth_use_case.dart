import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entity/forget_response_password_entity.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/entity/verify_email_response_entity.dart';
import 'package:online_exam_app/domain/repository/auth_repository.dart';

import '../common/result.dart';

@injectable
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Result<LoginResponseEntity>> callLogin(
      String email, String password) async {
    return await _authRepository.login(email, password);
  }

  Future<Result<ForgetResponsePasswordEntity>> callForgetPassword(
      String email) async {
    return await _authRepository.forgetPassword(email);
  }

  Future<Result<VerifyEmailResponseEntity>> callVerifyEmail(String code) async {
    return await _authRepository.verifyEmail(code);
  }
}
