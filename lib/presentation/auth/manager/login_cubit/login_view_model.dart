import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/use_case/auth_use_case.dart';
import 'package:online_exam_app/presentation/auth/manager/login_cubit/login_state.dart';
@injectable
class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel(this._auth) : super(LoginLoadingState());
  final AuthUseCase _auth;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  void doIntent(LoginIntent loginIntent) {
    switch (loginIntent) {
      case LoginClickedIntent():
        _login(emailController.text, passwordController.text);
    }
  }

  Future<void> _login(String email, String password) async {
    emit(LoginLoadingState());
    var result = await _auth.callLogin(email, password);
    switch (result) {
      case Success():
        emit(SuccessLoginState(result.data));
         log(result.data.toString());
      case Error():
        emit(ErrorLoginState(result.exception!.errorMessage.toString()));
    }
  }
}

sealed class LoginIntent {}

class LoginClickedIntent extends LoginIntent {
}
