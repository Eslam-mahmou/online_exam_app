import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/presentation/auth/pages/login_screen.dart';
import 'package:online_exam_app/presentation/auth/pages/sign_up_screen.dart';

class RoutesGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch (settings.name){
      case PagesRoutes.loginScreen :
        return MaterialPageRoute(builder: (context) => const LoginScreen(),settings: settings);
      case PagesRoutes.signUpScreen :
        return MaterialPageRoute(builder: (context) => const SignUpScreen(),settings: settings);
      default :
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
