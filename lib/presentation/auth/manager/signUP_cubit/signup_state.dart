import '../../../../domain/entity/sign_up_response.dart';

sealed class SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SuccessSignUpState extends SignUpState {
  final UserModel? success;
  SuccessSignUpState(this.success);
}

class ErrorSignUpState extends SignUpState {
  final String? errMessage;

  ErrorSignUpState(this.errMessage);
}
