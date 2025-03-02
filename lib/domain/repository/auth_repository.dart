import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/forget_response_password_entity.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/entity/reset_password_response_entity.dart';
import 'package:online_exam_app/domain/entity/verify_email_response_entity.dart';

import '../entity/sign_up_request.dart';
import '../entity/sign_up_response.dart';

abstract class AuthRepository {
  Future<Result<LoginResponseEntity>> login(String email,String password);
  Future<Result<ForgetResponsePasswordEntity>> forgetPassword(String email);
  Future<Result<VerifyEmailResponseEntity>> verifyEmail(String code);
  Future<Result<ResetPasswordResponseEntity>> resetPassword(String email,String newPassword);
  Future<Result<UserModel>> signUp(SignUpRequest data);

}