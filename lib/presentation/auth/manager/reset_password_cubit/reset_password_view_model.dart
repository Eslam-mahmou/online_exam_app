import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/services/shared_preference_services.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/use_case/auth_use_case.dart';
import 'package:online_exam_app/presentation/auth/manager/reset_password_cubit/reset_password_state.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordState> {
  ResetPasswordViewModel(this._authUseCase) :super(LoadingResetPasswordState());
  final AuthUseCase _authUseCase;
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final GlobalKey<FormState> formResetPasswordKey = GlobalKey<FormState>();

  void doIntent(ResetPasswordIntent resetPasswordIntent) {
    switch (resetPasswordIntent) {
      case ResetPasswordIntent():
        if (formResetPasswordKey.currentState!.validate()) {
          _resetPassword(
              SharedPreferenceServices.getData(AppConstants.email.toString())
                  .toString(), newPassword.text);
        }
    }
  }
 String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password ';
    }
    if (value != newPassword.text) {
      return 'Password do not match ';
    }
    return null;
  }
  void _resetPassword(String email, String newPassword) async {
    emit(LoadingResetPasswordState());
    var result = await _authUseCase.callResetPassword(email, newPassword);
    switch (result) {
      case Success():
        var data = result.data;
        if (data!.message == "success" && data.token != null) {
          emit(SuccessResetPasswordState());
        }
        else {
          emit(ErrorResetPasswordState(data.message.toString()));
        }
      case Error():
        emit(ErrorResetPasswordState(result.exception!));
    }
  }

}

sealed class ResetPasswordIntent {}

class ResetClickedIntent extends ResetPasswordIntent {}