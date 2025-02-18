sealed class VerifyEmailState{

}
class LoadingVerifyEmailState extends VerifyEmailState{}
class SuccessVerifyEmailState extends VerifyEmailState{}
class ErrorVerifyEmailState extends VerifyEmailState{
  final String?errMessage;
  ErrorVerifyEmailState(this.errMessage);
}