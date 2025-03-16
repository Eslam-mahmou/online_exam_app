import 'package:online_exam_app/domain/entity/login_response_entity.dart';

sealed class LoginState{}
class LoginLoadingState extends LoginState{}
class SuccessLoginState extends LoginState{
  final LoginResponseEntity? success;
  SuccessLoginState(this.success);

  List<Object?> get props => [success];
}
class ErrorLoginState extends LoginState{
  final String? errMessage;
  ErrorLoginState(this.errMessage);
}