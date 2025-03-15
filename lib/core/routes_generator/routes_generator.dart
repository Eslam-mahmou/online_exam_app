import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/auth/pages/forget_password/email_verification.dart';
import 'package:online_exam_app/presentation/auth/pages/forget_password/forget_password.dart';
import 'package:online_exam_app/presentation/auth/pages/forget_password/reset_pass_login.dart';
import 'package:online_exam_app/presentation/auth/pages/login_screen.dart';
import 'package:online_exam_app/presentation/auth/pages/sign_up_screen.dart';
import 'package:online_exam_app/presentation/exam/exam_screen.dart';
import 'package:online_exam_app/presentation/exam/score_screen.dart';
import 'package:online_exam_app/presentation/layout/layout.dart';
import 'package:online_exam_app/presentation/layout/manager/profile_tab_cubit/profile_tab_view_model.dart';
import 'package:online_exam_app/presentation/splash/splash_screen.dart';

import '../../presentation/exam/question_screen.dart';
import '../../presentation/layout/pages/profilePage/change_password.dart';
import '../../presentation/layout/pages/result/result_screen.dart';

class RoutesGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRoutes.splashScreen:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen(), settings: settings);
      case PagesRoutes.loginScreen:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen(), settings: settings);

      case PagesRoutes.signUpScreen:
        return MaterialPageRoute(
            builder: (context) => const SignUpScreen(), settings: settings);

      case PagesRoutes.resetPassword:
        return MaterialPageRoute(
            builder: (context) => const ChangePassword(), settings: settings);
      case PagesRoutes.layoutScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => getIt.get<ProfileTabViewModel>(),
                child: const LayoutScreen()),
            settings: settings);
      case PagesRoutes.forgetPassword:
        return MaterialPageRoute(
            builder: (context) => const ForgetPassword(), settings: settings);
      case PagesRoutes.emailVerification:
        return MaterialPageRoute(
            builder: (context) => const EmailVerification(),
            settings: settings);
      case PagesRoutes.resetPassLogin:
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordLogin(),
            settings: settings);
      case PagesRoutes.examScreen:
        return MaterialPageRoute(
            builder: (context) => const ExamScreen(), settings: settings);
      case PagesRoutes.questionScreen:
        return MaterialPageRoute(
            builder: (context) => const QuestionScreen(), settings: settings);
      case PagesRoutes.scoreScreen:
        return MaterialPageRoute(
            builder: (context) => const ExamScoreScreen(), settings: settings);
      case PagesRoutes.resultScreen:
        return MaterialPageRoute(
            builder: (context) => const ResultScreen(), settings: settings);
      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Un defined route"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Un defined route"),
        ),
      );
    },
  );
}
