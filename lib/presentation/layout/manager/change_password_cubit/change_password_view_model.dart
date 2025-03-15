import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/use_case/profile_use_case.dart';

import 'change_password_state.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final ProfileUseCase _profileUseCase;

  ChangePasswordViewModel(this._profileUseCase)
      : super(InitialChangePasswordState());

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  final GlobalKey<FormState> formResetPasswordKey = GlobalKey<FormState>();

  void doIntent(ResetPasswordIntent resetPasswordIntent) {
    switch (resetPasswordIntent) {
      case ResetClickedIntent():
        if (formResetPasswordKey.currentState!.validate()) {
          if (newPassword.text != rePassword.text) {
            emit(ErrorChangePasswordState("New Password DOES NOT MATCH"));
            return;
          }
          _changePassword();
        }
    }
  }
  void _changePassword() async {
    emit(LoadingChangePasswordState());

    String oldPass = oldPassword.text.trim();
    String newPass = newPassword.text.trim();
    String rePass = rePassword.text.trim();

    if (rePass != newPass) {
      rePass = newPass;
    }

    try {
      var result =
          await _profileUseCase.callChangePassword(oldPass, newPass, rePass);

      switch (result) {
        case Success():
          var data = result.data;
          if (data!.message == "success") {
            emit(SuccessChangePasswordState());
          } else {
            emit(ErrorChangePasswordState(data.message.toString()));
          }
          break;
        case Error():
          emit(ErrorChangePasswordState(result.toString()));
          break;
      }
    } catch (e) {
      emit(ErrorChangePasswordState("Error: ${e.toString()}"));
    }
  }
}

sealed class ResetPasswordIntent {}

class ResetClickedIntent extends ResetPasswordIntent {}
