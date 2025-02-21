sealed class ResetPasswordState {}

class LoadingResetPasswordState extends ResetPasswordState {}

class SuccessResetPasswordState extends ResetPasswordState {}

class ErrorResetPasswordState extends ResetPasswordState {
  String errorMessage;

  ErrorResetPasswordState(this.errorMessage);
}
