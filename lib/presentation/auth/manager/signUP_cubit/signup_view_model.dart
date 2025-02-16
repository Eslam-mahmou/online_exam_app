// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:injectable/injectable.dart';
// import 'package:online_exam_app/domain/common/result.dart';
// import 'package:online_exam_app/domain/use_case/auth_use_case.dart';
// import 'package:online_exam_app/domain/use_case/sign_up_use_case.dart';
// import 'package:online_exam_app/presentation/auth/manager/login_cubit/login_state.dart';
// import 'package:online_exam_app/presentation/auth/manager/signUP_cubit/signup_state.dart';
//
// import '../../../../domain/entity/sign_up_request.dart';
//
// @injectable
// class SignUpViewModel extends Cubit<SignUpState> {
//   SignUpViewModel(this._auth) : super(SignUpLoadingState());
//   final SignUpUseCase _auth;
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController rePasswordController = TextEditingController();
//
//  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
//
//   void doIntent(SignupIntent signupIntent) {
//     switch (signupIntent) {
//       case SignUpClickedIntent():
//         _signup();
//     }
//   }
//
//   Future<bool> _signup() async {
//     if (passwordController.text != rePasswordController.text) {
//       EasyLoading.showError("Passwords do not match");
//       return false;
//     }
//     var data = SignUpRequest(
//         username: userNameController.text,
//         firstName: firstNameController.text,
//         lastName: lastNameController.text,
//         phone: phoneController.text,
//         email: emailController.text,
//         password: passwordController.text,
//         rePassword: rePasswordController.text
//     );
//
//     EasyLoading.show();
//
//     emit(SignUpLoadingState()); // Start with loading state
//     var result = await _auth.execute(data);
//     switch (result) {
//       case Success():
//         var data = result.data;
//         if (data != null && data. != null) {
//           emit(SuccessSignUpState(data)); // Login successful
//           log("Login Success: ${data.token}");
//         } else {
//           emit(ErrorSignUpState(data?.message ?? "Login failed"));
//           log("Login Error: ${data?.message}");
//         }
//
//       case Error():
//         emit(ErrorSignUpState(result.exception!.errorMessage));
//         log("Login API Error: ${result.exception!.errorMessage}");
//     }
//   }
// }
//
// sealed class SignupIntent {}
// class SignUpClickedIntent extends SignupIntent {}
//
// class AuthCubit extends Cubit<AuthStates> {
//   AuthCubit(): super(InitialAuthState());
//   static AuthCubit get(context) => BlocProvider.of(context);
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController rePasswordController = TextEditingController();
//
//
//   Future<bool> doIntent(HomeIntent homeIntent){
//     switch(homeIntent){
//       case SignUpIntent():{
//         return _signUp();
//       }
//     }
//   }
//
//   Future<bool> _signUp() async {
//     if (passwordController.text != rePasswordController.text) {
//       EasyLoading.showError("Passwords do not match");
//       return false;
//     }
//     var data = SignUpRequest(
//         username: userNameController.text,
//         firstName: firstNameController.text,
//         lastName: lastNameController.text,
//         phone: phoneController.text,
//         email: emailController.text,
//         password: passwordController.text,
//         rePassword: rePasswordController.text
//     );
//
//     EasyLoading.show();
//     final result = await sl<SignUpUseCase>().execute(data);
//
//     return result.fold(
//           (fail) {
//         EasyLoading.dismiss();
//         print("Sign-up failed: ${fail.runtimeType} - ${fail.toString()}");
//         emit(ErrorSignUPState());
//         return false;
//       },
//           (userModel) {
//         EasyLoading.dismiss();
//         print("Sign-up success: ${userModel.username}");
//         emit(SuccessSignUPState(userModel));
//         return true;
//       },
//     );
//   }
// }
//
//
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/presentation/auth/manager/signUP_cubit/signup_state.dart';

import '../../../../domain/common/result.dart';
import '../../../../domain/entity/sign_up_request.dart';
import '../../../../domain/use_case/sign_up_use_case.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  SignUpViewModel(this._signUpUseCase) : super(SignUpLoadingState());

  final SignUpUseCase _signUpUseCase;

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  final GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();

  void doIntent(AuthIntent intent) {
    switch (intent) {
      case SignUpClickedIntent():
        _handleSignUp();
    }
  }

  // Future<void> _handleSignUp() async {
  //   if (!formSignUpKey.currentState!.validate()) {
  //     return;
  //   }
  //
  //   if (passwordController.text != rePasswordController.text) {
  //     EasyLoading.showError("Passwords do not match");
  //     return;
  //   }
  //
  //   var data = SignUpRequest(
  //     username: userNameController.text,
  //     firstName: firstNameController.text,
  //     lastName: lastNameController.text,
  //     phone: phoneController.text,
  //     email: emailController.text,
  //     password: passwordController.text,
  //     rePassword: rePasswordController.text,
  //   );
  //
  //   emit(SignUpLoadingState()); // Start with loading state
  //   EasyLoading.show();
  //
  //   var result = await _signUpUseCase.execute(data);
  //
  //   switch (result) {
  //     case Success():
  //       var user = result.data;
  //       if (user != null) {
  //         emit(SuccessSignUpState(user));
  //         log("Sign-up success: ${user.username}");
  //       } else {
  //         emit(ErrorSignUpState("Sign-up failed"));
  //         log("Sign-up Error: Sign-up failed");
  //       }
  //       EasyLoading.dismiss();
  //
  //     case Error():
  //       emit(ErrorSignUpState(result.exception.toString()));
  //       log("Sign-up API Error: ${result.exception}");
  //       EasyLoading.dismiss();
  //   }
  // }
  Future<void> _handleSignUp() async {
    if (!formSignUpKey.currentState!.validate()) return;
    if (passwordController.text != rePasswordController.text) {
      EasyLoading.showError("Passwords do not match");
      return;
    }

    EasyLoading.show();
    emit(SignUpLoadingState());
    var data = SignUpRequest(
      username: userNameController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phone: phoneController.text,
      email: emailController.text,
      password: passwordController.text,
      rePassword: rePasswordController.text,
    );

    var result = await _signUpUseCase.execute(data);

    EasyLoading.dismiss(); // Dismiss loader before handling the result

    switch (result) {
      case Success():
        if (result.data != null) {
          emit(SuccessSignUpState(result.data!));
          log("Sign-up success: ${result.data!.username}");
        } else {
          emit(ErrorSignUpState("Sign-up failed"));
        }
        break;

      case Error():
        emit(ErrorSignUpState(result.exception.toString()));
        log("Sign-up API Error: ${result.exception}");
        break;
    }
  }
}

class SuccessSignUPState {}

sealed class AuthIntent {}

class SignUpClickedIntent extends AuthIntent {}
