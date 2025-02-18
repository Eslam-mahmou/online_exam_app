import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/use_case/auth_use_case.dart';
import 'package:online_exam_app/presentation/auth/manager/verify_email_cubit/verify_email_state.dart';
@injectable
class VerifyEmailVewModel extends Cubit<VerifyEmailState> {
  VerifyEmailVewModel(this._auth) : super(LoadingVerifyEmailState());
  final AuthUseCase _auth;
  final code1 = TextEditingController();
  final code2 = TextEditingController();
  final code3 = TextEditingController();
  final code4 = TextEditingController();
  final code5 = TextEditingController();
  final code6 = TextEditingController();
  final GlobalKey<FormState> formVerifyKey = GlobalKey<FormState>();
  void doIntent(VerifyEmailIntent verifyEmailIntent) {
    switch(verifyEmailIntent){
      case ContinueClickedIntent():
        if(formVerifyKey.currentState!.validate()){
          _verifyEmail(_collectVerifyCode());
        }

    }
  }

  String _collectVerifyCode() {
    return "${code1.text}${code2.text}${code3.text}${code4.text}${code5.text}${code6.text}";
  }

  void _verifyEmail(String code) async {
    emit(LoadingVerifyEmailState());
    var result = await _auth.callVerifyEmail(code);
    switch (result) {
      case Success():
        var data = result.data;
        if (data!.status == "Success") {
          emit(SuccessVerifyEmailState());
        } else {
          emit(ErrorVerifyEmailState("something went wrong"));
        }
      case Error():
        emit(ErrorVerifyEmailState(result.exception!.errorMessage));
    }
  }
}
sealed class VerifyEmailIntent {}
class ContinueClickedIntent extends VerifyEmailIntent {}