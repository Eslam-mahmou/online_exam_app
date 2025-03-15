import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/use_case/auth_use_case.dart';
import 'package:online_exam_app/presentation/auth/manager/login_cubit/login_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel(this._auth) : super(LoginLoadingState());
  final AuthUseCase _auth;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
   bool isRememberMe = false;

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
        var data = result.data;
        if (data != null && data.token != null) {
          emit(SuccessLoginState(data));
          log("Login Success: ${data.token}");
        } else {
          emit(ErrorLoginState(data?.message ?? "Login failed"));
          log("Login Error: ${data?.message}");
        }
      case Error():
        emit(ErrorLoginState(result.exception!));
        log(result.exception!);
    }
  }
}

sealed class LoginIntent {}

class LoginClickedIntent extends LoginIntent {}
