sealed class ChangePasswordState {}

class InitialChangePasswordState extends ChangePasswordState {}

class LoadingChangePasswordState extends ChangePasswordState {}

class SuccessChangePasswordState extends ChangePasswordState {}

class ErrorChangePasswordState extends ChangePasswordState {
  String errorMessage;

  ErrorChangePasswordState(this.errorMessage);
}
